delimiter ; 
insert ignore into ds_addcommands_xtypes (id,name) values ('wm_pwgen_importcmd','Importieren');
insert ignore into ds_addcommands_xtypes (id,name) values ('wm_wb_importcmd','Importieren');
insert ignore into ds_addcommands_xtypes (id,name) values ('pwgen_pw_command','Passwortgenerator');
insert ignore into ds_addcommands_xtypes (id,name) values ('papervote_export_command','ZIP-Export');
insert ignore into ds_addcommands_xtypes (id,name) values ('papervote_barcode_command','Kandidaten-Barcodes');

insert ignore into ds_addcommands_xtypes (id,name) values ('wm_wb_importstatuscmd','Statusimport');


INSERT IGNORE INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) VALUES ("wahlberechtigte_anlage","wm_wb_importcmd","toolbar",1,"Importieren",NULL);
INSERT IGNORE INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) VALUES ("kandidaten","papervote_barcode_command","toolbar",1,"Barcodes",NULL);
INSERT IGNORE INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) VALUES ("kandidaten","papervote_export_command","toolbar",1,"ZIP-Export",NULL);
