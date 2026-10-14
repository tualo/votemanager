CREATE OR REPLACE VIEW `timechart` AS
SELECT
    target.`erwartet`,
    progress.`ausgezaehlt`,
    GREATEST(target.`erwartet` - progress.`ausgezaehlt`, 0) AS `offen`,
    progress.`zaehlung_beginn`,
    progress.`letzte_zaehlung`,
    TIMESTAMPDIFF(SECOND, progress.`zaehlung_beginn`, progress.`letzte_zaehlung`) AS `beobachtungszeit_sekunden`,
    CASE
        WHEN TIMESTAMPDIFF(SECOND, progress.`zaehlung_beginn`, CURRENT_TIMESTAMP) >= 900
        THEN ROUND(progress.`letzte_15_minuten` * 4, 2)
        ELSE NULL
    END AS `stimmzettel_pro_stunde`,
    CASE
        WHEN target.`erwartet` = 0 THEN NULL
        WHEN progress.`ausgezaehlt` >= target.`erwartet` THEN CURRENT_TIMESTAMP
        WHEN progress.`ausgezaehlt` > 0
            AND TIMESTAMPDIFF(SECOND, progress.`zaehlung_beginn`, CURRENT_TIMESTAMP) >= 900
            AND progress.`letzte_15_minuten` > 0
        THEN TIMESTAMPADD(
            SECOND,
            CEIL(
                (target.`erwartet` - progress.`ausgezaehlt`)
                * 900
                / progress.`letzte_15_minuten`
            ),
            CURRENT_TIMESTAMP
        )
        ELSE NULL
    END AS `prognose_ende`
FROM (
    SELECT COUNT(*) AS `erwartet`
    FROM `wahlschein`
    WHERE `wahlscheinstatus` = 2
    AND `abgabetyp` = 1
) AS target
CROSS JOIN (
    SELECT
        COUNT(*) AS `ausgezaehlt`,
        MIN(`stimmzettel2`.`createdatetime`) AS `zaehlung_beginn`,
        MAX(`stimmzettel2`.`createdatetime`) AS `letzte_zaehlung`,
        SUM(
            CASE
                WHEN `stimmzettel2`.`createdatetime` >= CURRENT_TIMESTAMP - INTERVAL 15 MINUTE THEN 1
                ELSE 0
            END
        ) AS `letzte_15_minuten`
    FROM `stimmzettel2`
    JOIN `stapel2` ON `stapel2`.`id` = `stimmzettel2`.`stapel2`
    WHERE COALESCE(`stimmzettel2`.`abgebrochen`, 0) = 0
      AND COALESCE(`stapel2`.`abgebrochen`, 0) = 0
) AS progress;