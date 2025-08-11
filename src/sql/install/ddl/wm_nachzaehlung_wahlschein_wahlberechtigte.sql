delimiter ;



CREATE TABLE IF NOT EXISTS wm_nachzaehlung_wahlschein_wahlberechtigte(
    `wahlberechtigte` bigint(20) NOT NULL,
    `wahlscheinstatus` int(11) DEFAULT 1,
    `abgabetyp` int(11) DEFAULT 0,
    primary key (`wahlberechtigte`, `wahlscheinstatus`, `abgabetyp`),

    `blocknumber` varchar(30) NOT NULL DEFAULT '0',
    `login` varchar(50),
    `ctime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `mtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY `idx_wm_nachzaehlung_wahlschein_wahlberechtigte_wahlberechtigte` (`wahlberechtigte`),
    KEY `idx_wm_nachzaehlung_wahlschein_wahlberechtigte_wahlscheinstatus` (`wahlscheinstatus`),
    KEY `idx_wm_nachzaehlung_wahlschein_wahlberechtigte_abgabetyp` (`abgabetyp`),
    KEY `idx_wm_nachzaehlung_wahlschein_wahlberechtigte_blocknumber` (`blocknumber`),
    KEY `idx_wm_nachzaehlung_wahlschein_wahlberechtigte_login` (`login`),

    CONSTRAINT `fk_wm_nachzaehlung_wahlschein_wahlberechtigte_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wm_nachzaehlung_wahlschein_wahlberechtigte_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE restrict ON UPDATE CASCADE,
    CONSTRAINT `fk_wm_nachzaehlung_wahlschein_wahlberechtigte_blocknumber` FOREIGN KEY (`blocknumber`) REFERENCES `wahlschein_blocknumbers` (`blocknumber`) ON DELETE restrict ON UPDATE CASCADE

)
WITH
  SYSTEM VERSIONING
COMMENT 'Tabelle für Nachzählung von Wahlberechtigten in der Wahlmanager-Anwendung';
;