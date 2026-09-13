USE FinanceAnalyticsPortfolioDB;
GO

;WITH OPEXTrend AS 
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        O.OPEXCategoryName,
        O.OPEXSubcategoryName,

        FO.OPEXAmount AS ActualAmount,

        LAG(FO.OPEXAmount) OVER
        (
            PARTITION BY
                O.OPEXCategoryName,
                O.OPEXSubcategoryName
            ORDER BY
                P.[Year],
                P.QuarterNumber    
        ) AS PreviousQuarterAmount

FROM dbo.FactOPEX AS FO        

INNER JOIN dbo.DimPeriod AS P
    ON FO.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S    
    ON FO.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimOPEX AS O
    ON FO.OPEXId = O.OPEXId

WHERE S.ScenarioName = 'Actual'        
)

SELECT
    [Year],
    [Quarter],
    OPEXCategoryName,
    OPEXSubcategoryName,

    CAST(
        ActualAmount
        AS DECIMAL(18,2)
    ) AS ActualAmount,

    CAST(
        PreviousQuarterAmount
        AS DECIMAL(18,2)  
    ) AS PreviousQuarterAmount,

    CAST(ActualAmount - PreviousQuarterAmount
         AS DECIMAL(18,4)
    ) AS QuarterChange,

    CAST(
        (
            ActualAmount - PreviousQuarterAmount 
        )
        /
        NULLIF(PreviousQuarterAmount,0)
        *
        100
        AS DECIMAL(18,2)
    ) AS QuarterChamngePercent

FROM OPEXTrend

ORDER BY
    OPEXCategoryName,
    OPEXSubCategoryName,
    [Year],
    QuarterNumber;
GO    