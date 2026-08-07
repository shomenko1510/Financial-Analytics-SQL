/*
===================================================================================================
Project    : Financial Analitics SQL
Script     : 15_Insert_FactSales_Actual_2024_Q1.sql
Purpose    : Insert Actual FactSales data for Q1 2024
Author     : Sergii Khomenko
===================================================================================================
*/
USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @ScenarioId INT;
DECLARE @PeriodId INT;

SELECT @CompanyId = CompanyId
FROM dbo.DimCompany
WHERE CompanyName = 'Company A';

SELECT @ScenarioId = ScenarioId
FROM dbo.DimScenario
WHERE ScenarioName = 'Actual';

SELECT @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2024
    AND [Quarter] = 'Q1';


-- Check whether the data for Company A and 2024 Q1 has already been loaded

IF EXISTS
(
    SELECT 1
    FROM dbo.FactSales
    WHERE @CompanyId = CompanyId
        AND @ScenarioId = ScenarioId
        AND @PeriodId = PeriodId
)
BEGIN
    RAISERROR
    (
        'FactSales Actual data for Company A, Q1 2024 is alredy exists',
        16,
        1
    );    
    RETURN;
END;

; WITH SourceData AS
(
    SELECT *
    FROM
    (
        VALUES
        ('Business Line A',    949.5900,     75.1000,     71314.3600),
        ('Business Line B',    199.7600,    237.1000,     47364.0400),
        ('Business Line C',   8709.4200,     19.0800,    166178.5000),
        ('Business Line D',      0.0000,      0.0000,         0.0000),
        ('Business Line E',    144.8300,     63.7100,      9226.7200),
        ('Business Line F',    244.7800,     42.1500,     10318.1600),
        ('Business Line G',    399.3400,     24.2700,      9693.1000),
        ('Business Line H',      0.0000,      0.0000,         0.0000),
        ('Other',                1.0000,   5135.3400,      5135.3400)
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

--Validation Total Revenue

/*
SELECT SUM(RevenueAmount) AS TotalRevenue
FROM SourceData;
*/

--Validation - Previev data before insert

/*
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

PRINT 'FackSales Actual for Q1 2024 loaded successfully';

