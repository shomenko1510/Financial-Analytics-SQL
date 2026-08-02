/*
==================================================================================================================
Priject   : Financial Analytics SQL
Script    : 20_CreateDimWorkingCapital.sql
Purpose   : Create the DimWorkingCapital table
Author    : Sergii Khomenko
==================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimWorkingCapital
(
    WorkingCapitalId INT IDENTITY(1,1) NOT NULL,
    WorkingCapitalCategory NVARCHAR(100) NOT NULL,
    WorkingCapitalItem NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_DimWorkingCapital
    PRIMARY KEY(WorkingCapitalId) 
);
GO

