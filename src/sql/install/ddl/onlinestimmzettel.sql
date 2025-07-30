DELIMITER ;
CREATE TABLE IF NOT EXISTS `onlinestimmzettel` (
  `stimmzettel` int(11) NOT NULL,
  `anzahl` int(11) DEFAULT 0,
  `erwartet` int(11) DEFAULT 0,
  `enthaltung` int(11) DEFAULT 0,
  `ungueltig` int(11) DEFAULT 0,
  `login` varchar(255) DEFAULT NULL,
  `createdatetime` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`stimmzettel`),
  CONSTRAINT `fk_onlinestimmzettel_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
)  ;