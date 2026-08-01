/*
===============================================================================================================
Project    : Financing Analytics SQL
Script     : 17_Create_DimOPEX.sql
Purpose    : Create the DimOPEX table
Author     : Sergii Khomenko
===============================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimOPEX
(
    OPEXId INT IDENTITY(1,1) NOT NULL,
    OPEXCategoryName NVARCHAR(100) NOT NULL,
    OPEXSubcategoryName NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_DimOPEX
        PRIMARY KEY (OPEXId),

    CONSTRAINT UQ_DimOPEX
        UNIQUE
        (
            OPEXCategoryName,
            OPEXSubcategoryName
        )
);

GO

