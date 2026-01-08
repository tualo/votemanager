DELIMITER ;
 
insert
    ignore into kandidaten_bilder_typen (id, name)
values
    (0, 'Barcode');

insert
    ignore into kandidaten_bilder_typen (id, name,include_in_export)
values
    (1, 'Portrait', 1);