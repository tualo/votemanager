
DELIMITER;
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO `ds` (`allowform`,`autosave`,`base_store_class`,`class_name`,`combined`,`default_pagesize`,`displayfield`,`existsreal`,`globalsearch`,`listselectionmodel`,`listviewbaseclass`,`modelbaseclass`,`phpexporter`,`phpexporterfilename`,`reorderfield`,`searchany`,`searchfield`,`showactionbtn`,`sortfield`,`syncable`,`table_name`,`title`,`use_history`,`use_insert_for_update`) VALUES ('1','0','Tualo.DataSets.data.Store','Wahlsystem','0','1000','table_name','1','0','rowmodel','Tualo.DataSets.ListView','Tualo.DataSets.model.Basic','XlsxWriter','wm_sync_tables {DATE} {TIME}','position','0','table_name','1','position','0','wm_sync_tables','WM: Sync Tables','0','0') ON DUPLICATE KEY UPDATE `allowform`=values(`allowform`),`autosave`=values(`autosave`),`base_store_class`=values(`base_store_class`),`class_name`=values(`class_name`),`combined`=values(`combined`),`default_pagesize`=values(`default_pagesize`),`displayfield`=values(`displayfield`),`existsreal`=values(`existsreal`),`globalsearch`=values(`globalsearch`),`listselectionmodel`=values(`listselectionmodel`),`listviewbaseclass`=values(`listviewbaseclass`),`modelbaseclass`=values(`modelbaseclass`),`phpexporter`=values(`phpexporter`),`phpexporterfilename`=values(`phpexporterfilename`),`reorderfield`=values(`reorderfield`),`searchany`=values(`searchany`),`searchfield`=values(`searchfield`),`showactionbtn`=values(`showactionbtn`),`sortfield`=values(`sortfield`),`syncable`=values(`syncable`),`table_name`=values(`table_name`),`title`=values(`title`),`use_history`=values(`use_history`),`use_insert_for_update`=values(`use_insert_for_update`); 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`deferedload`,`existsreal`,`fieldtype`,`is_generated`,`is_nullable`,`is_primary`,`numeric_precision`,`numeric_scale`,`privileges`,`syncable`,`table_name`,`writeable`) VALUES ('0','','last_sync','datetime','datetime','0','0','0','1','','NEVER','YES','0','0','0','select,insert,update,references','0','wm_sync_tables','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`is_generated`,`is_nullable`,`is_primary`,`numeric_precision`,`numeric_scale`,`privileges`,`syncable`,`table_name`,`writeable`) VALUES ('0','','position','int(11)','int','0','0','0','0','1','','NEVER','YES','0','10','0','select,insert,update,references','0','wm_sync_tables','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`deferedload`,`existsreal`,`fieldtype`,`is_generated`,`is_nullable`,`is_primary`,`numeric_precision`,`numeric_scale`,`privileges`,`syncable`,`table_name`,`writeable`) VALUES ('128','utf8mb3','PRI','table_name','varchar(128)','varchar','0','0','0','1','','NEVER','NO','1','0','0','select,insert,update,references','0','wm_sync_tables','1') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`align`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','left','last_sync','','','1','0','0','letze Sync.','DE','','2','','','','wm_sync_tables','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`align`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','left','position','','','1','0','0','Position','DE','','1','','','','wm_sync_tables','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`align`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','left','table_name','','','1','0','0','Tabelle','DE','','0','','','','wm_sync_tables','column_ds_tabelle') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','0','last_sync','Allgemein/Angaben','1','0','letze Sync.','DE','2','wm_sync_tables','displaydatefield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','0','position','Allgemein/Angaben','1','0','Position','DE','1','wm_sync_tables','displayfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','0','table_name','Allgemein/Angaben','1','0','Tabelle','DE','0','wm_sync_tables','combobox_ds_tabelle') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','0','_default_','wm_sync_tables','0') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('1','1','1','administration','wm_sync_tables','1') ; 
REPLACE INTO `docsystem_ds` (`table_name`) VALUES ('wm_sync_tables') ; 
SET FOREIGN_KEY_CHECKS=1;


/*DELIMITER ;
REPLACE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wm_sync_tables','WM: Sync Tables','position',NULL,'table_name','table_name','position',NULL,NULL,NULL,NULL,NULL,NULL,'rowmodel',NULL,NULL,NULL,NULL,NULL,'Wahlsystem',NULL,1,NULL,NULL,NULL,'XlsxWriter','wm_sync_tables {DATE} {TIME}',0,1000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ;

REPLACE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wm_sync_tables','last_sync',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'YES',NULL,1,NULL,'datetime','','datetime',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,''),
('wm_sync_tables','position','0',NULL,NULL,NULL,NULL,0,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('wm_sync_tables','table_name',NULL,NULL,NULL,NULL,1,0,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(128)',128,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
REPLACE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wm_sync_tables','last_sync','DE','letze Sync.','gridcolumn',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('wm_sync_tables','position','DE','Position','gridcolumn',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('wm_sync_tables','table_name','DE','Tabelle','column_ds_tabelle',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
REPLACE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wm_sync_tables','last_sync','DE','letze Sync.','displaydatefield','Allgemein/Angaben',2,0,1,NULL,NULL,NULL,'\'\''),
('wm_sync_tables','position','DE','Position','displayfield','Allgemein/Angaben',1,0,1,NULL,NULL,NULL,'\'\''),
('wm_sync_tables','table_name','DE','Tabelle','combobox_ds_tabelle','Allgemein/Angaben',0,0,1,NULL,NULL,NULL,'\'\'');

INSERT
    IGNORE INTO `ds_access` (
        `role`,
        `table_name`,
        `read`,
        `write`,
        `delete`,
        `append`,
        `existsreal`
    )
VALUES
    ('administration', 'wm_sync_tables', 1, 1, 1, 1, 0);

*/