/*
================================================================================
Project   : Financial Analytics SQL
Script    : 01_Financial_Report.sql
Purpose   : Create Financial Report with dimention tables
Author    : Sergii Khomenko
================================================================================
*/ 

USE FinanceAnalyticsPortfolioDB;
GO 

SELECT
    C.CompanyName,
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    FI.IndicatorCode,
    FI.IndicatorName,
    FD.Amount
FROM dbo.factFinancialData AS FD

INNER JOIN dbo.DimCompany AS C
    ON FD.CompanyId = C.CompanyId

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

INNER JOIN dbo.DimFinancialIndicator AS FI
    ON FD.IndicatorId = FI.IndicatorId

ORDER BY 
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    FI.IndicatorSortOrder;        