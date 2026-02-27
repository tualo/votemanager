DELIMITER;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','0','wahl_administration','briefwahlstimmzettel','1') ; 


INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','1','wahl_nachzaehlung','abgabetyp','1') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','1','wahl_nachzaehlung','wm_nachzaehlung_wahlschein_wahlberechtigte','1') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','01','wahl_nachzaehlung','wm_nachzaehlung_wahlschein_wahlscheinnummer','1') ;

