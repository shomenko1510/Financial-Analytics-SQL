/*
=================================================================================================
Project    : Financial Analytics SQL
Script     : 21_Create_FactWorkingCapital.sql
Purpose    : Create FactWorkingCapital table
Author     : Sergii Khomenko
=================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.FactWorkingCapital
(
    WorkingCapitalFactId INT IDENTITY(1,1) NOT NULL,
    CompanyId INT NOT NULL,
    PeriodId INT NOT NULL,
    ScenarioId INT NOT NULL,
    WorkingCapitalId INT NOT NULL,
    WorkingCapitalAmount DECIMAL(18,4) NOT NULL,

CONSTRAINT PK_FactWorkingCapital
PRIMARY KEY (WorkingCapitalFactId)
);
GO