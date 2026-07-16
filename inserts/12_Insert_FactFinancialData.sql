/*
================================================================================
Project   : Financial Analytics SQL
Script    : 12_Insert_FactFinancialIndicator.sql
Purpose   : Populate the FactFinancialData table with test data
Author    : Sergii Khomenko
================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @PeriodId INT;
DECLARE @ScenarioId INT;
DECLARE @DirectionId INT;

SELECT @CompanyId = CompanyId
FROM dbo.DimCompany
WHERE CompanyCode = 'Comp_A';

SELECT @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2025
    AND QuarterNumber = 1;

SELECT @ScenarioId = ScenarioId
FROM dbo.DimScenario
WHERE ScenarioName = 'Actual';

SELECT @DirectionId = DirectionId
FROM dbo.DimDirection
WHERE DirectionName = 'Business Line A'

SELECT 
	@CompanyId AS CompanyId,
	@PeriodId AS PeriodId,
	@ScenarioId AS ScenarioId,
	@DirectionId AS DirectionId;

INSERT INTO dbo.FactFinancialData
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    IndicatorId,
    Amount
)
SELECT
    @CompanyId AS CompanyId,
    @PeriodId AS PeriodId,
    @ScenarioId AS ScenarioId,
    @DirectionId AS DirectionId, 
    i.IndicatorId AS,
    SourceData.Amount
FROM
(
    VALUES
        ('REV',      120000.0000),
        ('COGS',      82000.0000),
        ('GP',        38000.0000),
        ('OPEX',      21000.0000),
        ('EBITDA',    17000.0000),
        ('NP',        12500.0000),
        ('AR',        45000.0000),
        ('INV',       62000.0000),
        ('AP',        31000.0000),
        ('OCF',       15500.0000),
        ('CAPEX',      5000.0000),
        ('CASH_OPEN', 18000.0000),
        ('CASH_CLOSE',28500.0000)
) AS SourceData (IndicatorCode, Amount)
INNER JOIN dbo.DimFinancialIndicator AS i 
    ON i.IndicatorCode = SourceData.IndicatorCode;
GO

SELECT
    f.FinancialDataId,
    c.CompanyName,
    p.PeriodName,
    s.ScenarioName,
    d.DirectionName,
    i.IndicatorCode,
    i.IndicatorName,
    f.Amount
FROM dbo.FactFinancialData AS f
INNER JOIN dbo.DimCompany AS c
    ON f.CompanyId = c.CompanyId
INNER JOIN dbo.DimPeriod AS p
    ON f.PeriodId = p.PeriodId
INNER JOIN dbo.DimScenario AS s
    ON f.ScenarioId = s.ScenarioId
INNER JOIN dbo.DimDirection AS d
    ON f.DirectionId = d.DirectionId
INNER JOIN dbo.DimFinancialIndicator AS i
    ON f.IndicatorId = i.IndicatorId
ORDER BY i.IndicatorSortOrder;
GO



