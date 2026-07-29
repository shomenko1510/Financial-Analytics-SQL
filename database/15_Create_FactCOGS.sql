/*
================================================================================================================
Project    : Financial Analitics SQL
Script     : 15_Create_FactCOGS.sql
Purpose    : Create FactSales table for anonymized COGS data
Author     : Khomenko Sergii
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.FactCOGS
(
    COGSId INT IDENTITY(1,1)  NOT NULL,
    CompanyId INT NOT NULL,
    PeriodId INT NOT NULL,
    ScrnarioId INT NOT NULL,
    DirectionId INT NOT NULL,
    COGSAmount DECIMAL(19,4) NOT NULL,

    CONSTRAINT PK_FactCOGS
    PRIMARY KEY (COGSId)
    
);

GO