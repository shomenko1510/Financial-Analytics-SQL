/*
=======================================================================================================================
Project    : Financial Analitics SQL
Script     : 16_Load_StgCOGS_Actual_2023_Q4.sql
Purpose    : Load Actual FactCOGS data for Q4 2023 into StgCOGS table
Author     : Sergii Khomenko
======================================================================================================================
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
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line A',  14226.8400),
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line B',  10781.3500),
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line C', 101391.3000),
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line D',      0.0000),
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line E',   8995.7000),
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line F',   5226.7200),
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line G',   1356.5000),
    ('Company A', 2023, 'Q4', 'Actual', 'Business Line H',      0.0000),
    ('Company A', 2023, 'Q4', 'Actual', 'Other',             2360.7000);
GO 

SELECT
    SUM(COGSAmount) AS TotalCOGSAmount,
    COUNT(*)
FROM dbo.StgCOGS
WHERE ScenarioName = 'Actual'
    AND [Year] = 2023
    AND [Quarter] = 'Q4';    


