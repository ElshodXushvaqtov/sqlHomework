1.
select Category, sum(StockQuantity) as Total_Products from Products
group by Category;

2.
select Category, avg(Price) as Avg_Price from Products
group by Category
having Category = 'Electronics';

3.
select FirstName+' '+LastName as FullName,City from Customers
where City like 'L%';

4.
select ProductName from Products
where ProductName like '%er';

5.
select FirstName+' '+LastName as FullName,Country from Customers
where Country like '%A';

6.
select top (1) ProductName, Price from Products
order by Price desc;

7.
select *, case when StockQuantity < 30 then 'Low Stock' else 'Sufficient' end as Stock_Status from Products; 

8.
select Country, count(CustomerID) as Total_Customers from Customers
group by Country;

9.
SELECT
    MIN(Quantity) AS Min_Quantity,
    MAX(Quantity) AS Max_Quantity
FROM Orders;

10.
SELECT DISTINCT o.CustomerID FROM Orders AS o
WHERE o.OrderDate >= '2023-01-01' AND o.OrderDate < '2023-02-01' AND o.CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Invoices);

11.
select ProductName from Products
union all
select ProductName from Products_Discounted;

12.
select ProductName from Products
union
select ProductName from Products_Discounted;

13.
select Year(OrderDate) as Order_Year, avg(TotalAmount) as Avg_OrderAmount from Orders
group by Year(OrderDate);

14.
select ProductName, case when Price < 100 then 'Low' when Price between 100 and 500 then 'Mid' else 'High' end as Pricegroup from Products;

15.
CREATE TABLE Population_Each_Year (
    [2012] INT,
    [2013] INT
);
INSERT INTO Population_Each_Year ([2012], [2013])
SELECT [2012], [2013]
FROM
(
    SELECT Year, Population
    FROM City_Population
    WHERE Year IN (2012, 2013)
) AS Source_Table
PIVOT
(
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;


16.
select ProductID, sum(SaleAmount) as Total_Sales from Sales
group by ProductID;

17.
select ProductName from Products
where ProductName like '%oo%';

18.
CREATE TABLE Population_Each_City (
    [Bektemir] INT,
    [Chilonzor] INT,
	[Yakkasaroy] INT
);
INSERT INTO Population_Each_City ([Bektemir], [Chilonzor], [Yakkasaroy])
SELECT [Bektemir], [Chilonzor], [Yakkasaroy]
FROM
(
    SELECT district_name, Population
    FROM City_Population
    WHERE district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) AS Source_Table
PIVOT
(
    SUM(Population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;

19.
select top (3) CustomerID, sum(TotalAmount) as TotalSpent from Invoices
group by CustomerID
order by max(TotalAmount) desc;

20.
SELECT
    CAST(year AS INT) AS Year,
    Population
FROM
    Population_Each_Year
UNPIVOT
(
    Population FOR year IN ([2012], [2013])
) AS UnpivotedData;

21.
select P.ProductName, count(SaleID) as Total_Sale from Products as P
inner join Sales as S on P.ProductID = S.ProductID
group by P.ProductName;

22.
SELECT
    CAST(district_name AS varchar(50)) AS district_name,
    Population
FROM
    Population_Each_City
UNPIVOT
(
    Population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS UnpivotedData;
