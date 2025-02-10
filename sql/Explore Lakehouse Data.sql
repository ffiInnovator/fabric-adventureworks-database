-- column metadata fo a table
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dimproduct' AND COLUMN_NAME = 'FinishedGoodsFlag';

-- data timeframe on different data domains
SELECT 'Sales [Internet]' AS "Domain", MIN(OrderDate) AS "Earliest Date", MAX(OrderDate) AS "Latest Date"
FROM [dbo].[factinternetsales]
UNION
SELECT 'Sales [Reseller]' AS "Domain", MIN(OrderDate) AS "Earliest Date", MAX(OrderDate) AS "Latest Date"
FROM [dbo].[factresellersales]
UNION
SELECT 'Calls' AS "Domain", MIN(Date) AS "Earliest Date", MAX(Date) AS "Latest Date"
FROM [dbo].[factcallcenter]
UNION
SELECT 'Finance' AS "Domain", MIN(Date) AS "Earliest Date", MAX(Date) AS "Latest Date"
FROM [dbo].[factfinance]
UNION
SELECT 'Product' AS "Domain", MIN(EndDate) AS "Earliest Date", MAX(EndDate) AS "Latest Date"
FROM [dbo].[dimproduct]
UNION
SELECT 'Employee' AS "Domain", MIN(EndDate) AS "Earliest Date", MAX(EndDate) AS "Latest Date"
FROM [dbo].[dimemployee];

-- [bit]
SELECT TOP 10 [CustomerKey], [EmailAddress], [NameStyle]
FROM [dbo].[dimcustomer];

SELECT TOP 10 [ProductKey], [EnglishProductName], [FinishedGoodsFlag]
FROM [dbo].[dimproduct]
WHERE [FinishedGoodsFlag] = 'FALSE';

SELECT TOP 10 [ProductKey], [EnglishProductName], [FinishedGoodsFlag]
FROM [dbo].[slv_dimproduct]
WHERE [FinishedGoodsFlag] = 'FALSE';

-- [float]
SELECT TOP 10 [PromotionKey], [EnglishPromotionName], [DiscountPct]
FROM [dbo].[dimpromotion];

-- [decimal]
SELECT TOP 10 [ResellerKey], [BankName], [AnnualRevenue]
FROM [dbo].[dimreseller];

-- [datetime2]
SELECT TOP 10 [ProductKey], [EnglishProductName], [StartDate]
FROM [dbo].[dimproduct];

SELECT TOP 10 [ProductKey], [EnglishProductName], [StartDate], [EndDate], DATEDIFF(DAY, [StartDate], [EndDate]) AS DaysBetween
FROM [dbo].[dimproduct];

SELECT TOP 10 [ProductKey], [EnglishProductName], [StartDate], [EndDate], DATEDIFF(DAY, [StartDate], [EndDate]) AS DaysBetween
FROM [dbo].[slv_dimproduct];

-- [date] nulls issue
SELECT TOP 10 [DateKey], [EnglishDayNameOfWeek], [FullDateAlternateKey], [WeekNumberOfYear]
FROM [dbo].[dimdate];

SELECT TOP 10 [CustomerKey], [EmailAddress], [DateFirstPurchase]
FROM [dbo].[dimcustomer];

SELECT TOP 10 [CustomerKey], [CustomerPONumber], [OrderDate] -- [datetime]
FROM [dbo].[factinternetsales];