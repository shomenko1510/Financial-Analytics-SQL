USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    C.CompanyName,
    P.[Year],
    P.[Quarter],
    FI.IndicatorCode,
    FI.IndicatorName,

    CAST(
        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FD.Amount
                ELSE 0
            END    
        )
        AS DECIMAL(18,2)
    ) AS ActualAmount,

    CAST(
        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FD.Amount
                ELSE 0
            END    
        )
        AS DECIMAL(18,2)
    ) AS BudgetAmount,

    CAST(
        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FD.Amount
                ELSE 0
            END       
    )
    -
    SUM(
        CASE
            WHEN S.ScenarioName = 'Budget'
            THEN FD.Amount
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
                    THEN FD.Amount
                    ELSE 0
                END    
            )
            -   
            SUM(
                CASE
                    WHEN S.ScenarioName = 'Budget'
                    THEN FD.Amount
                    ELSE 0
                END    
            )
        )
        /
        NULLIF(
            SUM(
                CASE
                    WHEN S.ScenarioName = 'Budget'
                    THEN FD.Amount
                    ELSE 0
                END    
            ),
            0
        ) * 100
        AS DECIMAL(18,2)
) AS VariancePercent  

FROM dbo.FactFinancialData AS FD

INNER JOIN dbo.DimCompany AS C
    ON FD.CompanyId = C.CompanyId

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimFinancialIndicator AS FI
    ON FD.IndicatorId = FI.IndicatorId

GROUP BY
    C.CompanyName,
    P.[Year],
    P.[Quarter],
    FI.IndicatorCode,
    FI.IndicatorName,
    FI.IndicatorSortOrder

ORDER BY
    P.[Year],
    P.[Quarter],
    FI.IndicatorSortOrder; 
GO