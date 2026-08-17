/*
============================================================================================
Project   : Financial Analitics SQL
Script    : 16_Load_StgCOGS_Actual_2023_Q1.sql
Purpose   : Load Q1 2023 Actual COGS data into StgCOGS
Author    : Sergii Khomenko
============================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS
    WHERE CompanyName = 'Company A'
    AND [Year] = 2023
    AND [Quarter] = 'Q1'
    AND ScenarioName = 'Actual'  
)
BEGIN
    RAISERROR
    (
        'StgCOGS Actual data for Company A, Q1 2023 already exists',
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
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line A',  22294.9500),
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line B',  33543.6000),
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line C',  97579.4000),
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line D',      0.0000),
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line E',   6685.1000),
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line F',   4702.4100),
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line G',     13.9000),
    ('Company A', 2023, 'Q1', 'Actual', 'Business Line H',      0.0000),
    ('Company A', 2023, 'Q1', 'Actual', 'Other',             3566.1000);
GO    

--Validation: Verify inserted data

/*
SELECT *
FROM dbo.StgCOGS
WHERE [Year] = 2023
    AND [Quarter] = 'Q1'
    AND ScenarioName = 'Actual';
*/

SELECT
    COUNT(*) AS TotalRows,
    SUM(COGSAmount) AS TotalCOGS
FROM dbo.StgCOGS
WHERE [Year] = 2023
    AND [Quarter] = 'Q1'
    AND ScenarioName = 'Actual';    
