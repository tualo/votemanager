delimiter ;
create table if not EXISTS votemanager_setup_involvement_types (
    id varchar(100) not null,
    title varchar(128) not null,
    created_at timestamp null default current_timestamp(),
    updated_at timestamp null default current_timestamp() on update current_timestamp(),
    primary key (id)
);

insert ignore into votemanager_setup_involvement_types (id, title) values ('stimmzettel', 'Stimmzettel');
insert ignore into votemanager_setup_involvement_types (id, title) values ('stimmzettelgruppe', 'Stimmzettelgruppe');
insert ignore into votemanager_setup_involvement_types (id, title) values ('wahlgruppe', 'Wahlgruppe');
insert ignore into votemanager_setup_involvement_types (id, title) values ('wahlbezirk', 'Wahlbezirk');