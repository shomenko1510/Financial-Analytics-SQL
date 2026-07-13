/*
==================================================================================================
Project    : Financial Analytics SQL
Script     : 05_Create_DimCompany.sql
Purpose    : Create the DimCompany table
Author     : Sergii Khomenko
==================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimCompany
(
    CompanyId INT IDENTITY(1,1) NOT NULL,
    CompanyName NVARCHAR(100) NOT NULL,
    CompanyCode NVARCHAR(50) NOT NULL,
    CompanySortOrder INT NOT NULL,

    CONSTRAINT PK_DimCompany
        PRIMARY KEY (CompanyId),

    CONSTRAINT UQ_DimCompany_CompanyName
        UNIQUE (CompanyName),

    CONSTRAINT UQ_DimCompany_CompanyCode
        UNIQUE (CompanyCode)    
);
GO

SELECT 
    CompanyId,
    CompanyName,
    CompanyCode,
    CompanySortOrder
FROM dbo.DimCompany;
GO    