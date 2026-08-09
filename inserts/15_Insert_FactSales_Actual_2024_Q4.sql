/*
======================================================================================================================
Project     : Financial Analitics SQL
Script      : 15_Insert_FactSales_Actual_2024_Q4
Purpose     : Insert Actual FactSales data for Company A, Q4 2024
Author      : Sergii Khomenko
======================================================================================================================
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
    AND [Quarter] = 'Q4';


-- CHECK whether Actual FactSales data for Company A, Q4 2024 is already exists    

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
        'Actual FactSales data for Company A, Q4 2024 is already exists',
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
            ('Business Line A',   296.1000,     75.7000,      22710.9300),
            ('Business Line B',    88.8500,    227.0300,      20170.7900),
            ('Business Line C',  6465.1800,     20.9600,     135487.5000),
            ('Business Line D',   149.5700,     10.9900,       1643.5100),
            ('Business Line E',   142.7200,     64.9500,       9270.1200),
            ('Business Line F',   160.3300,     38.9900,       6251.3900),
            ('Business Line G',   261.9100,     24.0600,       6300.7000),
            ('Business Line H',     0.0000,      0.0000,          0.0000),
            ('Other',               1.0000,   1095.2900,       1095.2900)       
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

--Validation Total Amount

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

PRINT 'Astual FactSales Data for Company A, Q4 2024 has been loaded succsessfully'        