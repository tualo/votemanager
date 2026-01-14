delimiter ;
create or replace view kandidaten_stimmenanzahl_losentscheid_stimmzettel as 
select 

    use_id,
    use_name,
    use_rang,
    count(*) c,
    group_concat(view_kandidaten_stimmenanzahl.anzeige_name separator '|') x,
    min(rn) min_rn,
    max(rn) max_rn,
    use_sitze,
    gesamtstimmen,

    if (
        min(rn) <= use_sitze and max(rn) > use_sitze,
        'Einzugslosung',
        if (
            min(rn) > use_sitze and max(rn) > use_sitze,
            'Nachrückerlosung',
            'Rangfolgelosung'
        )
    ) AS `msg`,

    JSON_ARRAYAGG(
        json_object (
            'name',  `view_readtable_kandidaten`.`anzeige_name`,
            'barcode', `view_readtable_kandidaten`.`barcode`,
            'id',  `view_readtable_kandidaten`.`id`,
            'stimmzettelgruppen_text', `view_readtable_kandidaten`.`stimmzettelgruppen_text`
        )
    ) AS `kn`
from 

    view_kandidaten_stimmenanzahl
    join view_readtable_kandidaten on 
        view_kandidaten_stimmenanzahl.id = view_readtable_kandidaten.id

group by use_id,use_rang
having c>1
;