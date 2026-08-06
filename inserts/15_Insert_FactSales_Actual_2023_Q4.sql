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
        'FactSales Actual data for Company A, Q4 2023 is already exists ',
        16,
        1
    )
    RETURN;
END;

; WITH SourceData AS 
(
    SELECT *
    FROM
    (
        VALUES
        ('Business Line A',   311.34000,     73.8000,        22976.8300),
        ('Business Line B',    60.95000,    230.1000,        14025.0200),
        ('Business Line C', 13343.80000,     11.3700,       151690.1000),
        ('Business Line D',     0.0000,       0.0000,            0.0000),
        ('Business Line E',   268.8800,      50.4300,        13559.2800),
        ('Business Line F',   276.7600,      28.8500,         7984.4800),
        ('Business Line G',    82.1100,      35.7300,         2933.6000),
        ('Business Line H',     0.0000,       0.0000,            0.0000),
        ('Other',               1.0000,    3103.1000,         3103.1000)     
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )    
)
--Check Total Revenue
/*
SELECT SUM(RevenueAmount)
FROM SourceData;
*/

-- Validation - Prewiew data before insert

/*
SELECT
    
    @CompanyId AS CompanyId,
    @PeriodId AS PeriodId,
    @ScenarioId AS ScenarioId,
    D.DirectionId,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
    ON SD.DirectionName = D.DirectionName;
*/
INSERT INTO dbo.FactSales
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    Volume,
    Price,
    RevenueAmount
)
SELECT 
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    D.DirectionId,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D    
    ON SD.DirectionName = D.DirectionName;

PRINT 'FactSales Actual for Q4 2023 loaded succesfully';
