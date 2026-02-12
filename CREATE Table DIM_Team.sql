--Creating DIM_Team

CREATE TABLE DIM_Team(
	Team_ID INT IDENTITY(1,1) PRIMARY KEY,
	Team_Name VARCHAR(250),
	League_Server VARCHAR(250),
	Team_Country VARCHAR(250),
	Country_Continent VARCHAR(250)
);
INSERT INTO DIM_Team (Team_Name)
SELECT DISTINCT Blue_Team FROM Staging_Match_Stats
UNION
SELECT DISTINCT Team FROM Staging_Player_Stats
UNION
SELECT DISTINCT Team FROM Staging_Worlds_2024

;

SELECT * FROM DIM_Team;

-- Using the DISTINCT values to help with cleaning There were some team names that were spelt wrng and some that had html code in them.
-- Making a new staging table for this as it is faster than trying to update a table with 1000s of rows.
-- Mapping Old and Clean Name

CREATE TABLE Staging_Team_CleanMap (
    Raw_Team_Name   VARCHAR(250) PRIMARY KEY,
    Clean_Team_Name VARCHAR(250)
);
-- Asked Copilot to write the values for this one to save some time. It was using data from a table i made in Excel.
INSERT INTO Staging_Team_CleanMap (Raw_Team_Name, Clean_Team_Name)
VALUES
('100_Thieves','100 Thieves'),
('Against_All_authority','Against All Authority'),
('Ahq_eSports_Club','ahq eSports Club'),
('Albus_NoX_Luna','Albus NoX Luna'),
('Alliance','Alliance'),
('Ascension_Gaming','Ascension Gaming'),
('Azubu_Frost','Azubu Frost'),
('Bangkok_Titans','Bangkok Titans'),
('Beyond_Gaming','Beyond Gaming'),
('BLG','Bilibili Gaming'),
('Chiefs_Esports_Club','Chiefs Esports Club'),
('Cloud9','Cloud9'),
('Clutch_Gaming','Clutch Gaming'),
('Counter_Logic_Gaming','Counter Logic Gaming'),
('Counter_Logic_Gaming_Europe','Counter Logic Gaming Europe'),
('CTBC_Flying_Oyster','CTBC Flying Oyster'),
('Dark_Passage','Dark Passage'),
('DetonatioN_FocusMe','DetonatioN FocusMe'),
('Dignitas','Dignitas'),
('Dire_Wolves','Dire Wolves'),
('DK','DK'),
('DRX','DRX'),
('DWG_KIA','DWG KIA'),
('EDward_Gaming','EDward Gaming'),
('Epik_Gamer','Epik Gamer'),
('Evil_Geniuses_2e-NA','Evil Geniuses NA'),
('Fenerbah_c3-_a7-e_Esports','Fenerbahçe Esports'),
('Flamengo_Esports','Flamengo Esports'),
('Flash_Wolves','Flash Wolves'),
('FLY','FLY'),
('FlyQuest','FlyQuest'),
('Fnatic','Fnatic'),
('FNC','Fnatic'),
('FunPlus_Phoenix','FunPlus Phoenix'),
('G_2d-Rex','G-Rex'),
('G2','G2'),
('G2_Esports','G2 Esports'),
('Galatasaray_Esports','Galatasaray Esports'),
('GAM','GAM Esports'),
('GAM_Esports','GAM Esports'),
('Gamania_Bears','Gamania Bears'),
('Gambit_Esports','Gambit Esports'),
('Gambit_Gaming','Gambit Gaming'),
('GamingGear_2e-eu','GamingGear.eu'),
('GEN','Gen.G'),
('Gen_2e-G','Gen.G'),
('Griffin__28-Korean_Team_29-','Griffin'),
('H2k_2d-Gaming','H2k Gaming'),
('Hanwha_Life_Esports','Hanwha Life Esports'),
('HLE','Hanwha Life Esports'),
('Hong_Kong_Attitude','Hong Kong Attitude'),
('I_May','I May'),
('Immortals','Immortals'),
('INFINITY','Infinity Esports'),
('INTZ','INTZ'),
('Invictus_Gaming','Invictus Gaming'),
('Istanbul_Wildcats','Istanbul Wildcats'),
('Isurus','Isurus'),
('J_Team','J Team'),
('JD_Gaming','JD Gaming'),
('KaBuM_21-_Esports','KaBuM! Esports'),
('Kaos_Latin_Gamers','Kaos Latin Gamers'),
('KT_Rolster','KT Rolster'),
('Kwangdong_Freecs','Kwangdong Freecs'),
('Legacy_Esports','Legacy Esports'),
('Lemondogs','Lemondogs'),
('LGD_Gaming','LGD Gaming'),
('LMQ','LMQ'),
('LNG','LNG Esports'),
('LNG_Esports','LNG Esports'),
('Longzhu_Gaming','Longzhu Gaming'),
('LOUD','LOUD'),
('Lowkey_Esports_2e-Vietnam','Lowkey Esports Vietnam'),
('Lyon_Gaming__28-2013_Latin_American_Team_29-','Lyon Gaming'),
('Machi_Esports','Machi Esports'),
('MAD_Lions','MAD Lions'),
('MAD_Team','MAD Team'),
('MAMMOTH','MAMMOTH'),
('MDK','MDK'),
('MEGA','MEGA'),
('Mineski','Mineski'),
('Misfits_Gaming','Misfits Gaming'),
('Moscow_Five','Moscow Five'),
('Movistar_R7','Movistar R7'),
('NaJin_Black_Sword','NaJin Black Sword'),
('NaJin_White_Shield','NaJin White Shield'),
('Oh_My_God','Oh My God'),
('Origen','Origen'),
('Pacific_eSports','Pacific Esports'),
('PaiN_Gaming','paiN Gaming'),
('Papara_SuperMassive','Papara SuperMassive'),
('PEACE__28-Oceanic_Team_29-','PEACE'),
('Phong_V_c5-_a9-_Buffalo','Phong Vu Buffalo'),
('PNG','PNG Esports'),
('PSG','PSG Esports'),
('PSG_Talon','PSG Talon'),
('Rampage','Rampage'),
('RED_Canids','RED Canids'),
('Rogue__28-European_Team_29-','Rogue'),
('ROX_Tigers','ROX Tigers'),
('Royal_Club','Royal Club'),
('Royal_Never_Give_Up','Royal Never Give Up'),
('Royal_Youth','Royal Youth'),
('Saigon_Buffalo','Saigon Buffalo'),
('Saigon_Jokers','Saigon Jokers'),
('Samsung_Blue','Samsung Blue'),
('Samsung_Galaxy','Samsung Galaxy'),
('Samsung_White','Samsung White'),
('SK_Gaming','SK Gaming'),
('SK_Telecom_T1','SK Telecom T1'),
('Splyce','Splyce'),
('Suning','Suning'),
('T1','T1'),
('Taipei_Assassins','Taipei Assassins'),
('Team_gamed_21-de','Team GamerDE'),
('Team_Liquid','Team Liquid'),
('Team_oNe_eSports','Team oNe Esports'),
('Team_Vitality','Team Vitality'),
('Team_Vulcun','Team Vulcun'),
('Team_WE','Team WE'),
('TES','Top Esports'),
('TL','Team Liquid'),
('Top_Esports','Top Esports'),
('TSM','TSM'),
('Unicorns_of_Love_2e-CIS','Unicorns of Love CIS'),
('V3_Esports','V3 Esports'),
('WBG','Weibo Gaming'),
('Xan','Xan'),
('Young_Generation','Young Generation');

--Using the newly mapped names, to update the other staging tables so that all data is accurate.

UPDATE S
SET S.Team = M.Clean_Team_Name
FROM Staging_Player_Stats S
JOIN Staging_Team_CleanMap M
    ON S.Team = M.Raw_Team_Name;

UPDATE S
SET S.Blue_Team = M.Clean_Team_Name
FROM Staging_Match_Stats S
JOIN Staging_Team_CleanMap M
    ON S.Blue_Team = M.Raw_Team_Name;

UPDATE S
SET S.Red_Team = M.Clean_Team_Name
FROM Staging_Match_Stats S
JOIN Staging_Team_CleanMap M
    ON S.Red_Team = M.Raw_Team_Name;

UPDATE S
SET S.Winner = M.Clean_Team_Name
FROM Staging_Match_Stats S
JOIN Staging_Team_CleanMap M
    ON S.Winner = M.Raw_Team_Name;


UPDATE S
SET S.Team = M.Clean_Team_Name
FROM Staging_Worlds_2024 S
JOIN Staging_Team_CleanMap M
    ON S.Team = M.Raw_Team_Name;

UPDATE S
SET S.Opponent_Team = M.Clean_Team_Name
FROM Staging_Worlds_2024 S
JOIN Staging_Team_CleanMap M
    ON S.Opponent_Team = M.Raw_Team_Name;

-- Removing all data from DIM_Team to then populate it using my new names, as well as other things that I manually tracked.

TRUNCATE TABLE DIM_Team;

INSERT INTO DIM_Team (Team_Name)
SELECT DISTINCT Team FROM Staging_Player_Stats
UNION
SELECT DISTINCT Blue_Team FROM Staging_Match_Stats
UNION
SELECT DISTINCT Team FROM Staging_Worlds_2024;

UPDATE DIM_Team
SET Team_Name_Clean = Team_Name;

-- I asked Copilot to write this bit of code using the table I made in Excel.
-- I wanted to show some variety in teh way i populate my columns to show off my skillset.
WITH TeamMeta AS (
    SELECT *
    FROM (VALUES
        ( '100 Thieves','North America','United States','North America'),
        ( 'Against All Authority','Europe West','France','Europe'),
        ( 'ahq eSports Club','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'Albus NoX Luna','Russia','Russia','Europe'),
        ( 'Alliance','Europe West','Sweden','Europe'),
        ( 'Ascension Gaming','Southeast Asia','Thailand','Asia'),
        ( 'Azubu Frost','Republic of Korea','South Korea','Asia'),
        ( 'Bangkok Titans','Southeast Asia','Thailand','Asia'),
        ( 'Beyond Gaming','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'Bilibili Gaming','Taiwan, Hong Kong, and Macao','China','Asia'),
        ( 'Chiefs Esports Club','Oceania','Australia','Oceania'),
        ( 'Cloud9','North America','United States','North America'),
        ( 'Clutch Gaming','North America','United States','North America'),
        ( 'Counter Logic Gaming','North America','United States','North America'),
        ( 'Counter Logic Gaming Europe','Europe West','United Kingdom','Europe'),
        ( 'CTBC Flying Oyster','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'Dark Passage','Turkey','Turkey','Europe'),
        ( 'DetonatioN FocusMe','Japan','Japan','Asia'),
        ( 'Dignitas','North America','United States','North America'),
        ( 'Dire Wolves','Oceania','Australia','Oceania'),
        ( 'DK','Republic of Korea','South Korea','Asia'),
        ( 'DRX','Republic of Korea','South Korea','Asia'),
        ( 'DWG KIA','Republic of Korea','South Korea','Asia'),
        ( 'EDward Gaming','Taiwan, Hong Kong, and Macao','China','Asia'),
        ( 'Epik Gamer','North America','United States','North America'),
        ( 'Evil Geniuses NA','North America','United States','North America'),
        ( 'Fenerbahçe Esports','Turkey','Turkey','Europe'),
        ( 'Flamengo Esports','Brazil','Brazil','South America'),
        ( 'Flash Wolves','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'FLY','North America','United States','North America'),
        ( 'FlyQuest','North America','United States','North America'),
        ( 'Fnatic','Europe West','United Kingdom','Europe'),
        ( 'FunPlus Phoenix','Taiwan, Hong Kong, and Macao','China','Asia'),
        ( 'G-Rex','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'G2','Europe West','Germany','Europe'),
        ( 'G2 Esports','Europe West','Germany','Europe'),
        ( 'Galatasaray Esports','Turkey','Turkey','Europe'),
        ( 'GAM Esports','Vietnam','Vietnam','Asia'),
        ( 'Gamania Bears','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'Gambit Esports','Russia','Russia','Europe'),
        ( 'Gambit Gaming','Russia','Russia','Europe'),
        ( 'GamingGear.eu','Europe West','Lithuania','Europe'),
        ( 'Gen.G','Republic of Korea','South Korea','Asia'),
        ( 'Griffin','Republic of Korea','South Korea','Asia'),
        ( 'H2k Gaming','Europe West','United Kingdom','Europe'),
        ( 'Hanwha Life Esports','Republic of Korea','South Korea','Asia'),
        ( 'Hong Kong Attitude','Taiwan, Hong Kong, and Macao','Hong Kong','Asia'),
        ( 'I May','China','China','Asia'),
        ( 'Immortals','North America','United States','North America'),
        ( 'Infinity Esports','Latin America South','Costa Rica','North America'),
        ( 'INTZ','Brazil','Brazil','South America'),
        ( 'Invictus Gaming','China','China','Asia'),
        ( 'Istanbul Wildcats','Turkey','Turkey','Europe'),
        ( 'Isurus','Latin America South','Argentina','South America'),
        ( 'J Team','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'JD Gaming','China','China','Asia'),
        ( 'KaBuM! Esports','Brazil','Brazil','South America'),
        ( 'Kaos Latin Gamers','Latin America South','Chile','South America'),
        ( 'KT Rolster','Republic of Korea','South Korea','Asia'),
        ( 'Kwangdong Freecs','Republic of Korea','South Korea','Asia'),
        ( 'Legacy Esports','Oceania','Australia','Oceania'),
        ( 'Lemondogs','Europe West','Sweden','Europe'),
        ( 'LGD Gaming','China','China','Asia'),
        ( 'LMQ','North America','United States','North America'),
        ( 'LNG Esports','China','China','Asia'),
        ( 'Longzhu Gaming','Republic of Korea','South Korea','Asia'),
        ( 'LOUD','Brazil','Brazil','South America'),
        ( 'Lowkey Esports Vietnam','Vietnam','Vietnam','Asia'),
        ( 'Lyon Gaming','Latin America North','Mexico','North America'),
        ( 'Machi Esports','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'MAD Lions','Europe West','Spain','Europe'),
        ( 'MAD Team','Taiwan, Hong Kong, and Macao','Taiwan','Asia'),
        ( 'MAMMOTH','Oceania','Australia','Oceania'),
        ( 'MDK','Turkey','South Korea','Asia'),
        ( 'MEGA','Vietnam','Thailand','Asia'),
        ( 'Mineski','Vietnam','Philippines','Asia'),
        ( 'Misfits Gaming','Taiwan, Hong Kong, and Macao','United Kingdom','Europe'),
        ( 'Moscow Five','Russia','Russia','Europe'),
        ( 'Movistar R7','Russia','Mexico','North America'),
        ( 'NaJin Black Sword','Europe West','South Korea','Asia'),
        ( 'NaJin White Shield','Republic of Korea','South Korea','Asia'),
        ( 'Oh My God','Republic of Korea','China','Asia'),
        ( 'Origen','Republic of Korea','Spain','Europe'),
        ( 'Pacific Esports','Europe West','Taiwan','Asia'),
        ( 'paiN Gaming','Republic of Korea','Brazil','South America'),
        ( 'Papara SuperMassive','Republic of Korea','Turkey','Europe'),
        ( 'PEACE','Taiwan, Hong Kong, and Macao','Australia','Oceania'),
        ( 'Phong Vu Buffalo','Taiwan, Hong Kong, and Macao','Vietnam','Asia'),
        ( 'PNG Esports','North America','Brazil','South America'),
        ( 'PSG Esports','Latin America South','France','Europe'),
        ( 'PSG Talon','Brazil','Hong Kong','Asia'),
        ( 'Rampage','Taiwan, Hong Kong, and Macao','Japan','Asia'),
        ( 'RED Canids','Turkey','Brazil','South America'),
        ( 'Rogue','Latin America South','United States','North America'),
        ( 'ROX Tigers','Taiwan, Hong Kong, and Macao','South Korea','Asia'),
        ( 'Royal Club','Taiwan, Hong Kong, and Macao','China','Asia'),
        ( 'Royal Never Give Up','Brazil','China','Asia'),
        ( 'Royal Youth','Latin America South','Turkey','Europe'),
        ( 'Saigon Buffalo','Republic of Korea','Vietnam','Asia'),
        ( 'Saigon Jokers','Republic of Korea','Vietnam','Asia'),
        ( 'Samsung Blue','Oceania','South Korea','Asia'),
        ( 'Samsung Galaxy','Europe West','South Korea','Asia'),
        ( 'Samsung White','Taiwan, Hong Kong, and Macao','South Korea','Asia'),
        ( 'SK Gaming','North America','Germany','Europe'),
        ( 'SK Telecom T1','Taiwan, Hong Kong, and Macao','South Korea','Asia'),
        ( 'Splyce','Taiwan, Hong Kong, and Macao','United States','North America'),
        ( 'Suning','Republic of Korea','China','Asia'),
        ( 'T1','Brazil','South Korea','Asia'),
        ( 'Taipei Assassins','Vietnam','Taiwan','Asia'),
        ( 'Team GamerDE','Latin America North','Germany','Europe'),
        ( 'Team Liquid','North America','United States','North America'),
        ( 'Team oNe Esports','Europe West','Brazil','South America'),
        ( 'Team Vitality','Taiwan, Hong Kong, and Macao','France','Europe'),
        ( 'Team Vulcun','Oceania','United States','North America'),
        ( 'Team WE','Taiwan, Hong Kong, and Macao','China','Asia'),
        ( 'Top Esports','Taiwan, Hong Kong, and Macao','China','Asia'),
        ( 'TSM','North America','United States','North America'),
        ( 'Unicorns of Love CIS','Russia','Russia','Europe'),
        ( 'V3 Esports','Japan','Japan','Asia'),
        ( 'Weibo Gaming','Taiwan, Hong Kong, and Macao','China','Asia'),
        ( 'Xan','Southeast Asia','Russia','Europe'),
        ( 'Young Generation','Vietnam','Vietnam','Asia')
    ) AS X(CleanName, League_Server, Team_Country, Country_Continent)
)
-- Fills the DIM_Team columns by matching the names in the data.
UPDATE T
SET 
    T.Team_Name_Clean   = M.CleanName,
    T.League_Server     = M.League_Server,
    T.Team_Country      = M.Team_Country,
    T.Country_Continent = M.Country_Continent
FROM DIM_Team T
JOIN TeamMeta M
    ON T.Team_Name = M.CleanName;


SELECT * FROM DIM_Team;