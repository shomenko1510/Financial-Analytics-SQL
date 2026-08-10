/*
======================================================================================================================
Project    : Financial Analytics SQL
Script     : 15_Insert_FactSales_Actual_2025_Q1.sql
Purpose    : Insert Actual FactSales data for Company A, Q1 2025
Author     : Sergii Khomenko
======================================================================================================================
*/

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
WHERE [Year] = 2025
    AND [Quarter] = 'Q1';

--Check whether Actual FactSales data for Company A, Q1 2025 is already exists

IF EXISTS
(
    SELECT 1
    FROM dbo.FactSales
    WHERE @CompanyId = CompanyId
        AND @PeriodId = PeriodId
        AND @ScenarioId = ScenarioId
)        
BEGIN
    RAISERROR
    (
        'Actual FactSales data for Company A, Q1 2025 is already exists',
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
            ('Business Line A',   796.3800,    77.3000,    61560.4700),
            ('Business Line B',   175.6400,   238.1200,    41824.5300),
            ('Business Line C',  9626.1100,    15.8900,   152944.6000),
            ('Business Line D',  1039.4900,    14.0400,    14593.2500),
            ('Business Line E',   174.1900,    66.1400,    11520.5900),
            ('Business Line F',   209.1100,    38.2600,     8001.1000),
            ('Business Line G',   648.0700,    24.1800,    15667.3000),
            ('Business Line H',   282.6900,    53.0600,    14998.9200),
            ('Other',               1.0000,  4736.4300,     4736.4300)
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

-- Validation Total RevenueAmount
/*
SELECT SUM(RevenueAmount)
FROM SourceData;
*/

--Validation - Previev data before insert
/*
SELECT
    @CompanyId,
    @ScenarioId,
    @PeriodId,
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
    ScenarioId,
    PeriodId,
    DirectionId,
    Volume,
    Price,
    RevenueAmount
)
SELECT
    @CompanyId,
    @ScenarioId,
    @PeriodId,
    D.DirectionId,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D    
    ON SD.DirectionName = D.DirectionName;

PRINT 'Actual FactSales data for Company A, Q1 2025 has been loaded successfully'    