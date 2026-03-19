


insert ignore into ich_habe_keinen_namen_mehr_reloaded (auswertung_id, use_id, top_col_id,wahlscheinstatus,abgabetyp,sum_helper)
select id, stimmzettel, 'wb_1' as top_col_id,wahlscheinstatus,abgabetyp, 1 sum_helper from wahlschein;