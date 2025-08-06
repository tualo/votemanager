DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlschein` (
  `id` bigint(20) NOT NULL,
  `stimmzettel` int(11) NOT NULL,
  `wahlscheinnummer` varchar(14) NOT NULL,
  `wahlberechtigte` bigint(20) NOT NULL,
  `wahlscheinstatus` int(11) DEFAULT 1,
  `wahlscheinstatus_grund` int(11) DEFAULT 0,
  `abgabetyp` int(11) DEFAULT 0,
  `pwhash` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `blocknumber` varchar(30) DEFAULT '0',
  `defered` tinyint(4) DEFAULT 0,
  `secret` varchar(500) DEFAULT NULL,
  `onlinecheck` tinyint(4) DEFAULT 0,
  `testdaten` tinyint(4) DEFAULT 0,
  `kombiniert` bigint(20) DEFAULT NULL,
  `usedate` date DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`,`stimmzettel`),
  
  KEY `idx_wahlschein_wahlscheinstatus` (`wahlscheinstatus`),
  KEY `idx_wahlschein_wahlscheinstatus_grund` (`wahlscheinstatus_grund`),
  KEY `idx_wahlschein_wahlberechtigte` (`wahlberechtigte`),
  KEY `idx_wahlschein_wahlscheinnummer` (`wahlscheinnummer`),
  KEY `idx_wahlschein_abgabetyp` (`abgabetyp`),
  KEY `fk_wahlschein_stimmzettel` (`stimmzettel`),
  KEY `uidx_wahlschein_username` (`username`),
  KEY `idx_wahlschein_blocknumber` (`blocknumber`),
    CONSTRAINT `fk_wahlschein_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wahlschein_wahlberechtigte` FOREIGN KEY (`wahlberechtigte`) REFERENCES `wahlberechtigte` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wahlschein_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wahlschein_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wahlschein_blocknumber` FOREIGN KEY (`blocknumber`) REFERENCES `wahlschein_blocknumbers` (`blocknumber`) ON DELETE restrict ON UPDATE CASCADE
) 
WITH
  SYSTEM VERSIONING;


DELIMITER // 

CREATE
OR REPLACE TRIGGER `trigger_wahlschein_bi_defaults` BEFORE INSERT ON `wahlschein` FOR EACH ROW BEGIN IF NEW.login IS NULL THEN
SET
  NEW.login = getSessionUser ();

END IF;

IF NEW.created_at IS NULL THEN
SET
  NEW.created_at = CURRENT_TIMESTAMP;

END IF;

END // 

CREATE
OR REPLACE TRIGGER `trigger_wahlschein_bu_defaults` BEFORE
UPDATE ON `wahlschein` FOR EACH ROW BEGIN IF NEW.login IS NULL THEN
SET
  NEW.login = getSessionUser ();

END IF;

IF NEW.created_at IS NULL THEN
SET
  NEW.updated_at = CURRENT_TIMESTAMP;

END IF;

END //