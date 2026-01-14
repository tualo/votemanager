DELIMITER ;
CREATE OR REPLACE VIEW `view_beteiligung_stimmzettel` AS (
    select
        cast(`wahlschein`.`row_start` as date) AS `datum_ts`,
       cast(`wahlschein`.`row_start` as date) AS `datum`,
        `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `wahlschein`.`stimmzettel` AS `stimmzettel`,
        `x`.`waehler` AS `ges_SZ`,
        `x`.`name` AS `SZ`,
        sum(if(`wahlschein`.`abgabetyp` = 1, 1, 0)) AS `briefwahl`,
        sum(if(`wahlschein`.`abgabetyp` = 1, 1, 0)) * 1000 / `x`.`waehler` AS `briefwahl_prozent`,
        0 AS `onlinewahl`,
        0 AS `onlinewahl_prozent`
    from
        (
            `wahlschein`
            join (
                select
                    `stimmzettel`.`name` AS `name`,
                    `stimmzettel`.`id` AS `id`,
                    count(
                        distinct concat(
                            `wahlschein`.`wahlscheinnummer`,
                            `wahlschein`.`wahlscheinstatus`
                        )
                    ) AS `waehler`
                from
                    (
                        `stimmzettel`
                        join `wahlschein` on(
                            `wahlschein`.`stimmzettel` = `stimmzettel`.`id`
                        )
                    )
                group by
                    `stimmzettel`.`id`
            ) `x` on(`wahlschein`.`stimmzettel` = `x`.`id`)
        )
    where
        `wahlschein`.`wahlscheinstatus` = 2
    group by
        cast(`wahlschein`.`row_start` as date),
        `wahlschein`.`wahlscheinstatus`,
        `wahlschein`.`stimmzettel`
);

CREATE
OR REPLACE VIEW `view_beteiligung_stimmzettel_pro_tag` AS (
    select
        distinct `view_beteiligung_stimmzettel`.`datum` AS `datum`
    from
        `view_beteiligung_stimmzettel`
);