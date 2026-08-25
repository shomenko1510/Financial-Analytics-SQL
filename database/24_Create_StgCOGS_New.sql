/*
==========================================================================================================
Project   : Financial Analytics SQL
Script    : 24_Create_StgCOGS_New.sql
Purpose   : Cteate a new StgCOGS table for bulki insert 
Author    : Sergii Khomenko
==========================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.StgCOGS_New
(
    CompanyName NVARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] NVARCHAR(10) NOT NULL,
    ScenarioName NVARCHAR(50) NOT NULL,
    DirectionName NVARCHAR(100) NOT NULL,
    COGSAmount DECIMAL(18,4) NOT NULL 
);
GO

INSERT INTO dbo.StgCOGS_New
(
    CompanyName,
    [Year],
    [Quarter],
    ScenarioName,
    DirectionName,
    COGSamount
)
SELECT
    CompanyName,
    [Year],
    [Quarter],
    ScenarioName,
    DirectionName,
    COGSAmount
FROM dbo.StgCOGS;
GO

SELECT
    ScenarioName,
    COUNT(*) AS CountRows,
    SUM(COGSAmount) AS TotalCOGSAmount
FROM dbo.StgCOGS
GROUP BY ScenarioName;

SELECT
    ScenarioName,
    COUNT(*) AS CountRows,
    SUM(COGSAmount) AS TotalCOGSAmount
FROM dbo.StgCOGS_New
GROUP BY ScenarioName;    

