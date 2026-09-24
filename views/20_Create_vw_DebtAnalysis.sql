USE FinanceAnalyticsPortfolioDB;
GO

CREATE OR ALTER VIEW dbo.vw_DebtAnalysis
AS

WITH DebtData AS
(
   SELECT
        C. CompanyName,
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        P.[Year] * 10 + P.QuarterNumber AS PeriodKey,

        DM.DebtMetricId,
        DM.DebtMetricName,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FD.DebtMetricValue
                ELSE 0
            END    
        ) AS ActualValue,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FD.DebtMetricValue
                ELSE 0
            END    
        ) AS BudgetValue

    FROM dbo.FactDebtSchedule AS FD

    INNER JOIN dbo.DimCompany AS C
        ON FD.CompanyId = C.CompanyId

    INNER JOIN dbo.DimPeriod AS P
        ON FD.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FD.ScenarioId = S.ScenarioId

    INNER JOIN dbo.DimDebtMetric AS DM
        ON FD.DebtMetricId = DM.DebtMetricId

    GROUP BY
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        P.[Year] * 10 + P.QuarterNumber,
        DM.DebtMetricId,
        DM.DebtMetricName            
)

SELECT
    CompanyName,
    PeriodKey,
    [Year],
    [Quarter],
    QuarterNumber,

    DebtMetricId,
    DebtMetricName,

    CAST(
        ActualValue
        AS DECIMAL(18,2)
    ) AS ActualValue,

    CAST(
        BudgetValue
        AS DECIMAL(18,2)
    ) AS BudgetValue,

    CAST(
        ActualValue - BudgetValue
        AS DECIMAL(18,2)
    ) AS Variance,

    CAST(
        (ActualValue - BudgetValue)
        /
        NULLIF(BudgetValue, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS VariancePercent

FROM Debtdata;
GO

/*
SELECT
    PeriodKey,
    [Year],
    [Quarter],
    DebtMetricName,
    ActualValue,
    BudgetValue,
    Variance,
    VariancePercent
FROM dbo.vw_DebtAnalysis

ORDER BY
    [Year],
    QuarterNumber,
    DebtMetricId;
*/    