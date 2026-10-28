/*
==========================================================================================================
Project: Financial Analitics SQL
Test 4: Revenue Reconciliation by Business Line

Purpose: 
Compare Revenue between StgSales and FactSales
for each company, period, scenario and business line

Expected result:
0 rows - no discrepancies found.
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
        DirectionName,
        COUNT(*) AS StagingRows,
        SUM(RevenueAmount) AS StagingRevenue
    FROM dbo.StgSales
    WHERE [Year] BETWEEN 2023 AND 2025
    GROUP BY
        CompanyName,
        [Year],
        [Quarter],
        ScenarioName,
        DirectionName     
),

FactRevenue AS
(
    SELECT
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        S.ScenarioName,
        D.DirectionName,
        COUNT(*) AS FactRows,
        SUM(FS.RevenueAmount) AS FactRevenue
    FROM dbo.FactSales AS FS

    INNER JOIN dbo.DimCompany AS C
        ON FS.CompanyId = C.CompanyId

    INNER JOIN dbo.DimPeriod AS P
        ON FS.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FS.ScenarioId = S.ScenarioId

    INNER JOIN dbo.DimDirection AS D
        ON FS.DirectionId = D.DirectionId    

    WHERE P.[Year] BETWEEN 2023 AND 2025

    GROUP BY
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        S.Scenarioname,
        D.DirectionName    
)

SELECT
    COALESCE(ST.Companyname, F.Companyname)
        AS CompanyName,
    COALESCE(ST.[Year], F.[Year])
        AS [Year],
    COALESCE(ST.[Quarter], F.[Quarter])
        AS [Quarter],
    COALESCE(ST.ScenarioName, F.ScenarioName)
        AS ScenarioName,
    COALESCE(ST.DirectionName, F.DirectionName)
        AS DirectionName,    

    ST.StagingRows,
    F.FactRows,

    CAST(
        ST.StagingRevenue AS DECIMAL(18,2)
    ) AS StagingRevenue,

    CAST(
        F.FactRevenue AS DECIMAL(18,2)
    ) AS FactRevenue,

    CAST(
        COALESCE(F.FactRevenue, 0)
        - COALESCE(ST.StagingRevenue,0) 
        AS DECIMAL(18,2) 
    ) AS RevenueDifference,

    CASE
        WHEN ST.StagingRows IS NULL 
        OR F.FactRows IS NULL
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
    AND ST.DirectionName = F.DirectionName

ORDER BY
    [Year],
    [Quarter],
    ScenarioName,
    CompanyName;    

