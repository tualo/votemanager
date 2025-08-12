create or replace view view_wahlbeteiligung_base as

with setup as (
    select * from votemanager_setup where id='wm_involvement_report_base'
), 

basedata as (
   select 
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        1 as sum_helper
    from 
        wahlschein
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join setup on   setup.val='stimmzettel'
        
    union all 


    select
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlscheinstatus.id as wahlscheinstatus,
        1 as abgabetyp,
        0 as testdaten,
        briefwahlstimmzettel.ohne_wahlschein as sum_helper
    from 
        (select * from wahlscheinstatus where id = 10) wahlscheinstatus
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
        1 as sum_helper
    from 
        wahlschein
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join stimmzettelgruppen
                on stimmzettelgruppen.stimmzettel = stimmzettel.id
        join setup on   setup.val='stimmzettelgruppen'
    
    
    union all 

    select
        setup.val,
        stimmzettel.id use_id,
        stimmzettel.name use_name,

        wahlscheinstatus.id as wahlscheinstatus,
        1 as abgabetyp,
        0 as testdaten,
        briefwahlstimmzettel.ohne_wahlschein as sum_helper
    from 
        (select * from wahlscheinstatus where id = 10) wahlscheinstatus
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
        1 as sum_helper
    from 
        wahlschein
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join wahlgruppe
                on wahlgruppe.id = stimmzettel.wahlgruppe
        join setup on   setup.val='wahlgruppe'

            
    union all 
    
    select 
        setup.val,
        wahlbezirk.id use_id,
        wahlbezirk.name use_name,

        wahlschein.wahlscheinstatus,
        wahlschein.abgabetyp,
        wahlschein.testdaten,
        1 as sum_helper
    from 
        wahlschein
        join stimmzettel 
                on stimmzettel.id = wahlschein.stimmzettel
        join wahlbezirk
                on wahlbezirk.id = stimmzettel.wahlbezirk
        join setup on   setup.val='wahlbezirk'
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

)
select * from wstest;