/*
=============================================================================================
Project   : Financial Analitics SQL
Script    : 25_Create_StgSales.sql
Purpose   : Create StgSales table
Author    : Sergii Khomenko
=============================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.StgSales
(
    CompanyName NVARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] NVARCHAR(10) NOT NULL,
    ScenarioName NVARCHAR(50) NOT NULL,
    DirectionName NVARCHAR(100) NOT NULL,
    Volume DECIMAL (18,4) NOT NULL,
    Price DECIMAL(18,4) NOT NULL,
    RevenueAmount DECIMAL(18,4) NOT NULL
);
GO

ALTER TABLE dbo.StgSales
ADD VolumeUnit NVARCHAR(20) NULL;