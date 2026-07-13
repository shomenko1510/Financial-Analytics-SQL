/*
======================================================================================
Project   : Financial Analytics SQL
Script    : 02_Create_Dim_Direction.sql
Purpose   : Create the DimDirection table
Author    : Sergii Khomenko
======================================================================================
*/
USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimDirection
(
	DirectionId INT IDENTITY(1,1) NOT NULL,
	DirectionName NVARCHAR(100) NOT NULL,
	DirectionSortOrder INT NOT NULL,

	CONSTRAINT PK_DimDirection
		PRIMARY KEY (DirectionId),

	CONSTRAINT UQ_DimDirection_DirectionName
		UNIQUE (DirectionName)
);
GO
