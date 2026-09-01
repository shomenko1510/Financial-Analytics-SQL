/*
=============================================================================================
Project   : Financial Analitics SQL
Script    : 23_Create_StgCOGS.sql
Purpose   : Create StgCOGS table
Author    : Sergii Khomenko
=============================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO 

CREATE TABLE dbo.StgCOGS
(
    CompanyName    NVARCHAR(100) NOT NULL,
    [Year]         INT NOT NULL,
    [Quarter]      NVARCHAR(2) NOT NULL,
    ScenarioName   NVARCHAR(50) NOT NULL,
    DirectionName  NVARCHAR(100) NOT NULL,
    COGSAmount     DECIMAL(18,4) NOT NULL 
);
GO
