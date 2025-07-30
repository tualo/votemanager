DELIMITER ;
CREATE TABLE IF NOT EXISTS  `wahlscheinstatus_online_erlaubt` (
  `wahlscheinstatus` int(11) NOT NULL,
  `abgabetyp` int(11) NOT NULL,
  PRIMARY KEY (`wahlscheinstatus`,`abgabetyp`),
  KEY `fk_wahlscheinstatus_online_erlaubt_abgabetyp` (`abgabetyp`),
  CONSTRAINT `fk_wahlscheinstatus_online_erlaubt_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlscheinstatus_online_erlaubt_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;