
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
          on wm_wahlschein_register.voter_id = wahlschein.id
        join 
          wahlberechtigte
          on wahlberechtigte.identnummer = wahlschein.identnummer
        join 
          wahlzeichnungsberechtigter
          on wahlberechtigte.id = wahlzeichnungsberechtigter.wahlberechtigte
        where

          (
            JSON_VALUE(wm_wahlschein_register.formdata,'$.firstname') = wahlzeichnungsberechtigter.vorname
            and JSON_VALUE(wm_wahlschein_register.formdata,'$.lastname') = wahlzeichnungsberechtigter.nachname
          ) or

          (
            JSON_VALUE(wm_wahlschein_register.formdata,'$.firstname') = wahlzeichnungsberechtigter.nachname
            and JSON_VALUE(wm_wahlschein_register.formdata,'$.lastname') = wahlzeichnungsberechtigter.vorname

          )
    ) THEN
      set NEW.wahlscheinstatus=8;
    END IF;
  END IF;
  
END //