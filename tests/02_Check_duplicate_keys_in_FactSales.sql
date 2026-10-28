/*
==========================================================================================================
Project: Financial Analitics SQL
Test: Check duplicate business keys in FactSales

Expected result:
0 rows
==========================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    COUNT(*) AS DuplicateCount
FROM dbo.FactSales
GROUP BY
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId
Having COUNT(*) > 1;    

