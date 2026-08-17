/*
=======================================================================================================================
Project    : Financial Analitics SQL
Script     : 16_Load_StgCOGS_Actual_2023_Q3.sql
Purpose    : Load Actual COGS data for Q3 2023 into StgCOGS
Author     : Sergii Khomenko
=======================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS
    WHERE CompanyName = 'Company A'
    AND [Year] = 2023
    AND [Quarter] = 'Q3'
    AND ScenarioName = 'Actual'  
)
BEGIN
    RAISERROR
    (
        'StgCOGS Actual data for Company A, Q3 2023 already exists',
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
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line A', 28022.4400),
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line B', 25592.7800),
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line C', 83908.1000),
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line D',     0.0000),
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line E', 11562.2000),
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line F',  6160.1000),
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line G',  2718.3000),
    ('Company A', 2023, 'Q3', 'Actual', 'Business Line H',     0.0000),
    ('Company A', 2023, 'Q3', 'Actual', 'Other',            2380.8000);

GO

--Validation: Verify inserted data

SELECT
    SUM(COGSAmount) AS TotalCOGS,
    COUNT(*)
FROM dbo.StgCOGS    
WHERE ScenarioName = 'Actual'
    AND [Year] = 2023
    AND [Quarter] = 'Q3';
