DELIMITER //
CREATE OR REPLACE TRIGGER   `wahlschein_login_bu`
    BEFORE UPDATE
    ON `wahlschein` FOR EACH ROW
BEGIN

    SET new.login = getSessionUser();
    SET new.updated_at=now();
    
END //

CREATE TRIGGER IF NOT EXISTS `wahlschein_login_bi`
    BEFORE INSERT
    ON `wahlschein` FOR EACH ROW
BEGIN
    SET new.login = getSessionUser();
    SET new.created_at=now();   
END //
