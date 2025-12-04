DELIMITER //


CREATE TABLE IF NOT EXISTS `voting_states` (
    id varchar(20) NOT NULL,
    constraint check(id in ('setup_phase', 'test_phase', 'production_phase', 'council_phase', 'reset_phase')),
    name varchar(255) NOT NULL,
    primary key (id)
) //

insert ignore into voting_states (id,name) values 
('setup_phase','Setup Phase'), ('test_phase','Test Phase'), ('production_phase','Wahldurchführung'), ('council_phase','Wahlauswertung'), ('reset_phase', 'Reset Phase') //

