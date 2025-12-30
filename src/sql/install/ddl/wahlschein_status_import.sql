DELIMITER //

CREATE TABLE IF NOT EXISTS `wahlschein_status_import` (
  `id` varchar(60) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `user` varchar(128) DEFAULT NULL,
  `importdatetime` datetime DEFAULT NULL,
  `processed_state` tinyint(4) DEFAULT NULL,
  `processed_datetime` datetime DEFAULT NULL,
  `processed_user` varchar(128) DEFAULT NULL,
  `processed_msg` varchar(255) DEFAULT NULL,
  `wahlscheinnummer` varchar(24) DEFAULT NULL,
  `identnummer` varchar(24) DEFAULT NULL,
  `neuer_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_wahlschein_status_import_processed_state` (`processed_state`)
) //

alter table wahlschein_status_import modify processed_datetime datetime default null //
alter table wahlschein_status_import modify `neuer_status` varchar(255) DEFAULT NULL //

CREATE TABLE IF NOT EXISTS `import_status_ausgangszustand` (
  `id_wahlscheinstatus` int(11) NOT NULL,
  `id_ausgang` int(11) NOT NULL,
  PRIMARY KEY (`id_wahlscheinstatus`,`id_ausgang`),
  KEY `fk_import_status_ausgangszustand_wahlscheinstatus_1` (`id_wahlscheinstatus`),
  CONSTRAINT `fk_import_status_ausgangszustand_wahlscheinstatus_1` FOREIGN KEY (`id_wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) //

insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (1,8) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (5,-1) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (5,1) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (5,5) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (8,1) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (13,-1) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (13,1) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (13,5) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (16,-1) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (16,1) //
insert ignore into import_status_ausgangszustand (id_wahlscheinstatus,id_ausgang) values (16,5) //


CREATE OR REPLACE VIEW `view_readtable_import_ausgangszustand` AS (
    select
        `isa`.`id_wahlscheinstatus` AS `id_wahlscheinstatus`,
        `isa`.`id_ausgang` AS `id_ausgang`,
        `wahlscheinstatus`.`name` AS `new_state_name`,
        `wahlscheinstatus`.`id` AS `new_state_id`,
        `x`.`name` AS `before_state_name`,
        `x`.`id` AS `before_state_id`
    from
        (
            (
                `import_status_ausgangszustand` `isa`
                left join `wahlscheinstatus` on(
                    `wahlscheinstatus`.`id` = `isa`.`id_wahlscheinstatus`
                )
            )
            left join `wahlscheinstatus` `x` on(`x`.`id` = `isa`.`id_ausgang`)
        )
) //




CREATE
OR REPLACE VIEW `view_readtable_wahlschein_by_identnr` AS (
    select
        `a`.`id` AS `id`,
        `a`.`wahlscheinnummer` AS `wahlscheinnummer`,
        `a`.`wahlberechtigte` AS `wahlberechtigte`,
        `a`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `b`.`id` AS `wahlberechtigte_id`,
        `b`.`identnummer` AS `identnummer`
    from
        (
            `wahlschein` `a`
            join `wahlberechtigte` `b`
        )
    where
        `a`.`wahlberechtigte` = `b`.`id`
) //

CREATE
OR REPLACE VIEW `view_readtable_counter_wahlscheinstatus` AS (
    select
        `wahlschein`.`wahlberechtigte` AS `wahlberechtigte`,
        count(distinct `wahlschein`.`wahlscheinnummer`) AS `anzahl_wahlschein`,
        count(distinct `wahlschein`.`wahlscheinstatus`) AS `anzahl_wahlschein_status`
    from
        `wahlschein`
    group by
        `wahlschein`.`wahlberechtigte`
) //




CREATE
OR REPLACE VIEW `view_readtable_import_status_loop` AS (
    select
        `view_readtable_wahlschein_by_identnr`.`id` AS `id`,
        `view_readtable_wahlschein_by_identnr`.`wahlscheinnummer` AS `wahlscheinnummer`,
        `view_readtable_wahlschein_by_identnr`.`wahlberechtigte` AS `wahlberechtigte`,
        `view_readtable_wahlschein_by_identnr`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `wahlscheinstatus`.`name` AS `aktueller_status_name`,
        `view_readtable_wahlschein_by_identnr`.`identnummer` AS `identnummer`,
        `view_readtable_counter_wahlscheinstatus`.`anzahl_wahlschein` AS `anzahl_wahlschein`,
        `view_readtable_counter_wahlscheinstatus`.`anzahl_wahlschein_status` AS `anzahl_wahlschein_status`
    from
        (
            (
                `view_readtable_wahlschein_by_identnr`
                join `view_readtable_counter_wahlscheinstatus` on(
                    `view_readtable_counter_wahlscheinstatus`.`wahlberechtigte` = `view_readtable_wahlschein_by_identnr`.`wahlberechtigte_id`
                )
            )
            join `wahlscheinstatus` on(
                `wahlscheinstatus`.`id` = `view_readtable_wahlschein_by_identnr`.`wahlscheinstatus`
            )
        )
) //


create table if not exists matview_readtable_import_status_loop as
select * from view_readtable_import_status_loop //

CREATE
OR REPLACE VIEW `view_read_table_impoprt_status_proc_loop` AS (
    select
        `wsi`.`id` AS `id`,
        `wsi`.`filename` AS `filename`,
        `wsi`.`user` AS `user`,
        `wsi`.`importdatetime` AS `importdatetime`,
        `wsi`.`processed_state` AS `processed_state`,
        `wsi`.`processed_datetime` AS `processed_datetime`,
        `wsi`.`processed_user` AS `processed_user`,
        `wsi`.`processed_msg` AS `processed_msg`,
        `wsi`.`wahlscheinnummer` AS `wahlscheinnummer`,
        `wsi`.`identnummer` AS `identnummer`,
        `wsi`.`neuer_status` AS `neuer_status`,
        `isl`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `isl`.`anzahl_wahlschein_status` AS `anzahl_wahlschein_status`,
        `isl`.`anzahl_wahlschein` AS `anzahl_wahlschein`,
        `isl`.`id` AS `wahlschein_id`,
        `isl`.`aktueller_status_name` AS `aktueller_status_name`,
        `iaz`.`new_state_name` AS `new_state_name`,
        `iaz`.`before_state_name` AS `before_state_name`,
        `iaz`.`new_state_id` AS `new_state_id`
    from
        (
            (
                (
                    select
                        `wahlschein_status_import`.`id` AS `id`,
                        `wahlschein_status_import`.`filename` AS `filename`,
                        `wahlschein_status_import`.`user` AS `user`,
                        `wahlschein_status_import`.`importdatetime` AS `importdatetime`,
                        `wahlschein_status_import`.`processed_state` AS `processed_state`,
                        `wahlschein_status_import`.`processed_datetime` AS `processed_datetime`,
                        `wahlschein_status_import`.`processed_user` AS `processed_user`,
                        `wahlschein_status_import`.`processed_msg` AS `processed_msg`,
                        `wahlschein_status_import`.`wahlscheinnummer` AS `wahlscheinnummer`,
                        `wahlschein_status_import`.`identnummer` AS `identnummer`,
                        `wahlschein_status_import`.`neuer_status` AS `neuer_status`
                    from
                        `wahlschein_status_import`
                    where
                        `wahlschein_status_import`.`processed_state` is null
                ) `wsi`
                join `matview_readtable_import_status_loop` `isl` on(
                    `wsi`.`wahlscheinnummer` = `isl`.`wahlscheinnummer`
                    or `wsi`.`identnummer` = `isl`.`identnummer`
                )
            )
            join `view_readtable_import_ausgangszustand` `iaz` on(
                `iaz`.`new_state_name` = `wsi`.`neuer_status`
                and `iaz`.`before_state_id` = `isl`.`wahlscheinstatus`
            )
        )
) //


CREATE
OR REPLACE VIEW `view_read_table_impoprt_status_proc_final_loop` AS (
    select
        `view_read_table_impoprt_status_proc_loop`.`id` AS `id`,
        `view_read_table_impoprt_status_proc_loop`.`filename` AS `filename`,
        `view_read_table_impoprt_status_proc_loop`.`user` AS `user`,
        `view_read_table_impoprt_status_proc_loop`.`importdatetime` AS `importdatetime`,
        `view_read_table_impoprt_status_proc_loop`.`processed_state` AS `processed_state`,
        `view_read_table_impoprt_status_proc_loop`.`processed_datetime` AS `processed_datetime`,
        `view_read_table_impoprt_status_proc_loop`.`processed_user` AS `processed_user`,
        `view_read_table_impoprt_status_proc_loop`.`processed_msg` AS `processed_msg`,
        `view_read_table_impoprt_status_proc_loop`.`wahlscheinnummer` AS `wahlscheinnummer`,
        `view_read_table_impoprt_status_proc_loop`.`identnummer` AS `identnummer`,
        `view_read_table_impoprt_status_proc_loop`.`neuer_status` AS `neuer_status`,
        `view_read_table_impoprt_status_proc_loop`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `view_read_table_impoprt_status_proc_loop`.`anzahl_wahlschein_status` AS `anzahl_wahlschein_status`,
        `view_read_table_impoprt_status_proc_loop`.`anzahl_wahlschein` AS `anzahl_wahlschein`,
        `view_read_table_impoprt_status_proc_loop`.`wahlschein_id` AS `wahlschein_id`,
        `view_read_table_impoprt_status_proc_loop`.`aktueller_status_name` AS `aktueller_status_name`,
        `view_read_table_impoprt_status_proc_loop`.`new_state_name` AS `new_state_name`,
        `view_read_table_impoprt_status_proc_loop`.`before_state_name` AS `before_state_name`,
        `view_read_table_impoprt_status_proc_loop`.`new_state_id` AS `new_state_id`,
        if(
            `view_read_table_impoprt_status_proc_loop`.`anzahl_wahlschein_status` is null,
            'Identnummer oder Wahlscheinnummer nicht gefunden',
            if(
                octet_length(
                    ifnull(
                        `view_read_table_impoprt_status_proc_loop`.`wahlscheinnummer`,
                        ''
                    )
                ) > 0
                and octet_length(
                    ifnull(
                        `view_read_table_impoprt_status_proc_loop`.`identnummer`,
                        ''
                    )
                ) > 0,
                'Importversuch über beide Nummern (WS und ID) nicht erlaubt',
                if(
                    `view_read_table_impoprt_status_proc_loop`.`anzahl_wahlschein_status` > 1
                    and octet_length(
                        ifnull(
                            `view_read_table_impoprt_status_proc_loop`.`identnummer`,
                            ''
                        )
                    ) > 0,
                    'Für die Wahlscheine dieser Identnummer gibt es unterschiedliche Zustände',
                    if(
                        `view_read_table_impoprt_status_proc_loop`.`new_state_name` is null,
                        concat(
                            'Der Status ',
                            `view_read_table_impoprt_status_proc_loop`.`neuer_status`,
                            ' ist für ',
                            `view_read_table_impoprt_status_proc_loop`.`aktueller_status_name`,
                            ' nicht erlaubt'
                        ),
                        ''
                    )
                )
            )
        ) AS `msg`
    from
        `view_read_table_impoprt_status_proc_loop`
) //


CREATE OR REPLACE PROCEDURE `set_wahlschein_status_iterim`()
    BEGIN DECLARE i_wahlscheinnummer varchar(255);
    DECLARE i_identnummer varchar(255);
    DECLARE i_neuer_status varchar(255);
    DECLARE i_errMsg varchar(255);
    DECLARE i_id varchar(255);
    DECLARE i_status varchar(255);
    DECLARE i_alter_status varchar(255);
    DECLARE i_wahlschein_id BIGINT;
    DECLARE done BOOLEAN DEFAULT 0;
    DECLARE importCRS CURSOR FOR
    select
            id,
            wahlscheinnummer,
            identnummer,
            new_state_id,
            msg,
            wahlschein_id,
            wahlscheinstatus
    from
            view_read_table_impoprt_status_proc_final_loop;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
    OPEN importCRS;

    REPEAT FETCH importCRS 
    INTO 
        i_id,
        i_wahlscheinnummer,
        i_identnummer,
        i_neuer_status,
        i_errMsg,
        i_wahlschein_id,
        i_alter_status;

        if (length(i_errMsg) > 0) then
            update
                    wahlschein_status_import
            set
                    processed_state = 0,
                    processed_datetime = now(),
                    processed_user = getsessionuser(),
                    processed_msg = i_errMsg
            where
                    id = i_id;

        else

        -- insert ignore into `change_access_tmg` (wahlschein_id,alter_status,neuer_status,id) values (i_wahlschein_id,i_alter_status,i_neuer_status,uuid());

        update
                wahlschein
        set
                wahlscheinstatus = i_neuer_status
        where

                wahlberechtigte in (
                    select id from wahlberechtigte where identnummer = i_identnummer
                );

        update
                wahlschein_status_import
        set
                processed_state = 1,
                processed_datetime = now(),
                processed_user = getsessionuser(),
                processed_msg = 'OK'
        where
                id = i_id;

        end if;

    UNTIL done
    END REPEAT;

    CLOSE importCRS;

END //

CREATE OR REPLACE PROCEDURE `set_wahlschein_status`()
BEGIN 
    
    drop table if exists matview_readtable_import_status_loop;
    create table matview_readtable_import_status_loop as
    select * from view_readtable_import_status_loop;
    create index idx_matview_readtable_import_status_loop_identnummer on matview_readtable_import_status_loop(identnummer);
    create index idx_matview_readtable_import_status_loop_wahlscheinnummer on matview_readtable_import_status_loop(wahlscheinnummer);

    call set_wahlschein_status_iterim();
END //