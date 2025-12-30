DELIMITER ;

create table if not exists wahlbeteiligung_pivot_datatable as
select 
    concat(wahlberechtigte_anlage.stimmzettel,lpad(wahlberechtigte_anlage.identnummer,12,"0")) xid,
    1=1 as auswertung_0,
    json_object(
        'auswertung_0', 1=1
    ) as json_values
from wahlberechtigte_anlage;

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

   select 
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        wahlbeteiligung_pivot_datatable.*,
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


    select
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlscheinstatus.id as wahlscheinstatus,
        1 as abgabetyp,
        0 as testdaten,
        wahlbeteiligung_pivot_datatable.*,
        briefwahlstimmzettel.ohne_wahlschein as sum_helper
    from 
        (select * from wahlscheinstatus where id = 10) wahlscheinstatus
        join (select * from wahlbeteiligung_pivot_datatable limit 1) wahlbeteiligung_pivot_datatable
        join briefwahlstimmzettel 
        join stimmzettel 
                on stimmzettel.id = briefwahlstimmzettel.stimmzettel
        
        join setup on   setup.val='stimmzettel' 
    union all
    
    select 
        setup.val,
        stimmzettelgruppen.id use_id,
        stimmzettelgruppen.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        wahlbeteiligung_pivot_datatable.*,
        1 as sum_helper
    from 
        wahlschein
        join wahlbeteiligung_pivot_datatable
            on wahlbeteiligung_pivot_datatable.auswertung_id = wahlschein.id
            and involvement_filter(wahlbeteiligung_pivot_datatable.json_values)
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join stimmzettelgruppen
                on stimmzettelgruppen.stimmzettel = stimmzettel.id
        join setup on   setup.val='stimmzettelgruppen'
        join testdata on   testdata.use_testdata = wahlschein.testdaten
    
    
    union all 

    select
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlscheinstatus.id as wahlscheinstatus,
        1 as abgabetyp,
        0 as testdaten,
        wahlbeteiligung_pivot_datatable.*,
        briefwahlstimmzettel.ohne_wahlschein as sum_helper
    from 
        (select * from wahlscheinstatus where id = 10) wahlscheinstatus
        join (select * from wahlbeteiligung_pivot_datatable limit 1) wahlbeteiligung_pivot_datatable
        join briefwahlstimmzettel 
        join stimmzettel 
                on stimmzettel.id = briefwahlstimmzettel.stimmzettel
        join stimmzettelgruppen
                on stimmzettelgruppen.stimmzettel = stimmzettel.id
        
        join setup on   setup.val='stimmzettelgruppen' 
    union all
    
    select 
        setup.val,
        wahlgruppe.id use_id,
        wahlgruppe.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        wahlbeteiligung_pivot_datatable.*,
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
        join wahlbeteiligung_bericht_abgabetyp
                on wahlbeteiligung_bericht_abgabetyp.bericht_id = wahlbeteiligung_bericht.id
                and wahlbeteiligung_bericht_abgabetyp.aktiv = 1
                and basedata.abgabetyp = wahlbeteiligung_bericht_abgabetyp.abgabetyp

)
select * from wstest;