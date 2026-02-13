-- Deleting DIM_Tournament table IF it exists

DROP TABLE IF EXISTS DIM_Tournament;


-- Creating DIM_Tournament table

CREATE TABLE DIM_Tournament (
    Tournament_ID INT IDENTITY(1,1) PRIMARY KEY,
    Tournament_Name VARCHAR(250) NOT NULL,
    Tournament_Year INT NOT NULL,
    Start_Date DATE,
    End_Date DATE,
    CONSTRAINT UQ_DIM_Tournament UNIQUE (Tournament_Name, Tournament_Year)
);


-- Populating DIM_Tournament using data from the Staging_Match_Stats

INSERT INTO DIM_Tournament (
    Tournament_Name,
    Tournament_Year,
    Start_Date,
    End_Date
)


-- Returns each tournament season with its name, year, and full match date range

SELECT
    s.Event        AS Tournament_Name,
    s.Season       AS Tournament_Year,
    MIN(s.Match_Date) AS Start_Date,
    MAX(s.Match_Date) AS End_Date
FROM Staging_Match_Stats s
WHERE s.Event IS NOT NULL
GROUP BY
    s.Event,
    s.Season;
GO


-- Shows everything currently stored in DIM_Tournament for verification

SELECT * FROM DIM_Tournament

