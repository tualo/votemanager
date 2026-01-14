DELIMITER ;


CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_status` (
  `wahlbeteiligung_bericht` integer NOT NULL,
  `wahlscheinstatus` integer NOT NULL,
  `aktiv` tinyint DEFAULT 0,
  PRIMARY KEY (`wahlbeteiligung_bericht`,`wahlscheinstatus`),

  KEY `idx_wahlbeteiligung_bericht_status_wahlbeteiligung_bericht` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_status_wahlscheinstatus` (`wahlscheinstatus`),

  CONSTRAINT `fk_wahlbeteiligung_bericht_status_wahlbeteiligung_bericht` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bericht_status_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*
alter table wahlbeteiligung_bericht_status drop constraint if exists fk_wahlbeteiligung_bericht_status_wahlscheinstatus;
alter table wahlbeteiligung_bericht_status add CONSTRAINT `fk_wahlbeteiligung_bericht_status_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
*/
create or replace view view_readtable_wahlbeteiligung_bericht_status as


select 
wahlbeteiligung_bericht.id as `wahlbeteiligung_bericht_id`,
wahlscheinstatus.id as `wahlscheinstatus`,
ifnull(wahlbeteiligung_bericht_status.aktiv, 0) as `aktiv`
from 

wahlbeteiligung_bericht
join wahlscheinstatus 
left join wahlbeteiligung_bericht_status on
    wahlbeteiligung_bericht_status.wahlbeteiligung_bericht = wahlbeteiligung_bericht.id
    and wahlbeteiligung_bericht_status.wahlscheinstatus = wahlscheinstatus.id

