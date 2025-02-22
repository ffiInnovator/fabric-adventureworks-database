CREATE TABLE [brz].[DimProductCategory](
	[ProductCategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryAlternateKey] [int] NULL,
	[EnglishProductCategoryName] [nvarchar](50) NOT NULL,
	[SpanishProductCategoryName] [nvarchar](50) NOT NULL,
	[FrenchProductCategoryName] [nvarchar](50) NOT NULL
) ON [PRIMARY];
GO