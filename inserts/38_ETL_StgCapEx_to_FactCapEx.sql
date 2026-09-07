USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.FactCapEx
(
    CompanyId,
    PeriodId,
    ScenarioId,
    CapExId,
    CapAmount
)
SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    CE.CapExId,
    SC.CapExAmount
FROM dbo.StgCapEx AS SC

INNER JOIN dbo.DimCompany AS C
    ON SC.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SC.[Year] = P.[Year]
    AND SC.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SC.ScenarioName = S.ScenarioName
    
INNER JOIN dbo.DimCapEx AS CE
    ON SC.CapExCategory = CE.CapExCategory
    AND SC.CapExItem = CE.CapExItem

LEFT JOIN dbo.FactCapEx AS FC
    ON FC.CompanyId = C.CompanyId
    AND FC.PeriodId = P.PeriodId
    AND FC.ScenarioId = S.ScenarioId
    AND FC.CapExId = CE.CapExId

WHERE SC.CompanyName = 'Company A'
    AND SC.[Year] BETWEEN 2023 AND 2025
    AND FC.CapExFactId IS NULL;
GO

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(*) AS CountRows,
    SUM(FC.CapAmount) AS TotalCapExAmount
FROM dbo.FactCapEx AS FC

INNER JOIN dbo.DimPeriod AS P
    ON FC.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FC.ScenarioId = S.ScenarioId

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName;        




