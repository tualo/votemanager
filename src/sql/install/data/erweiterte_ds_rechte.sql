DELIMITER;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','0','wahl_administration','briefwahlstimmzettel','1') ; 


INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','1','wahl_nachzaehlung','abgabetyp','1') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','1','wahl_nachzaehlung','wm_nachzaehlung_wahlschein_wahlberechtigte','1') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','1','wahl_nachzaehlung','wm_nachzaehlung_wahlschein_wahlscheinnummer','1') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','blocked_voters') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','wahlbezirk') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','wahlgruppe') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','stimmzettel') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','stimmzettelgruppen') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','kandidaten') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','kandidaten_bilder') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','kandidaten_bilder_typen') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','stimmzettel_stimmzettel_fusstexte') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','stimmzettel_fusstexte') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','ds_files') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_onlinewahl_sync','ds_files_data') ;
