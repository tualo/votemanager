DELIMITER //
CREATE  OR REPLACE FUNCTION `involvement_filter`(filterdata JSON) RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
  DECLARE lvl BOOLEAN DEFAULT FALSE;
  DECLARE keyname integer;
  if @involvement_filter_id IS NULL THEN
    set keyname = 0;
  END IF;

  if @involvement_filter_id IS not NULL THEN
    set keyname = @involvement_filter_id;
  END IF;
  set lvl = (SELECT 
      CASE 
        WHEN filterdata IS NULL THEN TRUE
        WHEN JSON_EXISTS(filterdata, CONCAT('$.auswertung_',keyname)) IS FALSE THEN FALSE
        WHEN JSON_EXTRACT(filterdata, CONCAT('$.auswertung_',keyname)) IS NULL THEN FALSE
        WHEN JSON_EXTRACT(filterdata, CONCAT('$.auswertung_',keyname)) = 1 THEN TRUE
        ELSE FALSE
      END AS filter_result
    );
  RETURN lvl;
END //