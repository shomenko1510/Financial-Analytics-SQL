/*
=================================================================================================
Project    : Financial Analytics SQL
Script     : 18_Create_FactOPEX.SQL
Purpose    : Create FactOPEX table
Author     : Sergii Khomenko
=================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.FactOPEX
(
    OPEXFactId INT IDENTITY(1,1) NOT NULL,
    CompanyId INT NOT NULL,
    PeriodId INT NOT NULL,
    ScenarioId INT NOT NULL,
    OPEXId INT NOT NULL,
    OPEXAmount DECIMAL(18,4) NOT NULL,

    CONSTRAINT PK_FactOPEX
    PRIMARY KEY (OPEXFactId)
    
);
GO

