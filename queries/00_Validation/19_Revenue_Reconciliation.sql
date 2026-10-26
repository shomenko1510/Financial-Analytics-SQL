/*
Purpose:
Reconcile Revenue between factFinancialData
and FactSales by period and scenario.
*/

USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    SUM([RevenueAmount]) AS TotalRevenue
FROM dbo.StgSales
WHERE [Year] = 2024
    AND [Quarter] = 'Q1'
    AND [Scenarioname] = 'Actual';

GO

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    SUM(FS.RevenueAmount) AS ToatalRevenue
FROM dbo.factSales AS FS

INNER JOIN dbo.DimPeriod AS Purpose
    ON FS.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId

WHERE P.[Year] = 2024
    and P.[Quarter] = 'Q1'

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY
    S.ScenarioName;

SELECT
    D.DirectionName,
    FS.Volume,
    FS.Price,
    FS.RevenueAmount
FROM dbo.FactSales AS FS

INNER JOIN dbo.DimPeriod AS P
    ON FS.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimDirection AS D
    ON FS.DirectionId = D.DirectionId

WHERE P.[Year] = 2024
    AND P.[Quarter] = 'Q1'
    AND S.ScenarioName = 'Actual'

ORDER BY
    D.DirectionName;    


SELECT
    SUM(FS.RevenueAmount) AS RevenueBeforeFIX
FROM dbo.FactSales AS FS

INNER JOIN dbo.DimPeriod AS P
    ON FS.PeriodId = P.PeriodId
INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId
WHERE P.[Year] = 2024
    AND p.[Quarter] = 'Q1'
    AND S.ScenarioName = 'Actual';        



