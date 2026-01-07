DELIMITER;

CREATE VIEW
    IF NOT EXISTS `view_wm_wahlschein_register_abgabe_zeichnungsberechtigt` AS
select
    `w`.`id` AS `id`,
    max(`w`.`fn`) AS `vorname`,
    max(`w`.`ln`) AS `nachname`,
    max(`w`.`identnummer`) AS `identnummer`,
    max(`w`.`stimmzettel`) AS `stimmzettel`,
    max(`w`.`wahlscheinstatus`) AS `wahlscheinstatus`
from
    `view_wm_wahlschein_register_abgabe_zeichnungsberechtigt_single` `w`
group by
    `w`.`id`;