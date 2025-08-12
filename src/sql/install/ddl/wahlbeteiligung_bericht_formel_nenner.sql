DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_formel_nenner` (
  `id` int(11) NOT NULL,
  
  `login` varchar(255) DEFAULT NULL,
  `aktiv` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `wahlbeteiligung_bericht_formel` int(11) not null  ,
  `wahlbeteiligung_bericht`  int(11) not null  ,
  
  
  PRIMARY KEY (`id`),
  KEY `idx_wahlbeteiligung_bericht_formel_nenner` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_formel_nenner_wbf` (`wahlbeteiligung_bericht_formel`),
  CONSTRAINT `fk_wahlbeteiligung_bericht_formel_nenner` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bf_nenner_wbb_formel` FOREIGN KEY (`wahlbeteiligung_bericht_formel`) REFERENCES `wahlbeteiligung_bericht_formel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

