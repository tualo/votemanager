delimiter ;

insert ignore into  system_settings_user_access 
select system_settings_id,'administration' from system_settings ;



insert ignore into system_settings_user_access(system_settings_id,groupname) values ('remote-erp/public','administration');
insert ignore into system_settings_user_access(system_settings_id,groupname) values ('remote-erp/url','administration');
insert ignore into system_settings_user_access(system_settings_id,groupname) values ('remote-erp/token','administration');
insert ignore into system_settings_user_access(system_settings_id,groupname) values ('erp/privatekey','administration');

insert ignore into  system_settings (system_settings_id) values 
	('remote-erp/public'),
  ('remote-erp/url'),
  ('remote-erp/token') 
;
insert ignore into system_settings_user_access(system_settings_id,groupname) values ('remote-erp/public','administration');
insert ignore into system_settings_user_access(system_settings_id,groupname) values ('remote-erp/url','administration');
insert ignore into system_settings_user_access(system_settings_id,groupname) values ('remote-erp/token','administration');
insert ignore into system_settings_user_access(system_settings_id,groupname) values ('erp/privatekey','administration');
