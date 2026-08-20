USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS
    WHERE CompanyName = 'Company A'
    AND [Year] = 2024
    AND [Quarter] = 'Q1'
    AND ScenarioName = 'Actual'  
        AND [Year] = 2024
        AND [Quarter] = 'Q1'
        AND [ScenarioName] = 'Actual'
)
BEGIN
    RAISERROR
    (
        'StgCOGS Actual data for Company A, Q1 2024 already exists',
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
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line A',   44262.6400),
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line B',   21718.8500),
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line C',  101250.4000),
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line D',       0.0000),
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line E',   11827.8000),
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line F',    5087.2900),
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line G',    4127.2000),
    ('Company A', 2024, 'Q1', 'Actual', 'Business Line H',       0.0000),
    ('Company A', 2024, 'Q1', 'Actual', 'Other',              3424.4000);

GO

SELECT 
    COUNT(*) AS TotalRows,
    SUM(COGSAmount) AS TotalCOGSAmount
FROM dbo.StgCOGS
WHERE [Year] = 2024
    AND [Quarter] = 'Q1';     