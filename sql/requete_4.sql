-- meilleurs buteurs de chaque saison, avec le tour atteint par leur club en phase finale

WITH tours AS (
    SELECT season, team_id,
           MAX(CASE stage WHEN 'Huitièmes' THEN 1 WHEN 'Quarts' THEN 2 WHEN 'Demi-finales' THEN 3 ELSE 4 END) AS niveau
    FROM (
        SELECT season, stage, home_team_id AS team_id FROM matches
        UNION ALL
        SELECT season, stage, away_team_id FROM matches
    ) x
    GROUP BY season, team_id
)
SELECT b.season,
       RANK() OVER (PARTITION BY b.season ORDER BY b.goals DESC) AS rang,
       p.player_name AS joueur,
       t.team_name   AS club,
       b.goals       AS buts,
       CASE tr.niveau
            WHEN 1 THEN 'Huitièmes'
            WHEN 2 THEN 'Quarts'
            WHEN 3 THEN 'Demi-finales'
            WHEN 4 THEN 'Finale'
            ELSE 'Éliminé avant'
       END AS tour_atteint
FROM top_buteurs b
JOIN players p USING (player_id)
JOIN teams   t USING (team_id)
LEFT JOIN tours tr ON tr.season = b.season AND tr.team_id = b.team_id
ORDER BY b.season, rang, joueur;
