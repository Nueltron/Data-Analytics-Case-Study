# Data Analytics Case Study 

This Project is an In-depth analysis of the  Remote's Case Study. The readme.md file is a detailed breakdown of the project.



## **Project Introduction / Case Study Introduction**

For this Case Study, **Atlas** will be used as the company alias. 

Atlas is an e-commerce firm that sells a wide range of products to a number of client segments in various countries. The database contains a collection of transaction data from 2011 to 2013. Atlas wants to keep track of various metrics to see how the firm is doing and gather insight on how they can enhance it.

The Database is a group of records holding some information on an organizations products, the customers that buy the products, detailed information on their customers, amount of money spent to purchase the product, the region the customer resides in, etc.

These records collectively make up the Dataset. They would be analyzed to answer questions that would help Atlas ascertain the performance of the organization. Some of these questions include:

1. Find the highest transaction of each month in 2012 for the product Sport-100 Helmet, Red
2. Find the lowest revenue-generating product for each month in 2012. Include the Sales Territory Country as well.
3. Find the Average Finance Amount for each Scenario (Actual Scenario, Budget Scenario, Forecast Scenario) for each Account Type (Assets, Balances, Liabilities, Flow, Expenditures, Revenue) in 2011.
4. Find all the products and their Total Sales Amount by Month of order which does have sales in 2012.
5. Write a query to find the age of customers. Bucket them under

**Age Group**:             

- Less than 35
- Between 35 and 50
- Greater than 50

Segregate the Number of Customers in each age group on **Marital Status** and **Gender**.



#### DataSet Description ###

**Definitions**

Dimension Table: A dimension table stores attributes, or dimensions, that describe the objects in a fact table.

Fact Table: A fact table contains measurements, metrics or facts about a business process. These measurements can be aggregated(Sum, Count, Min, Max,Stdev,Variance) E.g Amount, Quantity, etc

The case study encapsualtes the detailed analyisis of Atlas' DataSet with Five Dimension Tables and Two Fact Tables. They include:
1. DimAccounts: This is a Dimension Table that contains the records that describe the respective accounts in Atlas. Some of these accounts include Current Assets, Cash, Finished Goods, etc.

    Primary Key - **AccountKey**

2. DimProducts: This table contains records or information on all Atlas' products. Some of these products include Bearing Ball, Hex Nut 10, Metal Angle, etc

    Primary Key - **ProductKey**

3. DimCustomers: This table contains detailed information on all of Atlas' customers i.e individuals that have purchased products from Atlas.

    Primary Key - **CustomerKey**


4. DimScenario: This table contains information on Atlas' different Budgeting Scenarios. They include Actual, Budget and Forecast Scenarios 

    Primary Key - **ScenarioKey**

5. DimSalesTerritory: This table contains information of the  respective territories where customers purchase Atlas' products. E.g United States, Canada, etc..

    Primary Key - **SalesTerritoryKey**

6. FactFinance: This table contains amount details for specific scenarios with their respective AccountKeys.

    Primary Key - **FinanceKey**

7. FactResellerSales: This table contains measurement or fact information on products purchased by customers that can be aggregated e.g. ProductStandardCost, SalesAmout, TotalProductCost,etc

* FactResellerSales Table has rows that aren't referenced in other tables in the dataset. E.g EmployeeKey. The Database doesn't have all the required tables.



### Technologies Used 

* Microsoft SQL Server
* Tableau
* Markdown



### Methodology
* Data Quality / Profiling Check
* Data Analysis 
* Data Visualization
* Data Insights/Recommendation





## Getting Started
1. Download Atlas' Database as an Excel file. [here](https://docs.google.com/spreadsheets/d/1ksCG8l6brZWLvBxPacWmMqba396PbSlrxo1GPxMFwJ8/edit#gid=729762992)

2. Create a Database in Microsoft SQL Server with the following query.
     
    
    `CREATE DATABASE ATLAS; `

3. Import the Excel file into the ATLAS Database in Microsoft SQL Server 
with **SQL Server 2019 Import and Export Wizard**. 

    * Select **Microsoft Excel** 2016 as the Source file 
    * Insert the Data source file path
    * Select **Microsoft Excel 2016** as the version
    * Select **Microsoft OLE DB Driver** for SQL Server as the Destination
    * Connect to the **Atlas** Database with Windows authentication and the Server Name.
    * Import all the tables and views into the **Atlas DB**
    * The Atlas DB will contain seven tables after import.



## Data Profiling Assessment

Data Profiling Assessment is a verification exercise carried out by Data Analysts to ascertain the quality of data in a Database. It is the process of examining, analyzing and creating useful summaries of data to check alignment with business rules.





To carry out the Data Profiling Assessment for Atlas' Data, the following criteria would be evaluated. They include:

* Completeness - This criteria checks for the number of fields that are null or empty in the data set. The Data Completeness test is an important evaluation to be carried out to ensure that no nulls exists in Atlas' Database i.e no field is empty. This test would be carried out on all the columns in the respective tables.

* Uniqueness - This criteria ensures that a primary key field doesn't have duplicate values.

* Validity - This criteria ensures that the record in a specified column follows the format and type defined in the business rules document.


## Approach, Analysis and Results From the Data Profiling

**Approach**

Using MSQL Server, the Data profiling exercise was carried out on the three dimension tables because they contain the detailed description of the fact tables. They include DimAccoumts, DimCustomers and DimProducts. 

A master table was created for each Dimiension table to carry out the profiling exercise. The goal is to consolidate all the results of the above mentioned criteria into one table. This for ease of reference and analysis. 

Some Definitions in the Data Profiling Script:

* Quality Issues: This alias helps identify the number of fields in a row that corresponds with the conditions or criteria that is being tested. Quality Issues speaks to the Completness, Uniqueness and Validity criteria.

* Total: This alias helps identify the total number of fields in the column that is being tested.

* Field: This alias helps identify the table that is being tested. 

* Tag: This alias helps identify the specific profiling test being carried out.

**Profiling For DimAccount Table**

*Account Master Table SQL Script*
```
SELECT [AccountKey]
      ,[ParentAccountKey]
      ,[AccountCodeAlternateKey]
      ,[ParentAccountCodeAlternateKey]
      ,[AccountDescription]
      ,[AccountType]
      ,[Operator]
      ,[CustomMembers]
      ,[ValueType]
      ,[CustomMemberOptions]
	  , 1 Total INTO Account_master
  FROM [test].[dbo].[DimAccounts]   
```
The above script creates the table Account_master and adds the column Total to the table. The total column will later be used to aggregate the total number of fields in each column.


*Completeness Check For AccountKey Column SQL Script*
```
SELECT b.Field, 
		CASE WHEN a.QualityIssues is null then 0 else a.QualityIssues end as QualityIssues
		,b.Total
FROM(
SELECT 'AccountKey' Field,  
		COUNT(AccountKey) AS QualityIssues
FROM Account_master
WHERE AccountKey is null) a
JOIN 
(SELECT 'AccountKey' Field, 
	     SUM(total) Total
FROM Account_master) b 
ON a.Field = b.Field
```

***CodeExplanation***

Selected the name of the column "AccountKey" as Field and the COUNT of fields in the AccountKey column where AccountKey is null from the Account_master table. Used an alias "a" to represent this block of code.

Selected the name of the column "AccountKey" as Field and the Sum of the "Total" column as Total from Account_master table. Used an alias "b" to represent this block of code

 Used an INNER JOIN to join the aliases "a" and "b" with the common "Field" column.

 Used the newly joined table as a subquery to inform the selection of the final table. Used a CASE WHEN statement for Qualityissues to input 0 into the table if the "QualityIssues" column is null. If it is not null, the value of "Qualityissues" would be inputed into the table. 


 ***Result***

 | Field	|QualityIssues	|Total  |
 | -------- | ------------- |-------|
 |AccountKey|	0	        |  99   |


 Replicated this code convention for all the columns in the ***Account_Master*** table. 
 Used the ***UNION ALL*** function to consolidate all the tables into one table. The name of the new table is ***Account_completion***

```
SELECT * FROM Account_completion
```

 ***Completeness Check Result For The Account Master Table*** 

|Field  |	QualityIssues|	Total |
|--------|--------------|---------|
|AccountKey |	0 |	99 |
|ParentAccountKey |	3  |	99 |
|AccountCodeAlternateKey |	0 |	99|
|AccountDescription |	0	|99|
|AccountType |	1|	99|
|Operator |	0 |	99|
|CustomMembers |	98|	99|
|ValueType |	0|	99|
|CustomMemberOptions |	99|	99|


From the table above 5 columns have complete records. They include the AccountKey, AccountCodeAlternateKey, AccountDescription, Operator and Value Type columns. The columns that are incomplete include ParentAccountKey, AccountType, CustomerMembers and CustomerMemberOptions.

Column CustomerMembers and CustomerMemberOptions columns are completely null i.e they have no records. While cleaning, they should be removed from the dataset. 



**Validity Check For Account_master Table**

****Assumptions****

Atlas has a Business Rule document for Data Governance where the data standards for each column in the database are clearly defined as they align with the company's business processes. 

The validity test was carried out on the AccountKey Column and the AccountCodeAlternateKey Column

***Validity Rule Definition***

Referencing this document, Atlas outlined that the PrimaryKey Column(AccountKey) must exist within the range of 1 and 150. Any record outside this range is considered invalid. Also, the record must be completely numeric. No Alphanumeric records allowed. Any records outside this definitions are invalid.  


***Validity Check For AccountKey Column SQL Script***
```
SELECT b.Field,
	   CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
	   ,b.Total
FROM 
(SELECT 'AccountKey' Field, 
		 COUNT(AccountKey) AS QualityIssues
FROM Account_master
WHERE AccountKey IS NOT NULL
AND AccountKey NOT BETWEEN 1 AND 150
OR AccountKey NOT LIKE '%[0-9]'
) a
JOIN
(SELECT 'AccountKey' Field,  
		SUM(Total)Total FROM Account_master) b
ON a.Field = b.Field

```

***CodeExplanation***

Selected the name of the column "AccountKey" as Field and the COUNT of fields in the AccountKey column as "QualityIssues" where AccountKey is null from the Account_master table. Included a filter with the WHERE clause that is to select the records that are not null and are beyond the range 1 to 150 or are not completely numeric. 
 Used an alias "a" to represent this block of code.

Selected the name of the column "AccountKey" as Field and the Sum of the "Total" column as Total from Account_master table. Used an alias "b" to represent this block of code.

Used an INNER JOIN to join the aliases "a" and "b" with the common "Field" column.

 Used the newly joined table as a subquery to inform the selection of the final table. Used a CASE WHEN statement for Qualityissues to input 0 into the table if the "QualityIssues" column is null. If it is not null, the value of "Qualityissues" would be inputed into the table. 


  ***Result***

  |Field	|QualityIssues	|Total|
|-----------|---------------|------|
|AccountKey	|0	|99|


Replicated this code convention for AccountCodeAlternateKey columns in the ***Account_Master*** table. The validity rule for the AccountCodeAlternateKey column highlights that the records in the column must exist within the range of 1 and 10000 and the records must be completely numeric.
 
 I used the ***UNION ALL*** function to consolidate all the tables into one table. The name of the new table is ***Account_validation***

 ```
SELECT * FROM Account_validation
```


***Validity Check Result For The Account Master Table***

|Field |	QualityIssues	|Total
|-------|------------|--------|
|AccountKey|	0|	99|
|AccountCodeAlternateKey|	0|	99|

From the table above, the AccountKey and AccountCodeAlternateKey columns passed the validity test i.e. No record in this respective columns are invalid. 


***Uniquenes Check For Account_master Table***

The Uniqueness criteria in Data profiling tests for singularity of a Unique Identifier(Primary Key). This means a primary key field cannot have duplicates. It must uniquely identify a row. If there are duplicate primary key fields in a column, the column has failed the uniqueness test. 

The Uniqueness test would be carried out on the Primary Key(AccountKey) and AccountCodeAlternateKey in the Account_master table.



***Uniqueness Check For AccountKey Column SQL Script***
```
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.total
FROM
(SELECT 'AccountKey' Field,
         COUNT(DISTINCT AccountKey) AS QualityIssues
FROM Account_master
WHERE AccountKey IN (
SELECT AccountKey
FROM Account_master
WHERE AccountKey IS NOT NULL
GROUP BY AccountKey
HAVING COUNT(AccountKey) > 1) )a 
JOIN
(SELECT 'AccountKey' Field,
        SUM(Total)Total 
FROM Account_master)b 
ON a.Field = b.Field

```

***Code Explanation***


Selected the name of the column "AccountKey" as Field and the COUNT of DISTINCT fields in the AccountKey column as "QualityIssues". Included a filter with the WHERE clause that is to select the AccountKey from a SUBQUERY. 

The SUBQUERY selects the AccountKey where the AccountKey fields aren't null. It Groups BY the AccountKey column. The Aggregate function (COUNT) that is to get the number of duplicated fields in the AccountKey Column cannot be used with the WHERE clause. Rather, the COUNT function is used with the HAVING clause. Used an alias "a" to represent this block of code. 

Selected the name of the column "AccountKey" as Field and the Sum of the "Total" column as Total from Account_master table. Used an alias "b" to represent this block of code.

Used an INNER JOIN to join the aliases "a" and "b" with the common "Field" column.

Used the newly joined table as a subquery to inform the selection of the final table. Used a CASE WHEN statement for Qualityissues to input 0 into the table if the "QualityIssues" column is null. If it is not null, the value of "Qualityissues" would be inputed into the table. 

***Result***

|Field	|QualityIssues	|Total|
|-------|----------|---------|
|AccountKey|	0|	99|


Replicated this code convention for AccountCodeAlternateKey columns in the ***Account_Master*** table.

 Used the ***UNION ALL*** function to consolidate all the tables into one table. The name of the new table is ***Account_uniqueness***

 ```
SELECT * FROM Account_uniqueness
 ```

 ***Result***

|Field	|QualityIssues|	Total
|------|-------------|--------|
|AccountKey|	0	|99
|AccountCodeAlternateKey|	0	|99

From the table above, AccountKey and AccountCodeAlternateKey Columns have do not have duplicate fields i.e They passed the Uniqueness test.

The final table consolidates the Completeness, Validity and Uniqueness tables into one. This gives a robust insight into the data quality assessment of the Account_master table. The name of the table is **Account_consolidated**.


 ```
SELECT * FROM Account_consolidated;
 ```

***Result***

|Tag	|Field	|QualityIssues	|Total
|-------|-------|------------|---------|
Completeness|	AccountKey|	0	|99
Completeness|	ParentAccountKey|	3|	99
Completeness|	AccountCodeAlternateKey|	0|	99
Completeness|	AccountDescription|	0	|99
Completeness|	AccountType|	1|	99
Completeness|	Operator|	0  |	99
Completeness|	CustomMembers|	98 |	99
Completeness|	ValueType|	0 |	99
Completeness|	CustomMemberOptions|	99 |	99
Uniqueness|	AccountKey|	0 |	99
Uniqueness|	AccountCodeAlternateKey|	0|	99
Validity	|AccountKey|	0|	99
Validity| AccountCodeAlternateKey|	0|	99






**Data Profiling For DimProduct**

The Data Profiling Code convention was applied to the other Dimension tables in the Atlas DB. 

Selecting the consolidated view for the respective criteria evaluated would give a detailed Data Profiling overview of the table.

```
 SELECT * FROM Product_Consolidated
```

***Results***

|Tag|	Field|	QualityIssues|	Total|
|------|-------|-----------|---------|
Completeness|	ProductKey|	0|	569|
Completeness|	ProductAlternateKey|	0|	569
Completeness|	ProductSubcategoryKey|	209|	569
Completeness|	WeightUnitMeasureCode|	324|	569
Completeness|	SizeUnitMeasureCode|	352|	569
Completeness|	ProductName|	0|	569
Completeness|	StandardCost|	211|	569
Completeness|	FinishedGoodsFlag|	0|	569
Completeness|	Color|	254	|569
Completeness|	SafetyStockLevel|	0	|569
Completeness|	ReorderPoint|	0	|569
Completeness|	ListPrice|	211	|569
Completeness|	Size|	306	|569
Completeness|	SizeRange|	306|	569
Completeness|	Weight|	324	|569
Completeness|	DaysToManufacture|	0| 569
Completeness|	ProductLine|	225	|569
Completeness|	DealerPrice|	211	|569
Completeness|	Class|	275	|569
Completeness|	Style|	304	|569
Completeness|	ModelName|	209	|569
Completeness|	StartDate|	132	|569
Completeness|	EndDate|	467	|569
Completeness|	Status|	234	|569
Uniqueness|	ProductKey|	0	|569
Uniqueness|	ProductName|	61	|569
Uniqueness|	ProductAlternateKey|	61	|569
Validity|	ProductKey|	0	|569
Validity|	ProductAlternateKey|	0	|569


**Analysis**

From the table above, most of the columns in the Product Table have Quality Issues. 

For the Completeness test, just 7 out of 24 columns have complete  records. This will negatively affect the analysis of the dataset because the incomplete records would not highlight the true state of the data.

For the Uniqueness test, just 1 (ProductKey) out of 3 columns have a Unique Identifier. Drilling deeper into the dataset to understand why ProductName column is having 61 duplicates, it is observed that some product names are not unique to one ProductKey. i.e different product keys have the same product name. 

For example,  **ProductKey 212,213,214** have the same **Product Name "Sport-100 Helmet, Red"** also **ProductKey 235,236,237** have the same **ProductName "Long-Sleeve Logo Jersey, XL"**.

From my analysis, each product "Sport-100 Helmet, Red" have different **StandardCost** values and different **StartDates**. The StartDates are 2011,2012,2013 respectively. Querying this product without the date filter will affect some of the insights ATLAS wants to discover from the dataset. The naming convention for these products should be unique to avoid errors.


For the Validity Test, the two columns selected passed the validity test i.e the records are valid.


**Data Profiling For DimCustomer**

```
SELECT * FROM Customer_Consolidated
```

**Results**

|Tag	|Field	|QualityIssues	|Total|
|---------|---------|-----------|--------|
Completeness	|CustomerKey	|0	|18484
Completeness	|GeographyKey	|0	|18484
Completeness	|CustomerAlternateKey	|0	|18484
Completeness	|BirthDate	|10228	|18484
Completeness	|Title	|18383	|18484
Completeness	|EmailAddress	|0	|18484
Completeness	|FirstName	|0	|18484
Completeness	|MiddleName	|0	|18484
Completeness	|LastName	|0	|18484
Completeness	|NameStyle	|0	|18484
Completeness	|Phone	|0	|18484
Completeness	|Gender	|0	|18484
Completeness	|MaritalStatus	|0	|18484
Completeness	|Suffix	|18481	|18484
Completeness	|TotalChildren	|0	|18484
Completeness	|NumberChildrenAtHome	|0	|18484
Completeness	|EnglishEducation	|0	|18484
Completeness	|SpanishEducation	|0	|18484
Completeness	|FrenchEducation	|0	|18484
Completeness	|EnglishOccupation	|0	|18484
Completeness	|SpanishOccupation	|0	|18484
Completeness	|FrenchOccupation	|0	|18484
Completeness	|HouseOwnerFlag	|0	|18484
Completeness	|NumberCarsOwned	|0	|18484
Completeness	|YearlyIncome	|0	|18484
Completeness	|AddressLine1	|0	|18484
Completeness	|AddressLine2	|18172	|18484
Completeness	|CommuteDistance	|0	|18484
Completeness	|DateFirstPurchase	|0	|18484
Completeness	|F30	|18484	|18484
Completeness	|F31	|18484	|18484
Uniqueness	|CustomerKey	|0	|18484
Uniqueness	|EmailAddress	|0	|18484
Uniqueness	|CustomerAlternateKey	|0	|18484
Validity	|CustomerKey	|0	|18484
Validity	|CustomerAlternateKey	|0	|18484
Validity	|DateFirstPurchase 	|7308	|18484



**Analysis**

For the Completeness Test, most columns in the Table have no null values except 6 columns. They include **BirthDate, Title, Suffix, AddressLine2, F30 and F31**. The columns F30 and F31 are completely null. They should be removed from the dataset while cleaning. 

The **BirthDate** column has 10228 NULL values from a total of 18484 fields. More than 50% of the column is empty. This poses a big problem for the one of Atlas' Business Questions. Atlas wants to find the number of customers that are less than 35, between 35 and 50 and more than 50. 

The incomplete fields in the Birthdate column would affect the outcome of the analysis. The ages of over 10228 customers would be missing. Atlas would not be able to make an informed decision with this data.

For the Uniqueness Test, the 3 columns selected passed the test i.e there a are no duplicates in the respective columns.

For the Validity Test, 1 column(DateFirstPurchase) has 7308 fields that are not unique. Digging into the dataset, these 7308 fields don't exist in a  date format. Therefore they are invalid. 








## Answers to Atlas' Questions

1. Find the highest transaction of each month in 2012 for the product Sport-100 Helmet, Red


**SQL Query**
```
SELECT Month,
	   OrderDate,
	   SalesAmount 
FROM(
SELECT DATENAME(MONTH,OrderDate) AS Month, 
	   TRY_CONVERT(DATE,OrderDate) AS Orderdate, 
	   SalesAmount,
       ROW_NUMBER() OVER(PARTITION BY DATENAME(MONTH,OrderDate) ORDER BY SalesAmount DESC) AS SalesRanking
FROM FactResellerSales a
JOIN DimProduct b
ON a.productkey = b.ProductKey 
WHERE ProductName = 'Sport-100 Helmet, Red'
AND YEAR(OrderDate) = '2012' 
) ranks
WHERE SalesRanking = 1
ORDER BY DATEPART(MONTH, Orderdate)

```

**Code Explanation**


Selected the **Month Name from OrderDate** using the **DATENAME** function as Month. Selected the formatted **OrderDate** column using the **TRY_CONVERT** function as Orderdate and  **SalesAmount** as SalesAmount. 

Selected the **ROW_NUMBER()** function, partitioned ( using the **PARTITION BY** function) it by **MonthName** from **OrderDate** Column and Ordered it by  SalesAmount in Descending Order.

**ROW_NUMBER()** function provides consequtive numbering of rows by the Order selected in the OVER clause for each partition specified in the OVER clause. 

The **PARTITION BY** clause divides the result into partitions as specified by MonthName. This means the **PARTITION BY** clause divides the results into **Months**. The **ORDER BY** clause **sorts the row in each partiton by the SalesAmount in descending order**(From the highest to the lowest in each partition). Sequential numbers are assigned to each row in each partition.

The highest **SalesAmount** will be 1 and the lowest **SalesAmount** in the partition would be n. The block of code above is given the alias **Sales Ranking**

Joined FactResellerSales a to DimProduct b with the ProductKey.

Used the WHERE clause to filter for records with ProductName 'Sport-100 Helmet, Red' and YEAR being 2012.

The whole block of code above serves as a subquery with alias **ranks**.

Selected Month, OrderDate and SalesAmount from Subquery **ranks**. Used a **WHERE** clause to filter where **SalesRanking** is equal to one. This brings out all the rows in the partions where **SalesRanking** is 1.





**Result**

|Month	|OrderDate	|SalesAmount|
|-------|-----------|-----------|
January	|2012-01-29|	267.7266
February |	2012-02-29 |	421.898
March |	2012-03-30 |	229.4799
April |	2012-04-30 |210.3566
May	|2012-05-30	|229.4799
June	|2012-06-30	|141.3055
July	|2012-07-31	|161.492
August |2012-08-28	|201.865
September |	2012-09-28|267.7266
October	|2012-10-28	|229.4799
November	|2012-11-28|298.8444
December	|2012-12-28 |321.2082

**Analysis**

From the Table above, **February** had the **Highest Sales** transaction for the product Sport-100 Helmet, Red with **$421.898**.

**June** had the **Lowest Sales** transaction with **$141.31**

The Sport-100 Helmet, Red had the highest sales for the year 2012 in February.



2. Find the lowest revenue-generating product for each month in 2012. Include the Sales Territory Country as well.

SQL QUERY
```
SELECT Month, 
      ProductName, 
	  SalesAmount, 
	  SalesTerritoryCountry
FROM (
SELECT DATENAME(MONTH,OrderDate) AS Month,
       b.ProductName as ProductName, 
       SUM(a.SalesAmount) AS SalesAmount,
	   c.SalesTerritoryCountry AS SalesTerritoryCountry,
       ROW_NUMBER() OVER(PARTITION BY DATENAME(MONTH,OrderDate) 
	   ORDER BY SUM(SalesAmount) ASC) AS SalesRanking
FROM FactResellerSales a 
JOIN  DimProduct b ON a.productkey =  b.ProductKey 
JOIN DimSalesTerritory c ON a.SalesTerritoryKey = c.SalesTerritoryKey 
WHERE Year(OrderDate) = '2012' 
GROUP BY DATENAME(MONTH,OrderDate), ProductName, SalesTerritoryCountry
) ranks
WHERE SalesRanking = 1
```


**Code Explanation**

Selected the **Month Name from OrderDate** using the **DATENAME** function as Month, the **ProductName** as ProductName,  **SUM of SalesAmount** as SalesAmount and **SalesTerritoryCountry** as SalesTerritoryCountry.

Selected the **ROW_NUMBER()** function, partitioned ( using the **PARTITION BY** function) it by **MonthName** from **OrderDate** Column and Ordered it by 
SUM of SalesAmount Column in Ascending Order.

**ROW_NUMBER()** function provides consequtive numbering of rows by the Order selected in the OVER clause for each partition specified in the OVER clause. 

The **PARTITION BY** clause divides the result into partitions as specified by MonthName. This means the **PARTITION BY** clause divides the results into Months. The **ORDER BY** clause **sorts the row in each partiton by the SUM of SalesAmount in ascending order**(From the least to the highest in each partition). Sequential numbers are assigned to each row in each partition.

The least SUM(SalesAmount) will be 1 and the highest SUM(SalesAmount) in the partition would be n. The block of code above is given the alias **Sales Ranking**

Joined FactResellerSales a to DimProduct b with the ProductKey.

Joined FactResellerSales a to DimSalesTerritory c with the SalesTerritoryKey.

Used the WHERE clause to filter for records in 2012. Grouped By MonthName, ProductName, Sales Territory Country. 


The whole block of code above serves as a subquery with alias **ranks**.

Selected Month, ProductName, SalesAmount and SalesTerritoryCountry from Subquery **ranks**. Used a **WHERE** clause to filter where SalesRanking is equal to one. This brings out all the rows in the partions where SalesRanking is 1.




**Result**

|Month	|ProductName	|SalesAmount	|SalesTerritoryCountry
|-------|-----------|--------------|---------------|
|April	|LL Mountain Handlebars	|24.2945	|Canada
|August	|Half-Finger Gloves, S	|14.1289	|France
December	|Racing Socks, M	|5.394	|United Kingdom
February|	AWC Logo Cap|	10.373|	France
January |	LL Road Handlebars |	24.2945	|United Kingdom
July |	Minipump |	23.988	|United Kingdom
June |	AWC Logo Cap |	10.373 |	France
March |	Half-Finger Gloves, L	|14.1289	|United Kingdom
May|	AWC Logo Cap|	10.373|	United Kingdom
November |	Half-Finger Gloves, L	|14.1289	|United Kingdom
October	|Full-Finger Gloves, S	|22.794|	United Kingdom
September	|Minipump	|11.994	|United Kingdom


**Analysis**


3. Find the Average Finance Amount for each Scenario (Actual Scenario, Budget Scenario, Forecast Scenario) for each Account Type (Assets, Balances, Liabilities, Flow, Expenditures, Revenue) in 2011.

SQL Code
```
SELECT da.AccountType,
	   AVG(CASE WHEN d.ScenarioName = 'Actual' THEN f.Amount ELSE 0 END ) AS Actual_Scenario,
	   AVG(CASE WHEN d.ScenarioName ='Budget' THEN f.Amount ELSE 0 END) AS Budget_Scenario,
       AVG(CASE WHEN d.ScenarioName = 'Forecast' THEN f.Amount ELSE 0 END) AS Forecast_Scenario
FROM FactFinance f 
JOIN DimScenario d ON f.ScenarioKey=d.ScenarioKey
JOIN DimAccounts da ON f.AccountKey=da.AccountKey
WHERE YEAR(f.Date) = '2011'
GROUP BY da.AccountType
```

**Code Explanation**

Selected AccountType, the Average of all the Actual Amount using a CASE WHEN statement as **Actual Scenario**, the Average of all the Budget Amount using a CASE WHEN statement as **Budget Scenario**, the Average of all the Forecast Amount using a CASE WHEN statement as **Forecast Scenario**.

Joined FactFinance f with DimScenario d using the ScenarioKey

Joined FactFinance f with DimAccounts da using the AccountKey

Used a WHERE clause to filter for records with date as 2011

Grouped By AccountType. 




RESULTS

|AccountType	|Actual_Scenario	|Budget_Scenario	|Forecast_Scenario
|---------|----------|----------|---------|
|Assets	|110701.156199295	|0	|0
Balances	|11256.932885906	|0	|0
Expenditures	|2052.03114537892	|1643.87338946941	|0
Flow	|382.445945945946	|0	|0
Liabilities	|119785.411383588	|0|	0
Revenue	|26648.2775207469|	25508.2987551867|	0





4. Find all the products and their Total Sales Amount by Month of order which does have sales in 2012.


SQL CODE

```
SELECT f.ProductKey, 
       SUM(f.SalesAmount) AS SalesAmount, 
	  CONCAT(DATENAME(MONTH,f.OrderDate), ', ',YEAR(f.OrderDate)) AS OrderMonth
FROM FactResellerSales f 
JOIN DimProduct d 
ON f.ProductKey = d.ProductKey
WHERE YEAR(f.OrderDate) ='2012'
GROUP BY  f.OrderDate,f.ProductKey
ORDER BY  OrderDate,f.ProductKey
```
Code Explanation

Selected the Productkey, Sum of the SalesAmount Column to give the total sales with the alias **SalesAmount**. 

I also selected the Orderdate. Used the **DATENAME** function to select the Month Name as a string from the OrderDate column. Then I used the **CONCAT** function to combine the Month Name and the Year into one result. Used the **OrderDate** as an Alias to represent this line of code. 

To get all the products and their total sales by month in the  year 2012, DimProduct and FactResellerSales need to be joined. The product list resides in the DimProduct table and their respective sales data resides in  FactResellerSales table.

Joined these two tables with the **JOIN** keyword using the ProductKey column in the two tables. Used the WHERE clause to filter for transactions that occured in 2012. 

Grouped By the Date Column and ProductKey Column.

Ordered BY the OrderDate Column and ProductKey Column.



**RESULTS**

|ProductKey	|SalesAmount	|OrderMonth
|-----------|-------------|----------|
213	| 4305.0266	|January, 2012
216	|4804.387	|January, 2012
221	|4864.919	|January, 2012
224	|1731.0468	|January, 2012
230	|6057.9625	|January, 2012
233	|9259.92	|January, 2012
236	|4608.3678	|January, 2012
239	|46849.092	| January, 2012
242	|42945.001	|January, 2012
245	|15616.364	| January, 2012
.......|.....................|...............................|
596	|6803.874	|December, 2012
597	|7775.856	|December, 2012
598	|6155.886	|December, 2012
599	|12311.772	|December, 2012
600	|3239.94	|December, 2012
601	|907.032	|December, 2012
603	|2478.396	|December, 2012
604	|3887.928	|December, 2012
605	|37352.4583	|December, 2012
606	|30131.01	|December, 2012



5. Write a query to find the age of customers. Bucket them under

**Age Group**:             
- Less than 35
- Between 35 and 50
- Greater than 50

Segregate the Number of Customers in each age group on **Marital Status** and **Gender**.


SQL CODE
```
SELECT CASE MaritalStatus WHEN 'M' THEN 'Married' ELSE 'Single' END AS  MaritialStatus, 
	   CASE Gender WHEN 'M' THEN 'Male' ELSE 'Female' END AS Gender,
       COUNT(CASE WHEN (YEAR(GETDATE())-YEAR(BirthDate)) < 35 THEN ' ' END) AS 'Age < 35',
	   COUNT(CASE  WHEN ((YEAR(GETDATE())-YEAR(BirthDate)) >= 35) AND ((YEAR(GETDATE())-YEAR(BirthDate)) <= 50) THEN ' '  END) AS 'Age between 35-50',
       COUNT(CASE  WHEN (YEAR(GETDATE())-YEAR(BirthDate)) > 50 THEN ' ' END) AS 'Age > 50'
FROM  DimCustomer
WHERE BirthDate IS NOT NULL 
AND YEAR(GETDATE()) > YEAR(BirthDate)
GROUP BY  MaritalStatus, Gender

```
**Code Explanation**


Selected MaritalStatus using the CASE WHEN statement. When the field starts with 'M', input Married or else input Single. Selected Gender using the CASE WHEN statement. When the field starts with 'M' input Male or else input Female. 

Age = YEAR(GETDATE())-YEAR(BirthDate)

USING the CASE WHEN Statement Selected the COUNT of the Ages that were  less than 35. 

USING the CASE WHEN statement, selected the COUNT of the Ages that were between 35 and 50.

USING the CASE WHEN statement, selected the COUNT of the Ages that were greater than 50.

FROM DimCustomer. 

Used a WHERE clause to filter for Records where Birthdate is not null and YEAR(GETDATE()) is greater than YEAR(BirthDate).

GROUPED by MaritalStatus and Gender

**RESULT**

|MaritialStatus|	Gender|	Age < 35	|Age between 35-50	|Age > 50
|------------|-----------|-----------|------------|----------|
Married	|Male	|2	|992	|1427
Single	|Male	|1	|1049	|787
Single	|Female |	1	|1118	|783
Married	|Female	|2	|852	|1230






**Query Optimization**

To optimize the the SQL Queries above the following procedures were carried out.

1. Created Indexes. I created a composite index on the FactResellerSales Table on the OrderDate and ProductKey columns. Also created an Index on the DimProduct table and the ProductName column. These indexes would improve the speed of the queries.

```
CREATE INDEX idx_orderdate_productkey ON FactResellerSales(OrderDate,ProductKey)

CREATE INDEX idx_productname ON DimProduct(ProductName)
```

2. Used Subqueries.

3. Didn't use the Select * syntax. Rather, I selected the tables that were  required.

4. Used the Window Function ROWNUMBER() 




## Data Visualization

I created insightful dashboards from my SQL Query Results with Tableau Public. I published my results to Tableau Public. Find my dashboard [here](https://public.tableau.com/views/DataAnalystExercise_16536016626030/Dashboard6?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link)

## Tableau Analysis

6. Based on your results for question #2 above, create a visualization to highlight the sales territories with the lowest sales performances. Are there any territories with consistent low sales performance over time?

    **Answer**

    From my Tableau Visualization, the territory with consistently low sales performances over time is **United Kingdom**. United Kingdom has consistently low sales in September, October, November and December with figures 11.99, 22.79, 14.13 and 5.39 respectively.

    United Kingdom also has the lowest sales in January, March and May with figures 24.29, 14.13 and 10.37 respectively. 

    United Kingdom's percentage distribution on comparison to other territories is **68.23%**.

    I can infer that United Kingdom is the lowest Sales Territory for the year 2012. More data would be required to find out why and how to improve sales in this territory.


7.  Create a visualization based on your results for question #3 above, so that the user can switch between scenarios and account types. Please explain what insight can we gain from these results.

    **Answer**

    From the visualization the Scenario with the **Highest Finance Average** across all Account types is the **Actual Scenario** Amount with a **Total Finance Amount Average**  of **270,826.25**
    
    The **Liabilities Account** type has the **Highest Finance Amount Average** with **119785.41**. The **Assets Account** type has the **Second Highest Finance Amount Average** with **110701.16**.

    The **Flow Account** type has the **Least Finance Amount Average** with **382.44**

    The **Budget Scenario** just has **2 Finance Amount Averages** for **Expenditures** and **Revenue** with figures **1643.87** and **25508.29** respectively. This totals **27152.16**

    The **Forecast Scenario** has  **no Finance Amount Averages**.





8. Create a visualization based on your results for question #5 above. Please explain what insight can we gain from these results.

    P.S Note, more than **50%** of the BirthDate column are empty. So this analysis might not be accurate.

    From the Visualization,

    **The Total Number of Customers per age group**:

*    Age < 35 = 6
*   Age between 35-50 = 4011
*    Age > 50 = 4227

        We can infer that the **Largest Demographic that Atlas serves are  Customers above 50 years**.

        **The millenial generation and Gen Z harldy purchase Atlas' Products**.

        **We can also infer that Atlas' products are tailored for individuals older than 35 years**.


        **Total number of Customers per age group that are single** 

* Age < 35 = 2
* Age between 35 -50 = 2167
* Age > 50 = 1564

We can infer that single individuals between the ages 35-50 purchase more of Atlas' products


**Total number of Customers per age group that are Married** 

* Age < 35 = 4
* Age between 35-50 = 1844
* Age > 50 = 2657

We can infer that **Married individuals older than 50** purchase more of Atlas' products in this cateory.


**Total Number of Male Customers per Age Demographic**


* Age < 35 = 3
* Age between 35-50 = 2041
* Age > 50 = 2214
* Total Number of Male Customers = 4258

We can infer that **Males older than 50** purchase more of Atlas' products in this category

**Total Number of Female Customers per Age Demographic**

* Age < 35 = 3
* Age between 35-50 = 1970
* Age > 50 = 2013
* Total Number of Female Customers = 3986

We can infer that Females older than 50 purchase more of Atlas" products n this category



**Total number of Male to Female Customers**
 
 * Total Male Customers = 4258
 * Total Female Customers = 3986

We can infer that Atlas has **more male customers than female customers**.








    

