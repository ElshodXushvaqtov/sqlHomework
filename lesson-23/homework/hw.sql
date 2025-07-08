1.
SELECT
    Id,
    Dt,
    FORMAT(Dt, 'MM') AS MonthPrefixedWithZero
FROM Dates;

2.
SELECT
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT
        Id,
        rID,
        MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS SubQuery
GROUP BY rID;

3.
SELECT
    Id,
    Vals
FROM TestFixLengths
WHERE LEN(Vals) >= 6 AND LEN(Vals) <= 10;

4.
SELECT
    t.ID,
    t.Item,
    t.Vals
FROM TestMaximum t
INNER JOIN (
    SELECT
        ID,
        MAX(Vals) AS MaxVals
    FROM TestMaximum
    GROUP BY ID
) AS sub
ON t.ID = sub.ID AND t.Vals = sub.MaxVals;

5.
SELECT
    Id,
    SUM(MaxVals) AS SumofMax
FROM (
    SELECT
        DetailedNumber,
        Id,
        MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY DetailedNumber, Id
) AS SubQuery
GROUP BY Id;

6.
SELECT
    Id,
    a,
    b,
    CASE
        WHEN (a - b) = 0 THEN ''
        ELSE CAST((a - b) AS VARCHAR(20))
    END AS OUTPUT
FROM TheZeroPuzzle;

7.
SELECT
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;

8.
SELECT
    AVG(UnitPrice) AS AverageUnitPrice
FROM Sales;

9.
SELECT
    COUNT(SaleID) AS NumberOfTransactions
FROM Sales;

10.
SELECT
    MAX(QuantitySold) AS HighestUnitsSold
FROM Sales;

11.
SELECT
    Category,
    SUM(QuantitySold) AS TotalProductsSold
FROM Sales
GROUP BY Category
ORDER BY Category;

12.
SELECT
    Region,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region
ORDER BY Region;

13.
SELECT TOP 1
    Product,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

14.
SELECT
    SaleID,
    SaleDate,
    Product,
    (QuantitySold * UnitPrice) AS SaleRevenue,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate, SaleID) AS RunningTotalRevenue
FROM Sales
ORDER BY SaleDate, SaleID;

15.
SELECT
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    (SUM(QuantitySold * UnitPrice) * 100.0 / (SELECT SUM(QuantitySold * UnitPrice) FROM Sales)) AS PercentageContribution
FROM Sales
GROUP BY Category
ORDER BY PercentageContribution DESC;

17.
SELECT
    s.SaleID,
    s.Product,
    s.Category,
    s.QuantitySold,
    s.UnitPrice,
    s.SaleDate,
    s.Region,
    c.CustomerName
FROM Sales AS s
JOIN Customers AS c
ON s.CustomerID = c.CustomerID
ORDER BY c.CustomerName, s.SaleDate;

18.
SELECT
    c.CustomerName
FROM Customers AS c
LEFT JOIN Sales AS s
ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL
ORDER BY c.CustomerName;

19.
SELECT
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers AS c
JOIN Sales AS s
ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

20.
SELECT TOP 1
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers AS c
JOIN Sales AS s
ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

21.
SELECT
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalSales
FROM Customers AS c
JOIN Sales AS s
ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalSales DESC;

22.
ELECT DISTINCT
    p.ProductName
FROM Products AS p
JOIN Sales AS s
ON p.ProductName = s.Product
ORDER BY p.ProductName;

23.
SELECT TOP 1
    ProductName,
    SellingPrice
FROM Products
ORDER BY SellingPrice DESC;

24.
SELECT
    p.ProductName,
    p.Category,
    p.SellingPrice
FROM Products AS p
JOIN (
    SELECT
        Category,
        AVG(SellingPrice) AS AverageSellingPrice
    FROM Products
    GROUP BY Category
) AS CategoryAvg
ON p.Category = CategoryAvg.Category
WHERE p.SellingPrice > CategoryAvg.AverageSellingPrice
ORDER BY p.Category, p.ProductName;
