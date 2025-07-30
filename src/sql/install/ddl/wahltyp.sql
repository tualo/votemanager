DELIMITER ;
CREATE TABLE IF NOT EXISTS  `wahltyp` (
  `id` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `feld` varchar(255) DEFAULT '',
  `aktiv` tinyint(4) DEFAULT 1,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_wahltyp_name` (`name`)
) ;