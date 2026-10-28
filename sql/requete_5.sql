-- évolution des clubs présents en phase finale deux saisons de suite (LAG)

WITH buts AS (
    SELECT season, team_id, SUM(pour) AS buts_marques, SUM(contre) AS buts_encaisses
    FROM (
        SELECT season, home_team_id AS team_id, home_goals AS pour, away_goals AS contre FROM matches
        UNION ALL
        SELECT season, away_team_id, away_goals, home_goals FROM matches
    ) x
    GROUP BY season, team_id
),
evolution AS (
    SELECT team_id, season, buts_marques, buts_encaisses,
           LAG(buts_marques)   OVER (PARTITION BY team_id ORDER BY season) AS marques_avant,
           LAG(buts_encaisses) OVER (PARTITION BY team_id ORDER BY season) AS encaisses_avant
    FROM buts
)
SELECT t.team_name AS equipe,
       marques_avant   AS marques_2021_22,   buts_marques   AS marques_2022_23,
       encaisses_avant AS encaisses_2021_22, buts_encaisses AS encaisses_2022_23,
       buts_marques - marques_avant AS evolution_buts_marques
FROM evolution e
JOIN teams t USING (team_id)
WHERE season = '2022-23' AND marques_avant IS NOT NULL
ORDER BY evolution_buts_marques DESC;
