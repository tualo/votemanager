DELIMITER ;


insert ignore into `wahlscheinstatus` (`id`, `name`, `aktiv`, `barcode`, `farbe`, `ohne_wahlberechtigten`,`login`) values
('-1','mit TAN entsperrt','0','FC999999','rgb(111,111,111)','0','setup'),
('1','unbekannt','0','FC212','rgb(111,111,111)','0','setup'),
('2','angenommen','1','FC210','#20ff20','0','setup'),
('3','ungültig','1','FC213','#ff2020','0','setup'),
('4','zurückgewiesen','1','FC215','#080808','0','setup'),
('5','unzustellbar','0','FC214','#2020ff','0','setup'),
('7','neue Wahlunterlagen generiert','0','FC9999','rgb(111,111,111)','0','setup'),
('8','Klärung','1','FC216','#20ffff','0','setup'),
('9','nicht gewählt','0','FC217','rgb(111,111,111)','0','setup'),
('10','ohne Wahlschein','0','FC9998','rgb(111,111,111)','1','setup'),
('11','Korrektur','0','FC9997','rgb(111,111,111)','0','setup'),
('12','verspätet eingegangen','0','FC991','#000000','0','setup'),
('13','inaktiv','0','FC230','rgb(111,111,111)','0','setup'),
('14','eaktiv','0','FC231','rgb(111,111,111)','0','setup'),
('16','neue Wahlunterlagen','0','FC278','rgb(255,182,193)','0','setup'),
('17','Anlage','0','FC9995','rgb(111,111,111)','0','setup'),
('30','Briefwahlunterlagen','0','FC9994','rgb(111,111,111)','0','setup');