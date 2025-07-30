DELIMITER ;
CREATE TABLE IF NOT EXISTS `wzbruecklauffelder` (
  `table_name` varchar(128) NOT NULL DEFAULT 'wahlberechtigte_anlage',
  `column_name` varchar(100) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `reihenfolge` int(11) DEFAULT 0,
  PRIMARY KEY (`table_name`,`column_name`),
  CONSTRAINT `fk_wzbruecklauffelder_table_name_column_name` FOREIGN KEY (`table_name`, `column_name`) REFERENCES `ds_column` (`table_name`, `column_name`) ON DELETE CASCADE ON UPDATE CASCADE
);