DELIMITER ;
CREATE TABLE IF NOT EXISTS `wm_tanboegen` (
  `id` int(11) NOT NULL,
  `datum` date DEFAULT NULL,
  `zeit` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;