/*
=============================================================================================
Project   : Financial Analitics SQL
Script    : 26_Create_StgOPEX.sql
Purpose   : Create StgOPEX table
Author    : Sergii Khomenko
=============================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.StgOPEX
(
    CompanyName NVARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] NVARCHAR(10) NOT NULL,
    ScenarioName NVARCHAR(50) NOT NULL,
    OPEXCategoryName NVARCHAR(100) NOT NULL,
    OPEXSubcategoryName NVARCHAR(100) NOT NULL,
    OPEXAmount DECIMAL(18,4) NOT NULL
);
GO