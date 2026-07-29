/* 
=============================================================================================================
Priject    : Financial Analytics SQL
Script     : 13_Create_FactSales.sql
Purpose    : Creata FactSales table for anonymized sales data
Author     : Sergii Khomenko
=============================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.FactSales
(
    SalesId BIGINT IDENTITY(1,1) NOT NULL,
    PeriodId INT NOT NULL,
    CompanyId INT NOT NULL,
    ScenarioId INT NOT NULL,
    DirectionId INT NOT NULL,
    Volume DECIMAL (19,4) NOT NULL,
    Price DECIMAL (19,4) NOT NULL,
    RevenueAmount DECIMAL(19,4) NOT NULL,


    CONSTRAINT PK_FActSales
        PRIMARY KEY(SAlesId)
);
GO