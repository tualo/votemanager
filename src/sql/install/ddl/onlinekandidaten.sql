DELIMITER ;
CREATE TABLE IF NOT EXISTS  `onlinekandidaten` (
  `id` int(11) NOT NULL,
  `anzahl` int(11) NOT NULL DEFAULT 0,
  `login` varchar(255) DEFAULT NULL,
  `createdatetime` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_onlinekandidaten_kandidaten_id` FOREIGN KEY (`id`) REFERENCES `kandidaten` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;