DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlscheinstatus` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `barcode` varchar(36) DEFAULT uuid(),
  `farbe` varchar(25) DEFAULT 'rgb(111,111,111)',
  `ohne_wahlberechtigten` tinyint(4) DEFAULT 0,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wahlscheinstatus_barcode` (`barcode`)
) ;