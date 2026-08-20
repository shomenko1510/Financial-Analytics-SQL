USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS
    WHERE CompanyName = 'Company A'
    AND [Year] = 2024
    AND [Quarter] = 'Q2'
    AND ScenarioName = 'Actual'  
        AND [Year] = 2024
        AND [Quarter] = 'Q2'
        AND ScenarioName = 'Actual' 
)
BEGIN
    RAISERROR
    (
        'StgCOGS Actual data for Company A, Q2 2024 already exists',
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
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line A',    38155.2300),
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line B',    35817.6900),
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line C',   113743.4000),
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line D',     1656.3000),
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line E',     6818.8000),
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line F',     6801.2400),
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line G',     4382.6000),
    ('Company A', 2024, 'Q2', 'Actual', 'Business Line H',        0.0000),
    ('Company A', 2024, 'Q2', 'Actual', 'Other',               3649.2000);

GO

SELECT
    COUNT(*) AS TotalRows,
    SUM(COGSAmount) AS TotalCOGSAmount
FROM dbo.StgCOGS 
WHERE [Year] = 2024
AND [Quarter] = 'Q2';    
