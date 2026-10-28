USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    SUM(FS.RevenueAmount) AS TotalRevenue
FROM dbo.FactSales AS FS

INNER JOIN dbo.DimPeriod AS P
    ON FS.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId

WHERE S.ScenarioName = 'Actual'
    AND P.[Year] BETWEEN 2023 AND 2025

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY
    P.[Year],
    P.[Quarter];

