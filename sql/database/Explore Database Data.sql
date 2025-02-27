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
SELECT s.name AS SchemaName, OBJECT_NAME([f.parent_object_id]) TableName, f.name AS ForeignKeyName
FROM sys.foreign_keys f
JOIN sys.tables t ON f.referenced_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo'
AND t.name = 'FactInternetSales'
ORDER BY  OBJECT_NAME([f.parent_object_id]);
GO


-- foreign key constraint details
SELECT 
    sch_from.name AS SchemaName,
    t_from.name AS FromTableName,
    col_from.name AS FromColumnName,
    fk.name AS ForeignKeyName,
    sch_to.name AS ToSchemaName,
    t_to.name AS ToTableName,
    col_to.name AS ToColumnName
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables t_from ON t_from.object_id = fk.parent_object_id
JOIN sys.schemas sch_from ON t_from.schema_id = sch_from.schema_id
JOIN sys.columns col_from ON fkc.parent_object_id = col_from.object_id AND fkc.parent_column_id = col_from.column_id
JOIN sys.tables t_to ON t_to.object_id = fk.referenced_object_id
JOIN sys.schemas sch_to ON t_to.schema_id = sch_to.schema_id
JOIN sys.columns col_to ON fkc.referenced_object_id = col_to.object_id AND fkc.referenced_column_id = col_to.column_id
WHERE sch_from.name = 'dbo'
AND t_from.name = 'FactInternetSales'
AND t_to.name = 'DimDate'
ORDER BY SchemaName, FromTableName, ForeignKeyName;


-- foreign key contraints with multiple columns to the same target table
WITH ForeignKeyCounts AS ([
    SELECT 
        sch_from.name AS SchemaName,
        t_from.name AS FromTableName,
        t_to.name AS ToTableName,
        COUNT([*]) AS ForeignKeyCount
    FROM sys.foreign_keys fk
    JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    JOIN sys.tables t_from ON t_from.object_id = fk.parent_object_id
    JOIN sys.schemas sch_from ON t_from.schema_id = sch_from.schema_id
    JOIN sys.tables t_to ON t_to.object_id = fk.referenced_object_id
    JOIN sys.schemas sch_to ON t_to.schema_id = sch_to.schema_id
    WHERE sch_from.name = 'dbo'
    GROUP BY sch_from.name, t_from.name, t_to.name
    HAVING COUNT([*]) > 1
])
SELECT 
    sch_from.name AS SchemaName,
    t_from.name AS FromTableName,
    col_from.name AS FromColumnName,
    fk.name AS ForeignKeyName,
    sch_to.name AS ToSchemaName,
    t_to.name AS ToTableName,
    col_to.name AS ToColumnName
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables t_from ON t_from.object_id = fk.parent_object_id
JOIN sys.schemas sch_from ON t_from.schema_id = sch_from.schema_id
JOIN sys.columns col_from ON fkc.parent_object_id = col_from.object_id AND fkc.parent_column_id = col_from.column_id
JOIN sys.tables t_to ON t_to.object_id = fk.referenced_object_id
JOIN sys.schemas sch_to ON t_to.schema_id = sch_to.schema_id
JOIN sys.columns col_to ON fkc.referenced_object_id = col_to.object_id AND fkc.referenced_column_id = col_to.column_id
JOIN ForeignKeyCounts fkc_counts ON t_from.name = fkc_counts.FromTableName AND t_to.name = fkc_counts.ToTableName
WHERE sch_from.name = 'dbo'
ORDER BY FromTableName, ToTableName, ForeignKeyName;


-- show some data with the transformed columns
SELECT TOP 10 [ProductKey], [EnglishProductName],[StartDate]
            , [StandardCost], [FinishedGoodsFlag], [LargePhotoUrl]
FROM [dbo].[DimProduct];


-- check for nulls
SELECT *
FROM [dbo].[DimCurrency]
WHERE [CurrencyAlternateKey] = '';


-- check date timeframes
SELECT 'Sales [Internet]' AS "Domain", MIN([OrderDate]) AS "Earliest Date", MAX([OrderDate]) AS "Latest Date"
FROM [dbo].[FactInternetSales]
UNION
SELECT 'Sales [Reseller]' AS "Domain", MIN([OrderDate]) AS "Earliest Date", MAX([OrderDate]) AS "Latest Date"
FROM [dbo].[FactResellerSales]
UNION
SELECT 'Calls' AS "Domain", MIN([Date]) AS "Earliest Date", MAX([Date]) AS "Latest Date"
FROM [dbo].[FactCallCenter]
UNION
SELECT 'Finance' AS "Domain", MIN([Date]) AS "Earliest Date", MAX([Date]) AS "Latest Date"
FROM [dbo].[FactFinance]
UNION
SELECT 'Product' AS "Domain", MIN([EndDate]) AS "Earliest Date", MAX([EndDate]) AS "Latest Date"
FROM [dbo].[DimProduct]
UNION
SELECT 'Employee' AS "Domain", MIN([EndDate]) AS "Earliest Date", MAX([EndDate]) AS "Latest Date"
FROM [dbo].[DimEmployee]
UNION
SELECT 'Date' AS "Domain", MIN([FullDateAlternateKey]) AS "Earliest Date", MAX([FullDateAlternateKey]) AS "Latest Date"
FROM [dbo].[DimDate];


-- check date keys
SELECT 'Sales [Internet]' AS "Domain", MIN([OrderDateKey]) AS "Earliest Date key", MAX([OrderDateKey]) AS "Latest Date Key"
FROM [dbo].[FactInternetSales]
UNION
SELECT 'Date' AS "Domain", MIN([DateKey]) AS "Earliest Date Key", MAX([DateKey]) AS "Latest Date Key"
FROM [dbo].[DimDate];