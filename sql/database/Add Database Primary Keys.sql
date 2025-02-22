-- ******************************************************
-- Add Primary Keys
-- ******************************************************
PRINT '';
PRINT '*** Adding Primary Keys';
GO

SET QUOTED_IDENTIFIER ON;


ALTER TABLE [dbo].[DimAccount] WITH CHECK ADD
    CONSTRAINT [PK_DimAccount] PRIMARY KEY CLUSTERED
	(
	[AccountKey]
	);
GO


ALTER TABLE [dbo].[DimCurrency] WITH CHECK ADD
    CONSTRAINT [PK_DimCurrency_CurrencyKey] PRIMARY KEY CLUSTERED
    (
       [CurrencyKey]
    );
GO

ALTER TABLE [dbo].[DimCustomer] WITH CHECK ADD
    CONSTRAINT [PK_DimCustomer_CustomerKey] PRIMARY KEY CLUSTERED
    (
        [CustomerKey]
    );
GO


ALTER TABLE [dbo].[DimDate] WITH CHECK ADD
    CONSTRAINT [PK_DimDate_DateKey] PRIMARY KEY CLUSTERED
    (
        [DateKey]
    );
GO

ALTER TABLE [dbo].[DimDepartmentGroup] WITH CHECK ADD
    CONSTRAINT [PK_DimDepartmentGroup] PRIMARY KEY CLUSTERED
    (
        [DepartmentGroupKey]
    );
GO

ALTER TABLE [dbo].[DimEmployee] WITH CHECK ADD
    CONSTRAINT [PK_DimEmployee_EmployeeKey] PRIMARY KEY CLUSTERED
    (
       [EmployeeKey]
    );
GO

ALTER TABLE [dbo].[DimGeography] WITH CHECK ADD
    CONSTRAINT [PK_DimGeography_GeographyKey] PRIMARY KEY CLUSTERED
    (
       [GeographyKey]
    );
GO

ALTER TABLE [dbo].[DimOrganization] WITH CHECK ADD
    CONSTRAINT [PK_DimOrganization] PRIMARY KEY CLUSTERED
    (
       [OrganizationKey]
    );
GO

ALTER TABLE [dbo].[DimProduct] WITH CHECK ADD
    CONSTRAINT [PK_DimProduct_ProductKey] PRIMARY KEY CLUSTERED
    (
        [ProductKey]
    );
GO

ALTER TABLE [dbo].[DimProductCategory] WITH CHECK ADD
    CONSTRAINT [PK_DimProductCategory_ProductCategoryKey] PRIMARY KEY CLUSTERED
    (
        [ProductCategoryKey]
    );
GO

ALTER TABLE [dbo].[DimProductSubcategory] WITH CHECK ADD
    CONSTRAINT [PK_DimProductSubcategory_ProductSubcategoryKey] PRIMARY KEY CLUSTERED
    (
        [ProductSubcategoryKey]
    );
GO

ALTER TABLE [dbo].[DimPromotion] WITH CHECK ADD
    CONSTRAINT [PK_DimPromotion_PromotionKey] PRIMARY KEY CLUSTERED
    (
       [PromotionKey]
    );
GO

ALTER TABLE [dbo].[DimReseller] WITH CHECK ADD
    CONSTRAINT [PK_DimReseller_ResellerKey] PRIMARY KEY CLUSTERED
    (
        [ResellerKey]
    );
GO

ALTER TABLE [dbo].[DimSalesReason] WITH CHECK ADD
    CONSTRAINT [PK_DimSalesReason_SalesReasonKey] PRIMARY KEY CLUSTERED
    (
        [SalesReasonKey]
    );
GO

ALTER TABLE [dbo].[DimSalesTerritory] WITH CHECK ADD
    CONSTRAINT [PK_DimSalesTerritory_SalesTerritoryKey] PRIMARY KEY CLUSTERED
    (
        [SalesTerritoryKey]
    );
GO

ALTER TABLE [dbo].[DimScenario] WITH CHECK ADD
    CONSTRAINT [PK_DimScenario] PRIMARY KEY CLUSTERED
    (
        [ScenarioKey]
    );
GO

-- NVARCHAR(MAX) INVALID TYPE FOR USE AS A PRIMARY KEY
ALTER TABLE FactAdditionalInternationalProductDescription ALTER COLUMN CultureName NVARCHAR(50) NOT NULL;
ALTER TABLE [dbo].[FactAdditionalInternationalProductDescription] WITH CHECK ADD
    CONSTRAINT [PK_FactAdditionalInternationalProductDescription_ProductKey_CultureName] PRIMARY KEY CLUSTERED
    (
       [ProductKey],[CultureName]
    );
GO

ALTER TABLE [dbo].[FactCallCenter] WITH CHECK ADD
    CONSTRAINT [PK_FactCallCenter_FactCallCenterID] PRIMARY KEY CLUSTERED
    (
        [FactCallCenterID]
    );
GO

ALTER TABLE [dbo].[FactCurrencyRate] WITH CHECK ADD
    CONSTRAINT [PK_FactCurrencyRate_CurrencyKey_DateKey] PRIMARY KEY CLUSTERED
    (
      [CurrencyKey], [DateKey]
    );
GO

-- NVARCHAR(MAX) INVALID TYPE FOR USE AS A PRIMARY KEY
ALTER TABLE [dbo].[FactInternetSales] ALTER COLUMN [SalesOrderNumber] NVARCHAR(20) NOT NULL;
ALTER TABLE [dbo].[FactInternetSales] WITH CHECK ADD
    CONSTRAINT [PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED
    (
        [SalesOrderNumber], [SalesOrderLineNumber]
    );
GO

-- NVARCHAR(MAX) INVALID TYPE FOR USE AS A PRIMARY KEY
ALTER TABLE [dbo].[FactInternetSalesReason] ALTER COLUMN [SalesOrderNumber] NVARCHAR(20) NOT NULL;
ALTER TABLE [dbo].[FactInternetSalesReason] WITH CHECK ADD
    CONSTRAINT [PK_FactInternetSalesReason_SalesOrderNumber_SalesOrderLineNumber_SalesReasonKey] PRIMARY KEY CLUSTERED
    (
        [SalesOrderNumber], [SalesOrderLineNumber], [SalesReasonKey]
    );
GO

ALTER TABLE [dbo].[FactProductInventory] WITH CHECK ADD
    CONSTRAINT [PK_FactProductInventory] PRIMARY KEY CLUSTERED
    (
        [ProductKey], [DateKey]
    );
GO

-- NVARCHAR(MAX) INVALID TYPE FOR USE AS A PRIMARY KEY
ALTER TABLE [dbo].[FactResellerSales] ALTER COLUMN [SalesOrderNumber] NVARCHAR(20) NOT NULL;
ALTER TABLE [dbo].[FactResellerSales] WITH CHECK ADD
    CONSTRAINT [PK_FactResellerSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED
    (
        [SalesOrderNumber], [SalesOrderLineNumber]
    );
GO

ALTER TABLE [dbo].[FactSalesQuota] WITH CHECK ADD
    CONSTRAINT [PK_FactSalesQuota_SalesQuotaKey] PRIMARY KEY CLUSTERED
    (
       [SalesQuotaKey]
    );
GO

ALTER TABLE [dbo].[FactSurveyResponse] WITH CHECK ADD
    CONSTRAINT [PK_FactSurveyResponse_SurveyResponseKey] PRIMARY KEY CLUSTERED
    (
        [SurveyResponseKey]
    );
GO

ALTER TABLE [dbo].[ProspectiveBuyer] WITH CHECK ADD
    CONSTRAINT [PK_ProspectiveBuyer_ProspectiveBuyerKey] PRIMARY KEY CLUSTERED
    (
        [ProspectiveBuyerKey]
    );
GO
