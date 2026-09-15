USE FinanceAnalyticsPortfolioDB;
GO

;WITH DebtData AS 
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        DM.DebtMetricName,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Actual'
                THEN FD.DebtMetricValue
                ELSE 0
            END 
        ) AS ActualValue,

        SUM(
            CASE
                WHEN S.ScenarioName = 'Budget'
                THEN FD.DebtMetricValue
                ELSE 0
            END
        ) AS BudgetValue

    FROM dbo.FactDebtSchedule AS FD

    INNER JOIN dbo.DimPeriod AS P
        ON FD.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FD.ScenarioId = S.ScenarioId

    INNER JOIN dbo.DimDebtMetric AS DM
        ON FD.DebtMetricId = DM.DebtMetricId

    GROUP BY
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        DM.DebtMetricName                
)

SELECT
    [Year],
    [Quarter],
    DebtMetricName,

    CAST(
        ActualValue
        AS DECIMAL(18,2)
    ) AS ActualValue,

    CAST(
        BudgetValue
        AS DECIMAL(18,2)
    ) AS BudgetValue,

    CAST(
        ActualValue - BudgetValue
        AS DECIMAL(18,2)
    ) AS Variance,

    CAST(
        CASE
            WHEN DebtMetricName <> 'Interest Rate'
            THEN
                (
                    ActualValue - BudgetValue
                )
                /
                NULLIF(BudgetValue,0)
                * 100
            ELSE NULL
        END
        AS DECIMAL(18,2)        
    ) AS VariancePercent,

    CAST(
        CASE
            WHEN DebtMetricName = 'Interest Rate'
            THEN ActualValue - BudgetValue
            ELSE NULL
        END
        AS DECIMAL(18,2)    
    ) AS RateVariancePP

FROM DebtData

ORDER BY
    [Year],
    QuarterNumber,

    CASE DebtMetricName
        WHEN 'Opening Loan Balance' THEN 1
        WHEN 'Loan Drawndown' THEN 2
        WHEN 'Loan Repayment' THEN 3
        WHEN 'Closing Loan Balance' THEN 4
        WHEN 'Interest Rate' THEN 5
        WHEN 'Interest Expense' THEN 6
        ELSE 99
    END;

GO        

;WITH DebtCheck AS 
(
    SELECT
        P.[Year],
        P.[Quarter],
        P.QuarterNumber,
        S.ScenarioName,

        SUM(
            CASE
                WHEN DM.DebtMetricName = 'Opening Loan Balance'
                THEN FD.DebtMetricValue
                ELSE 0
            END    
        ) AS OpeningBalance,

        SUM(
            CASE
                WHEN DM.DebtMetricName = 'Loan Drawndown'
                THEN FD.DebtMetricValue
                ELSE 0
            END    
        ) AS LoanDrawdown,

        SUM(
            CASE
                WHEN DM.DebtMetricName = 'Loan Repayment'
                THEN FD.DebtMetricValue
                ELSE 0
            END
        ) AS LoanRepayment,

        SUM(
            CASE
                WHEN DM.DebtMetricName = 'Closing Loan Balance'
                THEN FD.DebtMetricValue
                ELSE 0
            END    
        ) AS ClosingBalance

FROM dbo.FactDebtSchedule AS FD

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimDebtMetric AS DM
    ON FD.DebtMetricId = DM.DebtMetricId

GROUP BY
    P.[Year],
    P.[Quarter],
    P.QuarterNumber,
    S.ScenarioName
)

SELECT
    [Year],
    [Quarter],
    ScenarioName,

    CAST(
        OpeningBalance
        AS DECIMAL(18,2)
    ) AS OpeningBalance,

    CAST(
        LoanDrawdown
        AS DECIMAL(18,2)  
    ) AS LoanDrawdown,

    CAST(
        LoanRepayment
        AS DECIMAL(18,2)
    ) AS LoanRepayment,

    CAST(
        ClosingBalance
        AS DECIMAL(18,2)
    ) AS ClosingBalance,

    CAST(
        OpeningBalance
        + LoanDrawdown
        - LoanRepayment
        AS DECIMAL(18,2)
    ) AS CalculatedClosingBalance,

    CAST(
        ClosingBalance
        -
        (
            OpeningBalance
            + LoanDrawdown
            - LoanRepayment
        )
        AS DECIMAL(18,2)
    ) AS BalanceDifference

FROM DebtCheck

ORDER BY
    [Year],
    QuarterNumber,
    ScenarioName;
GO
