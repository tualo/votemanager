DELIMITER //

create table if not exists `briefwahlkandidaten` (

    `id` int(11) primary key,
    `stimmzettelgruppen`	integer not null,
    `briefstimmen`	bigint(21),

    CONSTRAINT `fk_briefwahlkandidaten_id`
    foreign key (`id`)
    
    references `kandidaten`(`id`)
    on delete cascade
    on update cascade,


    CONSTRAINT `fk_briefwahlkandidaten_stimmzettelgruppen`
    foreign key (`stimmzettelgruppen`)
    
    references `stimmzettelgruppen`(`id`)
    on delete cascade
    on update cascade,

    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp
) //

