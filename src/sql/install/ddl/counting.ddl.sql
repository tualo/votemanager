DELIMITER ;

CREATE TABLE IF NOT EXISTS `kisten1` (

  `id` varchar(36) NOT NULL,
  `login` varchar(255) NOT NULL,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)

);

CREATE TABLE IF NOT EXISTS `stapel1` (
  `id` varchar(36) NOT NULL,
  `login` varchar(255) NOT NULL,
  `kisten1` varchar(36) NOT NULL,
  `abgebrochen` tinyint DEFAULT 0,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_stapel1_kisten1` FOREIGN KEY (`kisten1`) REFERENCES `kisten1` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS `stimmzettel1` (
  `id` varchar(36) NOT NULL,

  `login` varchar(255) NOT NULL,
  `stapel1` varchar(36)  DEFAULT NULL,

  `stimmzettel` integer not null,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),

  KEY `idx_stimmzettel1_stimmzettel` (`stimmzettel`),
  KEY `idx_stimmzettel1_stapel1` (`stapel1`),

  CONSTRAINT `fk_stimmzettel1_stapel1` FOREIGN KEY (`stapel1`) REFERENCES `stapel1` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stimmzettel1_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `kandidaten1` (
  
  `login` varchar(255) NOT NULL,
  `kandidaten` integer not null,
  `stimmzettel1` varchar(36) not null,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,  PRIMARY KEY (`kandidaten`,`stimmzettel1`),
  `stimmen` integer default 1,

  KEY `idx_kandidaten1_kandidaten` (`kandidaten`),
  KEY `idx_kandidaten1_stimmzettel1` (`stimmzettel1`),

  CONSTRAINT `fk_kandidaten1_stimmzettel1` FOREIGN KEY (`stimmzettel1`) REFERENCES `stimmzettel1` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kandidaten1_kandidaten` FOREIGN KEY (`kandidaten`) REFERENCES `kandidaten` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
  
);

CREATE TABLE IF NOT EXISTS `kisten2` (

  `id` varchar(36) NOT NULL,
  `login` varchar(255) NOT NULL,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)

);

CREATE TABLE IF NOT EXISTS `stapel2` (
  `id` varchar(36) NOT NULL,
  `login` varchar(255) NOT NULL,
  `kisten2` varchar(36) NOT NULL,
  `abgebrochen` tinyint DEFAULT 0,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_stapel2_kisten2` FOREIGN KEY (`kisten2`) REFERENCES `kisten2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS `stimmzettel2` (
  `id` varchar(36) NOT NULL,

  `login` varchar(255) NOT NULL,
  `stapel2` varchar(36)  DEFAULT NULL,

  `stimmzettel` integer not null,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),

  KEY `idx_stimmzettel1_stimmzettel` (`stimmzettel`),
  KEY `idx_stimmzettel1_stapel2` (`stapel2`),

  CONSTRAINT `fk_stimmzettel2_stapel2` FOREIGN KEY (`stapel2`) REFERENCES `stapel2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stimmzettel2_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `kandidaten2` (
  
  `login` varchar(255) NOT NULL,
  `kandidaten` integer not null,
  `stimmzettel2` varchar(36) not null,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,  PRIMARY KEY (`kandidaten`,`stimmzettel2`),
  `stimmen` integer default 1,

  KEY `idx_kandidaten1_kandidaten` (`kandidaten`),
  KEY `idx_kandidaten1_stimmzettel2` (`stimmzettel2`),

  CONSTRAINT `fk_kandidaten2_stimmzettel2` FOREIGN KEY (`stimmzettel2`) REFERENCES `stimmzettel2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kandidaten2_kandidaten` FOREIGN KEY (`kandidaten`) REFERENCES `kandidaten` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
  
);


 