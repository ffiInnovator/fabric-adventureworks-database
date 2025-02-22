-- ******************************************************
-- Create tables
-- ******************************************************
PRINT '';
PRINT '*** Creating Tables';
GO

CREATE TABLE [dbo].[DimAccount](
	[AccountKey] [int] NOT NULL,
	[ParentAccountKey] [int] NULL,
	[AccountCodeAlternateKey] [int] NULL,
	[ParentAccountCodeAlternateKey] [int] NULL,
	[AccountDescription] [varchar](50) NULL,
	[AccountType] [varchar](50) NULL,
	[Operator] [varchar](50) NULL,
	[CustomMembers] [varchar](300) NULL,
	[ValueType] [varchar](50) NULL,
	[CustomMemberOptions] [varchar](200) NULL
);
GO

CREATE TABLE [dbo].[DimCurrency](
	[CurrencyKey] [int] NOT NULL,
	[CurrencyAlternateKey] [char](3) NOT NULL,
	[CurrencyName] [varchar](50) NOT NULL
);
GO

CREATE TABLE [dbo].[DimCustomer](
	[CustomerKey] [int] NOT NULL,
	[GeographyKey] [int] NULL,
	[CustomerAlternateKey] [varchar](15) NOT NULL,
	[Title] [varchar](8) NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[NameStyle] [bit] NULL,
	[BirthDate] [date] NULL,
	[MaritalStatus] [char](1) NULL,
	[Suffix] [varchar](10) NULL,
	[Gender] [varchar](1) NULL,
	[EmailAddress] [varchar](50) NULL,
	[YearlyIncome] [decimal](38, 2) NULL,
	[TotalChildren] [int] NULL,
	[NumberChildrenAtHome] [int] NULL,
	[EnglishEducation] [varchar](40) NULL,
	[SpanishEducation] [varchar](40) NULL,
	[FrenchEducation] [varchar](40) NULL,
	[EnglishOccupation] [varchar](100) NULL,
	[SpanishOccupation] [varchar](100) NULL,
	[FrenchOccupation] [varchar](100) NULL,
	[HouseOwnerFlag] [char](1) NULL,
	[NumberCarsOwned] [int] NULL,
	[AddressLine1] [varchar](120) NULL,
	[AddressLine2] [varchar](120) NULL,
	[Phone] [varchar](20) NULL,
	[DateFirstPurchase] [date] NULL,
	[CommuteDistance] [varchar](15) NULL
);
GO

CREATE TABLE [dbo].[DimDate](
	[DateKey] [int] NOT NULL,
	[FullDateAlternateKey] [date] NOT NULL,
	[DayNumberOfWeek] [int] NOT NULL,
	[EnglishDayNameOfWeek] [varchar](10) NOT NULL,
	[SpanishDayNameOfWeek] [varchar](10) NOT NULL,
	[FrenchDayNameOfWeek] [varchar](10) NOT NULL,
	[DayNumberOfMonth] [int] NOT NULL,
	[DayNumberOfYear] [int] NOT NULL,
	[WeekNumberOfYear] [int] NOT NULL,
	[EnglishMonthName] [varchar](10) NOT NULL,
	[SpanishMonthName] [varchar](10) NOT NULL,
	[FrenchMonthName] [varchar](10) NOT NULL,
	[MonthNumberOfYear] [int] NOT NULL,
	[CalendarQuarter] [int] NOT NULL,
	[CalendarYear] [int] NOT NULL,
	[CalendarSemester] [int] NOT NULL,
	[FiscalQuarter] [int] NOT NULL,
	[FiscalYear] [int] NOT NULL,
	[FiscalSemester] [int] NOT NULL
);
GO

CREATE TABLE [dbo].[DimDepartmentGroup](
	[DepartmentGroupKey] [int] NOT NULL,
	[ParentDepartmentGroupKey] [int] NULL,
	[DepartmentGroupName] [varchar](50) NULL
);
GO

CREATE TABLE [dbo].[DimEmployee](
	[EmployeeKey] [int] NOT NULL,
	[ParentEmployeeKey] [int] NULL,
	[EmployeeNationalIDAlternateKey] [varchar](15) NULL,
	[ParentEmployeeNationalIDAlternateKey] [varchar](15) NULL,
	[SalesTerritoryKey] [int] NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](50) NULL,
	[NameStyle] [bit] NOT NULL,
	[Title] [varchar](50) NULL,
	[HireDate] [date] NULL,
	[BirthDate] [date] NULL,
	[LoginID] [varchar](256) NULL,
	[EmailAddress] [varchar](50) NULL,
	[Phone] [varchar](25) NULL,
	[MaritalStatus] [char](1) NULL,
	[EmergencyContactName] [varchar](50) NULL,
	[EmergencyContactPhone] [varchar](25) NULL,
	[SalariedFlag] [bit] NULL,
	[Gender] [char](1) NULL,
	[PayFrequency] [int] NULL,
	[BaseRate] [decimal](38, 2) NULL,
	[VacationHours] [int] NULL,
	[SickLeaveHours] [int] NULL,
	[CurrentFlag] [bit] NOT NULL,
	[SalesPersonFlag] [bit] NOT NULL,
	[DepartmentName] [varchar](50) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Status] [varchar](50) NULL,
	[EmployeePhoto] [varbinary](max) NULL
);
GO

CREATE TABLE [dbo].[DimGeography](
	[GeographyKey] [int] NOT NULL,
	[City] [varchar](30) NULL,
	[StateProvinceCode] [varchar](3) NULL,
	[StateProvinceName] [varchar](50) NULL,
	[CountryRegionCode] [varchar](3) NULL,
	[EnglishCountryRegionName] [varchar](50) NULL,
	[SpanishCountryRegionName] [varchar](50) NULL,
	[FrenchCountryRegionName] [varchar](50) NULL,
	[PostalCode] [varchar](15) NULL,
	[SalesTerritoryKey] [int] NULL,
	[IpAddressLocator] [varchar](15) NULL
);
GO

CREATE TABLE [dbo].[DimOrganization](
	[OrganizationKey] [int] NOT NULL,
	[ParentOrganizationKey] [int] NULL,
	[PercentageOfOwnership] [varchar](16) NULL,
	[OrganizationName] [varchar](50) NULL,
	[CurrencyKey] [int] NULL
);
GO

CREATE TABLE [dbo].[DimProduct](
	[ProductKey] [int] NOT NULL,
	[ProductAlternateKey] [varchar](25) NULL,
	[ProductSubcategoryKey] [int] NULL,
	[WeightUnitMeasureCode] [char](3) NULL,
	[SizeUnitMeasureCode] [char](3) NULL,
	[EnglishProductName] [varchar](50) NOT NULL,
	[SpanishProductName] [varchar](50) NOT NULL,
	[FrenchProductName] [varchar](50) NOT NULL,
	[StandardCost] [decimal](38, 2) NULL,
	[FinishedGoodsFlag] [bit] NOT NULL,
	[Color] [varchar](15) NOT NULL,
	[SafetyStockLevel] [int] NULL,
	[ReorderPoint] [int] NULL,
	[ListPrice] [decimal](38, 2) NULL,
	[Size] [varchar](50) NULL,
	[SizeRange] [varchar](50) NULL,
	[Weight] [float] NULL,
	[DaysToManufacture] [int] NULL,
	[ProductLine] [char](2) NULL,
	[DealerPrice] [decimal](38, 2) NULL,
	[Class] [char](2) NULL,
	[Style] [char](2) NULL,
	[ModelName] [varchar](50) NULL,
	[LargePhoto] [varbinary](max) NULL,
	[EnglishDescription] [varchar](400) NULL,
	[FrenchDescription] [varchar](400) NULL,
	[ChineseDescription] [varchar](400) NULL,
	[ArabicDescription] [varchar](400) NULL,
	[HebrewDescription] [varchar](400) NULL,
	[ThaiDescription] [varchar](400) NULL,
	[GermanDescription] [varchar](400) NULL,
	[JapaneseDescription] [varchar](400) NULL,
	[TurkishDescription] [varchar](400) NULL,
	[StartDate] [datetime2](6) NULL,
	[EndDate] [datetime2](6) NULL,
	[Status] [varchar](7) NULL
);
GO

CREATE TABLE [dbo].[DimProductCategory](
	[ProductCategoryKey] [int] NOT NULL,
	[ProductCategoryAlternateKey] [int] NULL,
	[EnglishProductCategoryName] [varchar](50) NOT NULL,
	[SpanishProductCategoryName] [varchar](50) NOT NULL,
	[FrenchProductCategoryName] [varchar](50) NOT NULL
);
GO

CREATE TABLE [dbo].[DimProductSubcategory](
	[ProductSubcategoryKey] [int] NOT NULL,
	[ProductSubcategoryAlternateKey] [int] NULL,
	[EnglishProductSubcategoryName] [varchar](50) NOT NULL,
	[SpanishProductSubcategoryName] [varchar](50) NOT NULL,
	[FrenchProductSubcategoryName] [varchar](50) NOT NULL,
	[ProductCategoryKey] [int] NULL
);
GO

CREATE TABLE [dbo].[DimPromotion](
	[PromotionKey] [int] NOT NULL,
	[PromotionAlternateKey] [int] NULL,
	[EnglishPromotionName] [varchar](255) NULL,
	[SpanishPromotionName] [varchar](255) NULL,
	[FrenchPromotionName] [varchar](255) NULL,
	[DiscountPct] [float] NULL,
	[EnglishPromotionType] [varchar](50) NULL,
	[SpanishPromotionType] [varchar](50) NULL,
	[FrenchPromotionType] [varchar](50) NULL,
	[EnglishPromotionCategory] [varchar](50) NULL,
	[SpanishPromotionCategory] [varchar](50) NULL,
	[FrenchPromotionCategory] [varchar](50) NULL,
	[StartDate] [datetime2](6) NOT NULL,
	[EndDate] [datetime2](6) NULL,
	[MinQty] [int] NULL,
	[MaxQty] [int] NULL
);
GO

CREATE TABLE [dbo].[DimReseller](
	[ResellerKey] [int] NOT NULL,
	[GeographyKey] [int] NULL,
	[ResellerAlternateKey] [varchar](15) NULL,
	[Phone] [varchar](25) NULL,
	[BusinessType] [varchar](20) NOT NULL,
	[ResellerName] [varchar](50) NOT NULL,
	[NumberEmployees] [int] NULL,
	[OrderFrequency] [char](1) NULL,
	[OrderMonth] [int] NULL,
	[FirstOrderYear] [int] NULL,
	[LastOrderYear] [int] NULL,
	[ProductLine] [varchar](50) NULL,
	[AddressLine1] [varchar](60) NULL,
	[AddressLine2] [varchar](60) NULL,
	[AnnualSales] [decimal](38, 2) NULL,
	[BankName] [varchar](50) NULL,
	[MinPaymentType] [int] NULL,
	[MinPaymentAmount] [decimal](38, 2) NULL,
	[AnnualRevenue] [decimal](38, 2) NULL,
	[YearOpened] [int] NULL
);
GO

CREATE TABLE [dbo].[DimSalesReason](
	[SalesReasonKey] [int] NOT NULL,
	[SalesReasonAlternateKey] [int] NOT NULL,
	[SalesReasonName] [varchar](50) NOT NULL,
	[SalesReasonReasonType] [varchar](50) NOT NULL
);
GO

CREATE TABLE [dbo].[DimSalesTerritory](
	[SalesTerritoryKey] [int] NOT NULL,
	[SalesTerritoryAlternateKey] [int] NULL,
	[SalesTerritoryRegion] [varchar](50) NOT NULL,
	[SalesTerritoryCountry] [varchar](50) NOT NULL,
	[SalesTerritoryGroup] [varchar](50) NULL,
	[SalesTerritoryImage] [varbinary](max) NULL
);
GO

CREATE TABLE [dbo].[DimScenario](
	[ScenarioKey] [int] NOT NULL,
	[ScenarioName] [varchar](50) NULL
);
GO

CREATE TABLE [dbo].[FactAdditionalInternationalProductDescription](
	[ProductKey] [int] NOT NULL,
	[CultureName] [varchar](50) NOT NULL,
	[ProductDescription] [varchar](max) NOT NULL
);
GO

CREATE TABLE [dbo].[FactCallCenter](
	[FactCallCenterID] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[WageType] [varchar](15) NOT NULL,
	[Shift] [varchar](20) NOT NULL,
	[LevelOneOperators] [int] NOT NULL,
	[LevelTwoOperators] [int] NOT NULL,
	[TotalOperators] [int] NOT NULL,
	[Calls] [int] NOT NULL,
	[AutomaticResponses] [int] NOT NULL,
	[Orders] [int] NOT NULL,
	[IssuesRaised] [int] NOT NULL,
	[AverageTimePerIssue] [int] NOT NULL,
	[ServiceGrade] [float] NOT NULL,
	[Date] [datetime2](6) NULL
);
GO

CREATE TABLE [dbo].[FactCurrencyRate](
	[CurrencyKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[AverageRate] [float] NOT NULL,
	[EndOfDayRate] [float] NOT NULL,
	[Date] [datetime2](6) NULL
);
GO

CREATE TABLE [dbo].[FactFinance](
	[FinanceKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[OrganizationKey] [int] NOT NULL,
	[DepartmentGroupKey] [int] NOT NULL,
	[ScenarioKey] [int] NOT NULL,
	[AccountKey] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[Date] [datetime2](6) NULL
);
GO

CREATE TABLE [dbo].[FactInternetSales](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[ShipDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[CurrencyKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[SalesOrderNumber] [varchar](20) NOT NULL,
	[SalesOrderLineNumber] [int] NOT NULL,
	[RevisionNumber] [int] NOT NULL,
	[OrderQuantity] [int] NOT NULL,
	[UnitPrice] [decimal](38, 2) NOT NULL,
	[ExtendedAmount] [decimal](38, 2) NOT NULL,
	[UnitPriceDiscountPct] [float] NOT NULL,
	[DiscountAmount] [float] NOT NULL,
	[ProductStandardCost] [decimal](38, 2) NOT NULL,
	[TotalProductCost] [decimal](38, 2) NOT NULL,
	[SalesAmount] [decimal](38, 2) NOT NULL,
	[TaxAmt] [decimal](38, 2) NOT NULL,
	[Freight] [decimal](38, 2) NOT NULL,
	[CarrierTrackingNumber] [varchar](25) NULL,
	[CustomerPONumber] [varchar](25) NULL,
	[OrderDate] [datetime2](6) NULL,
	[DueDate] [datetime2](6) NULL,
	[ShipDate] [datetime2](6) NULL
);
GO

CREATE TABLE [dbo].[FactInternetSalesReason](
	[SalesOrderNumber] [varchar](20) NOT NULL,
	[SalesOrderLineNumber] [int] NOT NULL,
	[SalesReasonKey] [int] NOT NULL
);
GO

CREATE TABLE [dbo].[FactProductInventory](
	[ProductKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[MovementDate] [date] NOT NULL,
	[UnitCost] [decimal](38, 2) NOT NULL,
	[UnitsIn] [int] NOT NULL,
	[UnitsOut] [int] NOT NULL,
	[UnitsBalance] [int] NOT NULL
);
GO

CREATE TABLE [dbo].[FactResellerSales](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[ShipDateKey] [int] NOT NULL,
	[ResellerKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[CurrencyKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[SalesOrderNumber] [varchar](20) NOT NULL,
	[SalesOrderLineNumber] [int] NOT NULL,
	[RevisionNumber] [int] NULL,
	[OrderQuantity] [int] NULL,
	[UnitPrice] [decimal](38, 2) NULL,
	[ExtendedAmount] [decimal](38, 2) NULL,
	[UnitPriceDiscountPct] [float] NULL,
	[DiscountAmount] [float] NULL,
	[ProductStandardCost] [decimal](38, 2) NULL,
	[TotalProductCost] [decimal](38, 2) NULL,
	[SalesAmount] [decimal](38, 2) NULL,
	[TaxAmt] [decimal](38, 2) NULL,
	[Freight] [decimal](38, 2) NULL,
	[CarrierTrackingNumber] [varchar](25) NULL,
	[CustomerPONumber] [varchar](25) NULL,
	[OrderDate] [datetime2](6) NULL,
	[DueDate] [datetime2](6) NULL,
	[ShipDate] [datetime2](6) NULL
);
GO

CREATE TABLE [dbo].[FactSalesQuota](
	[SalesQuotaKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[CalendarYear] [int] NOT NULL,
	[CalendarQuarter] [int] NOT NULL,
	[SalesAmountQuota] [decimal](38, 2) NOT NULL,
	[Date] [datetime2](6) NULL
);
GO

CREATE TABLE [dbo].[FactSurveyResponse](
	[SurveyResponseKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ProductCategoryKey] [int] NOT NULL,
	[EnglishProductCategoryName] [varchar](50) NOT NULL,
	[ProductSubcategoryKey] [int] NOT NULL,
	[EnglishProductSubcategoryName] [varchar](50) NOT NULL,
	[Date] [datetime2](6) NULL
);
GO

CREATE TABLE [dbo].[NewFactCurrencyRate](
	[AverageRate] [real] NULL,
	[CurrencyID] [varchar](3) NULL,
	[CurrencyDate] [date] NULL,
	[EndOfDayRate] [real] NULL,
	[CurrencyKey] [int] NULL,
	[DateKey] [int] NULL
);
GO

CREATE TABLE [dbo].[ProspectiveBuyer](
	[ProspectiveBuyerKey] [int] NOT NULL,
	[ProspectAlternateKey] [varchar](15) NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[BirthDate] [datetime2](6) NULL,
	[MaritalStatus] [char](1) NULL,
	[Gender] [varchar](1) NULL,
	[EmailAddress] [varchar](50) NULL,
	[YearlyIncome] [decimal](38, 2) NULL,
	[TotalChildren] [int] NULL,
	[NumberChildrenAtHome] [int] NULL,
	[Education] [varchar](40) NULL,
	[Occupation] [varchar](100) NULL,
	[HouseOwnerFlag] [char](1) NULL,
	[NumberCarsOwned] [int] NULL,
	[AddressLine1] [varchar](120) NULL,
	[AddressLine2] [varchar](120) NULL,
	[City] [varchar](30) NULL,
	[StateProvinceCode] [varchar](3) NULL,
	[PostalCode] [varchar](15) NULL,
	[Phone] [varchar](20) NULL,
	[Salutation] [varchar](8) NULL,
	[Unknown] [int] NULL
);
GO