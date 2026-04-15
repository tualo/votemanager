




create table if not exists ich_habe_keinen_namen_mehr (
    auswertung_id	bigint(20) not null,
    use_id	int(11) not null,
    top_col_id	varchar(26) not null,
    primary key (auswertung_id,use_id,top_col_id),
    

    wahlscheinstatus	int(11) not null,
    abgabetyp	int(11) not null,
    wahltyp	int(11) not null,

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
    sum_helper	tinyint not null,
    
    index idx_ich_habe_keinen_namen_mehr_auswertung_id (auswertung_id),
    index idx_ich_habe_keinen_namen_mehr_wahltyp (wahltyp),

    index idx_ich_habe_keinen_namen_mehr_auswertung_0 (auswertung_0),
    index idx_ich_habe_keinen_namen_mehr_auswertung_1 (auswertung_1),
    index idx_ich_habe_keinen_namen_mehr_auswertung_2 (auswertung_2),
    
    index idx_ich_habe_keinen_namen_mehr_top_col_id (top_col_id)
);


CREATE OR REPLACE PROCEDURE refresh_ich_habe_keinen_namen_mehr( in wahlschein_id bigint )
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN

    delete from ich_habe_keinen_namen_mehr where auswertung_id = wahlschein_id;



    insert into ich_habe_keinen_namen_mehr (

        auswertung_id,
        use_id,
        top_col_id,
        wahlscheinstatus,
        abgabetyp,
        testdaten,
        wahltyp,
        
        auswertung_0,
        auswertung_1,
        auswertung_2,
        /*
        auswertung_3,
        auswertung_4,
        auswertung_5,
        auswertung_6,
        auswertung_7,
        auswertung_8,
        auswertung_9,
        */

        -- json_values,
        sum_helper
    )
     with 
        basedata as (
            select 

                auswertung_id,

                auswertung_0,
                auswertung_1,
                auswertung_2,
                wahltyp
            
            from wahlbeteiligung_pivot_datatable   
            where auswertung_id = wahlschein_id
        ),

        wstest as (
            select
                `wahlscheinstatus`.`name` AS `wahlscheinstatus_name`,
                `wahlbeteiligung_bericht`.`name` AS `top_col_name`,
                concat('wb_', `wahlbeteiligung_bericht`.`id`) AS `top_col_id`,
                -- `basedata`.`val` AS `val`,
                `wahlschein`.`stimmzettel` AS `use_id`,
                -- `basedata`.`use_name` AS `use_name`,
                `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
                `wahlschein`.`abgabetyp` AS `abgabetyp`,
                `wahlschein`.`testdaten` AS `testdaten`,
                `basedata`.`wahltyp` AS `wahltyp`,

                `basedata`.`auswertung_id` AS `auswertung_id`,
                `basedata`.`auswertung_0` AS `auswertung_0`,
                `basedata`.`auswertung_1` AS `auswertung_1`,
                `basedata`.`auswertung_2` AS `auswertung_2`,
                --  `basedata`.`json_values` AS `json_values`,
                1 AS `sum_helper`
            from
                (
                    (
                        `wahlscheinstatus`
                        join `wahlschein`
                            on `wahlschein`.`wahlscheinstatus` = `wahlscheinstatus`.`id`
                        join `basedata`
                            on `basedata`.auswertung_id = wahlschein.id
                        join `wahlbeteiligung_bericht_status` on(
                            `wahlbeteiligung_bericht_status`.`wahlscheinstatus` = `wahlschein`.`wahlscheinstatus`
                            and `wahlbeteiligung_bericht_status`.`aktiv` = 1
                        )
                    )
                    join `wahlbeteiligung_bericht` on(
                        `wahlbeteiligung_bericht`.`id` = `wahlbeteiligung_bericht_status`.`wahlbeteiligung_bericht`
                        and `wahlbeteiligung_bericht`.`aktiv` = 1
                    )
                )

            union
            all
            select
                `wahlscheinstatus`.`name` AS `wahlscheinstatus_name`,
                `wahlbeteiligung_bericht`.`name` AS `top_col_name`,
                concat(
                    'wb_',
                    `wahlbeteiligung_bericht`.`id`,
                    '_',
                    `wahlbeteiligung_bericht_abgabetyp`.`abgabetyp`
                ) AS `top_col_id`,
            --  `basedata`.`val` AS `val`,
                `wahlschein`.`stimmzettel` AS `use_id`,
                -- `basedata`.`use_name` AS `use_name`,
                `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
                `wahlschein`.`abgabetyp` AS `abgabetyp`,
                `wahlschein`.`testdaten` AS `testdaten`,
                `basedata`.`wahltyp` AS `wahltyp`,
                `basedata`.`auswertung_id` AS `auswertung_id`,
                `basedata`.`auswertung_0` AS `auswertung_0`,
                `basedata`.`auswertung_1` AS `auswertung_1`,
                `basedata`.`auswertung_2` AS `auswertung_2`,
                -- `basedata`.`json_values` AS `json_values`,
                1 AS `sum_helper`
            from
                (
                    (
                        (
                            
                                `wahlscheinstatus`
                                join `wahlschein`
                                    on `wahlschein`.`wahlscheinstatus` = `wahlscheinstatus`.`id`
                                join `basedata`
                                    on `basedata`.auswertung_id = wahlschein.id
                                join `wahlbeteiligung_bericht_status` on(
                                    `wahlbeteiligung_bericht_status`.`wahlscheinstatus` = `wahlschein`.`wahlscheinstatus`
                                    and `wahlbeteiligung_bericht_status`.`aktiv` = 1
                                )
                            
                        )
                        join `wahlbeteiligung_bericht` on(
                            `wahlbeteiligung_bericht`.`id` = `wahlbeteiligung_bericht_status`.`wahlbeteiligung_bericht`
                            and `wahlbeteiligung_bericht`.`aktiv` = 1
                        )
                    )
                    join `wahlbeteiligung_bericht_abgabetyp` on(
                        `wahlbeteiligung_bericht_abgabetyp`.`bericht_id` = `wahlbeteiligung_bericht`.`id`
                        and `wahlbeteiligung_bericht_abgabetyp`.`aktiv` = 1
                        and `wahlschein`.`abgabetyp` = `wahlbeteiligung_bericht_abgabetyp`.`abgabetyp`
                    )
                )
        )
        select
            `wstest`.`auswertung_id` AS `auswertung_id`,
            `wstest`.`use_id` AS `use_id`,
            -- `wstest`.`wahlscheinstatus_name` AS `wahlscheinstatus_name`,
            -- `wstest`.`top_col_name` AS `top_col_name`,
            `wstest`.`top_col_id` AS `top_col_id`,
            -- `wstest`.`val` AS `val`,
            -- `wstest`.`use_name` AS `use_name`,
            `wstest`.`wahlscheinstatus` AS `wahlscheinstatus`,
            `wstest`.`abgabetyp` AS `abgabetyp`,
            `wstest`.`testdaten` AS `testdaten`,
            `wstest`.`wahltyp` AS `wahltyp`,
            `wstest`.`auswertung_0` AS `auswertung_0`,
            `wstest`.`auswertung_1` AS `auswertung_1`,
            `wstest`.`auswertung_2` AS `auswertung_2`,
            -- `wstest`.`json_values` AS `json_values`,
            `wstest`.`sum_helper` AS `sum_helper`
        from
            `wstest`
        ;

END //



CREATE OR REPLACE PROCEDURE `fill_ich_habe_keinen_namen_mehr`()
    DETERMINISTIC
BEGIN
    declare last_start datetime default '2020-01-01 00:00:01';

    set last_start = ifnull( (select val from votemanager_setup where id = 'fill_ich_habe_keinen_namen_mehr_last_start' limit 1),  '2020-01-01 00:00:01');

    
    
    -- for rec in ( select *  from wahlschein  where wahlscheinstatus  in (select id from wahlscheinstatus where id <> 1) and  updated_at > last_start - interval + 2 hour ) do
    for rec in ( select *  from wahlschein  where  updated_at > last_start - interval + 12 hour ) do

        call refresh_ich_habe_keinen_namen_mehr(rec.id);
    end for;
    replace into votemanager_setup(id,val) values ('fill_ich_habe_keinen_namen_mehr_last_start',now());
END //

