1.
select ProductID, Price, Category, StockQuantity, ProductName as Name from Products;

2.
select * from Customers as Clients;

3.
select ProductName from Products
union
select ProductName from Products_Discounted;

4.
select ProductName from Products
intersect
select ProductName from Products_Discounted;

5.
select distinct FirstName+' '+LastName as FullName, Country from Customers;

6.
select *, case when Price > 1000 then 'High' else 'Low' end as Status from Products;

7.
select *, iif(StockQuantity > 100, 'Yes', 'No') as Status from Products_Discounted;

8.
select ProductName from Products
union
select ProductName from Products_Discounted;

9.
select * from Products
except
select * from Products_Discounted;

10.
select *, iif(Price > 1000, 'Expensive', 'Affordable') as Status from Products;

11.
select * from Employees
where Age < 25 or Salary > 60000;

12.
update Employees
set Salary = Salary * 1.1
where DepartmentName = 'HR' or EmployeeID = 5;

13.
select *, case when SaleAmount > 500 then 'Top Tier' when SaleAmount between 200 and 500 then 'Mid Tier' else 'Low Tier' end as Tier from Sales;

14.
select CustomerID from Orders
except
select CustomerID from Sales;

15.
select CustomerID, Quantity, case when Quantity = 1 then 0.03 when Quantity between 2 and 3 then 0.05 else 0.07 end as Discount_Percentage from Orders;
