DELIMITER ;
CREATE TABLE IF NOT EXISTS  `kisten2` (
  `id` varchar(36) NOT NULL,
  `login` varchar(255) NOT NULL,
  `createdatetime` datetime DEFAULT current_timestamp(),
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
);