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


-- foreign key constraints for TMDL creation
WITH RelationshipCounts AS (
    SELECT 
        fk.name AS FK_Name, fk_tab.name AS FK_Table, c1.name AS FK_Column, pk.name AS PK_Table, c2.name AS PK_Column,
        CASE 
            -- One-to-One: FK column has a unique index AND PK column has a unique index
            WHEN fk_is_unique.index_id IS NOT NULL AND pk_is_unique.index_id IS NOT NULL THEN 'One-to-One'
            -- Many-to-One: FK is NOT unique, but PK has a unique index
            WHEN pk_is_unique.index_id IS NOT NULL THEN 'Many-to-One'
            -- Many-to-Many: Neither FK nor PK have unique constraints
            ELSE 'Many-to-Many'
        END AS Cardinality,
        COUNT(*) OVER (PARTITION BY pk.name, c2.name) AS PK_Reference_Count
    FROM sys.foreign_keys AS fk
    JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
    JOIN sys.tables AS fk_tab ON fk_tab.object_id = fkc.parent_object_id
    JOIN sys.columns AS c1 ON fkc.parent_column_id = c1.column_id 
        AND fkc.parent_object_id = c1.object_id
    JOIN sys.tables AS pk ON pk.object_id = fkc.referenced_object_id
    JOIN sys.columns AS c2 ON fkc.referenced_column_id = c2.column_id 
        AND fkc.referenced_object_id = c2.object_id
    -- Check if the referenced (PK) column is unique
    LEFT JOIN sys.index_columns AS pk_index_cols ON c2.object_id = pk_index_cols.object_id 
        AND c2.column_id = pk_index_cols.column_id
    LEFT JOIN sys.indexes AS pk_is_unique ON pk_index_cols.object_id = pk_is_unique.object_id 
        AND pk_index_cols.index_id = pk_is_unique.index_id 
        AND pk_is_unique.is_unique = 1  
        AND pk_is_unique.type IN (1, 2) -- Clustered or Non-clustered Unique Index
    -- Check if the foreign key (FK) column is unique
    LEFT JOIN sys.index_columns AS fk_index_cols ON c1.object_id = fk_index_cols.object_id 
        AND c1.column_id = fk_index_cols.column_id
    LEFT JOIN sys.indexes AS fk_is_unique ON fk_index_cols.object_id = fk_is_unique.object_id 
        AND fk_index_cols.index_id = fk_is_unique.index_id 
        AND fk_is_unique.is_unique = 1  
        AND fk_is_unique.type IN (1, 2) -- Clustered or Non-clustered Unique Index
)
SELECT 
    FK_Name, FK_Table, FK_Column, PK_Table, PK_Column, Cardinality
FROM RelationshipCounts
WHERE Cardinality = 'Many-to-One' 
AND PK_Reference_Count > 1
AND FK_Table = 'FactInternetSales' AND PK_Table = 'DimDate'    
ORDER BY FK_Name, PK_Table, PK_Column;


-- generate ADDs for not null constraints
SELECT ('ALTER TABLE [' +  TABLE_SCHEMA 
    + '].[' + TABLE_NAME + '] ALTER COLUMN [' 
    + COLUMN_NAME + '] ' + DATA_TYPE
    + ' NOT NULL;'
) AS stmt
FROM
    (SELECT 
        TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE, ORDINAL_POSITION,
        CASE 
            WHEN IS_NULLABLE = 'YES' THEN 'NULL'
            ELSE 'NOT NULL'
        END AS Nullability
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE IS_NULLABLE = 'NO'
        AND TABLE_SCHEMA = 'dbo'
    ) a
ORDER BY a.TABLE_NAME, a.COLUMN_NAME;


-- generate DROPs for foreign key constraints
SELECT 'ALTER TABLE [' + s.name + '].[' + OBJECT_NAME(f.parent_object_id) + '] DROP CONSTRAINT [' + f.name + '];' AS DropStmt
FROM sys.foreign_keys f
JOIN sys.tables t ON f.referenced_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo'
AND t.name = 'DimAccount'
ORDER BY  OBJECT_NAME(f.parent_object_id);
GO


-- show some data with the transformed columns
SELECT TOP 10 [ProductKey], [EnglishProductName],[StartDate]
            , [StandardCost], [FinishedGoodsFlag], [LargePhoto]
FROM [dbo].[DimProduct];
