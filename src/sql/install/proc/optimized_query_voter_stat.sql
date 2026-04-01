



create table if not exists optimized_query_voter_stats (
    auswertung_id	bigint(20) not null,
    use_id	int(11) not null,
    top_col_id	varchar(26) not null,
    primary key (auswertung_id,use_id,top_col_id),    

    wahlscheinstatus	int(11) not null default 0,
    abgabetyp	int(11) not null default 0,
    wahltyp	int(11) not null default 0,

    testdaten	boolean not null default false,
    
    auswertung_0	boolean not null default false,
    auswertung_1	boolean not null default false,
    auswertung_2	boolean not null default false,
    auswertung_3	boolean not null default false,
    auswertung_4	boolean not null default false,
    auswertung_5	boolean not null default false,
    auswertung_6	boolean not null default false,
    auswertung_7	boolean not null default false,
    auswertung_8	boolean not null default false,
    auswertung_9	boolean not null default false,

    -- achtung wird mehr, wenn unter wm_auswertungen mehr abfragen erstellt werden
    -- json_values	varchar(113) not null,
    sum_helper	tinyint not null default 0,

    json_values    json not null default '{}',   
    
    index idx_optimized_query_voter_stats_auswertung_id (auswertung_id),
    index idx_optimized_query_voter_stats_wahltyp (wahltyp),
    index idx_optimized_query_voter_stats_use_id (use_id),

    index idx_optimized_query_voter_stats_auswertung_0 (auswertung_0),
    index idx_optimized_query_voter_stats_auswertung_1 (auswertung_1),
    index idx_optimized_query_voter_stats_auswertung_2 (auswertung_2),
    index idx_optimized_query_voter_stats_auswertung_3 (auswertung_3),
    index idx_optimized_query_voter_stats_auswertung_4 (auswertung_4),
    index idx_optimized_query_voter_stats_auswertung_5 (auswertung_5),
    index idx_optimized_query_voter_stats_auswertung_6 (auswertung_6),
    index idx_optimized_query_voter_stats_auswertung_7 (auswertung_7),
    index idx_optimized_query_voter_stats_auswertung_8 (auswertung_8),
    index idx_optimized_query_voter_stats_auswertung_9 (auswertung_9),
    index idx_optimized_query_voter_stats_top_col_id (top_col_id)
);



create trigger optimized_query_voter_stats_trigger_au
after update on optimized_query_voter_stats
begin
end // 





CREATE OR REPLACE PROCEDURE create_involvement_datatable()
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
    DECLARE _sql_flds  TEXT;
    DECLARE _sql_json  TEXT;
    DECLARE _sql_datatable  TEXT;

    select group_concat(concat('if( `wahlberechtigte_anlage`','.','`',feld,'` in (',feldwerte,'),1=1,1=0) as `auswertung_',id,'`') separator ',') x 
    into _sql_flds
    from wm_auswertungen; 


    select concat('json_object("auswertung_0", 1=1',if(_sql_flds is null,'', concat(',',group_concat(concat('"auswertung_',id,'", if( `wahlberechtigte_anlage`.`',feld,'` in (',feldwerte,'),1=1,1=0)') separator ','),')'))) x 
    into _sql_json
    from wm_auswertungen; 

        /*
    for wm_auswertungen in (
        select 99999 id,'Allgemein' auswertung_name,'allgemein' feld,'1' feldwerte,-1 pos  
        union all
        select id,name auswertung_name,feld,feldwerte,pos from wm_auswertungen 
        order by pos,id
    ) do

    end for;
    */


    drop table if exists wahlbeteiligung_pivot_datatable;

    SET _sql_datatable = CONCAT('
    create table if not exists wahlbeteiligung_pivot_datatable as
    select 
        cast( concat(wahlberechtigte_anlage.stimmzettel,lpad(wahlberechtigte_anlage.identnummer,12,"0")) as int) auswertung_id,
        stimmzettel.wahltyp,
        1=1 as auswertung_0
        ', if(_sql_flds is null,'',concat(',',_sql_flds)) ,'
        ', if(_sql_json is null,'',concat(',',_sql_json)) ,' as json_values',

    '    from wahlberechtigte_anlage join stimmzettel on wahlberechtigte_anlage.stimmzettel = stimmzettel.id'
    );
    PREPARE _sql FROM _sql_datatable;
    EXECUTE _sql;
    DEALLOCATE PREPARE _sql;



    SET _sql_datatable = CONCAT('alter table wahlbeteiligung_pivot_datatable modify column auswertung_id bigint not null primary key');
    PREPARE _sql FROM _sql_datatable;
    EXECUTE _sql;
    DEALLOCATE PREPARE _sql;

    /*
    SET _sql_datatable = CONCAT('create unique index idx_wahlbeteiligung_pivot_datatable_xid on wahlbeteiligung_pivot_datatable(xid)');
    PREPARE _sql FROM _sql_datatable;
    EXECUTE _sql;
    DEALLOCATE PREPARE _sql;
    */

    for wm_auswertungen in (
            select 0 id,'Allgemein' auswertung_name,'allgemein' feld,'1' feldwerte,-1 pos  
            union all
            select id,name auswertung_name,feld,feldwerte,pos from wm_auswertungen 
            order by pos,id
    ) do

        SET _sql_datatable = CONCAT('alter table wahlbeteiligung_pivot_datatable modify column `auswertung_',wm_auswertungen.id,'` integer not null default 0');
        PREPARE _sql FROM _sql_datatable;
        EXECUTE _sql;
        DEALLOCATE PREPARE _sql;

        SET _sql_datatable = CONCAT('create index idx_wahlbeteiligung_pivot_datatable_',wm_auswertungen.id,' on wahlbeteiligung_pivot_datatable(','`auswertung_',wm_auswertungen.id,'`)');
        PREPARE _sql FROM _sql_datatable;
        EXECUTE _sql;
        DEALLOCATE PREPARE _sql;
            
    end for;    


    call recreate_involvement_baseview();

END //