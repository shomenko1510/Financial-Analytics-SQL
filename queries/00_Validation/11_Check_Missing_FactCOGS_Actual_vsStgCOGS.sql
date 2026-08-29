USE FinanceAnalyticsPortfolioDB;
GO

SELECT 
    SC.[Year],
    SC.[Quarter],
    SC.DirectionName,
    SC.COGSAmount
FROM dbo.StgCOGS AS SC

INNER JOIN dbo.DimCompany AS C
    ON SC.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SC.[Year] = P.[Year]
    AND SC.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SC.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDirection AS D
    ON SC.DirectionName = D.DirectionName

LEFT JOIN dbo.FactCOGS AS FC
    ON FC.CompanyId = C.CompanyId
    AND FC.PeriodId = P.PeriodId
    AND FC.ScenarioId = S.ScenarioId
    AND FC.DirectionId = D.DirectionId

WHERE SC.ScenarioName = 'Actual'
    AND FC.COGSId iS NULL

ORDER BY
    SC.[Year],
    SC.[Quarter],
    SC.DirectionName;
