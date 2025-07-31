DELIMITER //



CREATE OR REPLACE PROCEDURE `proc_briefwahlkandidaten`()
BEGIN


    if 
        exists(select * from  briefwahlkandidaten where updated_at < now() + interval - 1 minute) 
        or  
        exists(select count(*) c  from  briefwahlkandidaten having c=0) 
    then

        for rec in (
                with x as (
                    select 
                        `kandidaten`.`id` AS `id`,
                        `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,
                        count(0) AS `briefstimmen`,
                        `kandidaten`.`barcode` AS `zaehlung_barcode`,
                        `stimmzettel2`.`stimmzettel` AS `zaehlung_stimmzettel`
                    from (
                            (
                                (
                                    (
                                        (
                                            `kandidaten2`
                                            join `stimmzettel2` on(
                                                `kandidaten2`.`stimmzettel2` = `stimmzettel2`.`id`
                                            )
                                        )
                                        join `stapel2` on(
                                            `stimmzettel2`.`stapel2` = `stapel2`.`id`
                                            and `stapel2`.`abgebrochen` = 0
                                        )
                                    )
                                    join `kisten2` on(`stapel2`.`kisten2` = `kisten2`.`id`)
                                )
                                join `kandidaten` on(`kandidaten`.`id` = `kandidaten2`.`kandidaten`)
                            )
                            join `stimmzettelgruppen` on(
                                `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`id`
                            )
                        )
                    group by `kandidaten`.`id`
                )
                select 
                    `kandidaten`.`id`,
                    `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,

                    ifnull(x.briefstimmen,0) briefstimmen,
                    ifnull(x.zaehlung_barcode,`kandidaten`.`barcode`)  AS `zaehlung_barcode`,
                    ifnull(x.zaehlung_stimmzettel,stimmzettelgruppen.`stimmzettel`) AS `zaehlung_stimmzettel`

                from 
                    kandidaten
                    join `stimmzettelgruppen` on(
                        `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`id`
                    )
                    left join x on kandidaten.id = x.id
        ) do
            insert into `briefwahlkandidaten`  (
                `id`,
                `stimmzettelgruppen`,
                `briefstimmen`
            ) values 
            (
                rec.id,
                rec.stimmzettelgruppen,
                rec.briefstimmen
            )
            on duplicate key update `briefstimmen`=values(`briefstimmen`)
            ;
        end for;




        -- ------------------------------------------- ------------------------------------------- -------------------------------------------

        insert into `briefwahlstimmzettel`
        (
            `stimmzettel`,
            `erwartet`,
            `login`
        )

        select 
            stimmzettel,
            count(*) erwartet,
            getSessionUser() AS `login` from wahlschein where wahlscheinstatus = 2 and abgabetyp=1 group by stimmzettel
        on duplicate key update `erwartet`=values(`erwartet`),`login`=values(`login`)
        ;

        insert into `onlinestimmzettel`
        (
            `stimmzettel`,
            `erwartet`,
            `login`
        )

        select stimmzettel,count(*) erwartet,
            getSessionUser() AS `login` from wahlschein where wahlscheinstatus = 2 and abgabetyp=2 group by stimmzettel
        on duplicate key update `erwartet`=values(`erwartet`),`login`=values(`login`)
        ;


        insert into `briefwahlstimmzettel`
        (
            `stimmzettel`,
            `anzahl`,
            `login`
        )

                select 
            `stimmzettel2`.`stimmzettel` AS `stimmzettel`,
            count(`stimmzettel2`.id) AS `anzahl`,
            getSessionUser() AS `login`
        from 
            (
                `stimmzettel2` 
                join `stapel2` on(
                    `stimmzettel2`.`stapel2` = `stapel2`.`id`
                    and `stapel2`.`abgebrochen` = 0
                )
            )
        group by `stimmzettel2`.`stimmzettel` 

        on duplicate key update `anzahl`=values(`anzahl`),`login`=values(`login`)
        ;

    end if;

end //