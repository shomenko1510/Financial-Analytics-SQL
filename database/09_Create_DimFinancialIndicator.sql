/*
================================================================================
Project    : Financial Analytics SQL
Script     : 09_Create_DimFinancialIndicator.sql
Purpose    : Create the DimFinancialIndicator table
Author     : Sergii Khomenko
================================================================================
*/
USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimFinancialIndicator
(
    IndicatorId INT IDENTITY(1,1) NOT NULL,
    IndicatorCode NVARCHAR(20) NOT NULL,
    IndicatorName NVARCHAR(150) NOT NULL,
    IndicatorCategory NVARCHAR(50) NOT NULL,
    UnitOfMeasure NVARCHAR(30) NOT NULL,
    IndicatorSortOrder INT NOT NULL,

    CONSTRAINT PK_DIMFinancialIndicator
    PRIMARY KEY (IndicatorId),

    CONSTRAINT UQ_DimFinancialIndicator
    UNIQUE (IndicatorCode) 
);
GO

