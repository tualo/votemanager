delimiter ;


create or replace view view_protokoll_online_erwartet as
select 

sz.name,
sz.id,

ws.c erwartet,
wst.c testdaten_erwartet,
bb.anzahl gueltig,
ebb.anzahl enthaltung,
ubb.anzahl ungueltig

from 

(select * from stimmzettel) sz
left join (select stimmzettel,count(*) c from wahlschein where abgabetyp = 2 and wahlscheinstatus=2
    and testdaten =0 
group by stimmzettel) ws on ws.stimmzettel = sz.id
left join (select stimmzettel,count(*) c from wahlschein where abgabetyp = 2 and wahlscheinstatus=2
    and testdaten =1 
 group by stimmzettel) wst on wst.stimmzettel = sz.id
left join (select stimmzettel,anzahl from ballotbox_decrypted_sum where status = 'gültig') bb on bb.stimmzettel = sz.id
left join (select stimmzettel,anzahl from ballotbox_decrypted_sum where status = 'Enthaltung') ebb on ebb.stimmzettel = sz.id
left join (select stimmzettel,anzahl from ballotbox_decrypted_sum where status = 'ungültig') ubb on ubb.stimmzettel = sz.id
