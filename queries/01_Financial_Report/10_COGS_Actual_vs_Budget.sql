USE FinanceAnalyticsPortfolioDB;
GO

;WITH COGSdata AS
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        D.DirectionName,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FC.COGSAmount
                ELSE 0
            END    
        ) AS ActualCOGS,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FC.COGSAmount
                ELSE 0
            END
        ) AS BudgetCOGS
FROM dbo.FactCOGS AS FC

INNER JOIN dbo.DimPeriod AS P
    ON FC.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FC.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimDirection AS D
    ON FC.DirectionId = D.DirectionId

GROUP BY
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    D.DirectionName             
)

SELECT
    [Year],
    [Quarter],
    DirectionName,

    CAST(
        ActualCOGS
        AS DECIMAL(18,2)
    ) AS ActualCOGS,

    CAST(
        BudgetCOGS
        AS DECIMAL(18,2)
    ) AS BudgetCOGS,

    CAST(
        ActualCOGS - BudgetCOGS
        AS DECIMAL(18,2)   
    ) AS Variance,

    CAST(
        (
            ActualCOGS - BudgetCOGS
        )
        /
        NULLIF(BudgetCOGS, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS VariancePercent

FROM COGSData

ORDER BY
    [Year],
    QuarterNumber,
    DirectionName;
GO

