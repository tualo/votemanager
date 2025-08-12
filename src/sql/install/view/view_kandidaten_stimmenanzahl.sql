DELIMITER;


create or replace view `view_kandidaten_stimmenanzahl` as


with basedata_szg as (
select
    dense_rank() over (
        partition by 
            `stimmzettel`.`id`,
            `stimmzettelgruppen`.`id`
        order by
            
            ifnull(`kandidaten`.`kooptiert`,0) desc,

            ifnull(`onlinekandidaten`.`anzahl`, 0) 
            + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) desc,
            
            if(
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

    `onlinekandidaten`.`anzahl` AS `onlinestimmen`,
    `briefwahlkandidaten`.`briefstimmen`AS `offlinestimmen`,
    `onlinekandidaten`.`anzahl` + `briefwahlkandidaten`.`briefstimmen` AS `gesamtstimmen`,

    onlinestimmzettel.erwartet AS `onlinestimmzettel_erwartet`,
    onlinestimmzettel.enthaltung AS `onlinestimmzettel_enthaltung`,
    onlinestimmzettel.ungueltig AS `onlinestimmzettel_ungueltig`,
    onlinestimmzettel.anzahl AS `onlinestimmzettel_anzahl`,
    briefwahlstimmzettel.erwartet AS `briefwahlstimmzettel_erwartet`,
    briefwahlstimmzettel.enthaltung AS `briefwahlstimmzettel_enthaltung`,
    briefwahlstimmzettel.ungueltig AS `briefwahlstimmzettel_ungueltig`,
    briefwahlstimmzettel.anzahl AS `briefwahlstimmzettel_anzahl`
from
    (
        (
            (
                (
                    `kandidaten`
                    join `stimmzettelgruppen` on(
                        `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`id`
                    )
                )
                join `stimmzettel` on(
                    `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`id`
                )
            )
            join `onlinekandidaten` on(
                `onlinekandidaten`.`id` = `kandidaten`.`id`
            )
        )
        join `briefwahlkandidaten` on(
            `briefwahlkandidaten`.`id` = `kandidaten`.`id`
        )
        join `briefwahlstimmzettel` on(
            `stimmzettel`.`id` = `briefwahlstimmzettel`.`stimmzettel`
        )
        join `onlinestimmzettel` on(
            `stimmzettel`.`id` = `onlinestimmzettel`.`stimmzettel`
        )
    )
order by
    `onlinekandidaten`.`anzahl` + `briefwahlkandidaten`.`briefstimmen` desc
), basedata as (
    select 
        stimmzettel_id,
            
        dense_rank() over (
            partition by 

                stimmzettel_id
            
            order by

                kooptiert desc,


                if (
                    `stimmzettelgruppen_rang` <=  `stimmzettelgruppen_mindestsitze`,
                    1,
                    0
                ) desc,


                onlinestimmen + offlinestimmen desc,

                if(
                    `losnummer_stimmzettelgruppe` = 0,
                    2000000,
                    `losnummer_stimmzettelgruppe`
                ),

                if(
                    `losnummer` = 0,
                    1000000,
                    `losnummer`
                )

        ) AS `stimmzettel_rang`,
        stimmzettel_name,
        stimmzettel_sitze,
        stimmzettelgruppen_id,
        stimmzettelgruppen_rang,
        stimmzettelgruppen_name,
        stimmzettelgruppen_sitze,
        id,
        barcode,
        losnummer,
        losnummer_stimmzettelgruppe,
        kooptiert,
        stimmzettelgruppen_mindestsitze,

        onlinestimmen,
        offlinestimmen,
        gesamtstimmen,

        onlinestimmzettel_erwartet,
        onlinestimmzettel_enthaltung,
        onlinestimmzettel_ungueltig,
        onlinestimmzettel_anzahl,
        briefwahlstimmzettel_erwartet,
        briefwahlstimmzettel_enthaltung,
        briefwahlstimmzettel_ungueltig,
        briefwahlstimmzettel_anzahl
    from basedata_szg
)


, 

setup as (
    select * from votemanager_setup where id='wm_report_base'
), predata as (
    select 
        setup.val,
        stimmzettel_id use_id,
        stimmzettel_rang use_rang,
        stimmzettel_name use_name,
        stimmzettel_sitze use_sitze,

        row_number() over (partition by stimmzettel_id order by barcode) listenplatz,
        
        row_number() over (partition by stimmzettel_id order by stimmzettel_rang,id) rn,
        row_number() over (partition by stimmzettel_id order by stimmzettel_rang,id)<=stimmzettel_sitze as gewaehlt,
        basedata.*
    from basedata join setup on   setup.val='stimmzettel'

    union all 
        
    select 
        setup.val,
        stimmzettelgruppen_id use_id,
        stimmzettelgruppen_rang use_rang,
        stimmzettelgruppen_name use_name,
        stimmzettelgruppen_sitze use_sitze,

        row_number() over (partition by stimmzettelgruppen_id order by barcode) listenplatz,

        row_number() over (partition by stimmzettelgruppen_id order by stimmzettelgruppen_rang,id) rn,
        row_number() over (partition by stimmzettelgruppen_id order by stimmzettelgruppen_rang,id)<=stimmzettelgruppen_sitze as gewaehlt,
        basedata.*
    from basedata join setup on   setup.val='stimmzettelgruppen'
), 

finalcheck as (
    select 
        use_id,
        is_final
    from (
        select 
            0 is_final,
            use_id,
            use_rang,
            count(*) as cnt
        from predata
        group by use_id,use_rang
        having cnt > 1
    ) x group by use_id
)

select 
    ifnull(finalcheck.is_final, 1) as is_final,
    predata.* 
from 
    predata
    left join 
    finalcheck
    on predata.use_id = finalcheck.use_id 

