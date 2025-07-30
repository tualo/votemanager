DELIMITER ;
CREATE TABLE IF NOT EXISTS  `votemanager_setup` (
  `id` varchar(100) NOT NULL,
  `val` varchar(128) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ;