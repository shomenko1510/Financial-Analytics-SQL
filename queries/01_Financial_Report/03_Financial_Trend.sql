USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    P.[Year],
    P.[Quarter],
    FI.IndicatorCode,
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
    AND FI.IndicatorCode IN
    (
        'REV_EX_VAT',
        'GP',
        'NP',
        'OCF',
        'CASH_CLOSE'
    )

ORDER BY
    P.[Year],
    P.[Quarter],
    FI.IndicatorSortOrder;
GO        

