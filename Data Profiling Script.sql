------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*--------------------------------------------- ----------------Customer Data Quality Tests -------------------------------------------------------------------------*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/****** Script for Creating Customer_Master  ******/
DROP TABLE Customer_Master
SELECT [CustomerKey]
      ,[GeographyKey]
      ,[CustomerAlternateKey]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[NameStyle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Suffix]
      ,[Gender]
      ,[EmailAddress]
      ,[YearlyIncome]
      ,[TotalChildren]
      ,[NumberChildrenAtHome]
      ,[EnglishEducation]
      ,[SpanishEducation]
      ,[FrenchEducation]
      ,[EnglishOccupation]
      ,[SpanishOccupation]
      ,[FrenchOccupation]
      ,[HouseOwnerFlag]
      ,[NumberCarsOwned]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[Phone]
      ,[DateFirstPurchase]
      ,[CommuteDistance]
      ,[F30]
      ,[F31]
	  ,1 Total INTO Customer_master
  FROM [Remote].[dbo].[DimCustomer] 
 
SELECT * FROM Customer_Master


------------------------------------------------------/*Start Customer Completeness Tests*/---------------------------------------------------------------
DROP TABLE Customer_completion
SELECT * INTO Customer_completion
FROM (
/*-----------------------------------------------------Completeness_CustomerKey-----------------------------------------------*/
SELECT b.Field, 
	   CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'CustomerKey' Field, 
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE CustomerKey IS NULL) a
JOIN 
(SELECT 'CustomerKey' Field, 
         SUM(total) Total
FROM Customer_master) b 
ON a.Field = b.Field

 UNION ALL

/*----------------------------------------------------Completeness_GeographyKey-------------------------------------------*/
SELECT b.Field, 
	   CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
	  ,b.Total
FROM(
SELECT 'GeographyKey' Field,  
		COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE GeographyKey IS NULL) a
JOIN
(SELECT 'GeographyKey' Field, 
		SUM(Total) Total
FROM Customer_master) b 
ON a.Field = b.Field

 UNION ALL

/*---------------------------------------------Completeness_CustomerAlternateKey-------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'CustomerAlternateKey' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE CustomerAlternateKey IS NULL) a
JOIN
(SELECT 'CustomerAlternateKey' Field,
        SUM(Total) Total
FROM Customer_master) b 
ON a.Field = b.Field

 UNION ALL


/*-------------------------------------------------Completeness_BirthDate--------------------------------------------------*/
SELECT b.Field, 
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'BirthDate' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE BirthDate IS NULL) a
JOIN 
(SELECT 'BirthDate' Field,
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*------------------------------------------------Completeness_Title------------------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'Title' Field, 
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE Title = 'NULL') a
JOIN 
(SELECT 'Title' Field,
         SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*----------------------------------------Completeness_Emailaddress----------------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'EmailAddress' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE EmailAddress IS NULL) a
JOIN 
(SELECT 'EmailAddress' Field, 
         SUM(Total)  AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*---------------------------------------------Completeness_FirstName----------------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'FirstName' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE FirstName IS NULL) a
JOIN 
(SELECT 'FirstName' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-----------------------------------------------Completeness_MiddleName--------------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'MiddleName' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE MiddleName IS NULL) a
JOIN 
(SELECT 'MiddleName' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL



/*------------------------------------------------Completeness_LastName------------------------------------------------------*/
SELECT b.Field, CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
,b.Total
FROM(
SELECT 'LastName' Field,  COUNT(CustomerKey) QualityIssues
FROM Customer_master
WHERE LastName IS NULL) a
JOIN 
(SELECT 'LastName' Field, SUM(total) Total
FROM Customer_master) b 
on a.Field = b.Field

UNION ALL


/*---------------------------------------------Completeness_NameStyle---------------------------------------------*/
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'NameStyle' Field, 
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE NameStyle IS NULL) a
JOIN 
(SELECT 'NameStyle' Field, 
		SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-----------------------------------------Completeness_Phone-----------------------------------------------*/
SELECT b.Field, 
      CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'Phone' Field,  
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE Phone IS NULL) a
JOIN 
(SELECT 'Phone' Field,
         SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-----------------------------------------Completeness_Gender-------------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'Gender' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE Gender IS NULL) a
JOIN 
(SELECT 'Gender' Field,
         SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*---------------------------------------------Completeness_MaritalStatus----------------------------------------*/
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'MaritalStatus' Field, 
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE MaritalStatus IS NULL) a
JOIN 
(SELECT 'MaritalStatus' Field,
         SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL


/*-------------------------------------------Completeness_Suffix-----------------------------------------*/
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'Suffix' Field,  
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE Suffix ='NULL') a
JOIN
(SELECT 'Suffix' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field


UNION ALL

/*-------------------------Completeness_TotalChildren------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'TotalChildren' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE TotalChildren IS NULL) a
JOIN 
(SELECT 'TotalChildren' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL


/*------------------------Completeness_NumberChildrenAtHome------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'NumberChildrenAtHome' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE NumberChildrenAtHome IS NULL) a
JOIN 
(SELECT 'NumberChildrenAtHome' Field,
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-----------------------------Completeness_EnglishEducation---------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'EnglishEducation' Field,  
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE EnglishEducation IS NULL) a
JOIN 
(SELECT 'EnglishEducation' Field, 
       SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*--------------------------------Completeness_SpanishEducation-------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'SpanishEducation' Field,  
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE SpanishEducation IS NULL) a
JOIN 
(SELECT 'SpanishEducation' Field, SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field


UNION ALL
/*---------------------------------------Completeness_FrenchEducation------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'FrenchEducation' Field,
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE FrenchEducation IS NULL) a
JOIN 
(SELECT 'FrenchEducation' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field


UNION ALL

/*------------------------------------------Completeness_EnglishOccupation-------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'EnglishOccupation' Field, 
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE EnglishOccupation IS NULL) a
JOIN 
(SELECT 'EnglishOccupation' Field, SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field


UNION ALL
/*-------------------------------------Completeness_SpanishOccupation--------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'SpanishOccupation' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM  Customer_master
WHERE SpanishOccupation IS NULL) a
JOIN 
(SELECT 'SpanishOccupation' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*------------------------------------Completeness_FrenchOccupation------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'FrenchOccupation' Field,  
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE FrenchOccupation IS NULL) a
JOIN 
(SELECT 'FrenchOccupation' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field


UNION ALL
/*--------------------------Completeness_HouseOwnerFlag--------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'HouseOwnerFlag' Field, 
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE HouseOwnerFlag IS NULL) a
JOIN 
(SELECT 'HouseOwnerFlag' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-------------------------------------Completeness_NumberCarsOwned----------------------------------------------*/
SELECT b.Field, CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
,b.Total
FROM(
SELECT 'NumberCarsOwned' Field,  COUNT(CustomerKey) QualityIssues
FROM Customer_master
WHERE NumberCarsOwned IS NULL) a
JOIN
(SELECT 'NumberCarsOwned' Field, SUM(total) Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-------------------------------------Completeness_YearlyIncome-------------------------------------*/
SELECT b.Field, CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
,b.Total
FROM(
SELECT 'YearlyIncome' Field,  COUNT(CustomerKey) QualityIssues
FROM Customer_master
WHERE YearlyIncome IS NULL) a
JOIN 
(SELECT 'YearlyIncome' Field, SUM(total) Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-----------------------------------------------------Completeness_AddressLine1-----------------------------------------------*/
SELECT b.Field, CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
,b.Total
FROM(
SELECT 'AddressLine1' Field,  COUNT(CustomerKey) QualityIssues
FROM Customer_master
WHERE AddressLine1 IS NULL) a
JOIN 
(SELECT 'AddressLine1' Field, SUM(total) Total
FROM Customer_master) b 
on a.Field = b.Field

UNION ALL

/*-------------------------------------------------Completeness_AddressLine2--------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'AddressLine2' Field, 
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE AddressLine2 = 'NULL') a
JOIN 
(SELECT 'AddressLine2' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field


UNION ALL


/*------------------------------------------------Completeness_CommmuteDistance-----------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'CommuteDistance' Field, 
        COUNT(CustomerKey) AS QualityIssues
FROM  Customer_master
WHERE CommuteDistance IS NULL) a
JOIN 
(SELECT 'CommuteDistance' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field


UNION ALL
/*-------------------------------------------------Completeness_DateFirstPurchase---------------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'DateFirstPurchase' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE DateFirstPurchase IS NULL) a
JOIN 
(SELECT 'DateFirstPurchase' Field, 
         SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*---------------------------------------------------------Completeness_F30-------------------------------------------------------------*/
SELECT b.Field, 
	   CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'F30' Field,  
        COUNT(CustomerKey) AS QualityIssues
FROM  Customer_master
WHERE F30 IS NULL) a
JOIN 
(SELECT 'F30' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

UNION ALL

/*-------------------------------------------------Completness_F31-----------------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'F31' Field,  
       COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE F31 IS NULL) a
JOIN 
(SELECT 'F31' Field, 
        SUM(Total) AS Total
FROM Customer_master) b 
ON a.Field = b.Field

)c

SELECT * FROM Customer_completion


---------------------------------------------------------/*End Customer_Completeness Tests*/-------------------------------------------------------------


-----------------------------------------------------------/* Start Customer Validity Tests/*-------------------------------------------------------------
DROP TABLE Customer_validity

SELECT * INTO Customer_validity
FROM (
/*---------------------------------Validity_CustomerKey---------------------------------------------------*/
SELECT b.Field
      ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM 
(SELECT 'CustomerKey' Field, 
	     COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE CustomerKey IS NOT NULL
AND LEN([CustomerKey]) NOT BETWEEN 5 AND 7
OR [CustomerKey] NOT LIKE '%[0-9]'
) a
JOIN
(SELECT 'CustomerKey' Field,  
         SUM(Total) AS Total 
FROM Customer_master) b
ON a.Field = b.Field

UNION ALL

/*----------------------------------Validity_CustomerAlternateKey----------------------------------------*/
SELECT b.Field
,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
,b.Total
FROM 
(SELECT 'CustomerAlternateKey' Field,
         COUNT(CustomerAlternateKey) AS QualityIssues
FROM Customer_master
WHERE CustomerAlternateKey IS NOT NULL
AND LEN([CustomerAlternateKey]) NOT BETWEEN 10 AND 11
) a
JOIN
(SELECT 'CustomerAlternateKey' Field, 
SUM(Total) AS Total 
FROM Customer_master) b
ON a.Field = b.Field

UNION ALL

/*-----------------------------------Validity_DateFirstPurchase--------------------------------------*/
SELECT b.Field
      ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM 
(SELECT 'DateFirstPurchase' Field,
         COUNT(CustomerKey) AS QualityIssues
FROM Customer_master
WHERE DateFirstPurchase IS NOT NULL
AND CHARINDEX('/',DateFirstPurchase) = 0
) a
JOIN
(SELECT 'DateFirstPurchase' Field,
        SUM(Total)Total FROM Customer_master) b
ON a.Field = b.Field

)c

SELECT * FROM  Customer_validity

-----------------------------------------------------------/* End Customer Validity Tests/*-------------------------------------------------------------


---------------------------------------------------------/*Start Customer Uniqueness Tests*/ -----------------------------------------------------------
DROP TABLE Customer_Uniqueness
SELECT * INTO Customer_Uniqueness FROM (
/*-------------------------Uniqueness_CustomerKey---------------------------------------------*/
SELECT b.Field
      ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.total
FROM
(SELECT 'CustomerKey' Field,
		 COUNT(DISTINCT CustomerKey) AS QualityIssues
FROM Customer_Master
WHERE CustomerKey IN (
SELECT CustomerKey
FROM Customer_Master
WHERE CustomerKey IS NOT NULL
GROUP BY CustomerKey
HAVING COUNT(CustomerKey) > 1) )a 
JOIN 
(SELECT 'CustomerKey' Field, 
        SUM(Total) AS Total 
FROM Customer_Master)b 
ON a.Field = b.Field


UNION ALL
/*--------------------------------------Uniqueness_EmailAddress-----------------------------------*/
SELECT b.Field
       ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.total
FROM
(SELECT 'EmailAddress' Field, 
         COUNT(DISTINCT EmailAddress) AS QualityIssues
FROM Customer_Master
WHERE EmailAddress IN (
SELECT EmailAddress
FROM Customer_Master
WHERE EmailAddress IS NOT NULL
GROUP BY  EmailAddress
HAVING COUNT(EmailAddress) > 1) )a 
JOIN 
(SELECT 'EmailAddress' Field, 
         SUM(Total) AS Total FROM 
Customer_Master)b 
ON a.Field = b.Field

UNION ALL

/*--------------------------------Uniqueness_CustomerAlternateKey----------------------------------*/
SELECT b.Field
      ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.total
FROM
(SELECT 'CustomerAlternateKey' Field,
         COUNT(DISTINCT CustomerAlternateKey) AS QualityIssues
FROM Customer_Master
WHERE CustomerAlternateKey IN 
(SELECT CustomerAlternateKey
FROM Customer_Master
WHERE CustomerAlternateKey IS NOT NULL
GROUP BY  CustomerAlternateKey
HAVING COUNT( CustomerAlternateKey) > 1) )a 
JOIN (SELECT 'CustomerAlternateKey' Field,
              SUM(Total) AS Total FROM Customer_Master)b 
ON a.Field = b.Field

)c

SELECT *  FROM Customer_Uniqueness

-----------------------------------------------------------/* End Customer Uniqueness Tests/*-------------------------------------------------------------


----------------------------------------------------------/*Start Customer Consolidated*/---------------------------------------------------------------
DROP TABLE Customer_Consolidated 

SELECT * INTO Customer_Consolidated 
FROM(
/*---------------------------------Customer_Completion-------------------------------------*/
SELECT 'Completeness' Tag,
        Field,
		QualityIssues,
		Total
FROM Customer_Completion

UNION ALL

/*-------------------------------Customer_Uniqueness----------------------------------------*/
SELECT 'Uniqueness' Tag, 
        Field,
		QualityIssues,
		Total
FROM Customer_Uniqueness

UNION ALL

/*------------------------------Customer_Validity----------------------------------------*/
SELECT 'Validity' Tag, 
        Field,
		QualityIssues, 
		Total
FROM Customer_Validity)a

SELECT * FROM Customer_Consolidated

----------------------------------------------------------/*End Customer_Consolidated*/---------------------------------------------------------------

-------------------------------------------------------------/*End of Customer Data Quality Test*/-----------------------------------------------------------------







------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*--------------------------------------------- ----------------Product Data Quality Tests -------------------------------------------------------*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/****** Script for Creating Product Master Table  ******/

DROP TABLE Product_Master       
SELECT [ProductKey]
      ,[ProductAlternateKey]
      ,[SizeUnitMeasureCode]
      ,[ProductName]
      ,[StandardCost]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
	  ,[ProductSubcategoryKey]
      ,[WeightUnitMeasureCode]
      ,[ListPrice]
      ,[Size]
      ,[SizeRange]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[DealerPrice]
      ,[Class]
      ,[Style]
      ,[ModelName]
      ,[StartDate]
      ,[EndDate]
      ,[Status]
	  ,1 Total INTO Product_Master
  FROM [test].[dbo].[DimProduct]

  

 -----------------------------------------------------/*Start Product Completion Tests*/--------------------------------------------------------------------------
  DROP TABLE Product_completion
  SELECT * INTO Product_completion
  FROM (
/*------------------------------------------------Completeness_ProductKey----------------------------------------------*/

SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'ProductKey' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ProductKey IS NULL) a
JOIN 
(SELECT 'ProductKey' Field, 
        SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL


/*-----------------------------------Completeness ProductAlternateKey--------------------------------------------*/

SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'ProductAlternateKey' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ProductAlternateKey IS NULL) a
JOIN 
(SELECT 'ProductAlternateKey' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL

/*---------------------------Completeness_ProductSubcategoryKey--------------------*/
SELECT b.Field,
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'ProductSubcategoryKey' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ProductSubcategoryKey = 'NULL') a
JOIN 
(SELECT 'ProductSubcategoryKey' Field,
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL

/*-------------------------------Completeness_WeightUnitMeasureCode------------------------------------*/
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'WeightUnitMeasureCode' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE WeightUnitMeasureCode = 'NULL') a
JOIN 
(SELECT 'WeightUnitMeasureCode' Field, 
         SUM(Total)  AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL

/*-------------------------------Completeness_SizeUnitMeasureCode---------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM
(SELECT 'SizeUnitMeasureCode' Field,  
       COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE SizeUnitMeasureCode = 'NULL') a
JOIN 
(SELECT 'SizeUnitMeasureCode' Field, 
        SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL

/*-------------------------------Completeness_ProductName---------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'ProductName' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ProductName = 'NULL') a
JOIN 
(SELECT 'ProductName' Field, 
        SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL

/*------------------------Completeness_StandardCost-----------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues,
	   b.Total
FROM(
SELECT 'StandardCost' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE StandardCost = 'NULL') a
JOIN 
(SELECT 'StandardCost' Field, 
        SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL

/*----Completeness_FinishedGoodsFlag---------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'FinishedGoodsFlag' Field,  COUNT(ProductKey) QualityIssues
FROM Product_Master
WHERE FinishedGoodsFlag IS NULL) a
JOIN
(SELECT 'FinishedGoodsFlag' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL

/*------------------------------Completeness_Color-------------------------*/
SELECT b.Field,
      CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'Color' Field,  COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE Color = 'NA') a
JOIN 
(SELECT 'Color' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL
/*------------Completeness_SafetyStockLevel----------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'SafetyStockLevel' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE SafetyStockLevel IS NULL) a
JOIN 
(SELECT 'SafetyStockLevel' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL
/*---------------------------------Completeness_ReorderPoint------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'ReorderPoint' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ReorderPoint IS NULL) a
JOIN 
(SELECT 'ReorderPoint' Field, 
        SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL
/*----------------------------------Completeness_ListPrice-----------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'ListPrice' Field, 
	    COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ListPrice = 'NULL') a
JOIN 
(SELECT 'ListPrice' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL
/*-------------------------------------------Completeness_Size--------------------------------------*/
 SELECT b.Field, 
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'Size' Field,  
       COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE Size = 'NULL') a
JOIN 
(SELECT 'Size' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL
/*-----------------------------------Completeness_SizeRange------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'SizeRange' Field,  
       COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE SizeRange = 'NA') a
JOIN 
(SELECT 'SizeRange' Field, 
        SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL

/*--------------------------Completeness_Weight---------------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'Weight' Field,  
       COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE Weight = 'NULL') a
JOIN 
(SELECT 'Weight' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL

/*--------------------Completeness_DaysToManufacture-------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'DaysToManufacture' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE DaysToManufacture IS NULL) a
JOIN 
(SELECT 'DaysToManufacture' Field,
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL
/*-----------------------------------Completeness_ProductLine---------------------------------------*/
 SELECT b.Field, 
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'ProductLine' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ProductLine = 'NULL') a
JOIN 
(SELECT 'ProductLine' Field,
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field

UNION ALL

/*----------------------------Completeness_DealerPrice--------------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'DealerPrice' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE DealerPrice = 'NULL') a
JOIN 
(SELECT 'DealerPrice' Field, SUM(total) Total
FROM Product_Master) b 
on a.Field = b.Field


UNION ALL
/*---------------------------Completeness_Class---------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'Class' Field,  
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE Class = 'NULL') a
JOIN 
(SELECT 'Class' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL
/*--------------------------------Completeness_Style-------------------------------*/
SELECT b.Field, 
      CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'Style' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE Style = 'NULL') a
JOIN 
(SELECT 'Style' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL
/*--------Completeness_ModelName-------------------------------*/
SELECT b.Field, 
CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
,b.Total
FROM(
SELECT 'ModelName' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ModelName = 'NULL') a
JOIN
(SELECT 'ModelName' Field, SUM(Total) Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL

/*-------------------------------------Completeness_StartDate---------------------------------*/
SELECT b.Field, 
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'StartDate' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE StartDate IS NULL ) a
JOIN 
(SELECT 'StartDate' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL
/*----------------------------------Completeness_EndDate---------------------------------*/
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'EndDate' Field,  
        COUNT(ProductKey) QualityIssues
FROM Product_Master
WHERE EndDate = 'NULL' OR EndDate IS NULL ) a
JOIN 
(SELECT 'EndDate' Field, 
         SUM(Total) AS Total
FROM Product_Master) b 
ON a.Field = b.Field


UNION ALL
/*---------------------------------Completeness_Status-----------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'Status' Field, 
        COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE Status = 'NULL' OR Status IS NULL) a
JOIN 
(SELECT 'Status' Field, 
         SUM(Total)  AS Total
FROM Product_Master) b 
ON a.Field = b.Field
)c

SELECT * FROM Product_Completion
--------------------------------------------/*End Product Completion Tests*/--------------------------------------------------






 --------------------------------------------/*Beginning of Product Validity Tests*/-----------------------------------------------------------------


DROP TABLE Product_Validity
SELECT * INTO Product_Validity FROM (
/*-------------------------------------------Validity_ProductKey--------------------------------------------*/
SELECT b.Field
	  ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM 
(SELECT 'ProductKey' Field, 
         COUNT(ProductKey) AS QualityIssues
FROM Product_Master
WHERE ProductKey IS NOT NULL
AND ProductKey NOT BETWEEN 1 AND 1000
OR [ProductKey] NOT LIKE '%[0-9]'
) a
JOIN
(SELECT 'ProductKey' Field,  
         SUM(Total) AS Total 
FROM Product_Master) b
ON a.Field = b.Field

UNION ALL
/*---------------------------------------Validity_ProductAlternateKey---------------------------------*/
SELECT b.Field
      ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM 
(SELECT 'ProductAlternateKey' Field, 
         COUNT(Productkey) AS QualityIssues
FROM Product_Master
WHERE ProductAlternateKey IS NOT NULL
AND LEN([ProductAlternateKey]) NOT BETWEEN 7 AND 10
) a
JOIN 
(SELECT 'ProductAlternateKey' Field, 
         SUM(Total) AS Total 
FROM Product_Master) b
ON a.Field = b.Field

)c

 SELECT * FROM Product_validity

---------------------------------------------------/*End of Product Validity Tests*/-----------------------------------------------------------------


--------------------------------------------/*Start  Product_Uniqueness Tests*/-----------------------------------------------------------------

DROP TABLE Product_Uniqueness
SELECT * INTO Product_Uniqueness FROM (
/*------------------------------------Uniqueness_ProductKey---------------------------------------*/

SELECT b.Field
      ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.total
FROM
(SELECT 'ProductKey' Field,
         COUNT(DISTINCT ProductKey) AS QualityIssues
FROM Product_Master
WHERE ProductKey IN (
SELECT ProductKey
FROM Product_Master
WHERE ProductKey IS NOT NULL
GROUP BY ProductKey
HAVING COUNT(ProductKey) > 1) 
)a 
JOIN
(SELECT 'ProductKey' Field,
         SUM(Total) AS Total 
FROM Product_Master)b 
ON a.Field = b.Field

UNION ALL
/*------------------------Uniqueness_ProductName------------------------------*/
SELECT b.Field
	  ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
	   ,b.total
FROM
(SELECT 'ProductName' Field,
         COUNT(DISTINCT ProductName) AS QualityIssues
FROM Product_Master
WHERE ProductName IN (
SELECT ProductName
FROM Product_Master
WHERE ProductName IS NOT NULL
GROUP BY ProductName
HAVING COUNT(ProductName) > 1) 
)a 
JOIN (SELECT 'ProductName' Field, 
SUM(Total) AS Total 
FROM Product_Master)b 
ON a.Field = b.Field


UNION ALL
/*------------------------------Uniqueness_ProductAlternateKey-------------------------*/
SELECT b.Field
	  ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.total
FROM
(SELECT 'ProductAlternateKey' Field,
         COUNT(DISTINCT ProductAlternateKey) AS QualityIssues
FROM Product_Master
WHERE ProductAlternateKey IN (
SELECT ProductAlternateKey
FROM Product_Master
WHERE ProductAlternateKey IS NOT NULL
GROUP BY ProductAlternateKey
HAVING COUNT(ProductAlternateKey) > 1) 
)a 
JOIN 
(SELECT 'ProductAlternateKey' Field, 
         SUM(Total) AS Total 
FROM Product_Master)b 
ON a.Field = b.Field

)c
---------------------------------------------/*End of Product_Uniqueness Tests*/------------------------------------------------------------------



---------------------------------------------/Start Product_Consilidated*/-------------------------------------------------------------------

DROP TABLE Product_Consolidated
SELECT * INTO Product_Consolidated FROM(
/*-------------------------------Completeness Consolidated------------------------------*/
SELECT 'Completeness' Tag, 
        Field,
		QualityIssues 
		,Total
FROM Product_completion

UNION ALL
/*-------------------------------Uniqueness Consolidated---------------------------------*/
SELECT 'Uniqueness' Tag, 
        Field,
		QualityIssues,
		Total
FROM Product_uniqueness

UNION ALL
/*-------------------------------Validity Consolidated----------------------------------*/

SELECT 'Validity' Tag, 
        Field,
		QualityIssues,
		Total
FROM Product_validity)a
 
SELECT * FROM Product_Consolidated

--------------------------------------------/*End Product_Consolidated*/-----------------------------------------------------------------

 --------------------------------------------/*End Product Data Quality Tests*/-----------------------------------------------------------------









 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*--------------------------------------------- ----------------Account Data Quality Tests -------------------------------------------------------*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/****** Script for Creating Account Master Table ******/
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
	  , 1 Total INTO Account_Master
 FROM [test].[dbo].[DimAccounts]

 SELECT * FROM Account_Master

------------------------------------------------/* Start Account Completion Tests*/-----------------------------------------------------------------

DROP TABLE Account_Completion

SELECT * INTO Account_Completion
FROM( 
/*----------------------------------Completeness_AccountKey-------------------------------------------------*/
SELECT b.Field, 
	   CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
	   ,b.Total
FROM(
SELECT 'AccountKey' Field,  
		COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE AccountKey IS NULL
) a
JOIN 
(SELECT 'AccountKey' Field, 
	     SUM(total) Total
FROM Account_Master) b 
ON a.Field = b.Field


UNION ALL
/*---------------------------------Completeness_ParentAccountKey-------------------------------------------*/
SELECT b.Field, 
	  CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues,
       b.Total
FROM(
SELECT 'ParentAccountKey' Field,  
	   COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE ParentAccountKey IS NULL) a
JOIN
(SELECT 'ParentAccountKey' Field, 
		SUM(Total) AS Total
FROM Account_Master) b 
ON a.Field = b.Field


UNION ALL
/*-------------------------------Completeness_AccountCodeAlternateKey---------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM(
SELECT 'AccountCodeAlternateKey' Field,  
        COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE AccountCodeAlternateKey IS NULL
) a
JOIN
(SELECT 'AccountCodeAlternateKey' Field, 
        SUM(Total) AS Total
FROM Account_Master) b 
ON a.Field = b.Field



UNION ALL
/*------------------------Completeness_AccountDescription----------------------*/
 SELECT b.Field, 
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
        ,b.Total
FROM(
SELECT 'AccountDescription' Field,  
        COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE AccountDescription IS NULL) a
JOIN
(SELECT 'AccountDescription' Field,
        SUM(Total) AS Total
FROM Account_Master) b 
ON a.Field = b.Field


UNION ALL

/*------------------------------------Completeness_AccountType--------------------------------------*/
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'AccountType' Field, 
        COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE AccountType = 'NULL') a
JOIN
(SELECT 'AccountType' Field, 
        SUM(Total) AS Total
FROM Account_Master) b 
ON a.Field = b.Field



UNION ALL
/*------------------------------------Completeness_Operator---------------------------------------------*/
 SELECT b.Field,
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
        ,b.Total
FROM(
SELECT 'Operator' Field,  
        COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE Operator IS NULL) a
JOIN
(SELECT 'Operator' Field, 
         SUM(Total) AS Total
FROM Account_Master) b 
ON a.Field = b.Field

UNION ALL

/*-------------------------------Completeness_CustomMembers---------------------------------------------*/
 SELECT b.Field, CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
,b.Total
FROM(
SELECT 'CustomMembers' Field,  COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE CustomMembers = 'NULL') a
JOIN
(SELECT 'CustomMembers' Field, 
        SUM(Total) AS Total
FROM Account_Master) b 
ON a.Field = b.Field


UNION ALL

/*---------------------------------------Completeness_ValueType---------------------------------*/
SELECT b.Field, 
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'ValueType' Field,   
        COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE ValueType = 'NULL'
) a
JOIN
(SELECT 'ValueType' Field,
        SUM(Total)  AS Total
FROM Account_Master) b 
ON a.Field = b.Field

UNION ALL

/*----------------------------Completeness_CustomMemberOptions---------------------*/
 SELECT b.Field, 
        CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
       ,b.Total
FROM(
SELECT 'CustomMemberOptions' Field,  
        COUNT(AccountKey) AS QualityIssues
FROM  Account_Master
WHERE CustomMemberOptions = 'NULL') a
JOIN
(SELECT 'CustomMemberOptions' Field, 
         SUM(Total) AS Total
FROM Account_Master) b 
ON a.Field = b.Field

)c

SELECT * FROM Account_Completion
-------------------------------------------/*END of Account Completness Tests*/-------------------------------------------------------------------




--------------------------------------------/*Start Account Validity Tests*/-----------------------------------------------------------------
DROP TABLE Account_Validity
SELECT * INTO Account_Validity
FROM (
/*-------------------------------Validity_AccountKey------------------------*/
SELECT b.Field,
	   CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
	   ,b.Total
FROM 
(SELECT 'AccountKey' Field, 
		 COUNT(AccountKey) AS QualityIssues
FROM Account_Master
WHERE AccountKey IS NOT NULL
AND AccountKey NOT BETWEEN 1 AND 150
OR AccountKey NOT LIKE '%[0-9]'
) a
JOIN
(SELECT 'AccountKey' Field,  
		SUM(Total) AS Total
FROM Account_Master) b
ON a.Field = b.Field

UNION ALL

/*-------------------------------Validity_AccountCodeAlternateKey---------------------------*/
SELECT b.Field,
	   CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.Total
FROM 
(SELECT 'AccountCodeAlternateKey' Field, 
		COUNT(Accountkey) AS QualityIssues
FROM Account_Master
WHERE AccountCodeAlternateKey IS NOT NULL
AND AccountCodeAlternateKey NOT BETWEEN 1 AND 10000
OR AccountCodeAlternateKey NOT LIKE '%[0-9]'
) a
JOIN
(SELECT 'AccountCodeAlternateKey' Field,
		SUM(Total) AS Total 
FROM Account_Master) b
ON a.Field = b.Field

)c

SELECT * FROM Account_Validity
--------------------------------------------/*End Account Validity Tests*/-----------------------------------------------------------------


-------------------------------------------/*Start Account Uniqueness Tests*/-----------------------------------------------------------------

DROP TABLE Account_Uniqueness

SELECT * INTO Account_uniqueness FROM (
/*------------------------------------------Uniqueness_AccountKey--------------------------------------------------*/
SELECT b.Field,
       CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.total
FROM
(SELECT 'AccountKey' Field,
        COUNT(DISTINCT AccountKey) AS QualityIssues
FROM Account_Master
WHERE AccountKey IN (
SELECT AccountKey
FROM Account_Master
WHERE AccountKey IS NOT NULL
GROUP BY AccountKey
HAVING COUNT(AccountKey) > 1) )a 
JOIN
(SELECT 'AccountKey' Field,
        SUM(Total) AS Total 
FROM Account_Master)b 
ON a.Field = b.Field

UNION ALL
/*---------------------------------------------Uniqueness_AccountCodeAlternateKey----------------------------------------*/
SELECT b.Field
      ,CASE WHEN a.QualityIssues IS NULL THEN 0 ELSE a.QualityIssues END AS QualityIssues
      ,b.total
FROM
(SELECT 'AccountCodeAlternateKey' Field,count(distinct AccountCodeAlternateKey) QualityIssues
FROM Account_Master
WHERE AccountCodeAlternateKey IN (
SELECT AccountCodeAlternateKey
FROM Account_Master
WHERE AccountCodeAlternateKey IS NOT NULL
GROUP BY AccountCodeAlternateKey
HAVING COUNT(AccountCodeAlternateKey) > 1) 
)a 
JOIN(SELECT 'AccountCodeAlternateKey' Field, 
              SUM(Total) AS Total 
FROM Account_Master)b 
ON a.Field = b.Field

)c

SELECT * FROM Account_Uniqueness

-------------------------------------------------------/*End Account Uniqueness Tests*/-----------------------------------------------------------------





---------------------------------------------------------/*Start Account Consolidation*/-----------------------------------------------------------------
DROP TABLE Account_Consolidated

SELECT * INTO Account_Consolidated FROM(
/*------------------------------------Completeness Consolidated-------------------------------*/
SELECT 'Completeness' Tag, 
        Field,
		QualityIssues,
		Total
FROM Account_Completion

/*-------------------------------------Uniqueness Consolidated-----------------------------------*/
UNION ALL
SELECT 'Uniqueness' Tag, 
        Field,
		QualityIssues,
		Total
FROM Account_uniqueness

UNION ALL
/*--------------------------------------Validity Consolidated--------------------------------------*/
SELECT 'Validity' Tag, 
        Field,
		QualityIssues,
		Total
FROM Account_validity)a


SELECT * FROM Account_Consolidated
--------------------------------------------/*End Account_Consolidated*/-----------------------------------------------------------------

--------------------------------------------/*End of Account Data Quality Tets*/-----------------------------------------------------------------