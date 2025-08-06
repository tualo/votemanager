delimiter ;
create   view if not exists view_stimmzettel_default as
select
    stimmzettel.*,
    stimmzettel.id group_id
from
stimmzettel;