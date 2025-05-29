1.
select o.OrderID, c.FirstName as CustomerName, o.OrderDate from Orders as o
inner join Customers as c on c.CustomerID = o.CustomerID
where year(o.OrderDate)>'2022';

2.
select e.Name as EmployeeName, d.DepartmentName from Employees as e
inner join Departments as d on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales','Marketing');

3.
select d.DepartmentName, max(e.Salary) as MaxSalary from Departments as d
inner join Employees as e on e.DepartmentID = d.DepartmentID
group by d.DepartmentName;

4.
select c.FirstName as CustomerName, o.OrderID, o.OrderDate from Orders as o
inner join Customers as c on c.CustomerID = o.CustomerID
where year(o.OrderDate) = '2023' and c.Country = 'USA';

5.
select c.FirstName as CustomerName, count(o.OrderID) as TotalOrders from Customers as c
inner join Orders as o on c.CustomerID = o.CustomerID
group by c.CustomerID, c.FirstName;

6.
select p.ProductName, s.SupplierName from Products as p
inner join Suppliers as s on p.SupplierID = s.SupplierID
where s.SupplierName in ('Gadget Supplies','Clothing Mart');

7.
select c.FirstName as CustomerName, max(o.OrderDate) as MostRecentOrder from Customers as c
left join Orders as o on c.CustomerID = o.CustomerID
group by c.CustomerID, c.FirstName;

8.
select c.FirstName as CustomerName, sum(o.TotalAmount) as OrderTotal from Customers as c
inner join Orders as o on o.CustomerID = c.CustomerID
group by c.FirstName
having sum(o.TotalAmount) > 500;

9.
select p.ProductName, s.SaleDate, s.SaleAmount from Products as p 
inner join Sales as s on p.ProductID = s.ProductID
where year(s.SaleDate) = '2022' or s.SaleAmount > 400;

10.
select p.ProductName, sum(s.SaleAmount) as TotalSalesAmount from Products as p 
inner join Sales as s on s.ProductID = p.ProductID
group by p.ProductName;

11.
select e.Name as EmployeeName, d.DepartmentName, e.Salary from Employees as e 
inner join Departments as d on e.DepartmentID = d.DepartmentID 
where d.DepartmentName = 'Human Resources' and  e.Salary > 60000;

12.
select p.ProductName, s.SaleDate, p.StockQuantity from Products as p
inner join Sales as s on p.ProductID = s.ProductID
where year(s.SaleDate) = '2023' and p.StockQuantity > 100;

13.
select e.Name as EmployeeName, d.DepartmentName, e.HireDate from Employees as e
inner join Departments as d on d.DepartmentID = e.DepartmentID
where d.DepartmentName = 'Sales' or year(e.HireDate) > '2020';

14.
select c.FirstName as CustomerName, o.OrderID, c.Address, o.OrderDate from Customers as c
inner join Orders as o on c.CustomerID = o.CustomerID
where c.Address like '____%' and c.Country = 'USA';

15.
select p.ProductName, p.Category, s.SaleAmount from Products as p 
inner join Sales as s on p.ProductID = s.ProductID
where p.Category = 1 or s.SaleAmount > 350;

16.
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM Categories AS c
LEFT JOIN Products AS p ON c.CategoryID = p.Category
GROUP BY c.CategoryName;

17.
select c.FirstName as CustomerName, c.City, o.OrderID, o.TotalAmount as Amount from Customers as c
inner join Orders as o on o.CustomerID = c.CustomerID
where c.City = 'Los Angeles' and o.TotalAmount > 300;

18.
select e.Name as EmployeeName, d.DepartmentName from Employees as e
inner join Departments as d on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Human Resources','Finance') 
or (
        LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'a', '')) +
        LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'e', '')) +
        LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'i', '')) +
        LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'o', '')) +
        LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'u', ''))
    ) >= 4;

19.
select e.Name as EmployeeName, d.DepartmentName, e.Salary from Employees as e
inner join Departments as d on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales','Marketing') and e.Salary > 60000;


