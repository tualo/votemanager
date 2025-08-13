DELIMITER ;

CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_abgabetyp` (
  `bericht_id` int(11) NOT NULL,
  `abgabetyp` int(11) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`bericht_id`, `abgabetyp`),
  KEY `idx_wahlbeteiligung_bericht_abgabetyp_bericht_id` (`bericht_id`),
  CONSTRAINT `fk_wahlbeteiligung_bericht_abgabetyp_bericht_id` FOREIGN KEY (`bericht_id`) REFERENCES `wahlbeteiligung_bericht` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bericht_abgabetyp_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

create or replace view view_readtable_wahlbeteiligung_bericht_abgabetyp as
select 
wahlbeteiligung_bericht.id as `bericht_id`,
abgabetyp.id as `abgabetyp`,
ifnull(wahlbeteiligung_bericht_abgabetyp.aktiv, 0) as `aktiv`
from 

wahlbeteiligung_bericht
join abgabetyp 
left join wahlbeteiligung_bericht_abgabetyp on
    wahlbeteiligung_bericht_abgabetyp.bericht_id = wahlbeteiligung_bericht.id
    and wahlbeteiligung_bericht_abgabetyp.abgabetyp = abgabetyp.id;