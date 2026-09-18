USE FinanceAnalyticsPortfolioDB;
GO

CREATE OR ALTER VIEW dbo.vw_ActualVsBudget
AS 

WITH ActualBudgetData AS
(
    SELECT
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        P.[Year] * 10 + P.QuarterNumber AS PeriodKey,
        FI.IndicatorCode,
        FI.IndicatorName,
        FI.IndicatorSortOrder,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FD.Amount
                ELSE 0
            END    
        ) AS ActualAmount,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FD.Amount
                ELSE 0
            END    
        ) AS BudgetAmount

        FROM dbo.FactFinancialData AS FD

        INNER JOIN dbo.DimCompany AS C
            ON FD.CompanyId = C.CompanyId

        INNER JOIN dbo.DimPeriod AS P
            ON FD.PeriodId = P.PeriodId    

        INNER JOIN dbo.DimScenario AS S
            ON FD.ScenarioId = S.ScenarioId

        INNER JOIN dbo.DimFinancialIndicator AS FI
            ON FD.IndicatorId = FI.IndicatorId

        GROUP BY
            C.CompanyName,
            P.[Year],
            P.[Quarter],
            P.[Year] * 10 + P.QuarterNumber,
            P.QuarterNumber,
            FI.IndicatorCode,
            FI.IndicatorName,
            FI.IndicatorSortOrder        
)

SELECT
    CompanyName,
    [Year],
    [Quarter],
    PeriodKey,
    QuarterNumber,
    IndicatorCode,
    IndicatorName,
    IndicatorSortOrder,

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
        AS DECIMAL(18,2)
    ) AS Variance,

    CAST(
        (
            ActualAmount - BudgetAmount
        )
        /
        NULLIF(BudgetAmount, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS VariancePercent

FROM ActualBudgetData;
GO

/*
SELECT
    PeriodKey,
    [Year],
    QuarterNumber,
    IndicatorCode,
    IndicatorName,
    ActualAmount,
    BudgetAmount,
    Variance,
    VariancePercent
FROM dbo.vw_ActualVsBudget
ORDER BY
    [Year],
    QuarterNumber,
    IndicatorSortOrder;
GO    
*/