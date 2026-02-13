-- Deleting FACT_Match_Player table IF it exists

DROP TABLE IF EXISTS FACT_Match_Player;


-- Creating FACT_Match_Player table

CREATE TABLE FACT_Match_Player (
    Match_ID INT IDENTITY(1,1) PRIMARY KEY,
    Match_Date DATE NOT NULL,
    Event VARCHAR(100),
    Patch VARCHAR(20),
    Player_ID INT NOT NULL,
    Team_ID INT NOT NULL,
    Role VARCHAR(50),
    Champion VARCHAR(100),
    Opponent_Player VARCHAR(100),
    Opponent_Champion VARCHAR(100),
    Side VARCHAR(10),
    Outcome VARCHAR(10),
    Kills INT,
    Deaths INT,
    Assists INT,
    CS INT,
    Gold INT,
    Damage INT,
    CONSTRAINT FK_FACT_Player_DIM FOREIGN KEY (Player_ID) REFERENCES DIM_Player(Player_ID),
    CONSTRAINT FK_FACT_Team_DIM FOREIGN KEY (Team_ID) REFERENCES DIM_Team(Team_ID)
);
GO


-- Populating the FACT_Match_Player with damage included

WITH PlayerBase AS (

    -- Flattening Blue & Red side players from Staging_Match_Stats


    SELECT
        Match_Date,
        Event,
        Patch,
        BT_Top AS Player_Name, Blue_Team AS Team_Name, 'TOP' AS Role,
        BT_Pick_1 AS Champion,
        RT_Top AS Opponent_Player,
        RT_Pick_1 AS Opponent_Champion,
        'Blue' AS Side,
        CASE WHEN Winner = Blue_Team THEN 'Win' ELSE 'Lose' END AS Outcome
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, BT_Jungle, Blue_Team, 'JUNGLE', BT_Pick_2, RT_Jungle, RT_Pick_2, 'Blue',
           CASE WHEN Winner = Blue_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, BT_Mid, Blue_Team, 'MID', BT_Pick_3, RT_Mid, RT_Pick_3, 'Blue',
           CASE WHEN Winner = Blue_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, BT_ADC, Blue_Team, 'ADC', BT_Pick_4, RT_ADC, RT_Pick_4, 'Blue',
           CASE WHEN Winner = Blue_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, BT_Support, Blue_Team, 'SUPPORT', BT_Pick_5, RT_Support, RT_Pick_5, 'Blue',
           CASE WHEN Winner = Blue_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL

    -- Red side players


    SELECT Match_Date, Event, Patch, RT_Top, Red_Team, 'TOP', RT_Pick_1, BT_Top, BT_Pick_1, 'Red',
           CASE WHEN Winner = Red_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, RT_Jungle, Red_Team, 'JUNGLE', RT_Pick_2, BT_Jungle, BT_Pick_2, 'Red',
           CASE WHEN Winner = Red_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, RT_Mid, Red_Team, 'MID', RT_Pick_3, BT_Mid, BT_Pick_3, 'Red',
           CASE WHEN Winner = Red_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, RT_ADC, Red_Team, 'ADC', RT_Pick_4, BT_ADC, BT_Pick_4, 'Red',
           CASE WHEN Winner = Red_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats

    UNION ALL
    SELECT Match_Date, Event, Patch, RT_Support, Red_Team, 'SUPPORT', RT_Pick_5, BT_Support, BT_Pick_5, 'Red',
           CASE WHEN Winner = Red_Team THEN 'Win' ELSE 'Lose' END
    FROM Staging_Match_Stats
),

PlayerMetrics AS (


    -- Merge numeric stats including damage

    SELECT
        ps.Event,
        ps.Team AS Team_Name,
        ps.Player AS Player_Name,
        ps.Kills,
        ps.Deaths,
        ps.Assists,
        ps.CS,
        ps.Gold,
        ps.Damage
    FROM Staging_Player_Stats ps

    UNION ALL


    -- Merge Worlds stats if available

    SELECT
        ws.Round AS Event,
        ws.Team AS Team_Name,
        ws.Player AS Player_Name,
        ws.Kills,
        ws.Deaths,
        ws.Assists,
        ws.CS,
        ws.Golds AS Gold,
        ws.Total_damage_to_Champion AS Damage
    FROM Staging_Worlds_2024 ws
)


-- Populating FACT_Match_Player using PlayerBase for match info and PlayerMetrics for player stats,
-- joining DIM_Player and DIM_Team to get the corresponding IDs.

INSERT INTO FACT_Match_Player (
    Match_Date, Event, Patch, Player_ID, Team_ID, Role, Champion, Opponent_Player, Opponent_Champion, Side, Outcome,
    Kills, Deaths, Assists, CS, Gold, Damage
)
SELECT
    pb.Match_Date,
    pb.Event,
    pb.Patch,
    dp.Player_ID,
    dt.Team_ID,
    pb.Role,
    pb.Champion,
    pb.Opponent_Player,
    pb.Opponent_Champion,
    pb.Side,
    pb.Outcome,
    pm.Kills,
    pm.Deaths,
    pm.Assists,
    pm.CS,
    pm.Gold,
    pm.Damage
FROM PlayerBase pb
JOIN DIM_Player dp ON pb.Player_Name = dp.Player_Name
JOIN DIM_Team dt ON pb.Team_Name = dt.Team_Name
LEFT JOIN PlayerMetrics pm 
    ON pb.Player_Name = pm.Player_Name
   AND pb.Team_Name = pm.Team_Name
   AND pb.Event = pm.Event;
GO


-- Shows everything currently stored in FACT_Match_Player for verification

SELECT * FROM FACT_Match_Player;