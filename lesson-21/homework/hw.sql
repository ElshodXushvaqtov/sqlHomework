1.
SELECT SaleID, ProductName, SaleDate, 
       ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

2.
SELECT ProductName,
       SUM(Quantity) AS TotalQuantity,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS QuantityRank
FROM ProductSales
GROUP BY ProductName;

3.
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) t
WHERE rn = 1;

4.
SELECT SaleID, SaleDate, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

5.
SELECT SaleID, SaleDate, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales;

6.
SELECT *
FROM (
    SELECT *, LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) t
WHERE SaleAmount > PrevAmount;

7.
SELECT SaleID, ProductName, SaleAmount,
       LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS Difference
FROM ProductSales;

8.
SELECT SaleID, ProductName, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextAmount,
       (CAST(LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS FLOAT) - SaleAmount) * 100.0 / SaleAmount AS PercentChange
FROM ProductSales;

9.
SELECT SaleID, ProductName, SaleAmount,
       LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount,
       CAST(SaleAmount AS FLOAT) / NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS SaleRatio
FROM ProductSales;

10.
SELECT SaleID, ProductName, SaleAmount,
       FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FirstSale,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;

11.
SELECT *
FROM (
    SELECT *, LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) t
WHERE SaleAmount > PrevAmount;

12.
SELECT SaleID, SaleDate, SaleAmount,
       SUM(SaleAmount) OVER (ORDER BY SaleDate) AS RunningTotal
FROM ProductSales;

13.
SELECT SaleID, SaleDate, SaleAmount,
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM ProductSales;

14.
SELECT SaleID, SaleAmount,
       SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;

15.
WITH Ranked AS (
    SELECT *, 
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
),
RankCounts AS (
    SELECT SalaryRank
    FROM Ranked
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
SELECT r.*
FROM Ranked r
JOIN RankCounts rc ON r.SalaryRank = rc.SalaryRank;

16.
SELECT *
FROM (
    SELECT *, DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptSalaryRank
    FROM Employees1
) t
WHERE DeptSalaryRank <= 2;

17.
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees1
) t
WHERE rn = 1;

18.
SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees1;

19.
SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotalSalary
FROM Employees1;

20.
SELECT *, 
       AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary
FROM Employees1;

21.
SELECT *, 
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromAvg
FROM Employees1;

22.
SELECT *, 
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvgSalary
FROM Employees1;

23.
SELECT SUM(Salary) AS SumLast3Hired
FROM (
    SELECT Salary
    FROM Employees1
    ORDER BY HireDate DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) t;
