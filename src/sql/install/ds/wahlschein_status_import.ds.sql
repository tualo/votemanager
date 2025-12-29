DELIMITER;

insert into `ds`
                    (`table_name`)
                    values
                    ('import_status_ausgangszustand')
                    on duplicate key update `table_name`=values(`table_name`);
update `ds` set `title`='erlaubte Ausgangszustände',`reorderfield`='',`use_history`='0',`searchfield`='id_ausgang',`displayfield`='id_wahlscheinstatus',`sortfield`='id_ausgang',`searchany`='1',`hint`='',`overview_tpl`='',`sync_table`='',`writetable`='',`globalsearch`='0',`listselectionmodel`='cellmodel',`sync_view`='',`syncable`='0',`cssstyle`='',`read_table`='',`existsreal`='1',`class_name`='Unklassifiziert',`special_add_panel`='',`read_filter`='',`listxtypeprefix`='listview',`phpexporter`='XlsxWriter',`phpexporterfilename`='{GUID}',`combined`='0',`allowForm`= 1 ,`alternativeformxtype`='',`character_set_name`='',`default_pagesize`='100',`listviewbaseclass`='Tualo.DataSets.ListView',`showactionbtn`='1' where `table_name`='import_status_ausgangszustand';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('import_status_ausgangszustand','id_ausgang')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='1',`update_value`='',`is_nullable`='NO',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='int',`column_key`='PRI',`column_type`='int(11)',`character_maximum_length`='0',`numeric_precision`='10',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='import_status_ausgangszustand' and `column_name`='id_ausgang';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('import_status_ausgangszustand','id_wahlscheinstatus')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='1',`update_value`='',`is_nullable`='NO',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='int',`column_key`='PRI',`column_type`='int(11)',`character_maximum_length`='0',`numeric_precision`='10',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='import_status_ausgangszustand' and `column_name`='id_wahlscheinstatus';
insert into `ds_access`
                    (`role`,`table_name`)
                    values
                    ('administration','import_status_ausgangszustand')
                    on duplicate key update `role`=values(`role`),`table_name`=values(`table_name`);
update `ds_access` set `read`='0',`write`='1',`delete`='1',`append`='1',`existsreal`='0' where `role`='administration' and `table_name`='import_status_ausgangszustand';
insert into `ds_access`
                    (`role`,`table_name`)
                    values
                    ('_default_','import_status_ausgangszustand')
                    on duplicate key update `role`=values(`role`),`table_name`=values(`table_name`);
update `ds_access` set `read`='1',`write`='0',`delete`='0',`append`='0',`existsreal`='0' where `role`='_default_' and `table_name`='import_status_ausgangszustand';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('import_status_ausgangszustand','id_ausgang','DE','Ausgang','Allgemein/Angabe')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='combobox_wahlscheinstatus_id',`position`='1',`hidden`='0',`active`='1',`allowempty`='1',`fieldgroup`='' where `table_name`='import_status_ausgangszustand' and `column_name`='id_ausgang' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('import_status_ausgangszustand','id_wahlscheinstatus','DE','Wahlscheinstatus','Allgemein/Angabe')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='0',`hidden`='0',`active`='1',`allowempty`='1',`fieldgroup`='' where `table_name`='import_status_ausgangszustand' and `column_name`='id_wahlscheinstatus' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('import_status_ausgangszustand','kostenstelle_ausgang','DE','kostenstelle_ausgang','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='3',`hidden`='1',`active`='1',`allowempty`='1',`fieldgroup`='' where `table_name`='import_status_ausgangszustand' and `column_name`='kostenstelle_ausgang' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('import_status_ausgangszustand','kostenstelle_wahlscheinstatus','DE','kostenstelle_wahlscheinstatus','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='2',`hidden`='1',`active`='1',`allowempty`='1',`fieldgroup`='' where `table_name`='import_status_ausgangszustand' and `column_name`='kostenstelle_wahlscheinstatus' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('import_status_ausgangszustand','id_ausgang','DE','Ausgang')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='column_wahlscheinstatus_id',`editor`='',`position`='1',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='import_status_ausgangszustand' and `column_name`='id_ausgang' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('import_status_ausgangszustand','id_wahlscheinstatus','DE','Wahlscheinstatus-ID')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='column_wahlscheinstatus_id',`editor`='',`position`='0',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='import_status_ausgangszustand' and `column_name`='id_wahlscheinstatus' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('import_status_ausgangszustand','kostenstelle_ausgang','DE','kostenstelle_ausgang')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='2',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='import_status_ausgangszustand' and `column_name`='kostenstelle_ausgang' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('import_status_ausgangszustand','kostenstelle_wahlscheinstatus','DE','kostenstelle_wahlscheinstatus')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='3',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='import_status_ausgangszustand' and `column_name`='kostenstelle_wahlscheinstatus' and `language`='DE';
insert into `ds_reference_tables`
                    (`table_name`,`reference_table_name`,`constraint_name`)
                    values
                    ('import_status_ausgangszustand','wahlscheinstatus','fk_import_status_ausgangszustand_wahlscheinstatus_1')
                    on duplicate key update `table_name`=values(`table_name`),`reference_table_name`=values(`reference_table_name`),`constraint_name`=values(`constraint_name`);
update `ds_reference_tables` set `columnsdef`='{\"import_status_ausgangszustand__id_wahlscheinstatus\":\"wahlscheinstatus__id\",\"import_status_ausgangszustand__kostenstelle_wahlscheinstatus\":\"wahlscheinstatus__kostenstelle\"}',`active`='1',`searchable`='0',`autosync`='1',`position`='99999',`path`='' where `table_name`='import_status_ausgangszustand' and `reference_table_name`='wahlscheinstatus' and `constraint_name`='fk_import_status_ausgangszustand_wahlscheinstatus_1';
insert into `ds_reference_tables`
                    (`table_name`,`reference_table_name`,`constraint_name`)
                    values
                    ('import_status_ausgangszustand','wahlscheinstatus','fk_import_status_ausgangszustand_wahlscheinstatus_ausgang')
                    on duplicate key update `table_name`=values(`table_name`),`reference_table_name`=values(`reference_table_name`),`constraint_name`=values(`constraint_name`);
update `ds_reference_tables` set `columnsdef`='{\"import_status_ausgangszustand__id_ausgang\":\"wahlscheinstatus__id\",\"import_status_ausgangszustand__kostenstelle_ausgang\":\"wahlscheinstatus__kostenstelle\"}',`active`='0',`searchable`='0',`autosync`='1',`position`='99999',`path`='' where `table_name`='import_status_ausgangszustand' and `reference_table_name`='wahlscheinstatus' and `constraint_name`='fk_import_status_ausgangszustand_wahlscheinstatus_ausgang';
-- END DS import_status_ausgangszustand



-- BEGIN DS wahlschein_status_import
-- NAME: Wahlscheinstatus-Import

insert into `ds`
                    (`table_name`)
                    values
                    ('wahlschein_status_import')
                    on duplicate key update `table_name`=values(`table_name`);
update `ds` set `title`='Wahlscheinstatus-Import',`reorderfield`='',`use_history`='0',`searchfield`='identnummer',`displayfield`='id',`sortfield`='identnummer',`searchany`='1',`hint`='',`overview_tpl`='',`sync_table`='',`writetable`='',`globalsearch`='0',`listselectionmodel`='tualomultirowmodel',`sync_view`='',`syncable`='0',`cssstyle`='',`read_table`='',`existsreal`='1',`class_name`='Unklassifiziert',`special_add_panel`='',`read_filter`='',`listxtypeprefix`='listview',`phpexporter`='XlsxWriter',`phpexporterfilename`='{GUID}',`combined`='0',`allowForm`= 1 ,`alternativeformxtype`='',`character_set_name`='',`default_pagesize`='10000',`listviewbaseclass`='Tualo.DataSets.ListView',`showactionbtn`='1' where `table_name`='wahlschein_status_import';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','filename')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='filename';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','id')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='{:uuid()}',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='1',`update_value`='',`is_nullable`='NO',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='PRI',`column_type`='varchar(60)',`character_maximum_length`='60',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='\'\'',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='id';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','identnummer')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(24)',`character_maximum_length`='24',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='identnummer';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','importdatetime')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='{DATE}',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='datetime',`column_key`='',`column_type`='datetime',`character_maximum_length`='0',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='\'\'',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='importdatetime';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','neuer_status')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='neuer_status';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','processed_datetime')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='NO',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='datetime',`column_key`='',`column_type`='datetime',`character_maximum_length`='0',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_datetime';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','processed_msg')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_msg';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','processed_state')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='tinyint',`column_key`='MUL',`column_type`='tinyint(4)',`character_maximum_length`='0',`numeric_precision`='3',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='\'\'',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_state';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','processed_user')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(128)',`character_maximum_length`='128',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_user';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','user')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='{:getSessionUser()}',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(128)',`character_maximum_length`='128',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='\'\'',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='user';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('wahlschein_status_import','wahlscheinnummer')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='NO',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(24)',`character_maximum_length`='24',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='wahlscheinnummer';
insert into `ds_access`
                    (`role`,`table_name`)
                    values
                    ('administration','wahlschein_status_import')
                    on duplicate key update `role`=values(`role`),`table_name`=values(`table_name`);
update `ds_access` set `read`='1',`write`='1',`delete`='1',`append`='1',`existsreal`='0' where `role`='administration' and `table_name`='wahlschein_status_import';

insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','filename','DE','filename','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='filename' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','id','DE','id','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='0',`hidden`='0',`active`='1',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='id' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','identnummer','DE','identnummer','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='0',`active`='1',`allowempty`='0',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='identnummer' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','importdatetime','DE','importdatetime','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='importdatetime' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','neuer_status','DE','neuer_status','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='neuer_status' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','processed_datetime','DE','processed_datetime','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_datetime' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','processed_msg','DE','processed_msg','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_msg' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','processed_state','DE','processed_state','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_state' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','processed_user','DE','processed_user','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_user' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','user','DE','user','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='user' and `language`='DE';
insert into `ds_column_form_label`
                    (`table_name`,`column_name`,`language`,`label`,`field_path`)
                    values
                    ('wahlschein_status_import','wahlscheinnummer','DE','wahlscheinnummer','Allgemein')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`),`field_path`=values(`field_path`);
update `ds_column_form_label` set `xtype`='displayfield',`position`='999',`hidden`='1',`active`='0',`allowempty`='1',`fieldgroup`='' where `table_name`='wahlschein_status_import' and `column_name`='wahlscheinnummer' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','filename','DE','Filename')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='1',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='filename' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','id','DE','ID')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='0',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='id' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','identnummer','DE','Identnummer')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='7',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='identnummer' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','importdatetime','DE','Importiert am')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='datecolumn',`editor`='',`position`='6',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='importdatetime' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','neuer_status','DE','Importattribut')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='9',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='neuer_status' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','processed_datetime','DE','Verarbeitet am')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='datecolumn',`editor`='',`position`='2',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_datetime' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','processed_msg','DE','Meldung')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='column_view_wahlschein_status_import_processed_msg_processed_msg',`editor`='',`position`='10',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_msg' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','processed_state','DE','Verarbeitungsstatus')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='5',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_state' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','processed_user','DE','Verarbeitet-Login')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='3',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='processed_user' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','user','DE','Import-Login')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='4',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='user' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('wahlschein_status_import','wahlscheinnummer','DE','Wahlscheinnummer')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='8',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='wahlschein_status_import' and `column_name`='wahlscheinnummer' and `language`='DE';
-- END DS wahlschein_status_import

replace INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) 
VALUES ("wahlschein_status_import","wm_wb_importstatuscmd","toolbar",1,"Importieren",NULL);

delete from ds_addcommands 
where table_name = 'wahlschein_status_import' and xtype = 'wm_wb_importcmd' 
;