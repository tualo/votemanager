drop table voting_state //
drop table voting_states //

CREATE TABLE IF NOT EXISTS `voting_states` (
    id varchar(20) NOT NULL,
    constraint check(id in ('setup_phase', 'test_phase', 'production_phase', 'council_phase', 'reset_phase')),
    name varchar(255) NOT NULL,
    primary key (id)
) //

insert ignore into voting_states (id,name) values 
('setup_phase','Setup Phase'), ('test_phase','Test Phase'), ('production_phase','Wahldurchführung'), ('council_phase','Wahlauswertung'), ('reset_phase', 'Reset Phase') //




CREATE TABLE IF NOT EXISTS `voting_state` (
    id integer(11) NOT NULL,
    constraint check(id = 1),
    phase varchar(20) NOT NULL,
    login varchar(255) DEFAULT NULL,
    constraint check(phase in ('setup_phase', 'test_phase', 'reset_phase', 'production_phase', 'council_phase')),
    
    -- enum('setup_phase', 'test_phase', 'production_phase','council_phase') NOT NULL,
    constraint `fk_voting_state_id` foreign key (phase) references voting_states(id) on delete restrict  on update restrict,
    primary key (id)
) WITH SYSTEM VERSIONING//

create or replace TRIGGER `trigger_voting_state_insert_bi` BEFORE insert ON `voting_state`
FOR EACH ROW
BEGIN
    SET NEW.login = getSessionUser();

    if NEW.login is null then
        SET NEW.login = 'system';
    end if;

END //

create or replace TRIGGER `trigger_voting_state_insert_bu` BEFORE update ON `voting_state`
FOR EACH ROW
BEGIN
    SET NEW.login = getSessionUser();

    if NEW.login is null then
        SET NEW.login = 'system';
    end if;

    IF OLD.phase = 'production_phase' THEN
        IF NEW.phase = 'setup_phase' 
        or NEW.phase = 'test_phase'  
        or NEW.phase = 'reset_phase' THEN
            signal sqlstate '45000' set message_text = 'Cannot update voting_state from production_phase';
        END IF;
    END IF;

    -- check if ballotbox is empty
    -- check if ballotbox_decrypted is empty
    -- check if voters is empty
    -- check if blocked_voters is empty

END //




insert ignore into voting_state (id, phase) values (1,'setup_phase') //
