/*
==========================================================================================================
Project: Financial Analitics SQL
Test: FactSales Revenue Reconciliation

Purpose: 
Compare Revenue between StgSales and FactSales
by company, year, quarter and scenario.

Expected result:
RevenueDifference = 0 for every period.
==========================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

WITH StagingRevenue AS 
(
    SELECT
        CompanyName,
        [Year],
        [Quarter],
        ScenarioName,
        COUNT(*) AS StagingRows,
        SUM(RevenueAmount) AS StagingRevenue
    FROM dbo.StgSales
    WHERE [Year] BETWEEN 2023 AND 2025
    GROUP BY
        CompanyName,
        [Year],
        [Quarter],
        ScenarioName     
),

FactRevenue AS
(
    SELECT
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        S.ScenarioName,
        COUNT(*) AS FactRows,
        SUM(FS.RevenueAmount) AS FactRevenue
    FROM dbo.FactSales AS FS

    INNER JOIN dbo.DimCompany AS C
        ON FS.CompanyId = C.CompanyId

    INNER JOIN dbo.DimPeriod AS P
        ON FS.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FS.ScenarioId = S.ScenarioId

    WHERE P.[Year] BETWEEN 2023 AND 2025

    GROUP BY
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        S.Scenarioname    
)

SELECT
    COALESCE(ST.Companyname, F.Companyname) AS CompanyName,
    COALESCE(ST.[Year], F.[Year]) AS [Year],
    COALESCE(ST.[Quarter], F.[Quarter]) AS [Quarter],
    COALESCE(ST.ScenarioName, F.ScenarioName) AS ScenarioName,

    ST.StagingRows,
    F.factRows,

    CAST(
        COALESCE(F.FactRevenue, 0)
        - COALESCE(ST.StagingRevenue,0) 
        AS DECIMAL(18,2) 
    ) AS RevenueDifference,

    CASE
        WHEN ST.StagingRows IS NULL OR F.FactRows IS NULL
            THEN 'FAIL'
        WHEN ST.StagingRows <> F.FactRows
            THEN 'FAIL'
        WHEN ABS(
            COALESCE(F.FactRevenue,0)
            - COALESCE(ST.StagingRevenue, 0)  
        ) > 0.01
            THEN 'FAIL'
        ELSE 'PASS'

    END AS TestStatus

FROM StagingRevenue AS ST

FULL OUTER JOIN FactRevenue AS F
    ON ST.CompanyName = F.CompanyName
    AND ST.[Year] = F.[Year]
    AND ST.[Quarter] = F.[Quarter]
    AND ST.ScenarioName = F.ScenarioName

ORDER BY
    [Year],
    [Quarter],
    ScenarioName,
    CompanyName;    

