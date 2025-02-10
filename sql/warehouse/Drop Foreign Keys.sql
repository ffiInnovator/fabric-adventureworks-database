SELECT 'ALTER TABLE [' + s.name + '].[' + OBJECT_NAME(f.parent_object_id) + '] DROP CONSTRAINT [' + f.name + '];' AS DropStmt
FROM sys.foreign_keys f
JOIN sys.tables t ON f.referenced_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo'
--AND t.name = 'DimAccount'
ORDER BY  OBJECT_NAME(f.parent_object_id);
GO


ALTER TABLE [dbo].[DimAccount] DROP CONSTRAINT [FK_DimAccount_DimAccount];
ALTER TABLE [dbo].[DimCustomer] DROP CONSTRAINT [FK_DimCustomer_DimGeography];
ALTER TABLE [dbo].[DimDepartmentGroup] DROP CONSTRAINT [FK_DimDepartmentGroup_DimDepartmentGroup];
ALTER TABLE [dbo].[DimEmployee] DROP CONSTRAINT [FK_DimEmployee_DimEmployee];
ALTER TABLE [dbo].[DimEmployee] DROP CONSTRAINT [FK_DimEmployee_DimSalesTerritory];
ALTER TABLE [dbo].[DimGeography] DROP CONSTRAINT [FK_DimGeography_DimSalesTerritory];
ALTER TABLE [dbo].[DimOrganization] DROP CONSTRAINT [FK_DimOrganization_DimOrganization];
ALTER TABLE [dbo].[DimOrganization] DROP CONSTRAINT [FK_DimOrganization_DimCurrency];
ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [FK_DimProduct_DimProductSubcategory];
ALTER TABLE [dbo].[DimProductSubcategory] DROP CONSTRAINT [FK_DimProductSubcategory_DimProductCategory];
ALTER TABLE [dbo].[DimReseller] DROP CONSTRAINT [FK_DimReseller_DimGeography];
ALTER TABLE [dbo].[FactCallCenter] DROP CONSTRAINT [FK_FactCallCenter_DimDate];
ALTER TABLE [dbo].[FactCurrencyRate] DROP CONSTRAINT [FK_FactCurrencyRate_DimDate];
ALTER TABLE [dbo].[FactCurrencyRate] DROP CONSTRAINT [FK_FactCurrencyRate_DimCurrency];
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_FactFinance_DimAccount];
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_FactFinance_DimDate];
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_FactFinance_DimOrganization];
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_FactFinance_DimDepartmentGroup];
ALTER TABLE [dbo].[FactFinance] DROP CONSTRAINT [FK_FactFinance_DimScenario];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimSalesTerritory];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimProduct];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimPromotion];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate1];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate2];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimCustomer];
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimCurrency];
ALTER TABLE [dbo].[FactInternetSalesReason] DROP CONSTRAINT [FK_FactInternetSalesReason_DimSalesReason];
ALTER TABLE [dbo].[FactInternetSalesReason] DROP CONSTRAINT [FK_FactInternetSalesReason_FactInternetSales];
ALTER TABLE [dbo].[FactProductInventory] DROP CONSTRAINT [FK_FactProductInventory_DimProduct];
ALTER TABLE [dbo].[FactProductInventory] DROP CONSTRAINT [FK_FactProductInventory_DimDate];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimDate];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimDate1];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimDate2];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimCurrency];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimProduct];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimEmployee];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimPromotion];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimReseller];
ALTER TABLE [dbo].[FactResellerSales] DROP CONSTRAINT [FK_FactResellerSales_DimSalesTerritory];
ALTER TABLE [dbo].[FactSalesQuota] DROP CONSTRAINT [FK_FactSalesQuota_DimEmployee];
ALTER TABLE [dbo].[FactSalesQuota] DROP CONSTRAINT [FK_FactSalesQuota_DimDate];
ALTER TABLE [dbo].[FactSurveyResponse] DROP CONSTRAINT [FK_FactSurveyResponse_DateKey];
ALTER TABLE [dbo].[FactSurveyResponse] DROP CONSTRAINT [FK_FactSurveyResponse_CustomerKey];