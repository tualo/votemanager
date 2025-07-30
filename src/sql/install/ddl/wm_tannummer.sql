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