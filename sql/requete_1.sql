-- résultats de la phase finale : un match par ligne, avec le vainqueur de chaque confrontation

WITH confrontations AS (
    SELECT m.season, m.stage, m.tie_code,
           t.team_name,
           SUM(CASE WHEN m.home_team_id = t.team_id THEN m.home_goals ELSE m.away_goals END) AS buts_pour,
           SUM(CASE WHEN m.home_team_id = t.team_id THEN m.away_goals ELSE m.home_goals END) AS buts_contre
    FROM matches m
    JOIN teams t ON t.team_id IN (m.home_team_id, m.away_team_id)
    GROUP BY m.season, m.stage, m.tie_code, t.team_name
)
SELECT season, stage AS tour, team_name AS equipe,
       buts_pour || ' - ' || buts_contre AS cumul
FROM confrontations c
WHERE buts_pour > buts_contre AND stage <> 'Finale'
ORDER BY season,
         CASE stage WHEN 'Huitièmes' THEN 1 WHEN 'Quarts' THEN 2 ELSE 3 END,
         tie_code;
