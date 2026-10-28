-- parcours d'un club : tous les matchs d'une équipe, avec le cumul de buts au fil des rounds (ici Real Madrid)

WITH parcours AS (
    SELECT m.season, m.stage, m.leg,
           CASE WHEN m.leg = 'Finale' THEN 'Neutre' WHEN m.home_team_id = t.team_id THEN 'Domicile' ELSE 'Extérieur' END AS lieu,
           CASE WHEN m.home_team_id = t.team_id THEN a.team_name ELSE h.team_name END AS adversaire,
           CASE WHEN m.home_team_id = t.team_id THEN m.home_goals ELSE m.away_goals END AS pour,
           CASE WHEN m.home_team_id = t.team_id THEN m.away_goals ELSE m.home_goals END AS contre,
           m.match_id
    FROM matches m
    JOIN teams t ON t.team_name = 'Real Madrid' AND t.team_id IN (m.home_team_id, m.away_team_id)
    JOIN teams h ON h.team_id = m.home_team_id
    JOIN teams a ON a.team_id = m.away_team_id
)
SELECT season, stage AS tour, leg, adversaire, lieu,
       pour || ' - ' || contre AS score,
       CASE WHEN pour > contre THEN 'V' WHEN pour = contre THEN 'N' ELSE 'D' END AS resultat,
       SUM(pour) OVER (PARTITION BY season ORDER BY match_id) AS buts_cumules
FROM parcours
ORDER BY match_id;
