-- ****************************************
-- Create Foreign key constraints
--
-- SQL analytics endpoint and Warehouse in Microsoft Fabric support these table constraints:
--      PRIMARY KEY is only supported when NONCLUSTERED and NOT ENFORCED are both used.
--      FOREIGN KEY is only supported when NOT ENFORCED is used.
--      UNIQUE constraint is only supported when NONCLUSTERED and NOT ENFORCED are both used.
-- Ref: https://learn.microsoft.com/en-us/fabric/data-warehouse/table-constraints
-- ****************************************
PRINT '';
PRINT '*** Creating Foreign Key Constraints';
GO

ALTER TABLE [dbo].[DimAccount] ADD
    CONSTRAINT [FK_DimAccount_DimAccount] FOREIGN KEY
    (
        [ParentAccountKey]
    ) REFERENCES [dbo].[DimAccount] ([AccountKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimCustomer] ADD
	CONSTRAINT [FK_DimCustomer_DimGeography] FOREIGN KEY
	(
		[GeographyKey]
	)
	REFERENCES [dbo].[DimGeography] ([GeographyKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimDepartmentGroup] ADD
    CONSTRAINT [FK_DimDepartmentGroup_DimDepartmentGroup] FOREIGN KEY
    (
        [ParentDepartmentGroupKey]
    ) REFERENCES [dbo].[DimDepartmentGroup] ([DepartmentGroupKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimEmployee] ADD
    CONSTRAINT [FK_DimEmployee_DimSalesTerritory] FOREIGN KEY
    (
        [SalesTerritoryKey]
    ) REFERENCES [dbo].[DimSalesTerritory] ([SalesTerritoryKey]) NOT ENFORCED,
	CONSTRAINT [FK_DimEmployee_DimEmployee] FOREIGN KEY
    (
        [ParentEmployeeKey]
    ) REFERENCES [dbo].[DimEmployee] ([EmployeeKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimGeography] ADD
    CONSTRAINT [FK_DimGeography_DimSalesTerritory]  FOREIGN KEY
    (
        [SalesTerritoryKey]
    ) REFERENCES [dbo].[DimSalesTerritory] ([SalesTerritoryKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimOrganization] ADD
    CONSTRAINT [FK_DimOrganization_DimCurrency] FOREIGN KEY
    (
        [CurrencyKey]
    ) REFERENCES [dbo].[DimCurrency] ([CurrencyKey]) NOT ENFORCED,
    CONSTRAINT [FK_DimOrganization_DimOrganization] FOREIGN KEY
    (
        [ParentOrganizationKey]
    )REFERENCES [dbo].[DimOrganization] ([OrganizationKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimProduct] ADD
    CONSTRAINT [FK_DimProduct_DimProductSubcategory] FOREIGN KEY
    (
        [ProductSubcategoryKey]
    ) REFERENCES [dbo].[DimProductSubcategory] ([ProductSubcategoryKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimProductSubcategory] ADD
    CONSTRAINT [FK_DimProductSubcategory_DimProductCategory] FOREIGN KEY
    (
        [ProductCategoryKey]
    ) REFERENCES [dbo].[DimProductCategory] ([ProductCategoryKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[DimReseller] ADD
	CONSTRAINT [FK_DimReseller_DimGeography] FOREIGN KEY
	(
		[GeographyKey]
	) REFERENCES [dbo].[DimGeography] ([GeographyKey]) NOT ENFORCED;
GO


ALTER TABLE [dbo].[FactCallCenter] ADD
    CONSTRAINT [FK_FactCallCenter_DimDate] FOREIGN KEY
    (
        [DateKey]
    ) REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactCurrencyRate] ADD
    CONSTRAINT [FK_FactCurrencyRate_DimDate] FOREIGN KEY
    (
       [DateKey]
    ) REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactCurrencyRate_DimCurrency] FOREIGN KEY
    (
       [CurrencyKey]
    ) REFERENCES [dbo].[DimCurrency] ([CurrencyKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactFinance] ADD
    CONSTRAINT [FK_FactFinance_DimScenario] FOREIGN KEY
    (
        [ScenarioKey]
    ) REFERENCES [dbo].[DimScenario] ([ScenarioKey]) NOT ENFORCED,
    CONSTRAINT [FK_FactFinance_DimOrganization] FOREIGN KEY
    (
        [OrganizationKey]
    ) REFERENCES [dbo].[DimOrganization] ([OrganizationKey]) NOT ENFORCED,
    CONSTRAINT [FK_FactFinance_DimDepartmentGroup] FOREIGN KEY
    (
        [DepartmentGroupKey]
    ) REFERENCES [dbo].[DimDepartmentGroup] ([DepartmentGroupKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactFinance_DimDate] FOREIGN KEY
    (
        [DateKey]
    ) REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactFinance_DimAccount] FOREIGN KEY
    (
        [AccountKey]
    ) REFERENCES [dbo].[DimAccount] ([AccountKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactInternetSales] ADD
    CONSTRAINT [FK_FactInternetSales_DimCurrency] FOREIGN KEY
    (
        [CurrencyKey]
    ) REFERENCES [dbo].[DimCurrency] ([CurrencyKey]) NOT ENFORCED,
	 CONSTRAINT [FK_FactInternetSales_DimCustomer] FOREIGN KEY
    (
        [CustomerKey]
    ) REFERENCES [dbo].[DimCustomer] ([CustomerKey]) NOT ENFORCED,
	 CONSTRAINT [FK_FactInternetSales_DimDate] FOREIGN KEY
    (
        [OrderDateKey]
    ) REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	 CONSTRAINT [FK_FactInternetSales_DimDate1] FOREIGN KEY
    (
        [DueDateKey]
    ) REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	 CONSTRAINT [FK_FactInternetSales_DimDate2] FOREIGN KEY
    (
        [ShipDateKey]
    ) REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	 CONSTRAINT [FK_FactInternetSales_DimProduct] FOREIGN KEY
    (
        [ProductKey]
    ) REFERENCES [dbo].[DimProduct] ([ProductKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactInternetSales_DimPromotion] FOREIGN KEY
    (
        [PromotionKey]
    ) REFERENCES [dbo].[DimPromotion] ([PromotionKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactInternetSales_DimSalesTerritory] FOREIGN KEY
    (
        [SalesTerritoryKey]
    ) REFERENCES [dbo].[DimSalesTerritory] ([SalesTerritoryKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactInternetSalesReason] ADD
    CONSTRAINT [FK_FactInternetSalesReason_FactInternetSales] FOREIGN KEY
    (
        [SalesOrderNumber], [SalesOrderLineNumber]
    ) REFERENCES [dbo].[FactInternetSales] ([SalesOrderNumber], [SalesOrderLineNumber]) NOT ENFORCED,
	CONSTRAINT [FK_FactInternetSalesReason_DimSalesReason] FOREIGN KEY
	(
		[SalesReasonKey]
	) REFERENCES [dbo].[DimSalesReason] ([SalesReasonKey]) NOT ENFORCED;
GO


ALTER TABLE [dbo].[FactProductInventory] ADD
    CONSTRAINT [FK_FactProductInventory_DimDate] FOREIGN KEY
    (
        [DateKey]
    )REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactProductInventory_DimProduct] FOREIGN KEY
	(
		[ProductKey]
	) REFERENCES [dbo].[DimProduct] ([ProductKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactResellerSales] ADD
    CONSTRAINT [FK_FactResellerSales_DimCurrency] FOREIGN KEY([CurrencyKey])
			REFERENCES [dbo].[DimCurrency] ([CurrencyKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimDate] FOREIGN KEY([OrderDateKey])
			REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimDate1] FOREIGN KEY([DueDateKey])
			REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimDate2] FOREIGN KEY([ShipDateKey])
			REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimEmployee] FOREIGN KEY([EmployeeKey])
			REFERENCES [dbo].[DimEmployee] ([EmployeeKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimProduct] FOREIGN KEY([ProductKey])
			REFERENCES [dbo].[DimProduct] ([ProductKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimPromotion] FOREIGN KEY([PromotionKey])
			REFERENCES [dbo].[DimPromotion] ([PromotionKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimReseller] FOREIGN KEY([ResellerKey])
			REFERENCES [dbo].[DimReseller] ([ResellerKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactResellerSales_DimSalesTerritory] FOREIGN KEY([SalesTerritoryKey])
			REFERENCES [dbo].[DimSalesTerritory] ([SalesTerritoryKey]) NOT ENFORCED;
GO

ALTER TABLE [dbo].[FactSalesQuota] ADD
    CONSTRAINT [FK_FactSalesQuota_DimEmployee] FOREIGN KEY([EmployeeKey])
			REFERENCES [dbo].[DimEmployee] ([EmployeeKey]) NOT ENFORCED,
    CONSTRAINT [FK_FactSalesQuota_DimDate] FOREIGN KEY([DateKey])
			REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED;
GO


ALTER TABLE [dbo].[FactSurveyResponse]  ADD
    CONSTRAINT [FK_FactSurveyResponse_DateKey] FOREIGN KEY([DateKey])
			REFERENCES [dbo].[DimDate] ([DateKey]) NOT ENFORCED,
	CONSTRAINT [FK_FactSurveyResponse_CustomerKey] FOREIGN KEY([CustomerKey])
			REFERENCES [dbo].[DimCustomer] ([CustomerKey]) NOT ENFORCED;
GO