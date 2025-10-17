
DELIMITER //
CREATE OR REPLACE TRIGGER `trigger_wahlschein_bu_wm_register`
BEFORE
UPDATE ON `wahlschein` FOR EACH ROW
BEGIN
  IF (NEW.abgabetyp=2 and NEW.wahlscheinstatus=2) THEN
    IF NOT EXISTS (
      select 1 
      from
        wm_wahlschein_register
        join
        wahlschein
          on wm_wahlschein_register.id = wahlschein.id
        join 
          wahlberechtigte
          on wahlberechtigte.identnummer = wahlschein.name
        join 
          wahlzeichnungsberechtigter
          on wahlberechtigte.id = wahlzeichnungsberechtigter.wahlberechtigte
        where

          (
            JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') = wahlzeichnungsberechtigter.vorname
            and JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') = wahlzeichnungsberechtigter.nachname
          ) or

          (
            JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') = wahlzeichnungsberechtigter.nachname
            and JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') = wahlzeichnungsberechtigter.vorname

          )
    ) THEN
      set NEW.wahlscheinstatus=8;
    END IF;
  END IF;
  
END //