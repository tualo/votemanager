delimiter //

CREATE TABLE IF NOT EXISTS `wahlschein_history` (
  `uid` varchar(36) NOT NULL DEFAULT uuid(),
  `id` bigint(20) NOT NULL,
  `stimmzettel` int(11) NOT NULL,
  `wahlscheinnummer` varchar(14) NOT NULL,
  `wahlberechtigte` bigint(20) NOT NULL,
  `wahlscheinstatus` int(11) DEFAULT 1,
  `wahlscheinstatus_grund` int(11) DEFAULT 0,
  `abgabetyp` int(11) DEFAULT 0,
  `pwhash` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `blocknumber` varchar(30) DEFAULT '0',
  `defered` tinyint(4) DEFAULT 0,
  `secret` varchar(500) DEFAULT NULL,
  `onlinecheck` tinyint(4) DEFAULT 0,
  `testdaten` tinyint(4) DEFAULT 0,
  `kombiniert` bigint(20) DEFAULT NULL,
  `usedate` date DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`uid`),
  index `idx_wahlschein_history_id_stimmzettel` (`id`,`stimmzettel`)
) //

create index if not exists `idx_wahlschein_history_id_stimmzettel` on `wahlschein_history` (id,stimmzettel) //

CREATE OR REPLACE TRIGGER `trigger_wahlschein_au_history` AFTER UPDATE ON `wahlschein` 
FOR EACH ROW BEGIN 

    insert DELAYED into `wahlschein_history` (
        id,
        stimmzettel,
        wahlscheinnummer,
        wahlberechtigte,
        wahlscheinstatus,
        wahlscheinstatus_grund,
        abgabetyp,
        pwhash,
        username,
        blocknumber,
        defered,
        secret,
        onlinecheck,
        testdaten, 
        kombiniert,
        usedate,
        login 
    ) values (
        new.id,
        new.stimmzettel,
        new.wahlscheinnummer,
        new.wahlberechtigte,
        new.wahlscheinstatus,
        new.wahlscheinstatus_grund,
        new.abgabetyp,
        new.pwhash,
        new.username,
        new.blocknumber,
        new.defered,
        new.secret,
        new.onlinecheck,
        new.testdaten, 
        new.kombiniert,
        new.usedate,
        new.login 
    );

END //


CREATE OR REPLACE TRIGGER `trigger_wahlschein_ai_history` AFTER INSERT ON `wahlschein` 
FOR EACH ROW BEGIN
    insert DELAYED into `wahlschein_history` (
        id,
        stimmzettel,
        wahlscheinnummer,
        wahlberechtigte,
        wahlscheinstatus,
        wahlscheinstatus_grund,
        abgabetyp,
        pwhash,
        username,
        blocknumber,
        defered,
        secret,
        onlinecheck,
        testdaten, 
        kombiniert,
        usedate,
        login 
    ) values (
        new.id,
        new.stimmzettel,
        new.wahlscheinnummer,
        new.wahlberechtigte,
        new.wahlscheinstatus,
        new.wahlscheinstatus_grund,
        new.abgabetyp,
        new.pwhash,
        new.username,
        new.blocknumber,
        new.defered,
        new.secret,
        new.onlinecheck,
        new.testdaten, 
        new.kombiniert,
        new.usedate,
        new.login 
    );

END //


CREATE OR REPLACE TRIGGER `trigger_wahlschein_ad_history` AFTER DELETE ON `wahlschein` 
FOR EACH ROW BEGIN
    insert DELAYED into `wahlschein_history` (
        id,
        stimmzettel,
        wahlscheinnummer,
        wahlberechtigte,
        wahlscheinstatus,
        wahlscheinstatus_grund,
        abgabetyp,
        pwhash,
        username,
        blocknumber,
        defered,
        secret,
        onlinecheck,
        testdaten, 
        kombiniert,
        usedate,
        login,
        deleted_at
    ) values (
        old.id,
        old.stimmzettel,
        old.wahlscheinnummer,
        old.wahlberechtigte,
        old.wahlscheinstatus,
        old.wahlscheinstatus_grund,
        old.abgabetyp,
        old.pwhash,
        old.username,
        old.blocknumber,
        old.defered,
        old.secret,
        old.onlinecheck,
        old.testdaten, 
        old.kombiniert,
        old.usedate,
        old.login,
        now()
    );

END //




CREATE OR REPLACE PROCEDURE `fillup_wahlschein_history_cluster_safe`()
    DETERMINISTIC
BEGIN
    declare check_count int default 0;
    declare total_count int default 0;
    
    for ws in (  
        select 
            id,
            stimmzettel,
            wahlscheinnummer,
            wahlberechtigte,
            wahlscheinstatus,
            wahlscheinstatus_grund,
            abgabetyp,
            pwhash,
            username,
            blocknumber,
            defered,
            secret,
            onlinecheck,
            testdaten, 
            kombiniert,
            usedate,
            login ,
            row_start,
            row_start
        from wahlschein for system_time all
        limit 20000
    ) do
        if check_count=1000 then

            select 'still running ...' msg, total_count;
            if ifnull( (select val from votemanager_setup where id = 'stop_fillup_wahlschein_history_cluster_safe' limit 1),  0) = 1 then
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'stop_fillup_wahlschein_history_cluster_safe called';
            end if ;
            set check_count = 0;
        end if ;

        set check_count=check_count+1;
        set total_count=total_count+1;
        
        insert DELAYED ignore into `wahlschein_history` (
                id,
                stimmzettel,
                wahlscheinnummer,
                wahlberechtigte,
                wahlscheinstatus,
                wahlscheinstatus_grund,
                abgabetyp,
                pwhash,
                username,
                blocknumber,
                defered,
                secret,
                onlinecheck,
                testdaten, 
                kombiniert,
                usedate,
                login,
                created_at,
                updated_at
            ) 
            values ( 
                ws.id,
                ws.stimmzettel,
                ws.wahlscheinnummer,
                ws.wahlberechtigte,
                ws.wahlscheinstatus,
                ws.wahlscheinstatus_grund,
                ws.abgabetyp,
                ws.pwhash,
                ws.username,
                ws.blocknumber,
                ws.defered,
                ws.secret,
                ws.onlinecheck,
                ws.testdaten, 
                ws.kombiniert,
                ws.usedate,
                ws.login ,
                ws.row_start,
                ws.row_start
            );
    end for;
END //