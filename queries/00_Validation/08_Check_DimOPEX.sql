/*
================================================================================================================
Project   : Financial Analitics SQL
Script    : 08_Check_DimOPEX.sql
Purpose   : Validate data in the DimOPEX table
================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    OPEXId,
    OPEXCategoryName,
    OPEXSubCategoryName
FROM dbo.DimOPEX
ORDER BY 
    OPEXCategoryName,
    OPEXSubcategoryName;
GO

SELECT COUNT(*) AS TotalRows
FROM dbo.DimOPEX;        
