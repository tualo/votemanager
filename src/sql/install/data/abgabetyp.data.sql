DELIMITER ;

INSERT
    IGNORE INTO abgabetyp (
        id,
        name,
        aktiv
    )
VALUES
    (
        0,
        'unbekannt',
        1
    ),
    (
        1,
        'Briefwahl',
        1
    ),
    (
        2,
        'Onlinewahl',
        1
    )
;