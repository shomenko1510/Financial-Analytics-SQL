/*
==================================================================================================================
Project    : Financial Analytics SQL
Scrpt      : 10_Check_DimWorkingCapital.sql
Purpose    : Check data from the DimWorking capital tables
Author     : Sergii Khomenko
==================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

SELECT *
FROM dbo.DimWorkingCapital
ORDER BY WorkingCapitalId;
GO