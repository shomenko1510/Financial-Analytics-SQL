USE FinanceAnalyticsPortfolioDB;
GO

; WITH OPEXYoY AS
(

    SELECT
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    O.OPEXCategoryName,
    O.OPEXSubCategoryName,
    FO.OPEXAmount AS ActualAmount, 

    LAG(FO.OPEXAmount, 4) OVER
    (
        PARTITION BY
            O.OPEXCategoryName,
            O.OPEXSubCategoryName
        ORDER BY
            P.[Year],
            P.QuarterNumber
    ) AS PreviousYearAmount

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
    OPEXSubCategoryName,

    CAST(
        ActualAmount
        AS DECIMAL(18,2)
    ) AS ActualAmount,

    CAST(
        PreviousYearAmount
        AS DECIMAL(18,2)
    ) AS PreviousYearAmount,

    CAST(
        ActualAmount - PreviousYearAmount
        AS DECIMAL(18,2)
    ) AS YoYChange,

    CAST(
        (
         ActualAmount - PreviousYearAmount   
        )
        /
        NULLIF(PreviousYearAmount,0)
        * 100
        AS DECIMAL(18,2)
    ) AS YoYChangePercent

FROM OPEXYoY

ORDER BY
    OPEXCategoryName,
    OPEXSubCategoryName,
    [Year],
    QuarterNumber;
GO    



