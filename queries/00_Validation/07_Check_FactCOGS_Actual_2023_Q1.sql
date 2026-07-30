USE FinanceAnalyticsPortfolioDB;
GO

SELECT 
    FC.COGSId,
    C.CompanyName,
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    D.DirectionName,
    FC.COGSAmount
FROM dbo.FactCOGS AS FC
INNER JOIN dbo.DimCompany AS C
    ON FC.CompanyId = C.CompanyId
INNER JOIN dbo.DimPeriod AS P
    ON FC.PeriodId = P.PeriodId
INNER JOIN dbo.DimScenario AS S
    ON FC.ScenarioId = S.ScenarioId
INNER JOIN dbo.DimDirection AS D
    ON FC.DirectionId = D.DirectionId
WHERE C.CompanyName = 'Company A'
    AND P.[Year] = 2023
    AND P.[Quarter] = 'Q1'
    AND S.ScenarioName = 'Actual'
Order By D.DirectionSortOrder;

SELECT
    COUNT(*) AS TotalRows,
    SUM(FC.COGSAmount) AS TotalCOGS
FROM dbo.FactCOGS AS FC
INNER JOIN dbo.DimCompany AS C    
    ON FC.CompanyId = C.CompanyId
INNER JOIN dbo.DimScenario AS S
    ON FC.ScenarioId = S.ScenarioId
INNER JOIN dbo.DimPeriod AS P
    ON FC.PeriodId = P.PeriodId
WHERE C.CompanyName = 'Company A'
    AND P.[Year] = 2023
    AND P.[Quarter] = 'Q1'
    AND S.ScenarioName = 'Actual';    

