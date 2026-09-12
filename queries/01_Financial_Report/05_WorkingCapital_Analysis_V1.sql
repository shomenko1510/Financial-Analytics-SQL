USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    P.[Year],
    P.[Quarter],
    WC.WorkingCapitalCategory,
    WC.WorkingCapitalItem,

    CAST(
        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FW.WorkingCapitalAmount
                ELSE 0
            END    
        )
        AS DECIMAL(18,2)
    ) AS ActualAmount,

    CAST(
        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FW.WorkingCapitalAmount
                ELSE 0
            END    
        )
        -
        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FW.WorkingCapitalAmount
                ELSE 0
            END  
        )
        AS DECIMAL(18,2)
    ) AS Variance,    
        

    CAST(
        (
            SUM(
                CASE
                    WHEN S.ScenarioName = 'Actual'
                    THEN FW.WorkingCapitalAmount
                    ELSE 0
                END
            )
            -
            SUM(
                CASE
                    WHEN S.ScenarioName = 'Budget'
                    THEN FW.WorkingCapitalAmount
                    ELSE 0
                END    
            ) 
        )
        /
        NULLIF(
            SUM(
                CASE
                    WHEN S.ScenarioName = 'Budget'
                    THEN FW.WorkingCapitalAmount
                    ELSE 0
                END    
            ),
            0
        )
        * 100
        AS DECIMAL(18,2)
    ) AS VariancePercent

FROM dbo.FactWorkingCapital AS FW

INNER JOIN dbo.DimPeriod AS P
    ON FW.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S    
    ON FW.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimWorkingCapital AS WC
    ON FW.WorkingCapitalId = WC.WorkingCapitalId

GROUP BY
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    WC.WorkingCapitalCategory,
    WC.WorkingCapitalItem     

ORDER BY
    P.[Year],
    P.QuarterNumber,
    WC.WorkingCapitalCategory,
    WC.WorkingCapitalItem; 
GO            