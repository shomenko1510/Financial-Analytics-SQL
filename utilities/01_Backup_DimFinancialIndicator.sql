/*
==================================================================================================================
Project   : Financial Analytics SQL
Script    : 01_Backup_DimFinancialIndicator.sql
Purpose   : Create a backup copy of DimFinancialIndicator
Author    : Sergii Khomenko
==================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

SELECT * 
INTO dbo.DimFinancialIndicator_Backup
FROM dbo.DimFinancialIndicator;

Print 'Backup table created successfully.';
GO
