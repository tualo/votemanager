DELIMITER ;
CREATE TABLE IF NOT EXISTS `wm_tanboegen` (
  `id` int(11) NOT NULL,
  `datum` date DEFAULT NULL,
  `zeit` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;



DELIMITER //

CREATE  TRIGGER IF NOT EXISTS `trigger_wm_tanboegen_create_numbers`
    AFTER INSERT
    ON `wm_tanboegen` FOR EACH ROW
BEGIN
    DECLARE tan varchar(25);

    FOR i in 1 .. 20 DO
        SET tan = concat(
            'FC9',
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25))
        );
        INSERT IGNORE INTO wm_tannummer
        (
            tannummer,
            aktiv,
            bogen
        )
        VALUES 
        (
            tan,
            1,
            NEW.id
        );
    END FOR;
END //

