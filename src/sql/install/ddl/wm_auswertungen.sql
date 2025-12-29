DELIMITER ;
CREATE TABLE IF NOT EXISTS `wm_auswertungen` (
  `id` int(11) NOT NULL,
  `login` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `feld` varchar(255) DEFAULT NULL,
  `feldwerte` varchar(4000) DEFAULT NULL,
  `pos` int(11) DEFAULT 0,
  `aktiv` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
);

