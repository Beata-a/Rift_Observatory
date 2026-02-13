-- Deleting FACT_Match_Champion table IF it exists

DROP TABLE IF EXISTS FACT_Match_Champion;

--Creating FACT_Match_Champion table

CREATE TABLE FACT_Match_Champion (
    Champion_Match_ID INT IDENTITY(1,1) PRIMARY KEY,
    Match_Date DATE NOT NULL,
    Event VARCHAR(100),
    Patch VARCHAR(20),
    Team_ID INT NOT NULL,
    Champion VARCHAR(100) NOT NULL,
    Side VARCHAR(10),
    Outcome VARCHAR(10),
    Picked BIT,
    Banned BIT,
    Games_Played INT,
    Wins INT,
    Win_Rate DECIMAL(5,2),
    Kills INT,
    CS INT,
    Gold INT,
    Damage INT,
    Role VARCHAR(50),
    Range_Type VARCHAR(20),
    Resource_Type VARCHAR(50),
    CONSTRAINT FK_CHAMP_TEAM_DIM FOREIGN KEY (Team_ID) REFERENCES DIM_Team(Team_ID)
);
GO


-- Building all champion rows (picks + bans, skip NULL bans)

WITH ChampionRows AS (


    -- Picks Blue

    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Pick_1 AS Champion, 'Blue' AS Side,
           CASE WHEN s.Winner = s.Blue_Team THEN 'Win' ELSE 'Lose' END AS Outcome,
           1 AS Picked, 0 AS Banned
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Pick_2, 'Blue',
           CASE WHEN s.Winner = s.Blue_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Pick_3, 'Blue',
           CASE WHEN s.Winner = s.Blue_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Pick_4, 'Blue',
           CASE WHEN s.Winner = s.Blue_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Pick_5, 'Blue',
           CASE WHEN s.Winner = s.Blue_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name


    -- Picks Red

    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Pick_1, 'Red',
           CASE WHEN s.Winner = s.Red_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Pick_2, 'Red',
           CASE WHEN s.Winner = s.Red_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Pick_3, 'Red',
           CASE WHEN s.Winner = s.Red_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Pick_4, 'Red',
           CASE WHEN s.Winner = s.Red_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Pick_5, 'Red',
           CASE WHEN s.Winner = s.Red_Team THEN 'Win' ELSE 'Lose' END, 1, 0
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name


    -- Bans Blue (skip NULLs)

    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Ban_1, 'Blue', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    WHERE s.BT_Ban_1 IS NOT NULL AND s.BT_Ban_1 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Ban_2, 'Blue', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    WHERE s.BT_Ban_2 IS NOT NULL AND s.BT_Ban_2 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Ban_3, 'Blue', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    WHERE s.BT_Ban_3 IS NOT NULL AND s.BT_Ban_3 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Ban_4, 'Blue', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    WHERE s.BT_Ban_4 IS NOT NULL AND s.BT_Ban_4 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.BT_Ban_5, 'Blue', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Blue_Team = t.Team_Name
    WHERE s.BT_Ban_5 IS NOT NULL AND s.BT_Ban_5 <> ''

    -- Bans Red (skip NULLs)
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Ban_1, 'Red', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    WHERE s.RT_Ban_1 IS NOT NULL AND s.RT_Ban_1 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Ban_2, 'Red', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    WHERE s.RT_Ban_2 IS NOT NULL AND s.RT_Ban_2 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Ban_3, 'Red', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    WHERE s.RT_Ban_3 IS NOT NULL AND s.RT_Ban_3 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Ban_4, 'Red', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    WHERE s.RT_Ban_4 IS NOT NULL AND s.RT_Ban_4 <> ''
    UNION ALL
    SELECT s.Match_Date, s.Event, s.Patch, t.Team_ID, s.RT_Ban_5, 'Red', NULL, 0, 1
    FROM Staging_Match_Stats s JOIN DIM_Team t ON s.Red_Team = t.Team_Name
    WHERE s.RT_Ban_5 IS NOT NULL AND s.RT_Ban_5 <> ''
),

ChampionMetrics AS (
    SELECT 
        Champion,
        SUM(Played_Games) AS Games_Played,
        SUM(Win) AS Wins,
        AVG(Win_Rate) AS Win_Rate,
        SUM(Kills) AS Kills,
        SUM(Creep_Score) AS CS,
        SUM(Gold) AS Gold,
        SUM(Damage) AS Damage
    FROM Staging_Champion_Stats
    GROUP BY Champion
),

ChampionStatic AS (
    SELECT 
        Name AS Champion,
        Role,
        Range AS Range_Type,
        Resource AS Resource_Type
    FROM Staging_LOL_Champions_2024
)

-- Populating FACT_Match_Champion by combining match picks and bans with aggregated champion stats
-- and static champion attributes while joining DIM_Team for Team_ID and filling missing metrics with 0

INSERT INTO FACT_Match_Champion (
    Match_Date, Event, Patch, Team_ID, Champion, Side, Outcome, Picked, Banned,
    Games_Played, Wins, Win_Rate, Kills, CS, Gold, Damage,
    Role, Range_Type, Resource_Type
)
SELECT
    cr.Match_Date,
    cr.Event,
    cr.Patch,
    cr.Team_ID,
    cr.Champion,
    cr.Side,
    cr.Outcome,
    cr.Picked,
    cr.Banned,
    ISNULL(cm.Games_Played,0),
    ISNULL(cm.Wins,0),
    ISNULL(cm.Win_Rate,0),
    ISNULL(cm.Kills,0),
    ISNULL(cm.CS,0),
    ISNULL(cm.Gold,0),
    ISNULL(cm.Damage,0),
    cs.Role,
    cs.Range_Type,
    cs.Resource_Type
FROM ChampionRows cr
LEFT JOIN ChampionMetrics cm ON cr.Champion = cm.Champion
LEFT JOIN ChampionStatic cs ON cr.Champion = cs.Champion;
GO


-- Shows everything currently stored in FACT_Match_Champion for verification

SELECT * FROM FACT_Match_Champion;