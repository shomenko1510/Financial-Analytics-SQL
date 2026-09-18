USE FinanceAnalyticsPortfolioDB;
GO
CREATE OR ALTER VIEW dbo.vw_GrossProfitAnalysis
AS

WITH SalesData AS
(
    SELECT
        FS.PeriodId,
        FS.DirectionId,

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
    FROM dbo.factsales AS FS

    INNER JOIN dbo.DimScenario AS S
        ON FS.ScenarioId = S.ScenarioId

    GROUP BY
        FS.PeriodId,
        FS.DirectionId        
),

COGSData AS
(
    SELECT
        FC.PeriodId,
        FC.DirectionId,

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

    INNER JOIN dbo.DimScenario AS S
        ON FC.ScenarioId = S.ScenarioId

    GROUP BY
        FC.PeriodId,
        FC.DirectionId    
),

GrossProfitData AS
(
    SELECT 
        SD.PeriodId,
        SD.DirectionId,

        SD.ActualRevenue,
        SD.BudgetRevenue,

        CD.ActualCOGS,
        CD.BudgetCOGS,

        SD.ActualRevenue - CD.ActualCOGS
            AS ActualGrossProfit,
        
        SD.BudgetRevenue - CD.BudgetCOGS
            AS BudgetGrossProfit

    FROM SalesData AS SD

    INNER JOIN COGSData AS CD
        ON SD.PeriodId = CD.PeriodId
        AND SD.DirectionId = CD.DirectionId
)

SELECT
    P.[Year] * 10 + P.QuarterNumber AS PeriodKey,
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    D.DirectionName,

    CAST(
        GPD.ActualRevenue
        AS DECIMAL(18,2)
    ) AS ActualRevenue,

    CAST(
        GPD.BudgetRevenue
        AS DECIMAL(18,2)
    ) AS BudgetRevenue,

    CAST(
        GPD.ActualRevenue - GPD.BudgetRevenue
        AS DECIMAL(18,2)
    ) AS RevenueVariance,

    CAST(
        GPD.ActualCOGS
        AS DECIMAL(18,2)
    ) AS ActualCOGS,

    CAST(
        GPD.BudgetCOGS
        AS DECIMAL(18,2)
    ) AS BudgetCOGS,

    CAST(
        GPD.ActualCOGS - GPD.BudgetCOGS
        AS DECIMAL(18,2)
    ) AS COGSVariance,

    CAST(
        GPD.ActualGrossProfit
        AS DECIMAL(18,2)
    ) AS ActualGrossPrifit,

    CAST(
        GPD.BudgetGrossProfit
        AS DECIMAL(18,2)
    ) AS BudgetGrossProfit,

    CAST(
        GPD.ActualGrossProfit - GPD.BudgetGrossProfit
        AS DECIMAL(18,2)
    ) AS GrossProfitVariance,

    CAST(
        GPD.ActualGrossProfit
        /
        NULLIF(GPD.ActualRevenue, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS ActualGrossMarginPercent,

    CAST(
        GPD.BudgetGrossProfit
        /
        NULLIF(GPD.BudgetRevenue, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS BudgetGrossMarginPercent,

    CAST(
        (
            GPD.ActualGrossProfit
            /
            NULLIF(GPD.ActualRevenue, 0)
            * 100
        )
        -
        (
            GPD.BudgetGrossProfit
            /
            NULLIF(GPD.BudgetRevenue, 0)
            * 100
        )
        AS DECIMAL(18,2)
    ) AS GrossMarginVariancePP

FROM GrossProfitData AS GPD

INNER JOIN dbo.DimPeriod AS P
    ON GPD.PeriodId = P.PeriodId

INNER JOIN dbo.DimDirection AS D
    ON GPD.DirectionId = D.DirectionId;

GO        
/*
SELECT
    PeriodKey,
    [Year],
    [Quarter]
    QuarterNumber,
    DirectionName,
    ActualRevenue,
    BudgetRevenue,
    ActualCOGS,
    BudgetCOGS,
    ActualGrossPrifit,
    BudgetGrossProfit,
    ActualGrossMarginPercent,
    BudgetGrossMarginPercent,
    GrossMarginVariancePP
FROM dbo.vw_GrossProfitAnalysis
ORDER BY
    [Year],
    QuarterNumber,
    DirectionName;
GO    
*/