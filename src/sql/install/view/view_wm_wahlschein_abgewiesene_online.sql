DELIMITER;

CREATE  VIEW IF NOT EXISTS `view_wm_wahlschein_abgewiesene_online` AS
select
    `wahlschein`.`id` AS `id`,
    `wahlschein`.`updated_at` AS `updated_at`,
    `wahlschein`.`login` AS `login`,
    `wahlberechtigte`.`identnummer` AS `identnummer`,
    `wm_wahlschein_register`.`formdata` AS `formdata`,
    json_value(
        `wm_wahlschein_register`.`formdata`,
        '$.first_name'
    ) AS `firstname`,
    json_value(
        `wm_wahlschein_register`.`formdata`,
        '$.last_name'
    ) AS `lastname`,
    concat(
        ifnull(`wahlberechtigte_anlage`.`identnummer`, ''),
        char(10)
        
    ) AS `fullname`,
    concat(
        ifnull(`wahlberechtigte_anlage`.`identnummer`, ''),
        char(10)
    ) AS `address`,
    group_concat(
        ifnull(`wahlzeichnungsberechtigter`.`name`, '') separator ' '
    ) AS `zb`,
    `stimmzettel`.`name` AS `stimmzettel_name`
from
    (
        (
            (
                (
                    (
                        `wahlschein`
                        join `wm_wahlschein_register` on (`wahlschein`.`id` = `wm_wahlschein_register`.`id`)
                    )
                    join `wahlberechtigte` on (
                        `wahlberechtigte`.`id` = `wahlschein`.`wahlberechtigte`
                    )
                )
                join `wahlberechtigte_anlage` on (
                    `wahlschein`.`id` = concat (
                        `wahlberechtigte_anlage`.`stimmzettel`,
                        lpad (`wahlberechtigte_anlage`.`identnummer`, 12, '0')
                    )
                )
            )
            join `stimmzettel` on (`wahlschein`.`stimmzettel` = `stimmzettel`.`id`)
        )
        join `wahlzeichnungsberechtigter` on (
            `wahlzeichnungsberechtigter`.`wahlberechtigte` = `wahlberechtigte`.`id`
        )
    )
where
    `wahlschein`.`wahlscheinstatus` = 3
    and `wahlschein`.`abgabetyp` = 2
group by
    `wahlschein`.`id`;