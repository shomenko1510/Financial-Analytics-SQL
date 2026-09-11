USE FinanceAnalyticsPortfolioDB;
GO

;WITH QuarterlyData AS
(
    SELECT
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    FI.IndicatorCode,
    FI.IndicatorName,
    FD.Amount AS ActualAmount,

    LAG(FD.Amount) OVER
    (
        PARTITION BY FI.IndicatorCode
        ORDER BY
            P.[Year],
            P.QuarterNumber
    ) AS PreviousQuarterAmount

FROM dbo.factFinancialData AS FD     

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
)

SELECT
    [Year],
    [Quarter],
    IndicatorCode,
    IndicatorName,

    CAST(
        ActualAmount
        AS DECIMAL(18,2)     
    ) AS ActualAmount,

    CAST(
        PreviousQuarterAmount
        AS DECIMAL(18,2)      
    ) AS PreviousQuarterAmount,

    CAST(
        ActualAmount - PreviousQuarterAmount
        AS DECIMAL(18,2)
    ) AS QuarterChange,

    CAST(
        (
            ActualAmount -PreviousQuarterAmount
        )
        /
        NULLIF(PreviousQuarterAmount,0)
        * 100
        AS DECIMAL(18,2)
    ) QuarterChamngePercent
FROM QuarterlyData

ORDER BY
    IndicatorCode,
    [Year],
    QuarterNumber;
GO                    