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



DELIMITER //

CREATE OR REPLACE TRIGGER `trigger_wahlberechtigte_bi_defaults`
BEFORE INSERT ON `wahlberechtigte` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
END //

CREATE OR REPLACE TRIGGER `trigger_wahlberechtigte_bu_defaults`
BEFORE UPDATE ON `wahlberechtigte` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
  END IF;
END //
