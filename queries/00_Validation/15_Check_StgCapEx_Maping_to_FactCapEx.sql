USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    CE.CapExId,
    SC.CapExAmount,

    SC.CompanyName,
    SC.[Year],
    SC.[Quarter],
    SC.ScenarioName,
    SC.CapExCategory,
    SC.CapExItem

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

WHERE SC.CompanyName = 'Company A'
    AND SC.[Year] BETWEEN 2023 AND 2025

ORDER BY
    SC.ScenarioName,
    SC.[Year],
    SC.[Quarter],
    SC.CapExCategory,
    SC.CapExItem;    


