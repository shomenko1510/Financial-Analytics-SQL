USE FinanceAnalyticsPortfolioDB;
GO

;WITH CapExData AS 
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        C.CapExCategory,
        C.CapExItem,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN  FC.CapExAmount
                ELSE 0
            END    
        ) AS ActualCapEx,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FC.CapExAmount
                ELSE 0
            END    
        ) AS BudgetCapEx

    FROM dbo.FactCapEx AS FC

    INNER JOIN dbo.DimPeriod AS P
        ON FC.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FC.ScenarioId = S.ScenarioId

    INNER JOIN dbo.DimCapEx AS C
        ON FC.CapExId = C.CapExId

    GROUP BY
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        C.CapExCategory,
        C.CapExItem                
)

SELECT
    [Year],
    [Quarter],
    CapExCategory,
    CapExItem,

    CAST(
        ActualCapEx
        AS DECIMAL(18,2)
    ) AS ActualCapEx,

    CAST(
        BudgetCapEx
        AS DECIMAL(18,2)
    ) AS BudgetCapex,
    
    CAST(
        ActualCapEx - BudgetCapEx
        AS DECIMAL(18,2)
    ) AS Variance,

    CAST(
        (
            ActualCapEx - BudgetCapEx
        )
        /
        NULLIF(BudgetCapEx, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS VariancePercent

FROM CapExData    

ORDER BY
    [Year],
    QuarterNumber,
    CapExCategory,
    CapExItem;
GO    