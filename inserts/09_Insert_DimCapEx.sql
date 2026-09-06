INSERT INTO dbo.DimCapEx
(
    CapExCategory,
    CapExItem
)
VALUES
    ('Production Equipment', 'Machinery'),
    ('Production Equipment', 'Tools'),
    ('Infrastructure', 'Building'),
    ('IT', 'Hardware'),
    ('Other', 'Other CapEx');
GO

SELECT *
FROM dbo.DimCapEx
ORDER BY
    CapExCategory,
    CapExItem;
    
