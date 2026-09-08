USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.FactDebtSchedule
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DebtMetricId,
    DebtMetricValue
)
SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    M.DebtMetricId,
    SD.DebtMatricValue
FROM dbo.StgDebtSchedule AS SD

INNER JOIN dbo.DimCompany AS C
    ON SD.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P    
    ON SD.[Year] = P.[Year]
    AND SD.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SD.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDebtMetric AS M
    ON SD.DebtMetricName = M.DebtMetricName

LEFT JOIN dbo.FactDebtSchedule AS FD
    ON FD.CompanyId = C.CompanyId
    AND FD.PeriodId = P.PeriodId
    AND FD.ScenarioId = S.ScenarioId
    AND FD.DebtMetricId = M.DebtMetricId
    
WHERE C.CompanyName = 'Company A'
   AND P.[Year] BETWEEN 2023 AND 2025
   AND FD.DebtFactId IS NULL;
GO

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(*) AS CountRows
FROM dbo.FactDebtSchedule AS FD

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S. ScenarioId

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName;           
