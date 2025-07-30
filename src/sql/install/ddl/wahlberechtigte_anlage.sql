DELIMITER ;
CREATE TABLE IF NOT EXISTS  `wahlberechtigte_anlage` (
  `identnummer` varchar(20) NOT NULL,
  `stimmzettel` int(11) NOT NULL,
  `wahlscheinnummer` varchar(14) DEFAULT NULL,
  `kombiniert` varchar(20) DEFAULT NULL,
  `testdaten` tinyint(4) DEFAULT 0,
  `username` varchar(10) DEFAULT NULL,
  `pwhash` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`identnummer`,`stimmzettel`),
  KEY `idx_wahlberechtigte_anlage_wahlscheinnummer` (`wahlscheinnummer`),
  KEY `idx_wahlberechtigte_anlage_identnummer` (`identnummer`)
) ;