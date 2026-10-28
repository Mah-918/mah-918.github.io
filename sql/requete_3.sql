-- avantage du terrain : résultats des équipes qui reçoivent (finales exclues, lieu neutre)

SELECT season,
       COUNT(*)                                              AS matchs,
       ROUND(AVG(home_goals), 2)                             AS buts_dom_par_match,
       ROUND(AVG(away_goals), 2)                             AS buts_ext_par_match,
       ROUND(100.0 * COUNT(*) FILTER (WHERE home_goals > away_goals) / COUNT(*), 1) AS pct_victoires_dom,
       ROUND(100.0 * COUNT(*) FILTER (WHERE home_goals = away_goals) / COUNT(*), 1) AS pct_nuls,
       ROUND(100.0 * COUNT(*) FILTER (WHERE home_goals < away_goals) / COUNT(*), 1) AS pct_victoires_ext
FROM matches
WHERE leg <> 'Finale'
GROUP BY season
ORDER BY season;
