1.
select min(Price) as MIN_Price from Products;

2.
select max(Salary) as MAX_Salary from Employees;

3.
select count(*) as Rows_Count from Customers;

4.
select count(distinct(Category)) from Products;

5.
select sum(SaleAmount) as TotalSalesAmount from Sales
where ProductID = 7;

6.
select avg(Age) as AVG_Age from Employees;

7.
select count(EmployeeID) as EmployeesNumber, DepartmentName from Employees
group by DepartmentName;

8.
select min(Price) as MIN_Price, max(Price) as MAX_Price, Category from Products
group by Category;

9.
select CustomerID, sum(SaleAmount) as Total_Sales from Sales
group by CustomerID;

10.
select count(EmployeeID) as EmployeesNumber, DepartmentName from Employees
group by DepartmentName
having count(EmployeeID)>5;

11.
SELECT
        p.Category,
        SUM(s.SaleAmount) AS Total_Sale,
        AVG(s.SaleAmount) AS Avg_Sale
    FROM
        Sales AS s
    JOIN
        Products AS p ON s.ProductID = p.ProductID
    GROUP BY
        p.Category;


12.
select DepartmentName, count(EmployeeID) as Number_Employee from Employees
group by DepartmentName
having DepartmentName = 'HR';

13.
select DepartmentName, max(Salary) as Max_Salary, min(Salary) as Min_Salary from Employees
group by DepartmentName;

14.
select DepartmentName, avg(Salary) as Avg_Salary from Employees
group by DepartmentName;

15.
select DepartmentName,count(*) as Number_Employee,avg(Salary) as Avg_Salary from Employees
group by DepartmentName;

16.
select Category, avg(Price) as Avg_Price from Products
group by Category
having avg(Price)>400;

17.
SELECT YEAR(SaleDate) AS SaleYear, SUM(SaleAmount) AS Total_Sales FROM Sales
GROUP BY YEAR(SaleDate);

18.
select CustomerID, count(OrderID) as Orders_Number from Orders
group by CustomerID
having count(OrderID) >= 3;

19.
select DepartmentName, AVG(Salary) AS AVG_Salary FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

20.
select Category, avg(Price) as Avg_Price from Products
group by Category
having avg(Price) > 150;

21.
select CustomerID, sum(SaleAmount) as Total_Sales from Sales
group by CustomerID
having sum(SaleAmount) > 1500;

22.
select DepartmentName, sum(Salary) as Total_Salary, avg(Salary) as Avg_Salary from Employees
group by DepartmentName
having avg(Salary) > 65000;

23.
SELECT custid, SUM(CASE WHEN freight > 50 THEN freight ELSE 0 END) AS Total_Weight,
    MIN(freight) AS Least_PurchaseAmount
FROM
    TSQL2012.Sales.Orders
GROUP BY
    custid
ORDER BY
    custid;

24.
SELECT
    YEAR (OrderDate) AS SalesYear,
    MONTH (OrderDate) AS SalesMonth,
    SUM(TotalAmount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS UniqueProductsSold
FROM
    Orders
GROUP BY
    YEAR (OrderDate),
    MONTH (OrderDate)
HAVING
    COUNT(DISTINCT ProductID) >= 2
ORDER BY
    SalesYear,
    SalesMonth;

25.
select year(OrderDate) as Order_Year, min(Quantity) as Min_Quantity, max(Quantity) as Max_Quantity from Orders
group by year(OrderDate);
