USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.FactFinancialData
(
    CompanyId,
    PeriodId,
    ScenarioId,
    IndicatorId,
    Amount
)
SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    FI.IndicatorId,
    SF.Amount
FROM dbo.StgFinancialData AS SF

INNER JOIN dbo.DimCompany AS C
    ON SF.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SF.[Year] = P.[Year]
    AND SF.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SF.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimFinancialIndicator AS FI
    ON SF.IndicatorName = FI.IndicatorName

LEFT JOIN dbo.FactFinancialData AS FD
    ON FD.CompanyId = C.CompanyId
    AND FD.PeriodId = P.PeriodId
    AND FD.ScenarioId = S.ScenarioId
    AND FD.IndicatorId = FI.IndicatorId

WHERE C.CompanyName = 'Company A'
    AND P.[Year] BETWEEN 2023 AND 2026
    AND FD.FinancialDataId IS NULL;

GO

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(*) AS CountRows 
FROM dbo.FactFinancialData AS FD

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY
    P.[Year],
    P.[Quarter];

