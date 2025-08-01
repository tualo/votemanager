delimiter ;
insert ignore into  system_settings_user_access 
select system_settings_id,'administration' from system_settings ;