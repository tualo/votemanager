DELIMITER ;
CREATE TABLE IF NOT EXISTS  `wahlscheinstatus_grund` (
  `id` int(11) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `barcode` varchar(36) DEFAULT uuid(),
  `wahlscheinstatus` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_wahlscheinstatus_grund_wahlscheinstatus` (`wahlscheinstatus`),
  CONSTRAINT `fk_wahlscheinstatus_grund_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;