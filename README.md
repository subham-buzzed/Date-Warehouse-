# Data Warehouse and Analytics Project
  
This project demonstrates a data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, tried using the industry best practices in data engineering and analytics.

---
  Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![Data  Lake  House Architecture](https://github.com/user-attachments/assets/04b85bbe-6b75-4b5a-8175-eb55d79a098f)



1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

Here is the Data flow model in this Data Warehouse:

![Data_Flow](https://github.com/user-attachments/assets/b495ce6b-00be-4329-bcaf-ae021aa85737)

---
## Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

 This repository has been the best way for my exposure towards the following topics :
- SQL Development
- Data Architect
- Data Engineering  
- ETL Pipeline Developer  
- Data Modeling  
- Data Analytics  

 Project Requirements

 Building the Data Warehouse (Data Engineering)

  Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

  BI: Analytics & Reporting (Data Analysis)
  
-- Reports:
To analyse the measure and dimensions of the bussiness data and the reports that i have generated are:
  - *Overall Performance Analysis*
  - *Change Over Analysis*
  - *Category Analysis*
  - *Cummulative Analysis*

-- Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.  
