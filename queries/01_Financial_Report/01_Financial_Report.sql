USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    c.CompanyName,
    p.[Year],
    p.QuarterNumber,
    s.ScenarioName,
    d.DirectionName,
    i.IndicatorCode,
    i.IndicatorName,
    f.Amount
FROM dbo.FactFinancialData AS f
INNER JOIN dbo.DimCompany AS c
    ON f.CompanyId = c.CompanyId
INNER JOIN dbo.DimPeriod AS p
    ON f.PeriodId = p.PeriodId
INNER JOIN dbo.DimScenario AS s
    ON f.ScenarioId = s.ScenarioId
INNER JOIN dbo.DimDirection AS d
    ON f.DirectionId = d.DirectionId
INNER JOIN dbo.DimFinancialIndicator AS i
    ON f.IndicatorId = i.IndicatorId
ORDER BY
    p.[Year],
    p.QuarterNumber,
    i.IndicatorId;
GO        



