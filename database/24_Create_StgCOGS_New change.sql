USE FinanceAnalyticsPortfolioDB;
GO

DROP TABLE dbo.StgCOGS;
GO

EXEC sp_rename 'dbo.StgCOGS_New', 'StgCOGS';
GO

SELECT TOP 10 *
FROM dbo.StgCOGS;

EXEC sp_help 'dbo.StgCOGS';
