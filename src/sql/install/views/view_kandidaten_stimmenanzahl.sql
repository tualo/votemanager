CREATE VIEW `view_kandidaten_stimmenanzahl` AS
with
    basedata_szg as (
        select
            dense_rank() over (
                partition by
                    `stimmzettel`.`id`,
                    `stimmzettelgruppen`.`id`
                order by
                    ifnull (`kandidaten`.`kooptiert`, 0) desc,
                    ifnull (`onlinekandidaten`.`anzahl`, 0) + ifnull (`briefwahlkandidaten`.`briefstimmen`, 0) desc,
                    if (
                        `kandidaten`.`losnummer_stimmzettelgruppe` = 0,
                        1000000,
                        `kandidaten`.`losnummer_stimmzettelgruppe`
                    )
            ) AS `stimmzettelgruppen_rang`,
            `kandidaten`.`id` AS `id`,
            `kandidaten`.`barcode` AS `barcode`,
            `kandidaten`.`losnummer` AS `losnummer`,
            `kandidaten`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
            `kandidaten`.`kooptiert` AS `kooptiert`,
            `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,
            `stimmzettel`.`name` AS `stimmzettel_name`,
            `stimmzettelgruppen`.`id` AS `stimmzettelgruppen_id`,
            `stimmzettel`.`id` AS `stimmzettel_id`,
            `stimmzettelgruppen`.`name` AS `stimmzettelgruppen_name`,
            `stimmzettel`.`sitze` AS `stimmzettel_sitze`,
            `stimmzettelgruppen`.`sitze` AS `stimmzettelgruppen_sitze`,
            `stimmzettelgruppen`.`mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
            ifnull (`onlinekandidaten`.`anzahl`, 0) AS `onlinestimmen`,
            ifnull (`briefwahlkandidaten`.`briefstimmen`, 0) AS `offlinestimmen`,
            ifnull (`onlinekandidaten`.`anzahl`, 0) + ifnull (`briefwahlkandidaten`.`briefstimmen`, 0) AS `gesamtstimmen`,
            `onlinestimmzettel`.`erwartet` AS `onlinestimmzettel_erwartet`,
            `onlinestimmzettel`.`anzahl` AS `onlinestimmzettel_anzahl`,
            `briefwahlstimmzettel`.`erwartet` AS `briefwahlstimmzettel_erwartet`,
            `briefwahlstimmzettel`.`anzahl` AS `briefwahlstimmzettel_anzahl`
        from
            (
                (
                    (
                        (
                            (
                                (
                                    `kandidaten`
                                    join `stimmzettelgruppen` on (
                                        `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`id`
                                    )
                                )
                                join `stimmzettel` on (
                                    `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`id`
                                )
                            )
                            join `onlinekandidaten` on (`onlinekandidaten`.`id` = `kandidaten`.`id`)
                        )
                        join `briefwahlkandidaten` on (`briefwahlkandidaten`.`id` = `kandidaten`.`id`)
                    )
                    join `briefwahlstimmzettel` on (
                        `stimmzettel`.`id` = `briefwahlstimmzettel`.`stimmzettel`
                    )
                )
                join `onlinestimmzettel` on (
                    `stimmzettel`.`id` = `onlinestimmzettel`.`stimmzettel`
                )
            )
        order by
            ifnull (`onlinekandidaten`.`anzahl`, 0) + ifnull (`briefwahlkandidaten`.`briefstimmen`, 0) desc
    ),
    basedata as (
        select
            `basedata_szg`.`stimmzettel_id` AS `stimmzettel_id`,
            dense_rank() over (
                partition by
                    `basedata_szg`.`stimmzettel_id`
                order by
                    ifnull (`basedata_szg`.`kooptiert`, 0) desc,
                    if (
                        `basedata_szg`.`stimmzettelgruppen_rang` <= `basedata_szg`.`stimmzettelgruppen_mindestsitze`,
                        1,
                        0
                    ) desc,
                    ifnull (`basedata_szg`.`onlinestimmen`, 0) + ifnull (`basedata_szg`.`offlinestimmen`, 0) desc,
                    if (
                        `basedata_szg`.`losnummer_stimmzettelgruppe` = 0,
                        2000000,
                        `basedata_szg`.`losnummer_stimmzettelgruppe`
                    ),
                    if (
                        `basedata_szg`.`losnummer` = 0,
                        1000000,
                        `basedata_szg`.`losnummer`
                    )
            ) AS `stimmzettel_rang`,
            `basedata_szg`.`stimmzettel_name` AS `stimmzettel_name`,
            `basedata_szg`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
            `basedata_szg`.`stimmzettelgruppen_id` AS `stimmzettelgruppen_id`,
            `basedata_szg`.`stimmzettelgruppen_rang` AS `stimmzettelgruppen_rang`,
            `basedata_szg`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
            `basedata_szg`.`stimmzettelgruppen_sitze` AS `stimmzettelgruppen_sitze`,
            `basedata_szg`.`id` AS `id`,
            `basedata_szg`.`barcode` AS `barcode`,
            `basedata_szg`.`losnummer` AS `losnummer`,
            `basedata_szg`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
            `basedata_szg`.`kooptiert` AS `kooptiert`,
            `basedata_szg`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
            `basedata_szg`.`onlinestimmen` AS `onlinestimmen`,
            `basedata_szg`.`offlinestimmen` AS `offlinestimmen`,
            `basedata_szg`.`gesamtstimmen` AS `gesamtstimmen`,
            `basedata_szg`.`onlinestimmzettel_erwartet` AS `onlinestimmzettel_erwartet`,
            `basedata_szg`.`onlinestimmzettel_anzahl` AS `onlinestimmzettel_anzahl`,
            `basedata_szg`.`briefwahlstimmzettel_erwartet` AS `briefwahlstimmzettel_erwartet`,
            `basedata_szg`.`briefwahlstimmzettel_anzahl` AS `briefwahlstimmzettel_anzahl`
        from
            `basedata_szg`
    ),
    setup as (
        select
            `votemanager_setup`.`id` AS `id`,
            `votemanager_setup`.`val` AS `val`,
            `votemanager_setup`.`created_at` AS `created_at`,
            `votemanager_setup`.`updated_at` AS `updated_at`
        from
            `votemanager_setup`
        where
            `votemanager_setup`.`id` = 'wm_report_base'
    ),
    predata as (
        select
            `setup`.`val` AS `val`,
            `basedata`.`stimmzettel_id` AS `use_id`,
            `basedata`.`stimmzettel_rang` AS `use_rang`,
            `basedata`.`stimmzettel_name` AS `use_name`,
            `basedata`.`stimmzettel_sitze` AS `use_sitze`,
            row_number() over (
                partition by
                    `basedata`.`stimmzettel_id`
                order by
                    `basedata`.`stimmzettel_rang`,
                    `basedata`.`id`
            ) AS `rn`,
            row_number() over (
                partition by
                    `basedata`.`stimmzettel_id`
                order by
                    `basedata`.`stimmzettel_rang`,
                    `basedata`.`id`
            ) <= `basedata`.`stimmzettel_sitze` AS `gewaehlt`,
            `basedata`.`stimmzettel_id` AS `stimmzettel_id`,
            `basedata`.`stimmzettel_rang` AS `stimmzettel_rang`,
            `basedata`.`stimmzettel_name` AS `stimmzettel_name`,
            `basedata`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
            `basedata`.`stimmzettelgruppen_id` AS `stimmzettelgruppen_id`,
            `basedata`.`stimmzettelgruppen_rang` AS `stimmzettelgruppen_rang`,
            `basedata`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
            `basedata`.`stimmzettelgruppen_sitze` AS `stimmzettelgruppen_sitze`,
            `basedata`.`id` AS `id`,
            `basedata`.`barcode` AS `barcode`,
            `basedata`.`losnummer` AS `losnummer`,
            `basedata`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
            `basedata`.`kooptiert` AS `kooptiert`,
            `basedata`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
            `basedata`.`onlinestimmen` AS `onlinestimmen`,
            `basedata`.`offlinestimmen` AS `offlinestimmen`,
            `basedata`.`gesamtstimmen` AS `gesamtstimmen`,
            `basedata`.`onlinestimmzettel_erwartet` AS `onlinestimmzettel_erwartet`,
            `basedata`.`onlinestimmzettel_anzahl` AS `onlinestimmzettel_anzahl`,
            `basedata`.`briefwahlstimmzettel_erwartet` AS `briefwahlstimmzettel_erwartet`,
            `basedata`.`briefwahlstimmzettel_anzahl` AS `briefwahlstimmzettel_anzahl`
        from
            (
                `basedata`
                join `setup` on (`setup`.`val` = 'stimmzettel')
            )
        union all
        select
            `setup`.`val` AS `val`,
            `basedata`.`stimmzettelgruppen_id` AS `use_id`,
            `basedata`.`stimmzettelgruppen_rang` AS `use_rang`,
            `basedata`.`stimmzettelgruppen_name` AS `use_name`,
            `basedata`.`stimmzettelgruppen_sitze` AS `use_sitze`,
            row_number() over (
                partition by
                    `basedata`.`stimmzettelgruppen_id`
                order by
                    `basedata`.`stimmzettelgruppen_rang`,
                    `basedata`.`id`
            ) AS `rn`,
            row_number() over (
                partition by
                    `basedata`.`stimmzettelgruppen_id`
                order by
                    `basedata`.`stimmzettelgruppen_rang`,
                    `basedata`.`id`
            ) <= `basedata`.`stimmzettelgruppen_sitze` AS `gewaehlt`,
            `basedata`.`stimmzettel_id` AS `stimmzettel_id`,
            `basedata`.`stimmzettel_rang` AS `stimmzettel_rang`,
            `basedata`.`stimmzettel_name` AS `stimmzettel_name`,
            `basedata`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
            `basedata`.`stimmzettelgruppen_id` AS `stimmzettelgruppen_id`,
            `basedata`.`stimmzettelgruppen_rang` AS `stimmzettelgruppen_rang`,
            `basedata`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
            `basedata`.`stimmzettelgruppen_sitze` AS `stimmzettelgruppen_sitze`,
            `basedata`.`id` AS `id`,
            `basedata`.`barcode` AS `barcode`,
            `basedata`.`losnummer` AS `losnummer`,
            `basedata`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
            `basedata`.`kooptiert` AS `kooptiert`,
            `basedata`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
            `basedata`.`onlinestimmen` AS `onlinestimmen`,
            `basedata`.`offlinestimmen` AS `offlinestimmen`,
            `basedata`.`gesamtstimmen` AS `gesamtstimmen`,
            `basedata`.`onlinestimmzettel_erwartet` AS `onlinestimmzettel_erwartet`,
            `basedata`.`onlinestimmzettel_anzahl` AS `onlinestimmzettel_anzahl`,
            `basedata`.`briefwahlstimmzettel_erwartet` AS `briefwahlstimmzettel_erwartet`,
            `basedata`.`briefwahlstimmzettel_anzahl` AS `briefwahlstimmzettel_anzahl`
        from
            (
                `basedata`
                join `setup` on (`setup`.`val` = 'stimmzettelgruppen')
            )
    ),
    finalcheck as (
        select
            `x`.`use_id` AS `use_id`,
            `x`.`is_final` AS `is_final`
        from
            (
                select
                    0 AS `is_final`,
                    `predata`.`use_id` AS `use_id`,
                    `predata`.`use_rang` AS `use_rang`,
                    count(0) AS `cnt`
                from
                    `predata`
                group by
                    `predata`.`use_id`,
                    `predata`.`use_rang`
                having
                    `cnt` > 1
            ) `x`
        group by
            `x`.`use_id`
    )
select
    ifnull (`finalcheck`.`is_final`, 1) AS `is_final`,
    `predata`.`val` AS `val`,
    `predata`.`use_id` AS `use_id`,
    `predata`.`use_rang` AS `use_rang`,
    `predata`.`use_name` AS `use_name`,
    `predata`.`use_sitze` AS `use_sitze`,
    `predata`.`rn` AS `rn`,
    `predata`.`gewaehlt` AS `gewaehlt`,
    `predata`.`stimmzettel_id` AS `stimmzettel_id`,
    `predata`.`stimmzettel_rang` AS `stimmzettel_rang`,
    `predata`.`stimmzettel_name` AS `stimmzettel_name`,
    `predata`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
    `predata`.`stimmzettelgruppen_id` AS `stimmzettelgruppen_id`,
    `predata`.`stimmzettelgruppen_rang` AS `stimmzettelgruppen_rang`,
    `predata`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
    `predata`.`stimmzettelgruppen_sitze` AS `stimmzettelgruppen_sitze`,
    `predata`.`id` AS `id`,
    `predata`.`barcode` AS `barcode`,
    `predata`.`losnummer` AS `losnummer`,
    `predata`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
    `predata`.`kooptiert` AS `kooptiert`,
    `predata`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
    `predata`.`onlinestimmen` AS `onlinestimmen`,
    `predata`.`offlinestimmen` AS `offlinestimmen`,
    `predata`.`gesamtstimmen` AS `gesamtstimmen`,
    `predata`.`onlinestimmzettel_erwartet` AS `onlinestimmzettel_erwartet`,
    `predata`.`onlinestimmzettel_anzahl` AS `onlinestimmzettel_anzahl`,
    `predata`.`briefwahlstimmzettel_erwartet` AS `briefwahlstimmzettel_erwartet`,
    `predata`.`briefwahlstimmzettel_anzahl` AS `briefwahlstimmzettel_anzahl`
from
    (
        `predata`
        left join `finalcheck` on (`predata`.`use_id` = `finalcheck`.`use_id`)
    );