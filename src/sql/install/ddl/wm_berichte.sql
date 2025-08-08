delimiter ;
CREATE TABLE IF NOT EXISTS `wm_berichte` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);


alter table wm_berichte add if not exists page_orientation enum('portrait','landscape') default 'portrait';
alter table wm_berichte add if not exists page_format enum('a0','a1','a2','a3','a4','a5') default 'a4';
alter table wm_berichte add if not exists page_show_pagenumbers tinyint default 1;


create or replace  view view_wm_berichte_formats as
select
    'a5' as page_format,
    'DIN A5' as page_format_label
union all
select
    'a4' as page_format,
    'DIN A4' as page_format_label
union all
select
    'a3' as page_format,
    'DIN A3' as page_format_label
union all  
select
    'a2' as page_format,
    'DIN A2' as page_format_label
union all
select
    'a1' as page_format,
    'DIN A1' as page_format_label
    ;

create or replace view view_wm_berichte_page_orientations as
select
    'portrait' as page_orientation,
    'Hochformat' as page_orientation_label
union all
select
    'landscape' as page_orientation,
    'Querformat' as page_orientation_label
;