DELIMITER  //


create table if not exists wahlbeteiligung_pivot_datatable as
select 
    concat(wahlberechtigte_anlage.stimmzettel,lpad(wahlberechtigte_anlage.identnummer,12,"0")) auswertung_id,
    1=1 as auswertung_0,
    json_object(
        'auswertung_0', 1=1
    ) as json_values
from wahlberechtigte_anlage //

CREATE OR REPLACE PROCEDURE recreate_involvement_baseview()
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN

create or replace view view_wahlbeteiligung_base as

with setup as (
    select * from votemanager_setup where id='wm_involvement_report_base'
), 
testdata as (
    select count(*) use_testdata from votemanager_setup where id='wm_involvement_report_use_testdata' and val='1'
),
wahlschein_data as (
    select * from votemanager_setup where id='wm_involvement_report_wahlschein_data_source'
),
basedata as (
    -- Allgemeine Anmerkung zur Logik der Abfrage:
    -- 
    --     use_id und use_name dienen als basis für die spätere pivotierung der daten, 
    --         da diese in den verschiedenen tabellen unterschiedliche bezeichnungen haben, jedoch inhaltlich das gleiche darstellen.
    -- 
    --     ohne_wahlschein ist eine Hilfsspalte, welche die Anzahl der Fälle ohne Wahlschein darstellt,
    --     damit diese in der späteren Pivotierung mit berücksichtigt werden können, da es keinen Wahlschein gibt, welcher als basis dienen könnte.
    -- 
    --     sum_helper ist die Hilfsspalte, welche die Anzahl der Fälle mit Wahlschein darstellt, 
    --     damit diese in der späteren Pivotierung mit berücksichtigt werden können, da es keinen Wahlschein gibt, welcher als basis dienen könnte.
    -- 
    -- Basisdaten:
    -- 
    --     `call create_involvement_datatable()` baut die tabelle wahlbeteiligung_pivot_datatable auf, welche die basisdaten für die weitere auswertung enthält, da hier bereits die verschiedenen auswertungen als spalten hinterlegt werden, damit diese in der weiteren abfrage mit berücksichtigt werden können, ohne dass komplexe joins notwendig sind, um die verschiedenen auswertungen zu berücksichtigen.
    --     es muss nach dem import der wähler und/oder nach der änderung der auswertungen (wm_auswertungen) aufgerufen werden.
    -- 
    -- 
    -- 
    -- briefwahlstimmzettel
    --     enthält die anzahl der Fälle ohne Wahlschein, welche mit einem Stimmzettel verbunden sind, welcher als basis dient, damit diese in der späteren Pivotierung mit berücksichtigt werden können, da es keinen Wahlschein gibt, welcher als basis dienen könnte.


    -- Stimmzettel als basis,
    --     liste aller wahlscheine,
    --     markierung als ohne wahlschein (wahlscheinstatus = 10) mit hilfe der tabelle briefwahlstimmzettel,
    --     da hier die anzahl der ohne wahlschein Fälle hinterlegt ist, 
    --     welche sonst nicht ermittelt werden könnte, da es keinen wahlschein gibt, welcher als basis dienen könnte.
   select 
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        wahlbeteiligung_pivot_datatable.*,
        0 ohne_wahlschein,
        1 as sum_helper
    from 
        wahlschein
        join wahlbeteiligung_pivot_datatable
            on wahlbeteiligung_pivot_datatable.auswertung_id = wahlschein.id
            and involvement_filter(wahlbeteiligung_pivot_datatable.json_values)
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join setup on   setup.val='stimmzettel'
        join testdata on   testdata.use_testdata = wahlschein.testdaten
        
        
    union all 

    -- Anzahl der Fälle ohne Wahlschein, da es keinen Wahlschein gibt, welcher als basis dienen könnte, wird hier die tabelle briefwahlstimmzettel herangezogen, welche die anzahl der Fälle ohne Wahlschein enthält, welche mit einem Stimmzettel verbunden sind, welcher als basis dient.
    select
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlscheinstatus.id as wahlscheinstatus,
        1 as abgabetyp,
        0 as testdaten,
        
        wahlbeteiligung_pivot_datatable.*,
        1 ohne_wahlschein, -- <<< hier wird markiert, dass es sich um Fälle ohne Wahlschein handelt
        briefwahlstimmzettel.ohne_wahlschein as sum_helper
    from 
        (select * from wahlscheinstatus where id = 10) wahlscheinstatus
        join (select * from wahlbeteiligung_pivot_datatable limit 1) wahlbeteiligung_pivot_datatable
        join briefwahlstimmzettel 
        join stimmzettel 
                on stimmzettel.id = briefwahlstimmzettel.stimmzettel
        
        join setup on   setup.val='stimmzettel' 
    union all
    
    -- Stimmzettelgruppen als basis,
    -- hier werden die Fälle ohne Wahlschein nicht berücksichtigt, da es keinen Wahlschein gibt, welcher als basis dienen könnte, da es sich hier um eine Gruppierung von Stimmzetteln
    -- handelt, welche sowohl mit Wahlschein als auch ohne Wahlschein verbunden sein können, daher werden hier nur die Fälle mit Wahlschein berücksichtigt, da diese in der weiteren Auswertung relevant sind, da es keinen Wahlschein gibt, welcher als basis dienen könnte.
    select 
        setup.val,
        stimmzettelgruppen.id use_id,
        stimmzettelgruppen.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        wahlbeteiligung_pivot_datatable.*,
        0 ohne_wahlschein,
        1 / divisor.c as sum_helper
    from 
        wahlschein
        join wahlbeteiligung_pivot_datatable
            on wahlbeteiligung_pivot_datatable.auswertung_id = wahlschein.id
            and involvement_filter(wahlbeteiligung_pivot_datatable.json_values)
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join stimmzettelgruppen
                on stimmzettelgruppen.stimmzettel = stimmzettel.id
        join (
            select stimmzettel,count(*) c from stimmzettelgruppen  group by stimmzettel
        ) divisor
            on divisor.stimmzettel = stimmzettel.id
        
        join setup on   setup.val='stimmzettelgruppen'
        join testdata on   testdata.use_testdata = wahlschein.testdaten
    
    
    union all 

    -- Anzahl der Fälle ohne Wahlschein, da es keinen Wahlschein gibt, welcher als basis dienen könnte, wird hier die tabelle briefwahlstimmzettel herangezogen, welche die anzahl der Fälle ohne Wahlschein enthält, welche mit einem Stimmzettel verbunden sind, welcher als basis dient.
    -- 
    -- ACHTUNG!
    --     Stimmzettelgruppen können das ergebnis verzerren, da es sich hier um eine Gruppierung von Stimmzetteln handelt
    select
        setup.val,
        stimmzettelgruppen.id use_id,
        stimmzettelgruppen.name use_name,

        wahlscheinstatus.id as wahlscheinstatus,
        1 as abgabetyp,
        0 as testdaten,
        wahlbeteiligung_pivot_datatable.*,
        1 ohne_wahlschein,
        briefwahlstimmzettel.ohne_wahlschein / divisor.c as sum_helper 
        -- <<< hier wird markiert, dass es sich um Fälle ohne Wahlschein handelt, da es keinen Wahlschein gibt, welcher als basis dienen könnte, wird die anzahl der Fälle ohne Wahlschein durch die Anzahl der Stimmzettel pro Stimmzettelgruppe geteilt, um eine realistische Anzahl der Fälle ohne Wahlschein pro Stimmzettelgruppe zu erhalten, da es sich hier um eine Gruppierung von Stimmzetteln handelt, welche sowohl mit Wahlschein als auch ohne Wahlschein verbunden sein können, daher werden hier nur die Fälle mit Wahlschein berücksichtigt, da diese in der weiteren Auswertung relevant sind, da es keinen Wahlschein gibt, welcher als basis dienen könnte.
    from 
        (select * from wahlscheinstatus where id = 10) wahlscheinstatus
        join (select * from wahlbeteiligung_pivot_datatable limit 1) wahlbeteiligung_pivot_datatable
        join briefwahlstimmzettel 
        join stimmzettel 
                on stimmzettel.id = briefwahlstimmzettel.stimmzettel
        join stimmzettelgruppen
                on stimmzettelgruppen.stimmzettel = stimmzettel.id
        join (
            select stimmzettel,count(*) c from stimmzettelgruppen  group by stimmzettel
        ) divisor
            on divisor.stimmzettel = stimmzettel.id
        
        join setup on   setup.val='stimmzettelgruppen' 
    union all
    
    -- Weitere Gruppierungen als basis,
    -- hier werden die Fälle ohne Wahlschein nicht berücksichtigt, da es keinen Wahlschein gibt
    select 
        setup.val,
        wahlgruppe.id use_id,
        wahlgruppe.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        wahlbeteiligung_pivot_datatable.*,
        0 ohne_wahlschein,
        1 as sum_helper
    from 
        wahlschein
        join wahlbeteiligung_pivot_datatable
            on wahlbeteiligung_pivot_datatable.auswertung_id = wahlschein.id
            and involvement_filter(wahlbeteiligung_pivot_datatable.json_values)
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join wahlgruppe
                on wahlgruppe.id = stimmzettel.wahlgruppe
        join setup on   setup.val='wahlgruppe'
        join testdata on   testdata.use_testdata = wahlschein.testdaten
            

            
    union all 
    
    select 
        setup.val,
        wahlbezirk.id use_id,
        wahlbezirk.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        wahlbeteiligung_pivot_datatable.*,
        0 ohne_wahlschein,
        1 as sum_helper
    from 
        wahlschein
        join wahlbeteiligung_pivot_datatable
            on wahlbeteiligung_pivot_datatable.auswertung_id = wahlschein.id
            and involvement_filter(wahlbeteiligung_pivot_datatable.json_values)
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join wahlbezirk
                on wahlbezirk.id = stimmzettel.wahlbezirk
        join setup on   setup.val='wahlbezirk'
        join testdata on   testdata.use_testdata = wahlschein.testdaten
),
wstest as (
    select 
        wahlscheinstatus.name wahlscheinstatus_name,
        wahlbeteiligung_bericht.name top_col_name,
        concat('wb_',wahlbeteiligung_bericht.id) top_col_id,
        basedata.*
    from 
        wahlscheinstatus
        join basedata on basedata.wahlscheinstatus = wahlscheinstatus.id
        join wahlbeteiligung_bericht_status
                on wahlbeteiligung_bericht_status.wahlscheinstatus = basedata.wahlscheinstatus
                and wahlbeteiligung_bericht_status.aktiv = 1
        join wahlbeteiligung_bericht
                on wahlbeteiligung_bericht.id = wahlbeteiligung_bericht_status.wahlbeteiligung_bericht
                and wahlbeteiligung_bericht.aktiv = 1
                and (
                    (wahlbeteiligung_bericht.id<>7 and basedata.ohne_wahlschein = 0) 
                    or (wahlbeteiligung_bericht.id=7 and basedata.ohne_wahlschein = 1)
                )

    union all 

    select 
        wahlscheinstatus.name wahlscheinstatus_name,
        wahlbeteiligung_bericht.name top_col_name,
        concat('wb_',wahlbeteiligung_bericht.id,'_',wahlbeteiligung_bericht_abgabetyp.abgabetyp) top_col_id,
        basedata.*
    from 
        wahlscheinstatus
        join basedata on basedata.wahlscheinstatus = wahlscheinstatus.id
        join wahlbeteiligung_bericht_status
                on wahlbeteiligung_bericht_status.wahlscheinstatus = basedata.wahlscheinstatus
                and wahlbeteiligung_bericht_status.aktiv = 1
        join wahlbeteiligung_bericht
                on wahlbeteiligung_bericht.id = wahlbeteiligung_bericht_status.wahlbeteiligung_bericht
                and wahlbeteiligung_bericht.aktiv = 1
                and (
                    (wahlbeteiligung_bericht.id<>7 and basedata.ohne_wahlschein = 0) 
                    or (wahlbeteiligung_bericht.id=7 and basedata.ohne_wahlschein = 1)
                )
        join wahlbeteiligung_bericht_abgabetyp
                on wahlbeteiligung_bericht_abgabetyp.bericht_id = wahlbeteiligung_bericht.id
                and wahlbeteiligung_bericht_abgabetyp.aktiv = 1
                and basedata.abgabetyp = wahlbeteiligung_bericht_abgabetyp.abgabetyp

)
select * from wstest;

end //

call recreate_involvement_baseview() // 