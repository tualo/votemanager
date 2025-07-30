DELIMITER ;
CREATE TABLE IF NOT EXISTS  `wahlzeichnungsberechtigter` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `funktion` varchar(255) DEFAULT NULL,
  `personenident` varchar(255) DEFAULT NULL,
  `wahlberechtigte` bigint(20) DEFAULT NULL,
  `geburtsdatum` date DEFAULT '1900-01-01',
  `vorname` varchar(255) DEFAULT NULL,
  `nachname` varchar(255) DEFAULT NULL,
  `namenstitel` varchar(255) DEFAULT NULL,
  `nachtitel` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_wahlzeichnungsberechtigter_wahlberechtigte` (`wahlberechtigte`),
  CONSTRAINT `fk_wahlzeichnungsberechtigter_wahlberechtigte` FOREIGN KEY (`wahlberechtigte`) REFERENCES `wahlberechtigte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;