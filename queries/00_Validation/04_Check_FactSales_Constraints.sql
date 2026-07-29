/*
=================================================================================================================
Project   : Financial Analytics SQL
Script    : 04_Check_FactSales_Constraint.sql
Purpose   : Validate constraints created for FactSales
Author    : Sergii Khomenko
=================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

SELECT 
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    tc.TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
WHERE tc.TABLE_SCHEMA = 'dbo'
    AND tc.TABLE_NAME = 'FactSales'
ORDER BY 
    tc.CONSTRAINT_TYPE,
    tc.CONSTRAINT_NAME;
GO        

