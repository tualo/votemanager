DELIMITER ;
CREATE TABLE IF NOT EXISTS  `abgabetyp_offline_erlaubt` (
  `abgabetyp` int(11) NOT NULL,
  PRIMARY KEY (`abgabetyp`),
  CONSTRAINT `fk_abgabetyp_offline_erlaubt_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;