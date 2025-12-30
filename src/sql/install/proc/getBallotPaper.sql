DELIMITER //

CREATE OR REPLACE function  `getBallotpaper`(in_id integer) RETURNS varchar(255) 
    DETERMINISTIC
BEGIN
DECLARE `result` varchar(255);
select name into result from stimmzettel where id=in_id;
IF result is null THEN
    SET result = concat('nicht gesetzt');
END IF;

RETURN result;
END //