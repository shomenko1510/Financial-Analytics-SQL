USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    D.DirectionId,
    SS.Volume,
    SS.Price,
    SS.RevenueAmount
FROM dbo.StgSales AS SS

INNER JOIN dbo.DimCompany AS C
    ON SS.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SS.[Year] = P.[Year]
    AND SS.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SS.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDirection AS D
    ON SS.DirectionName = D.DirectionName

WHERE SS.CompanyName = 'Company A'
    AND SS.ScenarioName = 'Budget'
    AND SS.[Year] BETWEEN 2023 AND 2025;

INSERT INTO dbo.FactSales
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    Volume,
    Price,
    RevenueAmount
)
SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    D.DirectionId,
    SS.Volume,
    SS.Price,
    SS.RevenueAmount
FROM dbo.StgSales AS SS

INNER JOIN dbo.DimCompany AS C
    ON SS.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SS.[Year] = P.[Year]
    AND SS.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SS.         