DELIMITER ;
CREATE TABLE IF NOT EXISTS  `stapel2` (
  `id` varchar(36) NOT NULL,
  `login` varchar(255) NOT NULL,
  `kisten2` varchar(36) NOT NULL,
  `abgebrochen` tinyint(4) DEFAULT 0,
  `createdatetime` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_stapel2_kisten2` (`kisten2`),
  CONSTRAINT `fk_stapel2_kisten2` FOREIGN KEY (`kisten2`) REFERENCES `kisten2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);