/*------------------CREATE INDEXES FOR OPTIMIZATION---------------------------------------------------*/
CREATE INDEX idx_productname ON DimProduct(ProductName)
CREATE INDEX idx_orderdate ON FactResellerSales(OrderDate)
CREATE INDEX idx_orderdate_productkey ON FactResellerSales(OrderDate,ProductKey)


/*------------------------------------------------Question 1---------------------------------------------- */
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



/*-------------------------------------------------------Question 2---------------------------------------------------------*/

SELECT Month, 
      ProductName, 
	  SalesAmount, 
	  SalesTerritoryCountry
FROM (
SELECT DATENAME(MONTH,OrderDate) AS Month,
       b.ProductName as ProductName, SUM(a.SalesAmount) AS SalesAmount,
	   c.SalesTerritoryCountry AS SalesTerritoryCountry,
       ROW_NUMBER() OVER(PARTITION by DATENAME(month,OrderDate) 
	   ORDER BY SUM(SalesAmount) ASC) AS SalesRanking
FROM FactResellerSales a 
JOIN  DimProduct b ON a.productkey =  b.ProductKey 
JOIN DimSalesTerritory c ON a.SalesTerritoryKey = c.SalesTerritoryKey 
WHERE Year(OrderDate) = '2012' 
GROUP BY DATENAME(MONTH,OrderDate), ProductName, SalesTerritoryCountry
) Ranks
WHERE SalesRanking = 1
	
	



/*----------------------------------------------Question 3------------------------------------------------------*/
SELECT da.AccountType,
	   AVG(CASE WHEN d.ScenarioName = 'Actual' THEN F.Amount ELSE 0 END ) AS Actual_Scenario,
	   AVG(CASE WHEN d.ScenarioName ='Budget' THEN f.Amount ELSE 0 END) AS Budget_Scenario,
       AVG(CASE WHEN d.ScenarioName = 'Forecast' THEN f.Amount ELSE 0 END) AS Forecast_Scenario
FROM FactFinance f 
JOIN DimScenario d ON f.ScenarioKey=d.ScenarioKey
JOIN DimAccounts da ON f.AccountKey=da.AccountKey
WHERE YEAR(f.Date) = '2011'
GROUP BY da.AccountType





/*-------------------------------------------------Question 4---------------------------------------------------*/

SELECT f.ProductKey, 
       SUM(f.SalesAmount) AS SalesAmount, 
	   CONCAT(DATENAME(MONTH,f.OrderDate), ', ',YEAR(f.OrderDate)) AS OrderMonth
FROM FactResellerSales f 
JOIN DimProduct d 
ON f.ProductKey = d.ProductKey
WHERE YEAR(f.OrderDate) ='2012'
GROUP BY  f.OrderDate,f.ProductKey
ORDER BY  OrderDate,f.ProductKey




/*------------------------------------------------------Question 5----------------------------------------------------*/

SELECT CASE MaritalStatus WHEN 'M' THEN 'Married' ELSE 'Single' END AS  MaritialStatus, 
	   CASE Gender WHEN 'M' THEN 'Male' ELSE 'Female' END AS Gender,
       COUNT(CASE WHEN (YEAR(GETDATE())-YEAR(BirthDate)) < 35 THEN ' ' END) AS 'Age < 35',
	   COUNT(CASE  WHEN ((YEAR(GETDATE())-YEAR(BirthDate)) >= 35) AND ((YEAR(GETDATE())-YEAR(BirthDate)) <= 50) THEN ' '  END) AS 'Age between 35-50',
       COUNT(CASE  WHEN (YEAR(GETDATE())-YEAR(BirthDate)) > 50 THEN ' ' END) AS 'Age > 50'
FROM  DimCustomer
WHERE BirthDate IS NOT NULL 
AND YEAR(GETDATE()) > YEAR(BirthDate)
GROUP BY  MaritalStatus, Gender










