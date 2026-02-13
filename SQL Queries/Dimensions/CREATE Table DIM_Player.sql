-- Deleting DIM_Player table IF it exists

DROP TABLE IF EXISTS DIM_Player;


-- Creating DIM_Player table

CREATE TABLE DIM_Player(
    Player_ID INT IDENTITY(1,1) PRIMARY KEY,
    Player_Name VARCHAR(250) NOT NULL,
    Team_ID INT NOT NULL,
    CONSTRAINT FK_DIM_Player_Team
        FOREIGN KEY (Team_ID) REFERENCES DIM_Team(Team_ID),
    CONSTRAINT UQ_DIM_Player UNIQUE (Player_Name, Team_ID)
);
GO


-- Populating DIM_Tournament using data from the staging tables

WITH PlayerList AS (


    -- Blue side players

    SELECT BT_Top     AS Player_Name, Blue_Team AS Team_Name FROM Staging_Match_Stats
    UNION ALL
    SELECT BT_Jungle, Blue_Team FROM Staging_Match_Stats
    UNION ALL
    SELECT BT_Mid,    Blue_Team FROM Staging_Match_Stats
    UNION ALL
    SELECT BT_ADC,    Blue_Team FROM Staging_Match_Stats
    UNION ALL
    SELECT BT_Support,Blue_Team FROM Staging_Match_Stats

    UNION ALL


    -- Red side players

    SELECT RT_Top,     Red_Team FROM Staging_Match_Stats
    UNION ALL
    SELECT RT_Jungle,  Red_Team FROM Staging_Match_Stats
    UNION ALL
    SELECT RT_Mid,     Red_Team FROM Staging_Match_Stats
    UNION ALL
    SELECT RT_ADC,     Red_Team FROM Staging_Match_Stats
    UNION ALL
    SELECT RT_Support, Red_Team FROM Staging_Match_Stats

    UNION ALL

    -- Worlds 2024 players

    SELECT Player, Team FROM Staging_Worlds_2024

),
DistinctPlayers AS (


    -- Removing any duplicates, empty names and nulls

    SELECT DISTINCT Player_Name, Team_Name
    FROM PlayerList
    WHERE Player_Name IS NOT NULL
      AND Player_Name <> ''
)


-- Inserting players into DIM_Player with correct Team_ID

INSERT INTO DIM_Player (Player_Name, Team_ID)
SELECT
    dp.Player_Name,
    t.Team_ID
FROM DistinctPlayers dp
JOIN DIM_Team t
    ON dp.Team_Name = t.Team_Name;
GO


-- Shows everything currently stored in DIM_Player for verification

SELECT * FROM DIM_Player;