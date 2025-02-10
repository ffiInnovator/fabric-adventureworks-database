-- ******************************************************
-- Add Primary Keys
--
-- SQL analytics endpoint and Warehouse in Microsoft Fabric support these table constraints:
--      PRIMARY KEY is only supported when NONCLUSTERED and NOT ENFORCED are both used.
--      FOREIGN KEY is only supported when NOT ENFORCED is used.
--      UNIQUE constraint is only supported when NONCLUSTERED and NOT ENFORCED are both used.
-- Ref: https://learn.microsoft.com/en-us/fabric/data-warehouse/table-constraints
-- ******************************************************
PRINT '';
PRINT '*** Adding Primary Keys';
GO


ALTER TABLE [dbo].[DimAccount] ADD
    CONSTRAINT [PK_DimAccount] PRIMARY KEY NONCLUSTERED
	(
	[AccountKey]
	) NOT ENFORCED;
GO


ALTER TABLE [dbo].[DimCurrency] ADD
    CONSTRAINT [PK_DimCurrency_CurrencyKey] PRIMARY KEY NONCLUSTERED
    (
       [CurrencyKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimCustomer] ADD
    CONSTRAINT [PK_DimCustomer_CustomerKey] PRIMARY KEY NONCLUSTERED
    (
        [CustomerKey]
    )  NOT ENFORCED;
GO


ALTER TABLE [dbo].[DimDate] ADD
    CONSTRAINT [PK_DimDate_DateKey] PRIMARY KEY NONCLUSTERED
    (
        [DateKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimDepartmentGroup] ADD
    CONSTRAINT [PK_DimDepartmentGroup] PRIMARY KEY NONCLUSTERED
    (
        [DepartmentGroupKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimEmployee] ADD
    CONSTRAINT [PK_DimEmployee_EmployeeKey] PRIMARY KEY NONCLUSTERED
    (
       [EmployeeKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimGeography] ADD
    CONSTRAINT [PK_DimGeography_GeographyKey] PRIMARY KEY NONCLUSTERED
    (
       [GeographyKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimOrganization] ADD
    CONSTRAINT [PK_DimOrganization] PRIMARY KEY NONCLUSTERED
    (
       [OrganizationKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimProduct] ADD
    CONSTRAINT [PK_DimProduct_ProductKey] PRIMARY KEY NONCLUSTERED
    (
        [ProductKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimProductCategory] ADD
    CONSTRAINT [PK_DimProductCategory_ProductCategoryKey] PRIMARY KEY NONCLUSTERED
    (
        [ProductCategoryKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimProductSubcategory] ADD
    CONSTRAINT [PK_DimProductSubcategory_ProductSubcategoryKey] PRIMARY KEY NONCLUSTERED
    (
        [ProductSubcategoryKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimPromotion] ADD
    CONSTRAINT [PK_DimPromotion_PromotionKey] PRIMARY KEY NONCLUSTERED
    (
       [PromotionKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimReseller] ADD
    CONSTRAINT [PK_DimReseller_ResellerKey] PRIMARY KEY NONCLUSTERED
    (
        [ResellerKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimSalesReason] ADD
    CONSTRAINT [PK_DimSalesReason_SalesReasonKey] PRIMARY KEY NONCLUSTERED
    (
        [SalesReasonKey]
    )  NOT ENFORCED;
GO


ALTER TABLE [dbo].[DimSalesTerritory] ADD
    CONSTRAINT [PK_DimSalesTerritory_SalesTerritoryKey] PRIMARY KEY NONCLUSTERED
    (
        [SalesTerritoryKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimScenario] ADD
    CONSTRAINT [PK_DimScenario] PRIMARY KEY NONCLUSTERED
    (
        [ScenarioKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactAdditionalInternationalProductDescription] ADD
    CONSTRAINT [PK_FactAdditionalInternationalProductDescription_ProductKey_CultureName] PRIMARY KEY NONCLUSTERED
    (
       [ProductKey],[CultureName]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactCallCenter] ADD
    CONSTRAINT [PK_FactCallCenter_FactCallCenterID] PRIMARY KEY NONCLUSTERED
    (
        [FactCallCenterID]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactCurrencyRate] ADD
    CONSTRAINT [PK_FactCurrencyRate_CurrencyKey_DateKey] PRIMARY KEY NONCLUSTERED
    (
      [CurrencyKey], [DateKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactInternetSales] ADD
    CONSTRAINT [PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY NONCLUSTERED
    (
        [SalesOrderNumber], [SalesOrderLineNumber]
    )  NOT ENFORCED;
GO


ALTER TABLE [dbo].[FactInternetSalesReason] ADD
    CONSTRAINT [PK_FactInternetSalesReason_SalesOrderNumber_SalesOrderLineNumber_SalesReasonKey] PRIMARY KEY NONCLUSTERED
    (
        [SalesOrderNumber], [SalesOrderLineNumber], [SalesReasonKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactProductInventory] ADD
    CONSTRAINT [PK_FactProductInventory] PRIMARY KEY NONCLUSTERED
    (
        [ProductKey], [DateKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactResellerSales] ADD
    CONSTRAINT [PK_FactResellerSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY NONCLUSTERED
    (
        [SalesOrderNumber], [SalesOrderLineNumber]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactSalesQuota] ADD
    CONSTRAINT [PK_FactSalesQuota_SalesQuotaKey] PRIMARY KEY NONCLUSTERED
    (
       [SalesQuotaKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactSurveyResponse] ADD
    CONSTRAINT [PK_FactSurveyResponse_SurveyResponseKey] PRIMARY KEY NONCLUSTERED
    (
        [SurveyResponseKey]
    )  NOT ENFORCED;
GO

ALTER TABLE [dbo].[ProspectiveBuyer] ADD
    CONSTRAINT [PK_ProspectiveBuyer_ProspectiveBuyerKey] PRIMARY KEY NONCLUSTERED
    (
        [ProspectiveBuyerKey]
    )  NOT ENFORCED;
GO