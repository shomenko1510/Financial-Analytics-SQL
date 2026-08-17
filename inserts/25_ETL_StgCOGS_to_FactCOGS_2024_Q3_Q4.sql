/*
=======================================================================================================================
Progect     : Financial Analitics SQL
Script      : 25_ETL_StgCOGS_to_FactCOGS_2024_Q3_Q4.sql
Purpose     : Validate StgCOGS data before loading into FactCOGS
Author      : Sergii Khomenko
=======================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

SELECT 
    ST.CompanyName,
    ST.[Year],
    ST.[Quarter],
    ST.ScenarioName,
    ST.DirectionName,
    ST.COGSAmount,

    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    D.DirectionId

FROM dbo.StgCOGS AS ST

LEFT JOIN dbo.DimCompany AS C
    ON ST.CompanyName = C.CompanyName

LEFT JOIN dbo.DimPeriod AS P    
    ON ST.[Year] = P.[Year]
    AND ST.[Quarter] = P.[Quarter]

LEFT JOIN dbo.DimScenario AS S
    ON ST.ScenarioName = S.ScenarioName

LEFT JOIN dbo.DimDirection AS D
    ON ST.DirectionName = D.DirectionName;

-- Validation: Verify staging data against dimention table

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS AS ST

    LEFT JOIN dbo.DimCompany AS C
        ON ST.CompanyName = C.CompanyName

    LEFT JOIN dbo.DimPeriod AS P
        ON ST.[Year] = P.[Year]
        AND ST.[Quarter] = P.[Quarter]

    LEFT JOIN dbo.DimScenario AS S
        ON ST.ScenarioName = S.ScenarioName

    LEFT JOIN dbo.DimDirection AS D
        ON ST.DirectionName = D.DirectionName

    WHERE C.CompanyId IS NULL
        OR P.PeriodId IS NULL
        OR S.ScenarioId IS NULL
        OR D.DirectionId IS NULL                  
)
BEGIN
    RAISERROR
    (
        'ETL Validation failed: one or more saging value do not mutch dimention table',
        16,
        1
    )
    RETURN;
END;

--Validation: check whether data is already exists

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS AS ST

    INNER JOIN dbo.DimCompany AS C
        ON ST.CompanyName = C.CompanyName

    INNER JOIN dbo.DimPeriod AS P
        ON ST.[Year] = P.[Year]
        AND ST.[Quarter] = P.[Quarter]

    INNER JOIN dbo.DimScenario AS S
        ON ST.ScenarioName = S.ScenarioName

    INNER JOIN dbo.DimDirection AS D
        ON ST.DirectionName = D.DirectionName

    INNER JOIN dbo.FactCOGS AS FC
        ON FC.CompanyId = C.CompanyId
        AND FC.PeriodId = P.PeriodId
        AND FC.ScenarioId = S.ScenarioId
        AND FC.DirectionId = D.DirectionId
)
BEGIN
    RAISERROR
        (
            'ETL stopped: one or more FactCOGS records is already exists',
            16,
            1
        )
        RETURN;
END;

INSERT INTO dbo.FactCOGS
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    COGSAmount
)
SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    D.DirectionId,
    ST.COGSAmount
FROM dbo.StgCOGS AS ST

INNER JOIN dbo.DimCompany AS C
    ON ST.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON ST.[Year] = P.[Year]
    AND ST.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON ST.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDirection AS D
    ON ST.DirectionName = D.DirectionName

-- Validation: Verify inserted FactCOGS data

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(*) AS TotalRows,
    SUM(COGSAmount) AS TotalCOGSAmount

FROM dbo.FactCOGS AS FC

INNER JOIN dbo.DimPeriod AS P
    ON FC.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FC.ScenarioId = S.ScenarioId

GROUP BY 
    P.[Year],
    P.[Quarter],
    S.ScenarioName;        


    





