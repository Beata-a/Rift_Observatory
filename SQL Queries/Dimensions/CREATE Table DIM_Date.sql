-- Creating DIM_Date table

CREATE TABLE DIM_Date (
    Date_ID INT PRIMARY KEY,
    Full_Date DATE,
    Day INT,
    Month INT,
    Month_Name VARCHAR(250),
    Quarter INT,
    Year INT,
    Day_Of_Week INT,
    Day_Of_Week_Name VARCHAR(250),
    Is_Weekend BIT
);


-- Populating DIM_Date using a generated calendar covering 2010-2030

WITH DateRange AS (
    SELECT CAST('2010-01-01' AS DATE) AS TheDate
    UNION ALL
    SELECT DATEADD(DAY, 1, TheDate)
    FROM DateRange
    WHERE TheDate < '2030-12-31'
)
INSERT INTO DIM_Date (
    Date_ID,
    Full_Date,
    Day,
    Month,
    Month_Name,
    Quarter,
    Year,
    Day_Of_Week,
    Day_Of_Week_Name,
    Is_Weekend
)


-- Returns a full calendar row for each date in the range

SELECT
    CONVERT(INT, FORMAT(TheDate, 'yyyyMMdd')) AS Date_ID,
    TheDate AS Full_Date,
    DAY(TheDate) AS Day,
    MONTH(TheDate) AS Month,
    DATENAME(MONTH, TheDate) AS Month_Name,
    DATEPART(QUARTER, TheDate) AS Quarter,
    YEAR(TheDate) AS Year,
    DATEPART(WEEKDAY, TheDate) AS Day_Of_Week,
    DATENAME(WEEKDAY, TheDate) AS Day_Of_Week_Name,
    CASE WHEN DATENAME(WEEKDAY, TheDate) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END AS Is_Weekend
FROM DateRange
OPTION (MAXRECURSION 0);


-- Shows everything currently stored in DIM_Date

SELECT * FROM DIM_Date