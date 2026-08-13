/*
=======================================================================================================================
Progect     : Financial Analitics SQL
Script      : 25_ETL_StgCOGS_to_FactCOGS_2023_Q3.sql
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
