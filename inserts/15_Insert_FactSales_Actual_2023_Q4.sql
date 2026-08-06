/*
======================================================================================================================
Project    : Finncial Analitics SQL
Script     : 15_Insert_FactSales_Actual_2023_Q4.sql
Purpose    : Insert Actual FactSales data for 2023 Q1  
Author     : Sergii Khomenko
======================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @PeriodId INT;
DECLARE @ScenarioId INT;

SELECT @CompanyId = CompanyId
FROM dbo.DimCompany 
WHERE CompanyName = 'Company A';

SELECT @ScenarioId = ScenarioId
FROM dbo.DimScenario
WHERE ScenarioName = 'Actual';

SELECT @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2023
    AND [Quarter] = 'Q4';

-- Check whether the data has already been loaded

IF EXISTS
(
    SELECT 1
    FROM dbo.FactSales
    WHERE CompanyId = @CompanyId
        AND ScenarioId = @ScenarioId
        AND PeriodId = @PeriodId
)
BEGIN
    RAISERROR
    (
        'Fact Actual data for Company A, Q4 2023 is already exists ',
        16,
        1
    )
    RETURN;
END;



