USE FinanceAnalyticsPortfolioDB;
GO

CREATE OR ALTER VIEW dbo.vw_SalesPriceAnalysis
AS 

WITH SalesPVData AS 
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        D.DirectionName,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FS.Volume
                ELSE 0
            END    
        ) AS ActualVolume,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FS.Volume
                ELSE 0
            END
        ) AS BudgetVolume,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FS.Price
                ELSE 0
            END    
        ) AS ActualPrice,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FS.Price
                ELSE 0
            END    
        ) AS BudgetPrice,

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
    FROM dbp.FactSales AS FS

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
),

SalesVarianceData AS 
(
    SELECT
        [Year],
        [Quarter],
        QuarterNumber,
        DirectionName,

        ActualVolume,
        BudgetVolume,
        ActualPrice,
        ActualRevenue,
        BudgetRevenue,

        ActualVolume - BudgetVolume
            AS VolumeVariance,

        ACTUALPrice - BudgetPrice
            AS PriceVariance,

        ActualRevenue - BudgetRevenue
            AS RevenueVariance

    FROM SalesPVData
    )

    SELECT
        [Year],
        [Quarter],
        QuarterNumber,
        DirectionName,

        CAST(
            ActualVolume
            AS DECIMAL(18,2)
        ) AS ActualVolume,