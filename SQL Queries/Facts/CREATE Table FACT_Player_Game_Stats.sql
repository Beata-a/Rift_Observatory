-- Deleting FACT_Player_Game_Stats table IF it exists

DROP TABLE IF EXISTS FACT_Player_Game_Stats;


-- Creating FACT_Player_Game_Stats table

CREATE TABLE FACT_Player_Game_Stats(
    Player_Game_Stats_ID INT IDENTITY(1,1) PRIMARY KEY,
    Champion_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    Team_ID INT FOREIGN KEY REFERENCES DIM_Team(Team_ID),
    Match_ID INT FOREIGN KEY REFERENCES FACT_Match(Match_ID),
    Tournament_ID INT FOREIGN KEY REFERENCES DIM_Tournament(Tournament_ID),
    Date_ID INT FOREIGN KEY REFERENCES DIM_Date(Date_ID),
    Position VARCHAR(250),
    Lane VARCHAR(250),
    Role VARCHAR(250),
    Win BIT,
    Kills INT,
    Deaths INT,
    Assists INT,
    CS INT,
    Gold_Earned INT,
    Damage_Dealt INT,
    Damage_Taken INT,
    Vision_Score INT,
    Wards_Placed INT,
    Wards_Destroyed INT,
    Gold_Per_Min FLOAT,
    Damage_Per_Min FLOAT,
    DPM_Percentage FLOAT,
    Gold_Share FLOAT,
    XP_Diff_15 FLOAT,
    Gold_Diff_15 FLOAT,
    CS_Diff_15 FLOAT,
    Kill_Participation FLOAT,
    Healing INT,
    Shielding INT,
    Time_Dead INT
);
GO


-- Populating FACT_Player_Game_Stats using Tournament_Phase

INSERT INTO FACT_Player_Game_Stats (
    Champion_ID,
    Player_ID,
    Team_ID,
    Match_ID,
    Tournament_ID,
    Date_ID,
    Position,
    Lane,
    Role,
    Win,
    Kills,
    Deaths,
    Assists,
    CS,
    Gold_Earned,
    Damage_Dealt,
    Damage_Taken,
    Vision_Score,
    Wards_Placed,
    Wards_Destroyed,
    Gold_Per_Min,
    Damage_Per_Min,
    DPM_Percentage,
    Gold_Share,
    XP_Diff_15,
    Gold_Diff_15,
    CS_Diff_15,
    Kill_Participation,
    Healing,
    Shielding,
    Time_Dead
)
SELECT
    c.Champion_ID,
    p.Player_ID,
    tm.Team_ID,
    fm.Match_ID,
    t.Tournament_ID,
    d.Date_ID,
    s.Role AS Position,
    s.Side AS Lane,
    s.Role,
    CASE WHEN s.Outcome = 'Win' THEN 1 ELSE 0 END,
    s.Kills,
    s.Deaths,
    s.Assists,
    s.CS,
    s.Golds,
    s.Total_damage_to_Champion,
    s.Total_Damage_Taken,
    s.Vision_Score,
    s.Wards_Placed,
    s.Wards_Destroyed,
    s.GPM,
    s.DPM,
    s.DMG,
    s.GOLD,
    s.XPD_15,
    s.GD_15,
    s.CSD_15,
    s.KP,
    s.Total_Heal,
    s.Total_Damage_Shielded_On_Teammates,
    s.Total_Time_Spent_Dead
FROM Staging_Worlds_2024 s
JOIN DIM_Player p ON s.Player = p.Player_Name
JOIN DIM_Champion c ON s.Champion = c.Name
JOIN DIM_Team tm ON s.Team = tm.Team_Name
JOIN DIM_Team otm ON s.Opponent_Team = otm.Team_Name
JOIN DIM_Date d ON s.Match_Date = d.Full_Date
JOIN DIM_Tournament t ON s.Stage = t.Tournament_Name
JOIN FACT_Match fm 
    ON fm.Date_ID = d.Date_ID
    AND fm.Tournament_ID = t.Tournament_ID
    AND (
           (s.Side = 'Blue' AND fm.Blue_Team_ID = tm.Team_ID AND fm.Red_Team_ID = otm.Team_ID)
        OR (s.Side = 'Red'  AND fm.Red_Team_ID = tm.Team_ID AND fm.Blue_Team_ID = otm.Team_ID)
    );
GO


-- Shows everything currently stored in FACT_Player_Game_Stats for verification

SELECT * FROM FACT_Player_Game_Stats;
GO
