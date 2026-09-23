USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.DimCapEx
(
    CapExId INT IDENTITY(1,1) NOT NULL,
    CapExCategory NVARCHAR(100) NOT NULL,
    CapExItem NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_DimCapEx
        Primary KEY(CapExId),

    CONSTRAINT UQ_DimCapEx
        UNIQUE (CapExCategory, CapExItem)    
);
GO


