DELIMITER ;
CREATE TABLE IF NOT EXISTS  `wahlbezirk` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `zuweisungsschluessel` varchar(255) DEFAULT '0',
  `kurzbezeichnung` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ;