USE FinanceAnalyticsPortfolioDB;
GO

;WITH WorkingCapitalData AS
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        WC.WorkingCapitalCategory,
        WC.WorkingCapitalItem,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FW.WorkingCapitalAmount
                ELSE 0
            END    
        ) AS ActualAmount,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FW.WorkingCapitalAmount
                ELSE 0
            END    
        ) AS BudgetAmount

FROM dbo.FactWorkingCapital AS FW

INNER JOIN dbo.DimPeriod AS P
    ON FW.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S    
    ON FW.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimWorkingCapital AS WC
    ON FW.WorkingCapitalId = WC.WorkingCapitalId

GROUP BY
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    WC.WorkingCapitalCategory,
    WC.WorkingCapitalItem
)

SELECT
    [Year],
    [Quarter],
    WorkingCapitalCategory,
    WorkingCapitalItem,

    CAST(
        ActualAmount
        AS DECIMAL(18,2)
    ) AS ActualAmount,

    CAST(
        BudgetAmount
        AS DECIMAL(18,2)
    ) AS BudgetAmount,

    CAST(
        ActualAmount - BudgetAmount
        AS  DECIMAL(18,2)
    ) AS Variance,

    CAST(
        (
            ActualAmount -BudgetAmount
        )
        /
        NULLIF(BudgetAmount,0)
        * 100
        AS DECIMAL(18,2)
    ) AS VariancePercent
   
FROM WorkingCapitalData

ORDER BY
    [Year],
    QuarterNumber,
    WorkingCapitalCategory,
    WorkingCapitalItem;