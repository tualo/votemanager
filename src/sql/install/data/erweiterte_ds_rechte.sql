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



INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','1','wahl_ruecklauf','wahlschein') ;




INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','0','wahl_auswertungen','abgabetyp') ;


INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','0','wahl_auswertungen','wahlbeteiligung_bericht_formel') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','0','wahl_auswertungen','wahlbeteiligung_bericht') ;


INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','0','wahl_auswertungen','wm_berichte') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','0','wahl_auswertungen','kandidaten_stimmenanzahl_losentscheid_stimmzettel') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','0','wahl_auswertungen','view_protokoll_erwartet') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`write`,`role`,`table_name`) 
VALUES ('0','0','1','0','wahl_auswertungen','view_kandidaten_stimmenanzahl') ;

INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) 
VALUES ('0','0','1','wahl_auszaehlung','kandidaten','0') ;


insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_ruecklauf' `group`,1 allowed from route_scopes 
where scope ='papervote.return';



insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_auswertungen' `group`,1 allowed from route_scopes 
where scope ='papervote.involvement.reporting';


insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_auszaehlung' `group`,1 allowed from route_scopes 
where scope ='papervote.counting';


insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_auszaehlung' `group`,1 allowed from route_scopes 
where scope ='papervote.rescan';


insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_administration' `group`,1 allowed from route_scopes 
where scope ='votemanager.refreshpivot';


insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_auswertungen' `group`,1 allowed from route_scopes 
where scope ='tempfile.download';


insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_administration' `group`,1 allowed from route_scopes 
where scope ='onlinevote.create.ballotbox';

insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_leitung' `group`,1 allowed from route_scopes 
where scope ='onlinevote.create.ballotbox';

insert ignore into route_scopes_permissions (scope,`group`,allowed)
select scope,'wahl_leitung' `group`,1 allowed from route_scopes 
where scope ='onlinevote.state';
