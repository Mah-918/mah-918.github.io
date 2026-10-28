-- bilan des équipes sur chaque saison (les 5 meilleures) : buts marqués, encaissés, différence et rang

WITH lignes AS (
    SELECT season, home_team_id AS team_id, home_goals AS pour, away_goals AS contre FROM matches
    UNION ALL
    SELECT season, away_team_id, away_goals, home_goals FROM matches
),
bilan AS (
    SELECT season, team_id,
           COUNT(*)         AS matchs,
           SUM(pour)        AS buts_pour,
           SUM(contre)      AS buts_contre,
           SUM(pour - contre) AS difference
    FROM lignes
    GROUP BY season, team_id
)
SELECT season, equipe, matchs, buts_pour, buts_contre, difference, rang
FROM (
    SELECT season, t.team_name AS equipe, matchs, buts_pour, buts_contre, difference,
           RANK() OVER (PARTITION BY season ORDER BY difference DESC, buts_pour DESC) AS rang
    FROM bilan b
    JOIN teams t USING (team_id)
) classement
WHERE rang <= 5
ORDER BY season, rang, equipe;
