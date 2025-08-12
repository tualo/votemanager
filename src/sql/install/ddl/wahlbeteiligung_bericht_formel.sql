DELIMITER ;

CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_formel` (
  `id` int(11) NOT NULL,

  `login` varchar(255) DEFAULT NULL,
  
  `aktiv` tinyint(4) DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id` )
) ;

