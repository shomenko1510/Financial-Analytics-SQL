CREATE TABLE dbo.DimDirection
(
	DirectionId INT IDENTITY(1,1) NOT NULL,
	DirectionName NVARCHAR(100) NOT NULL,
	SortOrder INT NOT NULL,

	CONSTRAINT PK_DimDirection
		PRIMARY KEY (DirectionId),

	CONSTRAINT UQ_DimDirection_DirectionName
		UNIQUE (DirectionName)
);
GO
