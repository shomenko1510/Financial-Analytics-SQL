/*
=================================================================================================
Project    : Financial Analytics SQL
Script     : 18_Insert_DimOPEX_Actual 
Purpose    : Insert actual OPEX data for Q1 2023
Author     : Sergii Khomenko
=================================================================================================
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
    AND [Quarter] = 'Q1';

IF EXISTS
(
    SELECT 1
    FROM dbo.FactOPEX
    WHERE CompanyId = @CompanyId
        AND PeriodId = @PeriodId
        AND ScenarioId = @ScenarioId 
)
BEGIN
    RAISERROR
    (
        'FactOPEX Actual data for CompanyA, Q1 2023 already exists.',
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
            ('Administrative Expenses', 'Salaries', CAST(1259.6 AS DECIMAL(18,4))),
            ('Administrative Expenses', 'Bonuses', CAST(261.0 AS DECIMAL(18,4))),
            ('Administrative Expenses', 'Utilities', CAST(3045.1 AS DECIMAL(18,4))),
            ('Administrative Expenses', 'Internet & Comunication', CAST(128.8 AS DECIMAL(18,4))),
            ('Administrative Expenses', 'IT Servise', CAST(466.7 AS DECIMAL(18,4))),
            ('Administrative Expenses', 'Insurance', CAST(64.1 AS DECIMAL(18,4))),
            ('Selling Expenses', 'Salaries', CAST(638.4 AS DECIMAL(18,4))),
            ('Selling Expenses', 'Bonuses', CAST(733.7 AS DECIMAL(18,4))),
            ('Selling Expenses', 'Advertising', CAST(255.2 AS DECIMAL(18,4))),
            ('Selling Expenses','Marketing', CAST(89.8 AS DECIMAL(18,4))),
            ('Selling Expenses', 'Transportation', CAST(20248.9 AS DECIMAL(18,4))),
            ('Selling Expenses', 'Business Trip', CAST(152.2 AS DECIMAL(18,4))),
            ('Other Operating Expenses', 'Environmental Cost', CAST(2215.2 AS DECIMAL(18,4))),
            ('Other Operating Expenses', 'Write-offs', CAST(2736.5 AS DECIMAL(18,4))),
            ('Other Operating Expenses', 'Taxes & Fees', CAST(3221.0 AS DECIMAL(18,4))),
            ('Other Operating Expenses', 'Health & Safety', CAST(946.7 AS DECIMAL(18,4)))
    ) AS V
    (
        OPEXCategoryName,
        OPEXSubCategoryName,
        OPEXAmount
    )
)
/*
SELECT
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    O.OPEXId,
    SD.OPEXAmount
FROM SourceData AS SD
INNER JOIN dbo.DimOPEX AS O
    ON SD.OPEXCategoryName = O.OPEXCategoryName
    AND SD.OPEXSubCategoryName = O.OPEXSubcategoryName;
*/

INSERT INTO dbo.FactOPEX
    (
        CompanyId,
        PeriodId,
        ScenarioId,
        OPEXId,
        OPEXAmount
    )
SELECT
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    O.OPEXId,
    SD.OPEXAmount
FROM SourceData AS SD

INNER JOIN dbo.DimOPEX AS O
    ON SD.OPEXCategoryName = O.OPEXCategoryName
    AND SD.OPEXSubCategoryName = O.OPEXSubcategoryName;

PRINT 'FactOPEX Actual 2023 Q1 loaded successfully.';
GO    





