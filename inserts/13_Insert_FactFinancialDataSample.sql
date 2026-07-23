USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId   INT;
DECLARE @PeriodId    INT;
DECLARE @ScenarioId  INT;
DECLARE @DirectionId INT;

SELECT @CompanyId = CompanyId
FROM dbo.DimCompany
WHERE CompanyCode = 'Comp_A';

SELECT @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2023
AND [QuarterNumber] = 1;

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

INSERT INTO 
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
    IndicatorId,
    Amount
FROM 
(
    VALUES
        ('REV', 100000.000),
        ('COGS', 65000.000),
        ('GP',   35000.000),
        ('OPEX', 7000.000),
        ('EBITDA', 20000.000),
        ('NP', 14000.000),
        ('AR', 30000.000),
        ('INV', 65000.000),
        ('AP', 24000.000),
        ('OCF', 22000.000),
        ('CAPEX', 8000.000),
        ('CASH_OPEN', 1200.000),
        ('CASH_CLOSE', 1100.000)
) AS SourseData (IndicatorCode, Amount)
INNER JOIN dbo.DimFinancialIndicator AS i
ON i.DimFinancialIndicator = SourseData.IndicatorCode;
GO

SELECT 
    f.FinancialDataId,
    c.CompanyName,
    p.PeriodName,
    s.ScenarioName,
    d.DiractionName,
    i.IndicatorCode,
    i.IndicatorName,
    f.Amount
FROM dbo.FactFinancialData AS f    
INNER JOIN dbo.DimCompany AS c
    ON f.CompanyId = c.CompanyId
INNER JOIN dbo.DimPeriod AS p
    ON f.PeriodId = p.PeriodId
INNER JOIN dbo.DimScenario as s
    ON f.ScenarioId = s.ScenarioId
INNER JOIN dbo.DimDirection as d
    ON f.DirectionId = d.DirectionId
INNER JOIN dbo.DimFinancialIndicator as i
    ON f.IndicatorId = i.IndicatorId
ORDER BY i.IndicatorSortOrder;            




