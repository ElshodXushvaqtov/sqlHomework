1.
select top (5) * from Employees;

2.
select distinct Category from Products;

3.
select Price from Products
where Price > 100;

4.
select FirstName from Customers
where FirstName like 'A%';

5.
select * from Products 
order by Price asc;

6.
select * from Employees 
where Salary >= 60000 and DepartmentName = 'HR';

7.
UPDATE Employees
SET Email = ISNULL(Email, 'noemail@example.com')
WHERE Email IS NULL;

8.
select * from Products
where Price between 50 and 100;

9.
select distinct Category, ProductName from Products;

10.
select distinct Category, ProductName from Products
order by ProductName desc;

11.
select top(10) * from Products
order by Price desc;

12.
select *, coalesce(FirstName, LastName) as DsiplayInfo from Employees;

13.
select distinct Category, Price from Products;

14.
select * from Employees
where Age between 30 and 40 or DepartmentName = 'Marketing';

15.
select * from Employees
order by Salary desc
offset 10 rows
fetch next 10 rows only;

16.
select * from Products
where Price <= 1000 and StockQuantity > 50
order by StockQuantity asc;

17.
select * from Products
where ProductName like '%e%';

18.
select * from Employees
where DepartmentName in ('HR', 'IT', 'Finance');

19.
select * from Customers
order by City asc, PostalCode desc;

20.
select top(5) *, (StockQuantity * Price) as SalesAmount from Products
order by SalesAmount desc;

21.
select *, (FirstName + ' ' + LastName) as FullName from Employees;

22.
SELECT DISTINCT Category,ProductName,Price from Products
where Price > 50;

23.
select * from Products
where Price < (select avg(Price) * 0.1 from Products);

24.
select * from Employees
where age < 30 and DepartmentName in ('HR', 'IT');

25.
select * from Employees
where Email like '%@gmail.com';

26.
select * from Employees
where Salary > all(select Salary from Employees where DepartmentName = 'Sales');

27.
--This is the query to get the Orders f=in the last 180 days until the current date
SELECT
    *
FROM
    Orders
WHERE
    OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
