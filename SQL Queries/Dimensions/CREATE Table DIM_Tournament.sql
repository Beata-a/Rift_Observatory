-- Creating DIM_Tournament table

CREATE TABLE DIM_Tournament (
    Tournament_ID INT IDENTITY(1,1) PRIMARY KEY,
    Tournament_Name VARCHAR(250),
    Tournament_Year INT,
    Start_Date DATE,
    End_Date DATE
);


-- Populating DIM_Tournament using data from the Staging_Match_Stats

INSERT INTO DIM_Tournament (
    Tournament_Name,
    Tournament_Year,
    Start_Date,
    End_Date
)


-- Returns each tournament season with its name, year, and full match date range


SELECT DISTINCT
    Event AS Tournament_Name,
    Season AS Tournament_Year,
    MIN(Match_Date) OVER (PARTITION BY Event, Season) AS Start_Date,
    MAX(Match_Date) OVER (PARTITION BY Event, Season) AS End_Date
FROM Staging_Match_Stats
WHERE Event IS NOT NULL
ORDER BY Season, Event;


-- Shows everything currently stored in DIM_Tournament

SELECT * FROM DIM_Tournament