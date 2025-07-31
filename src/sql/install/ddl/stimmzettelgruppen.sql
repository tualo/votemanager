DELIMITER ;
CREATE TABLE IF NOT EXISTS  `stimmzettelgruppen` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `stimmzettel` int(11) NOT NULL,
  `sitze` int(11) DEFAULT 1,
  `mindestsitze` int(11) DEFAULT 0,
  `onlinebezeichnung` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_stimmzettelgruppen_stimmzettel` (`stimmzettel`),
  CONSTRAINT `fk_stimmzettelgruppen_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

DELIMITER //

CREATE OR REPLACE TRIGGER `trigger_stimmzettelgruppen_bi_defaults`
BEFORE INSERT ON `stimmzettelgruppen` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
END //

CREATE OR REPLACE TRIGGER `trigger_stimmzettelgruppen_bu_defaults`
BEFORE UPDATE ON `stimmzettelgruppen` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
  END IF;
END //