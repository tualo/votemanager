DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_formel_teiler` (
  `id` int(11) NOT NULL,
  `login` varchar(255) DEFAULT NULL,
  `aktiv` tinyint(1) DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `wahlbeteiligung_bericht_formel` int(11) NOT NULL,
  `wahlbeteiligung_bericht` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_wahlbeteiligung_bericht_formel_teiler` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_formel_teiler_wbf` (`wahlbeteiligung_bericht_formel`),
  CONSTRAINT `fk_wahlbeteiligung_bericht_formel_teiler` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bf_teiler_wbb_formel` FOREIGN KEY (`wahlbeteiligung_bericht_formel`) REFERENCES `wahlbeteiligung_bericht_formel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
