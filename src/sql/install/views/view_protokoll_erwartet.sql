delimiter ;

-- create or replace view view_kandidaten_stimmenanzahl_monitor as

create or replace view view_protokoll_erwartet as
select 
    use_id,
    use_name,
    use_sitze,


    max(onlinestimmzettel_erwartet) as onlinestimmzettel_erwartet,
    max(onlinestimmzettel_enthaltung) as onlinestimmzettel_enthaltung,
    max(onlinestimmzettel_ungueltig) as onlinestimmzettel_ungueltig,
    max(onlinestimmzettel_anzahl) as onlinestimmzettel_anzahl,


    
    max(briefwahlstimmzettel_erwartet) as briefwahlstimmzettel_erwartet,
    max(briefwahlstimmzettel_enthaltung) as briefwahlstimmzettel_enthaltung,
    max(briefwahlstimmzettel_ungueltig) as briefwahlstimmzettel_ungueltig,
    max(briefwahlstimmzettel_anzahl) as briefwahlstimmzettel_anzahl,


    (max(onlinestimmzettel_anzahl) +  max(onlinestimmzettel_enthaltung) +  max(onlinestimmzettel_ungueltig) )/    max(onlinestimmzettel_erwartet) `onlinewahl_quote`,
    (max(briefwahlstimmzettel_anzahl) +  max(briefwahlstimmzettel_enthaltung) +  max(briefwahlstimmzettel_ungueltig) )/    max(briefwahlstimmzettel_erwartet) `briefwahl_quote`,

    (max(briefwahlstimmzettel_anzahl) +  max(briefwahlstimmzettel_enthaltung) +  max(briefwahlstimmzettel_ungueltig) +max(onlinestimmzettel_anzahl) +  max(onlinestimmzettel_enthaltung) +  max(onlinestimmzettel_ungueltig) )/   ( max(briefwahlstimmzettel_erwartet) + max(onlinestimmzettel_erwartet) ) `gesamt_quote`
from 
    view_kandidaten_stimmenanzahl
group by     
    use_id,
    use_name