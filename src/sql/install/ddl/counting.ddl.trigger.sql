DELIMITER //

CREATE OR REPLACE TRIGGER   `kandidaten2_ai_defered_briefwahlkandidaten`
    AFTER INSERT
    ON `kandidaten2` FOR EACH ROW
BEGIN
    replace into deferred_sql_tasks (
        taskid,
        sessionuser,
        state,
        createtime,
        sqlstatement,
        hostname
    ) values (
        "proc_briefwahlkandidaten",
        getSessionUser(),
        0,
        current_timestamp(),
        "call proc_briefwahlkandidaten()",
        @@hostname
    );

END //

CREATE OR REPLACE TRIGGER  `stapel2_au_defered_briefwahlkandidaten`
    AFTER UPDATE
    ON `stapel2` FOR EACH ROW
BEGIN
    replace into deferred_sql_tasks (
        taskid,
        sessionuser,
        state,
        createtime,
        sqlstatement,
        hostname
    ) values (
        "proc_briefwahlkandidaten",
        getSessionUser(),
        0,
        current_timestamp(),
        "call proc_briefwahlkandidaten()",
        @@hostname
    );

END //