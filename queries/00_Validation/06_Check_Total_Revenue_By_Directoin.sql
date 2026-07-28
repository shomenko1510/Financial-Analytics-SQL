USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    FS.SalesId,
    C.CompanyName,
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    D.DirectionName,
    FS.Volume,
    FS.Price,
    FS.RevenueAmount
FROM dbo.FactSales AS FS
INNER JOIN dbo.DimCompany AS C
    ON FS.CompanyId = C.CompanyId
INNER JOIN dbo.DimPeriod AS P
    ON FS.PeriodId = P.PeriodId
INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId
INNER JOIN dbo.DimDirection AS D    
    ON FS.DirectionId = D.DirectionId
WHERE C.CompanyName = 'Company A'
    AND P.[Year] = 2023
    AND P.[Quarter] = 'Q1'
    AND S.ScenarioName = 'Actual'
ORDER BY D.DirectionId;

SELECT 
    COUNT (*) AS TotalRows,
    SUM(FS.RevenueAmount) AS TotalRevenue
FROM dbo.FactSales AS FS
INNER JOIN dbo.DimCompany AS C
    ON FS.CompanyId = C.CompanyId
INNER JOIN dbo.DimPeriod AS P   
    ON FS.PeriodId = P.PeriodId
INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId
WHERE C.CompanyNAme = 'Company A'
    AND P.[Year] = 2023
    AND P.[Quarter] = 'Q1'
    AND S.ScenarioName = 'Actual';
