CREATE TABLE DIM_Player(
    Player_ID INT IDENTITY(1,1) PRIMARY KEY,
    Player_Name VARCHAR(250)
);

WITH PlayerList AS (
    SELECT DISTINCT Player_Name
    FROM (
        -- From Staging_Match_Stats
        SELECT BT_Top AS Player_Name FROM Staging_Match_Stats
        UNION ALL
        SELECT BT_Jungle FROM Staging_Match_Stats
        UNION ALL
        SELECT BT_Mid FROM Staging_Match_Stats
        UNION ALL
        SELECT BT_ADC FROM Staging_Match_Stats
        UNION ALL
        SELECT BT_Support FROM Staging_Match_Stats
        UNION ALL
        SELECT RT_Top FROM Staging_Match_Stats
        UNION ALL
        SELECT RT_Jungle FROM Staging_Match_Stats
        UNION ALL
        SELECT RT_Mid FROM Staging_Match_Stats
        UNION ALL
        SELECT RT_ADC FROM Staging_Match_Stats
        UNION ALL
        SELECT RT_Support FROM Staging_Match_Stats

        UNION ALL

        -- From Staging_Worlds_2024
        SELECT Player FROM Staging_Worlds_2024
        UNION ALL
        SELECT Opponent_Player FROM Staging_Worlds_2024
    ) AS AllPlayers
    WHERE Player_Name IS NOT NULL
      AND Player_Name <> ''
)

INSERT INTO DIM_Player (Player_Name)
SELECT Player_Name
FROM PlayerList;

SELECT * FROM DIM_Player;
