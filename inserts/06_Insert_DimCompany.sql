/*
===============================================================================
Project   : Financial Analytics SQL
Script    : 06_Insert_DimCompany.sql
Purpose   : Populate the DimCompany table
Author    : Sergii Khomenko
===============================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimCompany
(
    CompanyName,
    CompanyCode,
    CompanySortOrder
)
VALUES
('Company A', 'Comp_A', 1);
GO

SELECT 
    CompanyId,
    CompanyName,
    CompanyCode,
    CompanySortOrder
FROM dbo.DimCompany
ORDER BY CompanySortOrder;
GO            

