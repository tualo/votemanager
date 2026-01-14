DELIMITER ;

CREATE TABLE IF NOT EXISTS  `kandidaten_bilder_typen` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `include_in_export` tinyint default 0,  
  `export_name_template` varchar(255) DEFAULT '{typ_name:ansii}_{barcode:ansii}',
  PRIMARY KEY (`id`)
) ;


ALTER TABLE `kandidaten_bilder_typen` add column if not exists `include_in_export` tinyint default 0;
ALTER TABLE `kandidaten_bilder_typen` add column if not exists `export_name_template` varchar(255) DEFAULT '{typ_name:ansii}_{barcode:ansii}';
