USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimDebtMetric
(
    DebtMetricId INT IDENTITY(1,1) NOT NULL,
    DebtMetricName NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_DimDebtMetric
        PRIMARY KEY (DebtMetricId),

    CONSTRAINT UQ_DimDebtMetric
        UNIQUE (DebtMetricName)
);
GO


