
DELIMITER //


insert ignore into `wahlscheinstatus` (`id`, `name`, `aktiv`, `barcode`, `farbe`, `ohne_wahlberechtigten`,`login`) values
('-8','Zeichnunsgberechtigter unklar','0','FC999000','rgba(230, 23, 23, 1)','0','setup') //

CREATE OR REPLACE TRIGGER `trigger_wahlschein_bu_wm_register`
BEFORE
UPDATE ON `wahlschein` FOR EACH ROW
BEGIN
  IF (NEW.abgabetyp=2 and NEW.wahlscheinstatus=2) THEN
    IF NOT EXISTS (
      
      
      select 
        JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') fn,
        JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') ln,
        wahlzeichnungsberechtigter.vorname,
        wahlzeichnungsberechtigter.nachname,
        if (
            (
                  (
                    JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') = wahlzeichnungsberechtigter.vorname
                    and JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') = wahlzeichnungsberechtigter.nachname
                  ) or

                  (
                    JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') = wahlzeichnungsberechtigter.nachname
                    and JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') = wahlzeichnungsberechtigter.vorname

                  )
                  ),
                  'match',
                  'no match'
        ) status,
        wm_wahlschein_register.*,
        wahlschein.wahlscheinstatus
      from
        wm_wahlschein_register
        join
        wahlschein
          on wm_wahlschein_register.id = wahlschein.id
          and wahlschein.id = NEW.id
        join 
          wahlberechtigte
          on wahlberechtigte.id = wahlschein.wahlberechtigte
        left join 
          wahlzeichnungsberechtigter
          on 
            wahlberechtigte.id = wahlzeichnungsberechtigter.wahlberechtigte

      having status='match'

    ) THEN
      set NEW.wahlscheinstatus=-8;
    END IF;
  END IF;
  
END //