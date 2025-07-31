delimiter ;
insert ignore into wahlscheinstatus_grund (id,name,aktiv,barcode,wahlscheinstatus,login,created_at,updated_at) values (0,'unbekannt',1,uuid(),1,'setup',now(),now()); 