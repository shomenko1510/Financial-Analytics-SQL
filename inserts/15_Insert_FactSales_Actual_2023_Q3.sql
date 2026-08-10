/*
=====================================================================================================================
Project     : Financing Analytics SQL
Script      : 15_Insert_FactSales_Actual_2023_Q3.sql
Purpose     : Insert Actual FactSales data for Q2 2023
Authot      : Sergii Khomenko
=====================================================================================================================
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
FROM DimPeriod
WHERE [Year] = 2023
AND [Quarter] = 'Q3'; 

-- Chect whether the data has already been loaded

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
            'FactSales Actual data for Company A, Q3 2023 is already exists',
            16,
            1
    )        
    RETURN;
END;

;WITH SourceData AS 
(
    SELECT *
    FROM
    (
        VALUES
            ('Business Line A',    673.5400,    73.5900,   49566.0400),
            ('Business Line B',    145.0200,   224.0100,   32485.6400),
            ('Business Line C',   9610.2200,    14.3000,  137386.7000),
            ('Business Line D',      0.0000,     0.0000,       0.0000),
            ('Business Line E',    258.8300,    58.6800,   15186.6500),
            ('Business Line F',    229.1500,    38.7300,    8875.4200),
            ('Business Line G',     89.7100,    61.7900,    5543.0000),
            ('Business Line H',      0.0000,     0.0000,       0.0000),
            ('Other',                1.0000,  2657.0700,    2657.0700)
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
SELECT 
    SUM(RevenueAmount) AS TotalRevenue
FROM SourceData;    
*/

-- Validation - Preview Data before INSERT

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

PRINT 'FactSales Actual for Q3 2023 loaded successfully';
