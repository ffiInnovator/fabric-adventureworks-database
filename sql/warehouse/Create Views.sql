-- ******************************************************
-- Create database views.
-- ******************************************************
PRINT '';
PRINT '*** Creating Table Views';
GO


-- vDMPrep will be used as a data source by the other data mining views.
-- Uses DW data at customer, product, day, etc. granularity and
-- gets region, model, year, month, etc.
CREATE OR ALTER VIEW [slv].[vDMPrep]
AS
    SELECT
        pc.[EnglishProductCategoryName]
        ,Coalesce(p.[ModelName], p.[EnglishProductName]) AS [Model]
        ,c.[CustomerKey]
        ,s.[SalesTerritoryGroup] AS [Region]
        ,CASE
            WHEN Month(GetDate()) < Month(c.[BirthDate])
                THEN DateDiff(yy,c.[BirthDate],GetDate()) - 1
            WHEN Month(GetDate()) = Month(c.[BirthDate])
            AND Day(GetDate()) < Day(c.[BirthDate])
                THEN DateDiff(yy,c.[BirthDate],GetDate()) - 1
            ELSE DateDiff(yy,c.[BirthDate],GetDate())
        END AS [Age]
        ,CASE
            WHEN c.[YearlyIncome] < 40000 THEN 'Low'
            WHEN c.[YearlyIncome] > 60000 THEN 'High'
            ELSE 'Moderate'
        END AS [IncomeGroup]
        ,d.[CalendarYear]
        ,d.[FiscalYear]
        ,d.[MonthNumberOfYear] AS [Month]
        ,f.[SalesOrderNumber] AS [OrderNumber]
        ,f.SalesOrderLineNumber AS LineNumber
        ,f.OrderQuantity AS Quantity
        ,f.ExtendedAmount AS Amount
    FROM
        [slv].[FactInternetSales] f
    INNER JOIN [slv].[DimDate] d
        ON f.[OrderDateKey] = d.[DateKey]
    INNER JOIN [slv].[DimProduct] p
        ON f.[ProductKey] = p.[ProductKey]
    INNER JOIN [slv].[DimProductSubcategory] psc
        ON p.[ProductSubcategoryKey] = psc.[ProductSubcategoryKey]
    INNER JOIN [slv].[DimProductCategory] pc
        ON psc.[ProductCategoryKey] = pc.[ProductCategoryKey]
    INNER JOIN [slv].[DimCustomer] c
        ON f.[CustomerKey] = c.[CustomerKey]
    INNER JOIN [slv].[DimGeography] g
        ON c.[GeographyKey] = g.[GeographyKey]
    INNER JOIN [slv].[DimSalesTerritory] s
        ON g.[SalesTerritoryKey] = s.[SalesTerritoryKey]
;

GO
/****** Object:  View [slv].[vTimeSeries]    Script Date: 7/8/2016 3:09:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- vTimeSeries view supports the creation of time series data mining models.
--      - Replaces earlier bike models with successor models.
--      - Abbreviates model names to improve readability in mining model viewer
--      - Concatenates model and region so that table only has one input.
--      - Creates a date field indexed to monthly reporting date for use in prediction.
CREATE OR ALTER VIEW [slv].[vTimeSeries]
AS
    SELECT
        CASE [Model]
            WHEN 'Mountain-100' THEN 'M200'
            WHEN 'Road-150' THEN 'R250'
            WHEN 'Road-650' THEN 'R750'
            WHEN 'Touring-1000' THEN 'T1000'
            ELSE Left([Model], 1) + Right([Model], 3)
        END + ' ' + [Region] AS [ModelRegion]
        ,(Convert(Integer, [CalendarYear]) * 100) + Convert(Integer, [Month]) AS [TimeIndex]
        ,Sum([Quantity]) AS [Quantity]
        ,Sum([Amount]) AS [Amount]
		,CalendarYear
		,[Month]
		--,[slv].[udfBuildISO8601Date] ([CalendarYear], [Month], 25)
		as ReportingDate
    FROM
        [slv].[vDMPrep]
    WHERE
        [Model] IN ('Mountain-100', 'Mountain-200', 'Road-150', 'Road-250',
            'Road-650', 'Road-750', 'Touring-1000')
    GROUP BY
        CASE [Model]
            WHEN 'Mountain-100' THEN 'M200'
            WHEN 'Road-150' THEN 'R250'
            WHEN 'Road-650' THEN 'R750'
            WHEN 'Touring-1000' THEN 'T1000'
            ELSE Left(Model,1) + Right(Model,3)
        END + ' ' + [Region]
        ,(Convert(Integer, [CalendarYear]) * 100) + Convert(Integer, [Month])
		,CalendarYear
		,[Month];
		--,[slv].[udfBuildISO8601Date] ([CalendarYear], [Month], 25);

GO
/****** Object:  View [slv].[vTargetMail]    Script Date: 7/8/2016 3:09:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- vTargetMail supports targeted mailing data model
-- Uses vDMPrep to determine if a customer buys a bike and joins to DimCustomer
CREATE OR ALTER VIEW [slv].[vTargetMail]
AS
    SELECT
        c.[CustomerKey],
        c.[GeographyKey],
        c.[CustomerAlternateKey],
        c.[Title],
        c.[FirstName],
        c.[MiddleName],
        c.[LastName],
        c.[NameStyle],
        c.[BirthDate],
        c.[MaritalStatus],
        c.[Suffix],
        c.[Gender],
        c.[EmailAddress],
        c.[YearlyIncome],
        c.[TotalChildren],
        c.[NumberChildrenAtHome],
        c.[EnglishEducation],
        c.[SpanishEducation],
        c.[FrenchEducation],
        c.[EnglishOccupation],
        c.[SpanishOccupation],
        c.[FrenchOccupation],
        c.[HouseOwnerFlag],
        c.[NumberCarsOwned],
        c.[AddressLine1],
        c.[AddressLine2],
        c.[Phone],
        c.[DateFirstPurchase],
        c.[CommuteDistance],
        x.[Region],
        x.[Age],
        CASE x.[Bikes]
            WHEN 0 THEN 0
            ELSE 1
        END AS [BikeBuyer]
    FROM
        [slv].[DimCustomer] c INNER JOIN (
            SELECT
                [CustomerKey]
                ,[Region]
                ,[Age]
                ,Sum(
                    CASE [EnglishProductCategoryName]
                        WHEN 'Bikes' THEN 1
                        ELSE 0
                    END) AS [Bikes]
            FROM
                [slv].[vDMPrep]
            GROUP BY
                [CustomerKey]
                ,[Region]
                ,[Age]
            ) AS [x]
        ON c.[CustomerKey] = x.[CustomerKey]
;
GO

/****** Object:  View [slv].[vAssocSeqOrders]    Script Date: 7/8/2016 3:09:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* vAssocSeqOrders supports assocation and sequence clustering data mmining models.
      - Limits data to FY2004.
      - Creates order case table and line item nested table.*/
CREATE OR ALTER VIEW [slv].[vAssocSeqOrders]
AS
SELECT DISTINCT OrderNumber, CustomerKey, Region, IncomeGroup
FROM         [slv].vDMPrep
WHERE     (FiscalYear = '2013')

GO
/****** Object:  View [slv].[vAssocSeqLineItems]    Script Date: 7/8/2016 3:09:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [slv].[vAssocSeqLineItems]
AS
SELECT     OrderNumber, LineNumber, Model
FROM         [slv].vDMPrep
WHERE     (FiscalYear = '2013')
GO
