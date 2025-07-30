DELIMITER ;
CREATE TABLE IF NOT EXISTS  `wahlberechtigte` (
  `id` bigint(20) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 0,
  `identnummer` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_wahlberechtigte_identnummer` (`identnummer`)
) ;