delimiter ;
create table if not exists wahlschein_blocknumbers (
    blocknumber varchar(30) primary key,
    login varchar(255),
    lastlogin varchar(255),
    createtime datetime not null default current_timestamp,
    lastinsert datetime not null default current_timestamp on update current_timestamp
);

insert ignore into wahlschein_blocknumbers (blocknumber, login, lastlogin) values
('0', 'setup', 'setup');
