USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    P.[Year],
    P.[Quarter],
    FI.IndicatorName,
    FD.Amount,

    CAST
        (
            LAG(FD.Amount) OVER
        (
                ORDER BY
                    P.[Year],
                    P.QuarterNumber
        ) AS DECIMAL(18,2)
        ) AS PreviousQuarterAmount

FROM dbo.FactFinancialData AS FD

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimFinancialIndicator AS FI
    ON FD.IndicatorId = FI.IndicatorId

WHERE IndicatorName = 'Revenue (excl. VAT)'

ORDER BY
    P.[Year],
    P.QuarterNumber;    


