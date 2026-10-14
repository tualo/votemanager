CREATE OR REPLACE VIEW `timechart_user_performance` AS
SELECT
    `stimmzettel2`.`login` AS `login`,
    COUNT(*) AS `ausgezaehlt`,
    SUM(
        CASE
            WHEN `stimmzettel2`.`createdatetime` >= CURRENT_TIMESTAMP - INTERVAL 1 HOUR THEN 1
            ELSE 0
        END
    ) AS `letzte_stunde`,
    MIN(`stimmzettel2`.`createdatetime`) AS `erste_zaehlung`,
    MAX(`stimmzettel2`.`createdatetime`) AS `letzte_zaehlung`,
    TIMESTAMPDIFF(
        SECOND,
        MIN(`stimmzettel2`.`createdatetime`),
        MAX(`stimmzettel2`.`createdatetime`)
    ) AS `beobachtungszeit_sekunden`,
    ROUND(
        COUNT(*) * 3600
        / NULLIF(
            TIMESTAMPDIFF(
                SECOND,
                MIN(`stimmzettel2`.`createdatetime`),
                MAX(`stimmzettel2`.`createdatetime`)
            ),
            0
        ),
        2
    ) AS `durchschnitt_pro_stunde`
FROM `stimmzettel2`
JOIN `stapel2` ON `stapel2`.`id` = `stimmzettel2`.`stapel2`
WHERE COALESCE(`stimmzettel2`.`abgebrochen`, 0) = 0
  AND COALESCE(`stapel2`.`abgebrochen`, 0) = 0
GROUP BY `stimmzettel2`.`login`;