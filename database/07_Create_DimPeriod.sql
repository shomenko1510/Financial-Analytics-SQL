/*
===============================================================================
Project    : Financial Analitics SQL
Script     : 07_Create_DimPeriod
Purpuse    : Create the DimPeriod table
Author     : Sergii Khomenko
===============================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimPeriod
(
    PeriodId INT IDENTITY(1,1) NOT NULL,
    [Year] SMALLINT NOT NULL,
    [Quarter] NVARCHAR(2) NOT NULL,
    QuarterNumber TINYINT NOT NULL,
    PeriodName NVARCHAR(7) NOT NULL,
    PeriodSortOrder INT NOT NULL,

    CONSTRAINT PK_DimPeriod
        PRIMARY KEY (PeriodId),

    CONSTRAINT UQ_DimPeriod
        UNIQUE ([Year], QuarterNumber)    
);
GO

