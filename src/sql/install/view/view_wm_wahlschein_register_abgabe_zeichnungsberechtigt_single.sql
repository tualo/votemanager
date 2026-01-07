selimiter ;
CREATE VIEW
    IF NOT EXISTS `view_wm_wahlschein_register_abgabe_zeichnungsberechtigt_single` AS
select
    `wahlschein`.`id` AS `id`,
    regexp_replace (
        json_value (
            `wm_wahlschein_register`.`formdata`,
            '$.first_name'
        ),
        '[^0-9sa-zA-ZäöüÄÖÜß]',
        ' '
    ) AS `fn`,
    regexp_replace (
        json_value (
            `wm_wahlschein_register`.`formdata`,
            '$.last_name'
        ),
        '[^0-9sa-zA-ZäöüÄÖÜß]',
        ' '
    ) AS `ln`,
    `wahlzeichnungsberechtigter`.`personenident` AS `personenident`,
    `wahlzeichnungsberechtigter`.`vorname` AS `vorname`,
    `wahlzeichnungsberechtigter`.`nachname` AS `nachname`,
    `wahlzeichnungsberechtigter`.`funktion` AS `funktion`,
    `wahlschein`.`stimmzettel` AS `stimmzettel`,
    `wahlberechtigte`.`identnummer` AS `identnummer`,
    if (
        json_value (
            `wm_wahlschein_register`.`formdata`,
            '$.first_name'
        ) = `wahlzeichnungsberechtigter`.`vorname`
        and json_value (
            `wm_wahlschein_register`.`formdata`,
            '$.last_name'
        ) = `wahlzeichnungsberechtigter`.`nachname`
        or json_value (
            `wm_wahlschein_register`.`formdata`,
            '$.first_name'
        ) = `wahlzeichnungsberechtigter`.`nachname`
        and json_value (
            `wm_wahlschein_register`.`formdata`,
            '$.last_name'
        ) = `wahlzeichnungsberechtigter`.`vorname`,
        'match',
        'no match'
    ) AS `status`,
    `wm_wahlschein_register`.`formdata` AS `formdata`,
    `wm_wahlschein_register`.`createdate` AS `createdate`,
    `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`
from
    (
        (
            (
                `wm_wahlschein_register`
                join `wahlschein` on (`wm_wahlschein_register`.`id` = `wahlschein`.`id`)
            )
            join `wahlberechtigte` on (
                `wahlberechtigte`.`id` = `wahlschein`.`wahlberechtigte`
            )
        )
        left join `wahlzeichnungsberechtigter` on (
            `wahlberechtigte`.`id` = `wahlzeichnungsberechtigter`.`wahlberechtigte`
        )
    )
where
    `wahlschein`.`wahlscheinstatus` in (-8, 8)
    and `wahlschein`.`abgabetyp` = 2
order by
    `wahlschein`.`wahlscheinstatus`;