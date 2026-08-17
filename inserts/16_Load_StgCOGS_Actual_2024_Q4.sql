/*
======================================================================================================================
Project   : Financial Analytics SQL
Script    : 16_Load_StgCOGS_Actual_2024_Q4.sql
Purpose   : Load Actual FactCOGS data for Q4 2024 into StgCOGS table 
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
    AND [Quarter] = 'Q4'
    AND ScenarioName = 'Actual'  
)
BEGIN
    RAISERROR
    (
        'StgCOGS Actual data for Company A, Q4 2024 already exists',
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
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line A',    12846.7200),
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line B',    16472.2800),
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line C',    67022.6000),
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line D',     1405.4000),
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line E',     6384.6000),
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line F',     3976.8300),
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line G',     3004.0000),
    ('Company A', 2024, 'Q4', 'Actual', 'Business Line H',        0.0000),
    ('Company A', 2024, 'Q4', 'Actual', 'Other',                917.8000);

GO

SELECT 
    COUNT(*) AS CountRows,
    SUM(COGSAmount)
FROM StgCOGS
WHERE [Year] = 2024
AND [Quarter] = 'Q4';
