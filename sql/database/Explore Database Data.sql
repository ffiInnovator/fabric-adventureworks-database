-- table metadata
SELECT  *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'dbo'
    AND TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- column metadata for a table
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FactInternetSales'
    AND COLUMN_NAME = 'SalesOrderNumber';

-- not null constraints
SELECT 
    TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE, ORDINAL_POSITION,
    CASE 
        WHEN IS_NULLABLE = 'YES' THEN 'NULL'
        ELSE 'NOT NULL'
    END AS Nullability
FROM INFORMATION_SCHEMA.COLUMNS
WHERE IS_NULLABLE = 'NO'
    AND TABLE_SCHEMA = 'dbo';

-- primary keys
SELECT 
    tc.TABLE_NAME AS TableName, 
    kcu.COLUMN_NAME AS ColumnName, 
    c.DATA_TYPE AS DataType
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
JOIN INFORMATION_SCHEMA.COLUMNS AS c 
    ON kcu.TABLE_NAME = c.TABLE_NAME 
    AND kcu.COLUMN_NAME = c.COLUMN_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY TableName, ColumnName;

-- foreign key constraints
SELECT s.name AS SchemaName, OBJECT_NAME(f.parent_object_id) TableName, f.name AS ForeignKeyName
FROM sys.foreign_keys f
JOIN sys.tables t ON f.referenced_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo'
AND t.name = 'DimAccount'
ORDER BY  OBJECT_NAME(f.parent_object_id);
GO

-- foreign key constraint columns
SELECT 
    sch.name AS SchemaName,
    t.name AS TableName,
    col.name AS ColumnName,
    fk.name AS ForeignKeyName
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables t ON t.object_id = fk.parent_object_id
JOIN sys.schemas sch ON t.schema_id = sch.schema_id
JOIN sys.columns col ON fkc.parent_object_id = col.object_id AND fkc.parent_column_id = col.column_id
--WHERE sch.name = 'dbo'
--AND t.name = 'DimAccount'
ORDER BY SchemaName, TableName, ForeignKeyName;

-- show some data with the transformed columns
SELECT TOP 10 [ProductKey], [EnglishProductName],[StartDate]
            , [StandardCost], [FinishedGoodsFlag], [LargePhotoUrl]
FROM [dbo].[DimProduct];

-- check for nulls
SELECT *
FROM [dbo].[DimCurrency]
WHERE [CurrencyAlternateKey] = '';

