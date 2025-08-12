DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht` (
  `id` int(11) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `checktyp` tinyint(4) DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `abgabetyp` JSON DEFAULT '{"abgabetyp0":true,"abgabetyp1":true,"abgabetyp2":true}',
  PRIMARY KEY (`id`),
  KEY `idx_wahlbeteiligung_bericht_name` (`name`)
) ;

