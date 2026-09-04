USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    WC.WorkingCapitalId,
    SWS.WorkingCapitalAmount,

    SWS.CompanyName,
    SWS.[Year],
    SWS.[Quarter],
    SWS.ScenarioName,
    SWS.WorkingCapitalCategory,
    SWS.WorkingCapitalItem

FROM dbo.StgWorkingCapital AS SWS

INNER JOIN dbo.DimCompany AS C
    ON SWS.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SWS.[Year] = P.[Year]
    AND SWS.[Quarter] = P.[Quarter]

INNER JOIN  dbo.DimScenario AS S
    ON SWS.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimWorkingCapital AS WC
    ON SWS.WorkingCapitalCategory = WC.WorkingCapitalCategory
    AND SWS.WorkingCapitalItem = WC.WorkingCapitalItem

WHERE SWS.CompanyName = 'Company A'
AND SWS.[Year] BETWEEN 2023 AND 2025

ORDER BY
    SWS.ScenarioName,
    SWS.[Year],
    SWS.[Quarter],
    SWS.WorkingCapitalCategory,
    SWS.WorkingCapitalItem;