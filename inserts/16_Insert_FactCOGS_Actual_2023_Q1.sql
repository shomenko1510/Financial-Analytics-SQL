/*
============================================================================================================
Project    : Financial Analitics SQL
Script     : 16_Insert_FactCOGS_Actual_2023_Q1.sql
Purpose    : Insert actual COGS data for Q1 2023
Author     : Sergiii Khomenko
============================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @ScenarioId INT;
DECLARE @PeriodId INT;

SELECT 
    @CompanyId = CompanyId
FROM dbo.DimCompany
WHERE CompanyName = 'Company A';

SELECT 
    @ScenarioId = ScenarioId
FROM dbo.DimScenario
WHERE ScenarioName = 'Actual';

SELECT
    @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2023
    AND [Quarter] = 'Q1';

-- Chect whether the data has already been loaded

IF EXISTS
(
    SELECT 1
    FROM dbo.FactCOGS
    WHERE CompanyId = @CompanyId
        AND ScenarioId = @ScenarioId
        AND PeriodId = @PeriodId   
)
BEGIN
    RAISERROR
    (
        'FactCOGS Actual data for Company A, Q1 2023 already exists.',
        16,
        1        
    );
    RETURN;
END;

;WITH SourceData AS 
(
    SELECT * 
    FROM
    (
        VALUES
            ('Business Line A', CAST(22294.9500 AS DECIMAL(18,5))),
            ('Business Line B', CAST(33543.6000 AS DECIMAL(18,4))),
            ('Business Line C', CAST(97579.4000 AS DECIMAL(18,4))),
            ('Business Line D', CAST(0.0000 AS DECIMAL(18,4))),
            ('Business Line E', CAST(6685.1000 AS DECIMAL(18,4))),
            ('Business Line F', CAST(4702.4100 AS DECIMAL(18,4))),
            ('Business Line G', CAST(13.9000 AS DECIMAL(18,4))),
            ('Business Line H', CAST(0.0000 AS DECIMAL(18,4))),
            ('Other', CAST(3566.1000 AS DECIMAL(18,4)))
    ) AS V
    (
        DirectionName,
        COGSAmount
    )
)
INSERT INTO dbo.FactCOGS
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    COGSAmount
)
SELECT
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    D.DirectionId,
    SD.COGSAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
    ON SD.DirectionName = D.DirectionName;

PRINT 'FactCOGS Actual 2023 Q1 loaded successfully.';
GO