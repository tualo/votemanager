delimiter ;
 

insert ignore into wahlscheinstatus_online_erlaubt (wahlscheinstatus,abgabetyp) values (1,0);
update wahlschein set abgabetyp = 0 where abgabetyp is null ;
