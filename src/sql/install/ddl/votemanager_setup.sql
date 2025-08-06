DELIMITER ;
CREATE TABLE IF NOT EXISTS  `votemanager_setup` (
  `id` varchar(100) NOT NULL,
  `val` varchar(128) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ;

insert ignore into votemanager_setup (id, val) values ('wm_report_base', 'stimmzettel');
insert ignore into votemanager_setup (id, val) values ('wm_report_partial', 'show');
insert ignore into votemanager_setup (id, val) values ('wm_report_pagenumbers', 'show');
insert ignore into votemanager_setup (id, val) values ('wm_report_bp_break', 'yes');

