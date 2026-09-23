USE FinanceAnalyticsPortfolioDB;
GO 

CREATE OR ALTER VIEW dbo.vw_CapExAnalysis
AS

WITH CapExData AS
(
    SELECT
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        P.[Year] * 10 + P.QuarterNumber AS PeriodKey, 

        CE.CapExId,
        CE.CapExCategory,
        CE.CapExItem,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FC.CapExAmount
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

    INNER JOIN dbo. DimCompany AS C
        ON FC.CompanyId = C.CompanyId

    INNER JOIN dbo.DimPeriod AS P
        ON FC.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FC.ScenarioId = S.ScenarioId

    INNER JOIN dbo.DimCapEx AS CE
        ON FC.CapExId = CE.CapExId

    GROUP BY
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        P.[Year] * 10 + P.QuarterNumber,
        CE.CapExId,
        CE.CapExCategory,
        CE.CapExItem                
)

SELECT
    CompanyName,
    PeriodKey,
    [Year],
    [Quarter],
    QuarterNumber,

    CapExId,
    CapExCategory,
    CapExItem,

    CAST(
        ActualCapEx
        AS DECIMAL(18,2)
    ) AS ActualCapEx,

    CAST(
        BudgetCapEx
        AS DECIMAL(18,2)
    ) AS BudgetCapEx,

    CAST(
        ActualCapEx - BudgetCapEx
        AS DECIMAL(18,2)
    ) AS CapExVariance,

    CAST(
        (ActualCapEx - BudgetcapEx)
        /
        NULLIF(BudgetCapEx,0)
        *
        100
        AS DECIMAL(18,1)
    ) AS CapExVariancePercent

FROM CapExData;
GO


/*
SELECT
    PeriodKey,
    [Year],
    [Quarter],
    CapExCategory,
    CapExItem,
    ActualCapEx,
    BudgetCapEx,
    CapExVariance,
    CapExVariancePercent
FROM dbo.vw_CapExAnalysis

ORDER BY
    [Year],
    CapExCategory,
    CapExItem;
*/