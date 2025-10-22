delimiter ; 
CREATE OR REPLACE VIEW `view_ruecklauffelder_columns` AS 

select 

    `ds_column_form_label`.`column_name` AS `column_name`,
    `ds_column_form_label`.`label` AS `label` 
from 
    `ds_column_form_label` 
where 
    `ds_column_form_label`.`table_name` = 'wahlberechtigte_anlage' 
union select 'stimmzettel_name' AS `column_name`,'Stimmzettelname' AS `label` 
union select 'wahlgruppe_name' AS `column_name`,'Wahlgruppename' AS `label` 
union select 'wahlbezirk_name' AS `column_name`,'Wahlbezirkname' AS `label` 
union select 'leerzeile' AS `column_name`,'Leerzeile' AS `label`
union select 'leerzeile2' AS `column_name`,'Leerzeile2' AS `label`
union select 'hstr' AS `column_name`,'Historie' AS `label`
union select concat('displ_',stimmzettelfeld,'_name')  AS `column_name`, concat('SZ ',name,' Text') AS `label`  from wahltyp where aktiv=1
;