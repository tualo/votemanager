DELIMITER ;
 
insert
    ignore into kandidaten_bilder_typen (id, name)
values
    (0, 'Barcode');

insert
    ignore into kandidaten_bilder_typen (id, name,include_in_export)
values
    (1, 'Portrait', 1);

insert
    ignore into kandidaten_bilder_typen (id, name,include_in_export)
values
    (80, 'Druck-Portrait', 1);

insert
    ignore into kandidaten_bilder_typen (id, name,include_in_export)
values
    (90, 'Web-Portrait', 1);
    