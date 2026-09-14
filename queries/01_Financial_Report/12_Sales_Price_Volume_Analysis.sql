USE FinanceAnalyticsPortfolioDB;
GO

;WITH SalesPVData AS 
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
        ActualPrice
        AS DECIMAL(18,2)
    ) AS ActualPrice,

    CAST(
        BudgetPrice
        AS DECIMAL(18,2)
    ) AS BudgetPrice,

    CAST(
        ActualRevenue
        AS DECIMAL(18,2)
    ) AS ActualRevenue,

    CAST(
        BudgetRevenue
        AS DECIMAL(18,2)
    ) AS BudgetRevenue,

    CAST(
        ActualVolume - BudgetVolume
        AS DECIMAL(18,2)
    ) AS VolumeVariance,
    
    CAST(
        ActualPrice - BudgetPrice
        AS DECIMAL(18,2)
    ) AS PriceVariance,

    CAST(
        ActualRevenue - BudgetRevenue
        AS DECIMAL(18,2)
    ) AS RevenueVariance

FROM SalesPVData

ORDER BY
    [Year],
    QuarterNumber,
    DirectionName;
GO    






