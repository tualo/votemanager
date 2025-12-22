DELIMITER ;

CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_formel` (
  `id` int(11) NOT NULL,

  `login` varchar(255) DEFAULT NULL,
  
  `aktiv` tinyint(4) DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id` )
) ;



create or replace view `view_readtable_wahlbeteiligung_bericht_formel` as
select
  wahlbeteiligung_bericht_formel.`id`,
  wahlbeteiligung_bericht_formel.`login`,
  wahlbeteiligung_bericht_formel.`aktiv`,
  wahlbeteiligung_bericht_formel.`name`,
  json_arrayagg(
      distinct
      if(`wahlbeteiligung_bericht_formel_nenner`.`wahlbeteiligung_bericht` is null, null,
    json_object(
      'id', `wahlbeteiligung_bericht_formel_nenner`.`wahlbeteiligung_bericht`,
      'name', `wahlbeteiligung_bericht_formel_nenner`.`name`,
      'aktiv', `wahlbeteiligung_bericht_formel_nenner`.`aktiv`,
      'login', `wahlbeteiligung_bericht_formel_nenner`.`login`
    ))
  ) as nenner,
  json_arrayagg(
      distinct
      if(`wahlbeteiligung_bericht_formel_teiler`.`wahlbeteiligung_bericht` is null, null,
    json_object(
      'id', `wahlbeteiligung_bericht_formel_teiler`.`wahlbeteiligung_bericht`,
      'name', `wahlbeteiligung_bericht_formel_teiler`.`name`,
      'aktiv', `wahlbeteiligung_bericht_formel_teiler`.`aktiv`,
      'login', `wahlbeteiligung_bericht_formel_teiler`.`login`
    ))
  ) as teiler
from
  `wahlbeteiligung_bericht_formel`
  left join wahlbeteiligung_bericht_formel_nenner
  on wahlbeteiligung_bericht_formel_nenner.wahlbeteiligung_bericht_formel = wahlbeteiligung_bericht_formel.id
    and wahlbeteiligung_bericht_formel_nenner.aktiv = 1
  left join wahlbeteiligung_bericht_formel_teiler
  on wahlbeteiligung_bericht_formel_teiler.wahlbeteiligung_bericht_formel = wahlbeteiligung_bericht_formel.id
    and wahlbeteiligung_bericht_formel_teiler.aktiv = 1
group by id
;