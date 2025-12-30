DELIMITER //

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
        1=1 as auswertung_0
        ', if(_sql_flds is null,'',concat(',',_sql_flds)) ,'
        ', if(_sql_json is null,'',concat(',',_sql_json)) ,' as json_values',

    '    from wahlberechtigte_anlage'
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

END //

CREATE OR REPLACE PROCEDURE create_involvement_pivot(
    IN tbl_name VARCHAR(99),       -- table name (or db.tbl)
    IN base_cols VARCHAR(99),      -- column(s) on the left, separated by commas
    IN pivot_col VARCHAR(64),      -- name of column to put across the top
    IN tally_col VARCHAR(64),      -- name of column to SUM up
    IN where_clause VARCHAR(99),   -- empty string or "WHERE ..."
    IN order_by VARCHAR(99)        -- empty string or "ORDER BY ..."; usually the base_cols
)
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN


    DECLARE _sql_aggregate  TEXT;
    DECLARE _sql_view  TEXT;





    SET _sql_aggregate = '';
    for wahlbeteiligung_bericht in 
        (select concat("wb_",wahlbeteiligung_bericht.id) val,wahlbeteiligung_bericht.id  from wahlbeteiligung_bericht where aktiv = 1)
    do
        if _sql_aggregate <> '' then
            SET _sql_aggregate = concat(_sql_aggregate, ',\n');
        end if;

        SET _sql_aggregate = concat(_sql_aggregate, 
            'SUM(IF(', pivot_col, ' = "', wahlbeteiligung_bericht.val, '", ', tally_col, ', 0)) AS `', wahlbeteiligung_bericht.val, '`'
        );

        for wahlbeteiligung_bericht_abgabetyp in 
        (select concat("wb_",wahlbeteiligung_bericht_abgabetyp.bericht_id,'_',wahlbeteiligung_bericht_abgabetyp.abgabetyp) val,wahlbeteiligung_bericht_abgabetyp.bericht_id  from wahlbeteiligung_bericht_abgabetyp where  aktiv = 1 and wahlbeteiligung_bericht_abgabetyp.bericht_id = wahlbeteiligung_bericht.id)
        do

            if _sql_aggregate <> '' then
                SET _sql_aggregate = concat(_sql_aggregate, ',\n');
            end if;
            SET _sql_aggregate = concat(_sql_aggregate, 
                'SUM(IF(', pivot_col, ' = "', wahlbeteiligung_bericht_abgabetyp.val, '", ', tally_col, ', 0)) AS `', wahlbeteiligung_bericht_abgabetyp.val, '`'
            );
        end for;

    end for;

    SET _sql_view = CONCAT(
        'create or replace view `', tbl_name, '_pivot` as SELECT ',
            base_cols, ',\n',
            _sql_aggregate,
            -- ',\n SUM(', tally_col, ') AS Total'
        '\n FROM 
        
        ', tbl_name, ' 
        
        ',
        where_clause,
        ' GROUP BY ', base_cols,
        '\n WITH ROLLUP',
        '\n', order_by
    );
    

    PREPARE _sql FROM _sql_view;
    EXECUTE _sql;                     -- The resulting pivot table ouput
    DEALLOCATE PREPARE _sql;

END //



CREATE OR REPLACE TRIGGER `trigger_wahlbeteiligung_bericht_ai_pivot`
AFTER INSERT ON `wahlbeteiligung_bericht` FOR EACH ROW
BEGIN

    DECLARE sql_command longtext;
        set sql_command = concat(
            "call ",database(),".create_involvement_pivot(   'view_wahlbeteiligung_base',     'use_name',     'top_col_id',      'sum_helper',     '',      '' )"
        );

        insert into deferred_sql_tasks
                (taskid,sessionuser     ,hostname  ,sqlstatement)
        values  (uuid(),getsessionuser(),@@hostname,sql_command );
END //


CREATE OR REPLACE TRIGGER `trigger_wahlbeteiligung_bericht_au_pivot`
AFTER UPDATE ON `wahlbeteiligung_bericht` FOR EACH ROW
BEGIN

    DECLARE sql_command longtext;
        set sql_command = concat(
            "call ",database(),".create_involvement_pivot(     'view_wahlbeteiligung_base',     'use_name',     'top_col_id',      'sum_helper',     '',      '' )"
        );

        insert into deferred_sql_tasks
                (taskid,sessionuser     ,hostname  ,sqlstatement)
        values  (uuid(),getsessionuser(),@@hostname,sql_command );

END //


