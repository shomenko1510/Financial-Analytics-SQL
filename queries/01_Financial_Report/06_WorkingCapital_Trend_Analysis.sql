USE FinanceAnalyticsPortfolioDB;
GO

; WITH WorkingCapitalTrend AS
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        WC.WorkingCapitalCategory,
        WC.WorkingCapitalItem,

        FW.WorkingCapitalAmount AS ActualAmount,

        LAG(FW.WorkingCapitalAmount) OVER
        (
            PARTITION BY WC.WorkingCapitalItem
            ORDER BY
                P.[Year],
                P.QuarterNumber
        ) AS PreviousQuarterAmount

    FROM dbo.FactWorkingCapital AS FW

    INNER JOIN dbo.DimPeriod AS P
        ON FW.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FW.ScenarioId = S.ScenarioId

    INNER JOIN dbo.DimWorkingCapital AS WC
        ON FW.WorkingCapitalId = WC.WorkingCapitalId

    WHERE S.ScenarioName = 'Actual'    
)

SELECT
    [Year],
    [Quarter],
    WorkingCapitalCategory,
    WorkingCapitalItem,

    CAST(
        ActualAmount
        AS DECIMAL(18,2)    
    ) AS ActualAmount,

    CAST(
        PreviousQuarterAmount
        AS DECIMAL(18,2)
    ) AS PreviousQuarterAmount,

    CAST(
        ActualAmount - PreviousQuarterAmount
        AS DECIMAL(18,2)  
    ) AS QuarterChange,

    CAST(
        (
     
            ActualAmount - PreviousQuarterAmount
        )
        /
        NULLIF(PreviousQuarterAmount,0)
        *100
        AS DECIMAL(18,2)    
    ) AS QuarterChamngePercent

FROM WorkingCapitalTrend

ORDER BY
    WorkingCapitalItem,
    [Year],
    QuarterNumber;
GO    

