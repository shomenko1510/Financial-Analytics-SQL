USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    P.[Year],
    P.[Quarter],
    FI.IndicatorName,
    CAST(FD.Amount AS DECIMAL(18,2)) AS ActualAmount

FROM dbo.FactFinancialData AS FD

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimFinancialIndicator AS FI
    ON FD.IndicatorId = FI.IndicatorId

WHERE S.ScenarioName = 'Actual'
    AND FI.IndicatorCode = 'REV_EX_VAT'

ORDER BY
    P.[Year],
    P.QuarterNumber;

SELECT
    P.[Year],
    P.[Quarter],

    CAST(
        FD.Amount
        AS DECIMAL(18,2)
    ) AS ActualAmount,

    CAST(
        LAG(FD.Amount) OVER
        (
            ORDER BY
                P.[Year],
                P.QuarterNumber
        )
        AS DECIMAL(18,2)
    ) AS PreviousQuarterAmount

FROM dbo.FactFinancialData AS FD

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimFinancialIndicator AS FI
    ON FD.IndicatorId = FI.IndicatorId

WHERE S.ScenarioName = 'Actual'
    AND FI.IndicatorCode = 'REV_EX_VAT'
 
ORDER BY
    P.[Year],
    P.QuarterNumber;