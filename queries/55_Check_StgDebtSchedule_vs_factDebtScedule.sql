USE FinanceAnalyticsPortfolioDB;
GO

SELECT SD.CompanyName,
SD.[Year],
SD.[Quarter],
SD.ScenarioName,
SD.DebtmetricValue,

C.CompanyId,
P.PeriodId,
S.ScenarioId,
M.DebtMetricId

FROM dbo.StgDebtSchedule AS SD

LEFT JOIN dbo.DimCompany AS C
    ON SD.CompanyName = C.CompanyName

LEFT JOIN dbo.DimPeriod AS P
    ON SD.[Year] = P.[Year]
    AND SD.[Quarter] = P.[Quarter]

LEFT JOIN dbo.DimScenario AS S
    ON SD.ScenarioName = S.ScenarioName

LEFT JOIN dbo.DimDebtMetric AS M
    ON SD.DebtMetricName = M.DebtMetricName

WHERE C.CompanyId IS NULL
    OR P.PeriodId IS NULL
    OR S.ScenarioId IS NULL
    OR M.DebtMetricId IS NULL;            

