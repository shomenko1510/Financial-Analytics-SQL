USE FinanceAnalyticsPortfolioDB;
GO

;WITH SalesData AS
(
    SELECT
        FS.PeriodId,
        FS.DirectionId,
        SUM(FS.RevenueAmount) AS RevenueAmount
    
    FROM dbo.FactSales AS FS

    INNER JOIN dbo.DimScenario AS S
        ON FS.ScenarioId = S.ScenarioId

    WHERE S.ScenarioName = 'Actual'

    GROUP BY
        FS.PeriodId,
        FS.DirectionId    
),

COGSData AS
(
    SELECT
        FC.PeriodId,
        FC.DirectionId,
        SUM(FC.COGSAmount)
    
    FROM dbo.FactCOGS AS FC
    
    INNER JOIN dbo.DimScenario AS S
        ON FC.ScenarioId = S.ScenarioId

    WHERE ScenarioName = 'Actual'

    GROUP BY
        FC.PeriodId,
        FC.DirectionId            
) 

SELECT
    P.[Year],
    P.[Quarter],
    D.DirectionName,

    CAST(
        SD.RevenueAmount
        AS DECIMAL(18,2)
    ) AS Revenue,

    CAST(
        CD.COGSAmount
        AS DECIMAL(18,2)
    ) AS COGS,

    CAST(
        SD.RevenueAmount - CD.COGSAmount
        AS DECIMAL(18,1)
    ) AS GrossProfit,

    CAST(
        (
            SD.RevenueAmount - CD.COGSAmount
        )
        /
        NULLIF(SD.RevenueAmount,0)
        * 100
        AS DECIMAL(18,2)
    ) AS GrossMarginPercent

FROM SalesData AS SD

INNER JOIN COGSData AS CD
    ON SD.PeriodId = CD.PeriodId
    AND SD.DirectionId = CD.DirectionId

INNER JOIN dbo.DimPeriod AS P
    ON SD.PeriodId = P.PeriodId

INNER JOIN dbo.DimDirection AS D
    ON SD.DirectionId = D.DirectionId

ORDER BY
    P.[Year],
    P.QuarterNumber,
    D.DirectionName;
GO