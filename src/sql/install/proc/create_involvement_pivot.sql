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





    -- Find the distinct values
    -- Build the SUM()s
    /*
    SET @subq = CONCAT('SELECT DISTINCT ', pivot_col, ' AS val ',
                    ' FROM ', tbl_name, ' ', where_clause, ' ORDER BY 1');
*/
    SET @subq = CONCAT('   select 
            concat("wb_",wahlbeteiligung_bericht.id) as val
    from 
        wahlbeteiligung_bericht
    where aktiv = 1');

    -- select @subq;

    SET @cc1 = "CONCAT('SUM(IF(&p = ', &v, ', &t, 0)) AS ', &v)";
    SET @cc2 = REPLACE(@cc1, '&p', pivot_col);
    SET @cc3 = REPLACE(@cc2, '&t', tally_col);
    -- select @cc2, @cc3;
    SET @qval = CONCAT("'\"', val, '\"'");
    -- select @qval;
    SET @cc4 = REPLACE(@cc3, '&v', @qval);
    -- select @cc4;

    SET SESSION group_concat_max_len = 10000;   -- just in case
    SET @stmt = CONCAT(
            'SELECT  GROUP_CONCAT(', @cc4, ' SEPARATOR ",\n")  INTO @sums',
            ' FROM ( ', @subq, ' ) AS top');

    PREPARE _sql FROM @stmt;
    EXECUTE _sql;                      -- Intermediate step: build SQL for columns
    DEALLOCATE PREPARE _sql;
    -- Construct the query and perform it
    SET @stmt2 = CONCAT(
            'create or replace view `', tbl_name, '_pivot` as SELECT ',
                base_cols, ',\n',
                @sums,
                -- ',\n SUM(', tally_col, ') AS Total'
            '\n FROM ', tbl_name, ' ',
            where_clause,
            ' GROUP BY ', base_cols,
            -- '\n WITH ROLLUP',
            '\n', order_by
        );
    


    PREPARE _sql FROM @stmt2;
    EXECUTE _sql;                     -- The resulting pivot table ouput
    DEALLOCATE PREPARE _sql;
    -- For debugging / tweaking, SELECT the various @variables after CALLing.
END //



CREATE OR REPLACE TRIGGER `trigger_wahlbeteiligung_bericht_ai_pivot`
AFTER INSERT ON `wahlbeteiligung_bericht` FOR EACH ROW
BEGIN

    DECLARE sql_command longtext;
        set sql_command = concat(
            "call ",database(),".create_involvement_pivot(   view_wahlbeteiligung_base',     'use_name',     'top_col_id',      'sum_helper',     '',      '' )"
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


