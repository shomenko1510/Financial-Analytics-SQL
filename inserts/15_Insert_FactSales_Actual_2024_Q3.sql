/*
=======================================================================================================================
Project    : Financial Analytics SQL
Script     : 15_Insert_FactSales_Actual_2024_Q3.sql
Purpose    : Insert Actual Factsales data for Company A, Q3 2024
Author     : Sergii Khomenko
=======================================================================================================================
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
    AND [Quarter] = 'Q3';

;WITH SourceData AS
(
    SELECT * 
    FROM
    (
        VALUES
            ('Business Line A',    681.2400,     76.8000,     52319.0300),
            ('Business Line B',    107.1400,    238.4000,     25541.2200),
            ('Business Line C',   9558.6600,     16.9000,    161545.1000),
            ('Business Line D',    107.8800,     10.9900,      1185.4400),
            ('Business Line E',    229.7700,     64.9500,     14924.0000),
            ('Business Line F',    140.3700,     38.9900,      5472.9900),
            ('Business Line G',    484.7200,     24.0600,     11660.6000),
            ('Business Line H',      0.0000,      0.0000,         0.0000),
            ('Other',                1.0000,   3453.6500,      3453.6500)      
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

--Validation  Total Amount

/*
SELECT SUM(RevenueAmount)
FROM SourceData;
*/

