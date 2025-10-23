delimiter ;
create table if not exists kandidaten_stimmzettelgruppen (
    kandidaten_id integer,
    stimmzettelgruppen_id integer,
    barcode varchar(36),
    aktiv tinyint default 0,
    primary key (kandidaten_id,stimmzettelgruppen_id),
    constraint `fk_kandidaten_stimmzettelgruppen_kandidaten_id` foreign key (kandidaten_id) references `kandidaten` (id) on delete cascade on update cascade,
    constraint `fk_kandidaten_stimmzettelgruppen_stimmzettelgruppen_id` foreign key (stimmzettelgruppen_id) references `stimmzettelgruppen` (id) on delete cascade on update cascade
);

create or replace view `view_readtable_kandidaten_stimmzettelgruppen` as
select 
    kandidaten.id as kandidaten_id,
    stimmzettelgruppen.id as stimmzettelgruppen_id,
    ifnull(kandidaten_stimmzettelgruppen.barcode,uuid()) as barcode,
    ifnull(kandidaten_stimmzettelgruppen.aktiv,0) as aktiv
from 
    kandidaten
    join stimmzettelgruppen on 1=1
    left join kandidaten_stimmzettelgruppen
    on kandidaten_stimmzettelgruppen.kandidaten_id = kandidaten.id
    and kandidaten_stimmzettelgruppen.stimmzettelgruppen_id = stimmzettelgruppen.id
;   

