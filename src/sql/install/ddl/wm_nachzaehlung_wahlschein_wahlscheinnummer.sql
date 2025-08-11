delimiter ;



CREATE TABLE IF NOT EXISTS wm_nachzaehlung_wahlschein_wahlscheinnummer(
    `wahlscheinnummer` varchar(14) NOT NULL,
    `wahlscheinstatus` int(11) DEFAULT 1,
    `abgabetyp` int(11) DEFAULT 0,
    primary key (`wahlscheinnummer`, `wahlscheinstatus`, `abgabetyp`),
    `blocknumber` varchar(30) NOT NULL DEFAULT '0',
    `login` varchar(50),
    `ctime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `mtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY `idx_wm_nachzaehlung_wahlschein_wahlscheinnummer_wahlscheinnummer` (`wahlscheinnummer`),
    KEY `idx_wm_nachzaehlung_wahlschein_wahlscheinnummer_wahlscheinstatus` (`wahlscheinstatus`),
    KEY `idx_wm_nachzaehlung_wahlschein_wahlscheinnummer_abgabetyp` (`abgabetyp`),

    KEY `idx_wm_nachzaehlung_wahlschein_wahlscheinnummer_blocknumber` (`blocknumber`),
    KEY `idx_wm_nachzaehlung_wahlschein_wahlscheinnummer_login` (`login`),

    CONSTRAINT `fk_wm_nachzaehlung_wahlschein_wahlscheinnummer_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wm_nachzaehlung_wahlschein_wahlscheinnummer_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wm_nachzaehlung_wahlschein_wahlscheinnummer_blocknumber` FOREIGN KEY (`blocknumber`) REFERENCES `wahlschein_blocknumbers` (`blocknumber`) ON DELETE restrict ON UPDATE CASCADE

)
WITH
  SYSTEM VERSIONING
COMMENT 'Tabelle für Nachzählung von Wahlscheinnummern in der Wahlmanager-Anwendung';
;
