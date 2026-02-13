--Creating FACT_Match table

CREATE TABLE FACT_Match (
    Match_ID INT IDENTITY(1,1) PRIMARY KEY,
    Date_ID INT NOT NULL FOREIGN KEY REFERENCES DIM_Date(Date_ID),
    Tournament_ID INT NOT NULL FOREIGN KEY REFERENCES DIM_Tournament(Tournament_ID),
    Blue_Team_ID INT NOT NULL FOREIGN KEY REFERENCES DIM_Team(Team_ID),
    Red_Team_ID INT NOT NULL FOREIGN KEY REFERENCES DIM_Team(Team_ID),
    Winner_Team_ID INT NOT NULL FOREIGN KEY REFERENCES DIM_Team(Team_ID),
    Season INT,
    Patch FLOAT,
    BT_Ban_1_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Ban_2_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Ban_3_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Ban_4_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Ban_5_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Ban_1_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Ban_2_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Ban_3_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Ban_4_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Ban_5_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Pick_1_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Pick_2_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Pick_3_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Pick_4_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Pick_5_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Pick_1_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Pick_2_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Pick_3_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Pick_4_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    RT_Pick_5_ID INT FOREIGN KEY REFERENCES DIM_Champion(Champion_ID),
    BT_Top_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    BT_Jungle_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    BT_Mid_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    BT_ADC_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    BT_Support_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    RT_Top_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    RT_Jungle_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    RT_Mid_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    RT_ADC_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID),
    RT_Support_Player_ID INT FOREIGN KEY REFERENCES DIM_Player(Player_ID)
);


-- Populating FACT_Match using fully resolved match, team, player, and champion data

INSERT INTO FACT_Match (
    Date_ID,
    Tournament_ID,
    Blue_Team_ID,
    Red_Team_ID,
    Winner_Team_ID,
    Season,
    Patch,
    BT_Ban_1_ID, 
	BT_Ban_2_ID, 
	BT_Ban_3_ID, 
	BT_Ban_4_ID, 
	BT_Ban_5_ID,
    RT_Ban_1_ID, 
	RT_Ban_2_ID, 
	RT_Ban_3_ID, 
	RT_Ban_4_ID, 
	RT_Ban_5_ID,
    BT_Pick_1_ID, 
	BT_Pick_2_ID, 
	BT_Pick_3_ID, 
	BT_Pick_4_ID, 
	BT_Pick_5_ID,
    RT_Pick_1_ID, 
	RT_Pick_2_ID, 
	RT_Pick_3_ID, 
	RT_Pick_4_ID, 
	RT_Pick_5_ID,
    BT_Top_Player_ID, 
	BT_Jungle_Player_ID, 
	BT_Mid_Player_ID, 
	BT_ADC_Player_ID, 
	BT_Support_Player_ID,
    RT_Top_Player_ID, 
	RT_Jungle_Player_ID, 
	RT_Mid_Player_ID, 
	RT_ADC_Player_ID, 
	RT_Support_Player_ID

)


-- Returns each match with its date, teams, bans, picks, and player assignments mapped to dimension IDs

SELECT
    d.Date_ID,
    t.Tournament_ID,
    bt.Team_ID,
    rt.Team_ID,
    wt.Team_ID,
    s.Season,
    s.Patch,
    cBTB1.Champion_ID, 
	BTB2.Champion_ID, 
	cBTB3.Champion_ID, 
	cBTB4.Champion_ID, 
	cBTB5.Champion_ID,
    cRTB1.Champion_ID, 
	cRTB2.Champion_ID, 
	cRTB3.Champion_ID, 
	cRTB4.Champion_ID, 
	cRTB5.Champion_ID,
    cBTP1.Champion_ID, 
	cBTP2.Champion_ID, 
	cBTP3.Champion_ID, 
	cBTP4.Champion_ID, 
	cBTP5.Champion_ID,
    cRTP1.Champion_ID, 
	cRTP2.Champion_ID, 
	cRTP3.Champion_ID, 
	cRTP4.Champion_ID, 
	cRTP5.Champion_ID,
    pBTTop.Player_ID, 
	pBTJungle.Player_ID, 
	pBTMid.Player_ID, 
	pBTADC.Player_ID, 
	pBTSupport.Player_ID,
    pRTTop.Player_ID, 
	pRTJungle.Player_ID, 
	pRTMid.Player_ID, 
	pRTADC.Player_ID, 
	pRTSupport.Player_ID

FROM Staging_Match_Stats s

JOIN DIM_Date d ON s.Match_Date = d.Full_Date
JOIN DIM_Tournament t ON s.Event = t.Tournament_Name
JOIN DIM_Team bt ON s.Blue_Team = bt.Team_Name
JOIN DIM_Team rt ON s.Red_Team = rt.Team_Name
JOIN DIM_Team wt ON s.Winner = wt.Team_Name
JOIN DIM_Champion cBTB1 ON s.BT_Ban_1 = cBTB1.Name
JOIN DIM_Champion cBTB2 ON s.BT_Ban_2 = cBTB2.Name
JOIN DIM_Champion cBTB3 ON s.BT_Ban_3 = cBTB3.Name
JOIN DIM_Champion cBTB4 ON s.BT_Ban_4 = cBTB4.Name
JOIN DIM_Champion cBTB5 ON s.BT_Ban_5 = cBTB5.Name
JOIN DIM_Champion cRTB1 ON s.RT_Ban_1 = cRTB1.Name
JOIN DIM_Champion cRTB2 ON s.RT_Ban_2 = cRTB2.Name
JOIN DIM_Champion cRTB3 ON s.RT_Ban_3 = cRTB3.Name
JOIN DIM_Champion cRTB4 ON s.RT_Ban_4 = cRTB4.Name
JOIN DIM_Champion cRTB5 ON s.RT_Ban_5 = cRTB5.Name
JOIN DIM_Champion cBTP1 ON s.BT_Pick_1 = cBTP1.Name
JOIN DIM_Champion cBTP2 ON s.BT_Pick_2 = cBTP2.Name
JOIN DIM_Champion cBTP3 ON s.BT_Pick_3 = cBTP3.Name
JOIN DIM_Champion cBTP4 ON s.BT_Pick_4 = cBTP4.Name
JOIN DIM_Champion cBTP5 ON s.BT_Pick_5 = cBTP5.Name
JOIN DIM_Champion cRTP1 ON s.RT_Pick_1 = cRTP1.Name
JOIN DIM_Champion cRTP2 ON s.RT_Pick_2 = cRTP2.Name
JOIN DIM_Champion cRTP3 ON s.RT_Pick_3 = cRTP3.Name
JOIN DIM_Champion cRTP4 ON s.RT_Pick_4 = cRTP4.Name
JOIN DIM_Champion cRTP5 ON s.RT_Pick_5 = cRTP5.Name
JOIN DIM_Player pBTTop ON s.BT_Top = pBTTop.Player_Name
JOIN DIM_Player pBTJungle ON s.BT_Jungle = pBTJungle.Player_Name
JOIN DIM_Player pBTMid ON s.BT_Mid = pBTMid.Player_Name
JOIN DIM_Player pBTADC ON s.BT_ADC = pBTADC.Player_Name
JOIN DIM_Player pBTSupport ON s.BT_Support = pBTSupport.Player_Name
JOIN DIM_Player pRTTop ON s.RT_Top = pRTTop.Player_Name
JOIN DIM_Player pRTJungle ON s.RT_Jungle = pRTJungle.Player_Name
JOIN DIM_Player pRTMid ON s.RT_Mid = pRTMid.Player_Name
JOIN DIM_Player pRTADC ON s.RT_ADC = pRTADC.Player_Name
JOIN DIM_Player pRTSupport ON s.RT_Support = pRTSupport.Player_Name;


-- Shows everything currently stored in FACT_Match

 SELECT * FROM FACT_Match