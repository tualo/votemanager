DELIMITER;

CREATE
OR REPLACE VIEW `view_kandidaten_sitze_vergeben` AS
select
    `stimmzettelgruppen`.`id` AS `id`,
    count(distinct `kandidaten`.`id`) AS `vergeben`
from
    (
        `kandidaten`
        join `stimmzettelgruppen` on (
            `stimmzettelgruppen`.`id` = `kandidaten`.`stimmzettelgruppen`
        )
    )