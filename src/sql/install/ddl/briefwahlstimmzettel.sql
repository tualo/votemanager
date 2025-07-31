DELIMITER ;


CREATE TABLE IF NOT EXISTS `briefwahlstimmzettel` (
  `stimmzettel` integer NOT NULL,
  `anzahl` int(11) DEFAULT 0,
  `erwartet` int(11) DEFAULT 0,

  `enthaltung` int(11) DEFAULT 0,
  `ungueltig` int(11) DEFAULT 0,  

  `login` varchar(255) DEFAULT NULL,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stimmzettel`),
  CONSTRAINT `fk_briefwahlstimmzettel_stimmzettel`
  foreign key (stimmzettel)
  references stimmzettel(id)
  on delete cascade
  on update cascade
);


alter table `briefwahlstimmzettel` add column if not exists `enthaltung` int(11) DEFAULT 0;
alter table `briefwahlstimmzettel` add column if not exists `ungueltig` int(11) DEFAULT 0;


DELIMITER //

CREATE OR REPLACE TRIGGER `trigger_stimmzettel_ai_briefwahlstimmzettel`
AFTER INSERT ON `stimmzettel` FOR EACH ROW
BEGIN
  insert ignore into briefwahlstimmzettel(stimmzettel) values (new.id) ;
END //