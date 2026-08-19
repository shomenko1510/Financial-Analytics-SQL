/*
======================================================================================================================
Project   : Financial Analytics SQL
Script    : 16_Load_StgCOGS_Actual_2024_Q3.sql
Purpose   : Load Actual FactCOGS data for Q3 2024 into StgCOGS table 
Author    : Sergii Khomenko
======================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS
    WHERE CompanyName = 'Company A'
    AND [Year] = 2024
    AND [Quarter] = 'Q3'
    AND ScenarioName = 'Actual'  
)
BEGIN
    RAISERROR
    (
        'StgCOGS Actual data for Company A, Q3 2024 already exists',
        16,
        1
    )
    RETURN;
END;    


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
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line A',    30992.1600),
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line B',    19670.1700),
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line C',   114319.9000),
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line D',      585.6000),
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line E',    11908.4000),
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line F',     3567.1900),
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line G',     6074.3000),
    ('Company A', 2024, 'Q3', 'Actual', 'Business Line H',        0.0000),
    ('Company A', 2024, 'Q3', 'Actual', 'Other',               2761.3000);

GO

SELECT 
    COUNT(*) AS CountRows,
    SUM(COGSAmount)
FROM StgCOGS
WHERE [Year] = 2024
AND [Quarter] = 'Q3';

