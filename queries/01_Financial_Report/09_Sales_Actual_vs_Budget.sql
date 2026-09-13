USE FinanceAnalyticsPortfolioDB;
GO

;WITH SalesData AS
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        D.DirectionName,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FS.RevenueAmount
                ELSE 0
            END    
        ) AS ActualRevenue,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FS.RevenueAmount
                ELSE 0
            END                   
        ) AS BudgetRevenue

FROM dbo.FactSales AS FS

INNER JOIN dbo.DimPeriod AS P
    ON FS.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId     

INNER JOIN dbo.DimDirection AS D
    ON FS.DirectionId = D.DirectionId

GROUP BY
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    D.DirectionName
)

SELECT
    [Year],
    [Quarter],
    Directionname,

    CAST(
        ActualRevenue
        AS DECIMAL(18,2)
    ) AS ActualRevenue,

    CAST(
        BudgetRevenue
        AS DECIMAL(18,2)
    ) AS BUDGETRevenue,

    CAST(
        ActualRevenue - BudgetRevenue
        AS DECIMAL(18,2)
    ) AS Variance,

    CAST(
        (
            ActualRevenue - BudgetRevenue
        )
        /
        NULLIF(BudgetRevenue,0)
        * 100
        AS DECIMAL(18,2)
    ) AS VariancePercent

FROM SalesData

ORDER BY
    [Year],
    QuarterNumber,
    DirectionName;
GO    