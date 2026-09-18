USE FinanceAnalyticsPortfolioDB;
GO

CREATE OR ALTER VIEW dbo.vw_SalesPriceVolumeAnalysis
AS 

WITH SalesPVData AS 
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.[Year] * 10 + P.QuarterNumber AS PeriodKey,
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
        P.[Year] * 10 + P.QuarterNumber,
        P.QuarterNumber,
        D.DirectionName        
),

SalesVarianceData AS 
(
    SELECT
        [Year],
        [Quarter],
        [Year] * 10 + QuarterNumber AS PeriodKey,
        QuarterNumber,
        DirectionName,
        ActualVolume,
        BudgetVolume,
        ActualPrice,
        BudgetPrice,
        ActualRevenue,
        BudgetRevenue,

        ActualVolume - BudgetVolume
            AS VolumeVariance,

        ActualPrice - BudgetPrice
            AS PriceVariance,

        ActualRevenue - BudgetRevenue
            AS RevenueVariance

    FROM SalesPVData
    )

SELECT
    [Year] * 10 + QuarterNumber AS PeriodKey,
    [Year],
    [Quarter],
    QuarterNumber,
    DirectionName,

    CAST(
        ActualVolume
        AS DECIMAL(18,2)
    ) AS ActualVolume,

    CAST(
        BudgetVolume
        AS DECIMAL(18,2)
    ) AS BudgetVolume,

    CAST(
        VolumeVariance
        AS DECIMAL(18,2)
    ) AS VolumeVariance,

    CAST(
        ActualPrice
        AS DECIMAL(18,2)                
    ) AS ActualPrice,

    CAST(
        BudgetPrice
        AS DECIMAL(18,2)
    ) AS BudgetPrice,

    CAST(
        PriceVariance
        AS DECIMAL(18,2)          
    ) AS PriceVariance,

    CAST(
        ActualRevenue
        AS DECIMAL(18,2)          
    ) AS ActualRevenue,

    CAST(
        BudgetRevenue
        AS DECIMAL(18,2)    
    ) AS BudgetRevenue,

    CAST(
        RevenueVariance
        AS DECIMAL(18,2)
    ) AS RevenueVariance,

    CAST(
        VolumeVariance * BudgetPrice
        AS DECIMAL(18,2)
    ) AS VolumeEffect,
                
    CAST(
        PriceVariance * BudgetPrice
        AS DECIMAL(18,2)
    ) AS PriceEffect,

    CAST(
        RevenueVariance
        -(VolumeVariance * BudgetPrice)
        -(PriceVariance * ActualVolume)
        AS DECIMAL(18,2)
    ) AS ResidualEffect

FROM SalesVariancedata;
GO

/*
SELECT
    PeriodKey,
    [Year],
    [Quarter],
    QuarterNumber,
    DirectionName,
    ActualVolume,
    BudgetVolume,
    ActualPrice,
    BudgetPrice,
    ActualRevenue,
    BudgetRevenue,
    RevenueVariance,
    VolumeEffect,
    PriceEffect,
    ResidualEffect

FROM dbo.vw_SalesPriceVolumeAnalysis
ORDER BY
    [Year],
    QuarterNumber,
    DirectionName;
GO
*/
