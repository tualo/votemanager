DELIMITER //


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
        '\n FROM ', tbl_name, ' ',
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
            "call ",database(),".create_involvement_pivot(   view_wahlbeteiligung_base',     'use_id,use_name',     'top_col_id',      'sum_helper',     '',      '' )"
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
            "call ",database(),".create_involvement_pivot(     'view_wahlbeteiligung_base',     'use_id,use_name',     'top_col_id',      'sum_helper',     '',      '' )"
        );

        insert into deferred_sql_tasks
                (taskid,sessionuser     ,hostname  ,sqlstatement)
        values  (uuid(),getsessionuser(),@@hostname,sql_command );

END //


