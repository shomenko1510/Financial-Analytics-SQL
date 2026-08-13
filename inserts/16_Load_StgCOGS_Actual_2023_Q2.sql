/*
============================================================================================
Project   : Financial Analitics SQL
Script    : 16_Load_StgCOGS_Actual_2023_Q2.sql
Purpose   : Load Q2 2023 Actual COGS data into StgCOGS
Author    : Sergii Khomenko
============================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.StgCOGS
(
    CompanyName,
    [Year],
    [Quarter],
    ScenarioName,
    DirectionName,
    COGSAmount
)
VALUES
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line A',  31287.2600),
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line B',  42030.2900),
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line C', 116955.0000),
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line D',      0.0000),
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line E',   8289.2000),
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line F',   6727.8100),
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line G',   1916.6000),
    ('Company A', 2023, 'Q2', 'Actual', 'Business Line H',    536.2000),
    ('Company A', 2023, 'Q2', 'Actual', 'Other',             3588.7000);
GO    

--Validation: Verify inserted data

/*
SELECT *
FROM dbo.StgCOGS
WHERE [Year] = 2023
    AND [Quarter] = 'Q2'
    AND ScenarioName = 'Actual';
*/

SELECT
    COUNT(*) AS TotalRows,
    SUM(COGSAmount) AS TotalCOGS
FROM dbo.StgCOGS
WHERE [Year] = 2023
    AND [Quarter] = 'Q2'
    AND ScenarioName = 'Actual';    
