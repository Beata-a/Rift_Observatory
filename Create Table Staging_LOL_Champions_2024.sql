CREATE TABLE Staging_LOL_Champions_2024(
	Name VARCHAR(250),
	Nick_Name VARCHAR(250),
	Class VARCHAR(250),
	Release_Date DATE,
	Last_Changed VARCHAR(250),
	Blue_Essence INT,
	RP INT,
	Difficulty VARCHAR(250),
	Role VARCHAR(250),
	Range VARCHAR(250),
	Resource VARCHAR(250),
	Base_HP INT,
	Base_Mana INT
);
INSERT INTO Staging_LOL_Champions_2024	
SELECT
	Name,
	Nick_Name,
	Classes,
	Release_Date,
	Last_Changed,
	Blue_Essence,
	RP,
	Difficulty,
	Role,
	Range_type,
	Resourse_type,
	Base_HP,
	Base_mana
FROM [LoL_Champions 2024]
