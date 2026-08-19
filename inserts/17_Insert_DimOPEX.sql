/*
================================================================================================================
Project    : Financial Analitics SQL
Script     : 17_Insert_DimOPEX.sql
Purpose    : Populate the DimOPEX table
Author     : Sergii Khomenko
================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.DimOPEX
)
BEGIN
    RAISERROR
    (
        'DimOPEX has already been populated.',
        16,
        1
    );
    RETURN;
END;    

INSERT INTO dbo.DimOPEX
    (
        OPEXCategoryName,
        OPEXSubcategoryName
    )
VALUES
    
    ('Administrative Expenses', 'Salaries'),
    ('Administrative Expenses', 'Bonuses'),
    ('Administrative Expenses', 'Utilities'),
    ('Administrative Expenses', 'Internet & Comunication'),
    ('Administrative Expenses', 'IT Servise'),
    ('Administrative Expenses', 'Insurance'),
    ('Selling Expenses', 'Salaries'),
    ('Selling Expenses', 'Bonuses'),
    ('Selling Expenses', 'Advertising'),
    ('Selling Expenses', 'Marketing'),
    ('Selling Expenses', 'Transportation'),
    ('Selling Expenses', 'Business Trip'),
    ('Other Operating Expenses', 'Environmental Cost'),
    ('Other Operating Expenses', 'Write-offs'),
    ('Other Operating Expenses', 'Taxes & Fees'),
    ('Other Operating Expenses', 'Health & Safety');
GO

SELECT
    OPEXId,
    OPEXCategoryName,
    OPEXSubCategoryName
FROM dbo.DimOPEX;

GO



    
