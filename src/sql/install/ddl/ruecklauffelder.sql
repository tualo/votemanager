DELIMITER ;
CREATE TABLE IF NOT EXISTS  `ruecklauffelder` (
  `column_name` varchar(50) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `reihenfolge` int(11) DEFAULT 0,
  PRIMARY KEY (`column_name`)
);