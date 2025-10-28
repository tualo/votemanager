DELIMITER ;
CREATE VIEW IF NOT EXISTS `view_readtable_kandidaten` AS
select
    `stimmzettelgruppen`.`sitze` AS `sitze`,
    ifnull (`view_kandidaten_sitze_vergeben`.`vergeben`, 0) AS `vergeben`,
    `stimmzettelgruppen`.`name` AS `stimmzettelgruppen_text`,
    `kandidaten`.`id` AS `id`,
    `kandidaten`.`aktiv` AS `aktiv`,
    `kandidaten`.`titel` AS `titel`,
    `kandidaten`.`vorname` AS `vorname`,
    `kandidaten`.`nachname` AS `nachname`,
    `kandidaten`.`telefon` AS `telefon`,
    `kandidaten`.`email` AS `email`,
    `kandidaten`.`www` AS `www`,
    `kandidaten`.`barcode` AS `barcode`,
    `kandidaten`.`firma1` AS `firma1`,
    `kandidaten`.`firma2` AS `firma2`,
    `kandidaten`.`firma3` AS `firma3`,
    `kandidaten`.`firma4` AS `firma4`,
    `kandidaten`.`firma_strasse` AS `firma_strasse`,
    `kandidaten`.`firma_plz` AS `firma_plz`,
    `kandidaten`.`firma_ort` AS `firma_ort`,
    `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,
    `kandidaten`.`funktion1` AS `funktion1`,
    `kandidaten`.`funktion2` AS `funktion2`,
    `kandidaten`.`funktion3` AS `funktion3`,
    `kandidaten`.`firmen_identnummer` AS `firmen_identnummer`,
    `kandidaten`.`personen_identnummer` AS `personen_identnummer`,
    `kandidaten`.`geburtsdatum` AS `geburtsdatum`,
    `kandidaten`.`geburtsjahr` AS `geburtsjahr`,
    `kandidaten`.`geschlecht` AS `geschlecht`,
    `kandidaten`.`anrede` AS `anrede`,
    `kandidaten`.`branche` AS `branche`,
    `kandidaten`.`kooptiert` AS `kooptiert`,
    `kandidaten`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
    `kandidaten`.`losnummer` AS `losnummer`,
    `kandidaten`.`ist_gewaehlt` AS `ist_gewaehlt`,
    `kandidaten`.`login` AS `login`,
    `kandidaten`.`created_at` AS `created_at`,
    `kandidaten`.`updated_at` AS `updated_at`,
    concat (
        if (
            `kandidaten`.`titel` <> '',
            concat (`kandidaten`.`titel`, ' '),
            ''
        ),
        `kandidaten`.`nachname`,
        ', ',
        `kandidaten`.`vorname`
    ) AS `anzeige_name`,
    concat (
        './dsfiles/kandidaten_bilder/',
        `kandidaten_bilder`.`file_id`
    ) AS `portrait_url`,
    concat ('./dsfiles/kandidaten_bilder/', `bc`.`file_id`) AS `barcode_url`,
    `stimmzettel`.`id` AS `stimmzettel_id`
from
    (
        (
            (
                (
                    (
                        `kandidaten`
                        join `stimmzettelgruppen` on (
                            `stimmzettelgruppen`.`id` = `kandidaten`.`stimmzettelgruppen`
                        )
                    )
                    join `stimmzettel` on (
                        `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`id`
                    )
                )
                left join `view_kandidaten_sitze_vergeben` on (
                    `view_kandidaten_sitze_vergeben`.`id` = `stimmzettelgruppen`.`id`
                )
            )
            left join `kandidaten_bilder` on (
                `kandidaten_bilder`.`kandidat` = `kandidaten`.`id`
                and `kandidaten_bilder`.`typ` = 1
            )
        )
        left join `kandidaten_bilder` `bc` on (
            `bc`.`kandidat` = `kandidaten`.`id`
            and `kandidaten_bilder`.`typ` = 0
        )
    )