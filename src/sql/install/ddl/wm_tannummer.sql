DELIMITER ;
CREATE TABLE IF NOT EXISTS `wm_tannummer` (
  `tannummer` varchar(25) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 0,
  `bogen` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`tannummer`),
  KEY `idx_wm_tanboegen_bogen` (`bogen`),
  CONSTRAINT `fk_wm_tanboegen_bogen` FOREIGN KEY (`bogen`) REFERENCES `wm_tanboegen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

DELIMITER //

CREATE OR REPLACE TRIGGER `trigger_wm_tannummer_bi_defaults`
BEFORE INSERT ON `wm_tannummer` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
END //

CREATE OR REPLACE TRIGGER `trigger_wm_tannummer_bu_defaults`
BEFORE UPDATE ON `wm_tannummer` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
  END IF;
END //