1.
SELECT
  p.ProductName,
  s.SupplierName
FROM Products AS p
CROSS JOIN Suppliers AS s;

2.
select d.DepartmentName, e.Name from Departments as d
cross join Employees as e;

3.
select p.ProductName, s.SupplierName from Products as p
inner join Suppliers as s on s.SupplierID = p.SupplierId;

4.
SELECT
  c.FirstName + ' '+ c.LastName,
  o.OrderID
FROM Customers AS c
INNER JOIN Orders AS o
  ON c.CustomerID = o.CustomerID;

5.
select s.Name, c.CourseName from Students as s
cross join Courses as c;

6.
select p.ProductName, o.OrderID from Products as p
inner join Orders as o on  p.ProductID = o.ProductID;

7.
select  e.Name, d.DepartmentName from Employees as e
inner join Departments as d on e.DepartmentID = d.DepartmentID;

8.
select s.name, e.courseid from Students as s
inner join Enrollments as e on s.studentid = e.studentid;

9.
select p.paymentid, o.orderid from orders as o
inner join payments as p on p.OrderID = o.OrderID;

10.
select o.orderid, p.productname, p.price from Orders as o
inner join Products as p on o.ProductID = p.ProductID and p.Price> 100;

11.
select e.Name, d.DepartmentName from Employees as e
inner join Departments as d on e.DepartmentID != d.DepartmentID;

12.
select o.OrderID, o.Quantity, p.StockQuantity from Orders as o
inner join Products as p on o.ProductID=p.ProductID and o.Quantity>p.StockQuantity;

13.
select c.FirstName, s.ProductID from Customers as c
inner join Sales as s on c.CustomerID = s.CustomerID and s.SaleAmount>=500;

14.
select s.name, c.coursename from Students as s
inner join Enrollments as e on e.StudentID = s.StudentID
inner join Courses as c on c.CourseID = e.CourseID;

15.
select p.ProductName, s.SupplierName from Products as p
inner join Suppliers as s on p.SupplierID = s.SupplierID and s.SupplierName like '%Tech%';

16.
select o.orderid, p.amount, o.totalamount from Orders as o
inner join Payments as p on o.OrderID = p.OrderID and p.Amount < o.TotalAmount;

17.
select e.Name, d.DepartmentName from Employees as e
inner join Departments as d on d.DepartmentID = e.DepartmentID;

18.
select p.ProductName, c.CategoryName from Categories as c
inner join Products as p on c.CategoryID = p.Category and c.CategoryName in ('Electronics', 'Furniture');

19.
select s.saleid, s.SaleAmount, c.customerid , c.country from Sales as s
inner join Customers as c on s.CustomerID = c.CustomerID and c.Country = 'USA';

20.
select o.OrderID, c.CustomerID, c.Country, o.TotalAmount from orders as o
inner join Customers as c on c.CustomerID = o.CustomerID and c.Country = 'Germany' and o.TotalAmount > 100;

21.
SELECT
  e1.Name AS Employee1Name,
  e2.Name AS Employee2Name,
  e1.DepartmentID AS Employee1DepartmentID,
  e2.DepartmentID AS Employee2DepartmentID
FROM Employees AS e1
INNER JOIN Employees AS e2
  ON e1.DepartmentID != e2.DepartmentID
  AND e1.EmployeeID < e2.EmployeeID;

22.
select pa.PaymentID, o.OrderID, p.ProductID, pa.PaymentMethod from Payments as pa
inner join Orders as o on pa.OrderID = o.OrderID
inner join Products as p on p.ProductID = o.ProductID and pa.Amount != p.Price * o.Quantity;

23.
SELECT
  s.Name
FROM Students AS s
LEFT JOIN Enrollments AS e
  ON s.StudentID = e.StudentID
WHERE
  e.EnrollmentID IS NULL;

24.
select e2.EmployeeID as E2EmployeeID, e2.Name as E2Name from Employees as e1
inner join Employees as e2 on e1.EmployeeID = e2.ManagerID and e2.Salary <= e1.Salary

25.
select c.FirstName + ' '+c.LastName as FullName from Customers as c
inner join Orders as o on c.CustomerID = o.CustomerID
left join Payments as p on p.OrderID = o.OrderID 
where p.PaymentID is null;
