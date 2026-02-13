-- Creating DIM_Champion table

CREATE TABLE DIM_Champion (
    Champion_ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(250),
	Title VARCHAR(250),
    Class VARCHAR(250),           
    Resource VARCHAR(250),   
    Range VARCHAR(250),      
    Release_Date DATE,
    Role VARCHAR(250)            
);


-- Populating DIM_Champion using Staging_LOL_Champions_2024

INSERT INTO DIM_Champion (
    Name,
	Title,
    Class,
    Resource,
    Range,
    Release_Date,
    Role
)


-- Returns a distinct list of champions with the defining attributes

SELECT DISTINCT
    Name AS Name,
	Nick_Name as Title,
    Class AS Class,
    Resource AS Resource,
    Range AS Range,
    Release_Date AS Release_Date,
    Role
FROM Staging_LOL_Champions_2024
WHERE Name IS NOT NULL
ORDER BY Release_Date;


-- Shows everything currently stored in DIM_Champion

Select * FROM DIM_Champion