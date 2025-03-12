# Microsoft Fabric AdventureWorks Database

Demonstrates a best practice approach for building a Microsoft Fabric Medallion Architecture using the real-world scenario of vendor-provided raw CSV files. We get these files from the Microsoft samples project on GitHub.

The project uses the new Microsoft Fabric Task Flow, a powerful feature that streamlines data workflows, helping organizations manage and automate their data processes more efficiently. Microsoft Fabric provides a built-in template for creating a Medallion Architecture, which simplifies the process of designing and implementing a structured data lakehouse. This template follows the Bronze, Silver, and Gold layer approach, ensuring data is efficiently ingested, transformed, and curated for analytics.

![Fabric AdventureWorks Architecture](resources/fabric-adventureworks-taskflow.png "The Medallion taskflow in Microsoft Fabric")
**Fabric AdventureWorks Task Flow -- Medallion Architecture**

## Prerequisites

In order to leverage this solution, you'll need a Microsoft Fabric capacity (F2 or higher) and a Power BI licence (Pro or PPU).

## Architecture

The intent of this project is to illustrate a best practice approach to build a Medallion Architecture in Microsoft Fabric by using a different fit-for-purpose components for each layer. Lakehouses are used for raw data in the **bronze** layer, where each attribute is a string to ensure every row is ingested without error.

The Warehouse hosts the **silver** with the data model needed to meet the business requirements. It was chosen for two reasons;

1. Many data types are not supported in Lakehouses. For instance, I faced challenges with boolean and binary (images).
1. The SQL to create primary and foreign keys is not supported in Lakehouses.

Finally, the **gold** layer utilizes SQL Database because it supports the richest set of SQL language and development capabities (e.g., stored procedures, user-defined functions, etc). Semantic Models are built from the database to create a data mesh design and expose information as data products. This approach allows for reusable models for various users and business domains, enabling more fine-grained security, governance, and self-service reporting.

![Fabric AdventureWorks Architecture](resources/fabric-adventureworks-architecture.png "The Medallion architecture pattern implemented in Microsoft Fabric")
**Fabric AdventureWorks Architecture**

## Phase 1 -- Raw to Bronze

First, create the workspace for the project; I called mine "AdventureWorks Dev". Many of us struggle with naming conventions and standards. You don't want the name too long as it quickly gets truncated on the right-side by the UI.

We do need separate workspaces for dev, test and prod. Ideally, the best practice is to have separate workspaces for data and reports as well; this allows for more fine-grained access control required by large enterprises. The data workspaces can be further sepated by layer. To keep things simple whill still demonstrating the key concepts, I choose just to have a single workspace for development.

Second, create the Lakehouse that will serve as the BRONZE layer; I called mine "AdventureWorks_Lakehouse". Create a folder named "bronze" (the layer) and a subfolder named "warehouse" (the application).

Third, download the CSV files from the [Microsoft samples GitHub](https://github.com/microsoft/sql-server-samples) site. These CSV files from the the AdventureWorks folder initially had issues. It was discoverd that they were encoded with UTF-16LE:

```
👉 file -I DimAccount.csv
DimAccount.csv: text/plain; charset=utf-16le
```

The issue was fixed by converting all the CSV files to UTF-8. A bash shell script is included in this repo for future conversions, if necessay. An OS conversion program was used and is the key to the script execution; please check if is avaialbe on your OS or use an equivelent one:

```
# Convert the file from UTF-16LE to UTF-8 using iconv
iconv -f UTF-16LE -t UTF-8 DimAccount.csv >DimAccount_UTF8.csv
```

I saved you the pain of this step, so you can simply upload the converted, UTF-8 formatted CSV files from this repo to the "warehouse" folder in your Lakehouse.


## Raw to Bronze
