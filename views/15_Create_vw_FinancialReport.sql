USE FinanceAnalyticsPortfolioDB;
GO

CREATE OR ALTER VIEW dbo.vw_FinancialReport
AS

SELECT
    C.CompanyName,
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    P.[Year] * 10 + P.QuarterNumber AS PeriodKey,
    S.ScenarioName,
    FI.IndicatorCode,
    FI.IndicatorName,
    FI.IndicatorSortOrder,
    FD.Amount

FROM dbo.FactFinancialData AS FD

INNER JOIN dbo.DimCompany AS C
    ON FD.CompanyId = C.CompanyId

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimFinancialIndicator AS FI
    ON FD.IndicatorId = FI.IndicatorId;
GO 

/*
SELECT
    PeriodKey,
    [Year],
    [Quarter],
    QuarterNumber,
    ScenarioName,
    IndicatorCode,
    IndicatorName,
    Amount
FROM dbo.vw_FinancialReport
ORDER BY
    [Year],
    QuarterNumber,
    ScenarioName,
    IndicatorCode;
GO    
*/
