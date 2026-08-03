/*
==================================================================================================================
Project    : Financial Analytics SQL
Scrpt      : 19_Insert_DimWorkingCapital.sql
Purpose    : Populate the DimWorkingCapital table
Author     : Sergii Khomenko
==================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimWorkingCapital
(
    WorkingCapitalCategory,
    WorkingCapitalItem
)

VALUES
    ('Inventory',       'Total Inventory'),
    ('Receivables',     'Total Trade Receivables'),
    ('Payables',        'Total Payables');

PRINT 'DimWorkingCapital loaded successfully.';
GO
