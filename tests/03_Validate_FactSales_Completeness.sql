USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(DISTINCT FS.DirectionId) AS DirectionCount,
    CASE
        WHEN COUNT(DISTINCT FS.DirectionId) = 9
            THEN 'PASS'
        ELSE 'FAIL'
    END AS TestStatus
FROM dbo.FactSales AS FS

INNER JOIN dbo.DimPeriod AS P
    ON FS.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FS.ScenarioId = S.ScenarioId

WHERE P.[Year] BETWEEN 2023 AND 2025

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName;    


