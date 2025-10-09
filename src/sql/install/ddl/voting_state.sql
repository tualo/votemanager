DELIMITER //




CREATE TABLE IF NOT EXISTS `voting_state` (
    id integer(11) NOT NULL,
    constraint check(id = 1),
    phase varchar(20) NOT NULL,
    constraint check(phase in ('setup_phase', 'test_phase', 'production_phase', 'council_phase')),
    
    -- enum('setup_phase', 'test_phase', 'production_phase','council_phase') NOT NULL,
    constraint `fk_voting_state_id` foreign key (phase) references voting_states(id) on delete restrict  on update restrict,
    primary key (id)
) //

create or replace TRIGGER `trigger_voting_state_insert_bu` BEFORE update ON `voting_state`
FOR EACH ROW
BEGIN
    IF OLD.phase = 'production_phase' THEN
        if NEW.phase = 'setup_phase' or NEW.phase = 'test_phase' THEN
            signal sqlstate '45000' set message_text = 'Cannot update voting_state from production_phase';
        END IF;
    END IF;

    -- check if ballotbox is empty
    -- check if ballotbox_decrypted is empty
    -- check if voters is empty
    -- check if blocked_voters is empty

END //
