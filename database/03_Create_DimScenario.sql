/*
============================================================================================================
Project   : Financial Analytics SQL
Script    : 03_Create_DimScenario.sql
Purpose   : Create the DimScenario table
Author    : Sergii Khomenko
============================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE DimScenario
(
    ScenarioId INT IDENTITY(1,1) NOT NULL,
    ScenarioName NVARCHAR(100) NOT NULL,
    ScenarioOrder INT NOT NULL,

    CONSTRAINT PK_DimScenario
        PRIMARY KEY (ScenarioId),

    CONSTRAINT UQ_DimScenario_ScenarioName
        UNIQUE (ScenarioName)    
);
GO
