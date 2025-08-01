DELIMITER ;
CREATE TABLE IF NOT EXISTS `system_settings_suggestion` (
  `suggestion_id` varchar(50) NOT NULL,
  `system_settings_id` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `inserttime` datetime NOT NULL,
  `property` text DEFAULT NULL,
  CONSTRAINT `fk_system_settings_suggestion_system_settings` FOREIGN KEY (`system_settings_id`) REFERENCES `system_settings` (`system_settings_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (`suggestion_id`)
) ;
