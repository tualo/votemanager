DELIMITER //
CREATE OR REPLACE FUNCTION `randomString`(length SMALLINT(3),allowedChars varchar(255)) 
RETURNS varchar(100) CHARSET utf8
begin
    SET @returnStr = '';
    SET @i = 0;

    WHILE (@i < length) DO
        SET @returnStr = CONCAT(@returnStr, substring(allowedChars, FLOOR(RAND() * LENGTH(allowedChars) + 1), 1));
        SET @i = @i + 1;
    END WHILE;

    RETURN @returnStr;
END //

CREATE OR REPLACE PROCEDURE `createRandomList`(
    in randomLength SMALLINT(3),
    in allowedChars varchar(255), 
    in listLength int(11),
    in fieldToUnique varchar(255)
)
begin

    declare sql_command longtext;
    declare c int;
--    drop table if exists temp_random_list;

    set sql_command = concat('create temporary table if not exists temp_random_list (seq bigint , val varchar(',randomLength,') primary key)');
    PREPARE stmt FROM sql_command;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;


    set c=0;
    while (c< listLength) DO
        set sql_command = concat('insert ignore into temp_random_list (seq  , val )  select seq,randomString(',randomLength,',"',allowedChars,'") val from seq_1_to_3000');
        PREPARE stmt FROM sql_command;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        if (fieldToUnique='username') then
            delete from temp_random_list where val in (select username from wahlschein FOR SYSTEM_TIME ALL);
        end if;

        if (fieldToUnique='wahlscheinnummer') then
            delete from temp_random_list where val in (select wahlscheinnummer from wahlschein  FOR SYSTEM_TIME ALL);
        end if;

        set c = (select count(*)x from temp_random_list);
    END WHILE;

end //
