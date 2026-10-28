-- création des tables et chargement des données (phase à élimination directe 2021-22 et 2022-23)

DROP TABLE IF EXISTS top_buteurs, matches, players, teams CASCADE;

CREATE TABLE teams (
    team_id    SERIAL PRIMARY KEY,
    team_name  VARCHAR(40) NOT NULL UNIQUE,
    country    VARCHAR(30) NOT NULL
);

CREATE TABLE players (
    player_id   SERIAL PRIMARY KEY,
    player_name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE matches (
    match_id     SERIAL PRIMARY KEY,
    season       VARCHAR(7)  NOT NULL,
    stage        VARCHAR(15) NOT NULL CHECK (stage IN ('Huitièmes','Quarts','Demi-finales','Finale')),
    tie_code     VARCHAR(3)  NOT NULL,
    leg          VARCHAR(7)  NOT NULL CHECK (leg IN ('Aller','Retour','Finale')),
    home_team_id INT NOT NULL REFERENCES teams(team_id),
    away_team_id INT NOT NULL REFERENCES teams(team_id),
    home_goals   INT NOT NULL,
    away_goals   INT NOT NULL,
    extra_time   BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE top_buteurs (
    season    VARCHAR(7) NOT NULL,
    player_id INT NOT NULL REFERENCES players(player_id),
    team_id   INT NOT NULL REFERENCES teams(team_id),
    goals     INT NOT NULL,
    PRIMARY KEY (season, player_id)
);

CREATE INDEX idx_matches_season ON matches(season);
CREATE INDEX idx_matches_tie    ON matches(season, tie_code);

INSERT INTO teams (team_name, country) VALUES
    ('Red Bull Salzburg', 'Autriche'),
    ('Bayern Munich', 'Allemagne'),
    ('Sporting CP', 'Portugal'),
    ('Manchester City', 'Angleterre'),
    ('Benfica', 'Portugal'),
    ('Ajax', 'Pays-Bas'),
    ('Chelsea', 'Angleterre'),
    ('Lille', 'France'),
    ('Atlético Madrid', 'Espagne'),
    ('Manchester United', 'Angleterre'),
    ('Villarreal', 'Espagne'),
    ('Juventus', 'Italie'),
    ('Inter Milan', 'Italie'),
    ('Liverpool', 'Angleterre'),
    ('Paris Saint-Germain', 'France'),
    ('Real Madrid', 'Espagne'),
    ('RB Leipzig', 'Allemagne'),
    ('Club Bruges', 'Belgique'),
    ('AC Milan', 'Italie'),
    ('Tottenham Hotspur', 'Angleterre'),
    ('Eintracht Francfort', 'Allemagne'),
    ('Napoli', 'Italie'),
    ('Borussia Dortmund', 'Allemagne'),
    ('FC Porto', 'Portugal'),
    ('FC Barcelone', 'Espagne');

INSERT INTO players (player_name) VALUES
    ('Karim Benzema'),
    ('Robert Lewandowski'),
    ('Sébastien Haller'),
    ('Mohamed Salah'),
    ('Christopher Nkunku'),
    ('Riyad Mahrez'),
    ('Cristiano Ronaldo'),
    ('Darwin Núñez'),
    ('Kylian Mbappé'),
    ('Leroy Sané'),
    ('Arnaut Danjuma'),
    ('Erling Haaland'),
    ('Vinícius Júnior'),
    ('João Mário'),
    ('Victor Osimhen'),
    ('Mehdi Taremi'),
    ('Rodrygo'),
    ('Rafa Silva'),
    ('Olivier Giroud');

INSERT INTO matches (season, stage, tie_code, leg, home_team_id, away_team_id, home_goals, away_goals, extra_time) VALUES
    ('2021-22', 'Huitièmes', 'H1', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Red Bull Salzburg'), (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), 1, 1, FALSE),
    ('2021-22', 'Huitièmes', 'H1', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), (SELECT team_id FROM teams WHERE team_name = 'Red Bull Salzburg'), 7, 1, FALSE),
    ('2021-22', 'Huitièmes', 'H2', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Sporting CP'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 0, 5, FALSE),
    ('2021-22', 'Huitièmes', 'H2', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), (SELECT team_id FROM teams WHERE team_name = 'Sporting CP'), 0, 0, FALSE),
    ('2021-22', 'Huitièmes', 'H3', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Benfica'), (SELECT team_id FROM teams WHERE team_name = 'Ajax'), 2, 2, FALSE),
    ('2021-22', 'Huitièmes', 'H3', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Ajax'), (SELECT team_id FROM teams WHERE team_name = 'Benfica'), 0, 1, FALSE),
    ('2021-22', 'Huitièmes', 'H4', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), (SELECT team_id FROM teams WHERE team_name = 'Lille'), 2, 0, FALSE),
    ('2021-22', 'Huitièmes', 'H4', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Lille'), (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), 1, 2, FALSE),
    ('2021-22', 'Huitièmes', 'H5', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Atlético Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Manchester United'), 1, 1, FALSE),
    ('2021-22', 'Huitièmes', 'H5', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Manchester United'), (SELECT team_id FROM teams WHERE team_name = 'Atlético Madrid'), 0, 1, FALSE),
    ('2021-22', 'Huitièmes', 'H6', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Villarreal'), (SELECT team_id FROM teams WHERE team_name = 'Juventus'), 1, 1, FALSE),
    ('2021-22', 'Huitièmes', 'H6', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Juventus'), (SELECT team_id FROM teams WHERE team_name = 'Villarreal'), 0, 3, FALSE),
    ('2021-22', 'Huitièmes', 'H7', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), 0, 2, FALSE),
    ('2021-22', 'Huitièmes', 'H7', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), 0, 1, FALSE),
    ('2021-22', 'Huitièmes', 'H8', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Paris Saint-Germain'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 1, 0, FALSE),
    ('2021-22', 'Huitièmes', 'H8', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Paris Saint-Germain'), 3, 1, FALSE),
    ('2021-22', 'Quarts', 'Q1', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 1, 3, FALSE),
    ('2021-22', 'Quarts', 'Q1', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), 2, 3, TRUE),
    ('2021-22', 'Quarts', 'Q2', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), (SELECT team_id FROM teams WHERE team_name = 'Atlético Madrid'), 1, 0, FALSE),
    ('2021-22', 'Quarts', 'Q2', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Atlético Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 0, 0, FALSE),
    ('2021-22', 'Quarts', 'Q3', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Villarreal'), (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), 1, 0, FALSE),
    ('2021-22', 'Quarts', 'Q3', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), (SELECT team_id FROM teams WHERE team_name = 'Villarreal'), 1, 1, FALSE),
    ('2021-22', 'Quarts', 'Q4', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Benfica'), (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), 1, 3, FALSE),
    ('2021-22', 'Quarts', 'Q4', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), (SELECT team_id FROM teams WHERE team_name = 'Benfica'), 3, 3, FALSE),
    ('2021-22', 'Demi-finales', 'D1', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 4, 3, FALSE),
    ('2021-22', 'Demi-finales', 'D1', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 3, 1, TRUE),
    ('2021-22', 'Demi-finales', 'D2', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), (SELECT team_id FROM teams WHERE team_name = 'Villarreal'), 2, 0, FALSE),
    ('2021-22', 'Demi-finales', 'D2', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Villarreal'), (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), 2, 3, FALSE),
    ('2021-22', 'Finale', 'F', 'Finale', (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), 1, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H1', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'RB Leipzig'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 1, 1, FALSE),
    ('2022-23', 'Huitièmes', 'H1', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), (SELECT team_id FROM teams WHERE team_name = 'RB Leipzig'), 7, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H2', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Club Bruges'), (SELECT team_id FROM teams WHERE team_name = 'Benfica'), 0, 2, FALSE),
    ('2022-23', 'Huitièmes', 'H2', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Benfica'), (SELECT team_id FROM teams WHERE team_name = 'Club Bruges'), 5, 1, FALSE),
    ('2022-23', 'Huitièmes', 'H3', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 2, 5, FALSE),
    ('2022-23', 'Huitièmes', 'H3', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), 1, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H4', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'AC Milan'), (SELECT team_id FROM teams WHERE team_name = 'Tottenham Hotspur'), 1, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H4', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Tottenham Hotspur'), (SELECT team_id FROM teams WHERE team_name = 'AC Milan'), 0, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H5', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Eintracht Francfort'), (SELECT team_id FROM teams WHERE team_name = 'Napoli'), 0, 2, FALSE),
    ('2022-23', 'Huitièmes', 'H5', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Napoli'), (SELECT team_id FROM teams WHERE team_name = 'Eintracht Francfort'), 3, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H6', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Borussia Dortmund'), (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), 1, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H6', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), (SELECT team_id FROM teams WHERE team_name = 'Borussia Dortmund'), 2, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H7', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), (SELECT team_id FROM teams WHERE team_name = 'FC Porto'), 1, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H7', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'FC Porto'), (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), 0, 0, FALSE),
    ('2022-23', 'Huitièmes', 'H8', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Paris Saint-Germain'), (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), 0, 1, FALSE),
    ('2022-23', 'Huitièmes', 'H8', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), (SELECT team_id FROM teams WHERE team_name = 'Paris Saint-Germain'), 2, 0, FALSE),
    ('2022-23', 'Quarts', 'Q1', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), 2, 0, FALSE),
    ('2022-23', 'Quarts', 'Q1', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Chelsea'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 0, 2, FALSE),
    ('2022-23', 'Quarts', 'Q2', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Benfica'), (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), 0, 2, FALSE),
    ('2022-23', 'Quarts', 'Q2', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), (SELECT team_id FROM teams WHERE team_name = 'Benfica'), 3, 3, FALSE),
    ('2022-23', 'Quarts', 'Q3', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), 3, 0, FALSE),
    ('2022-23', 'Quarts', 'Q3', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 1, 1, FALSE),
    ('2022-23', 'Quarts', 'Q4', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'AC Milan'), (SELECT team_id FROM teams WHERE team_name = 'Napoli'), 1, 0, FALSE),
    ('2022-23', 'Quarts', 'Q4', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Napoli'), (SELECT team_id FROM teams WHERE team_name = 'AC Milan'), 1, 1, FALSE),
    ('2022-23', 'Demi-finales', 'D1', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'AC Milan'), (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), 0, 2, FALSE),
    ('2022-23', 'Demi-finales', 'D1', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), (SELECT team_id FROM teams WHERE team_name = 'AC Milan'), 1, 0, FALSE),
    ('2022-23', 'Demi-finales', 'D2', 'Aller', (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 1, 1, FALSE),
    ('2022-23', 'Demi-finales', 'D2', 'Retour', (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 4, 0, FALSE),
    ('2022-23', 'Finale', 'F', 'Finale', (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), (SELECT team_id FROM teams WHERE team_name = 'Inter Milan'), 1, 0, FALSE);

INSERT INTO top_buteurs (season, player_id, team_id, goals) VALUES
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Karim Benzema'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 15),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Robert Lewandowski'), (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), 13),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Sébastien Haller'), (SELECT team_id FROM teams WHERE team_name = 'Ajax'), 11),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Mohamed Salah'), (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), 8),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Christopher Nkunku'), (SELECT team_id FROM teams WHERE team_name = 'RB Leipzig'), 7),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Riyad Mahrez'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 7),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Cristiano Ronaldo'), (SELECT team_id FROM teams WHERE team_name = 'Manchester United'), 6),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Darwin Núñez'), (SELECT team_id FROM teams WHERE team_name = 'Benfica'), 6),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Kylian Mbappé'), (SELECT team_id FROM teams WHERE team_name = 'Paris Saint-Germain'), 6),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Leroy Sané'), (SELECT team_id FROM teams WHERE team_name = 'Bayern Munich'), 6),
    ('2021-22', (SELECT player_id FROM players WHERE player_name = 'Arnaut Danjuma'), (SELECT team_id FROM teams WHERE team_name = 'Villarreal'), 6),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Erling Haaland'), (SELECT team_id FROM teams WHERE team_name = 'Manchester City'), 12),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Mohamed Salah'), (SELECT team_id FROM teams WHERE team_name = 'Liverpool'), 8),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Kylian Mbappé'), (SELECT team_id FROM teams WHERE team_name = 'Paris Saint-Germain'), 7),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Vinícius Júnior'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 7),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'João Mário'), (SELECT team_id FROM teams WHERE team_name = 'Benfica'), 6),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Victor Osimhen'), (SELECT team_id FROM teams WHERE team_name = 'Napoli'), 5),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Robert Lewandowski'), (SELECT team_id FROM teams WHERE team_name = 'FC Barcelone'), 5),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Mehdi Taremi'), (SELECT team_id FROM teams WHERE team_name = 'FC Porto'), 5),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Rodrygo'), (SELECT team_id FROM teams WHERE team_name = 'Real Madrid'), 5),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Rafa Silva'), (SELECT team_id FROM teams WHERE team_name = 'Benfica'), 5),
    ('2022-23', (SELECT player_id FROM players WHERE player_name = 'Olivier Giroud'), (SELECT team_id FROM teams WHERE team_name = 'AC Milan'), 5);
