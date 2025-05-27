1.
select e.Name as EmployeeName, e.Salary, d.DepartmentName from Employees as e
inner join Departments as d on e.DepartmentID = d.DepartmentID and e.Salary > 50000;

2.
select c.FirstName, c.LastName, o.OrderDate from Customers as c
inner join Orders as o on o.CustomerID = c.CustomerID and year(o.OrderDate) = '2023';

3.
select e.Name as EmployeeName, d.DepartmentName from Employees as e
left join Departments as d on d.DepartmentID =	e.DepartmentID;

4.
select s.SupplierName, p.ProductName from Suppliers as s
left join Products as p on p.SupplierID = s.SupplierID;

5.
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount from Orders as o 
full join Payments as p on o.OrderID = p.OrderID;

6.
select e1.Name as EmployeeName, e2.Name as ManagerName from Employees as e1
inner join Employees as e2 on e1.managerid = e2.employeeid;

7.
select s.Name as StudentName, c.CourseName from Students as s
inner join Enrollments as e on s.StudentID = e.StudentID
inner join Courses as c on c.CourseID = e.CourseID and  e.CourseID = 1;

8.
select c.FirstName, c.LastName, o.Quantity from Customers as c
inner join Orders as o on o.CustomerID = c.CustomerID and o.Quantity > 3;

9.
select e.Name as EmployeeName, d.DepartmentName from Employees as e
inner join Departments as d on e.DepartmentID = d.DepartmentID and d.DepartmentName = 'Human Resources';

10.
select d.DepartmentName, count(e.EmployeeID) as EmployeeCount from Employees as e
inner join Departments as d on d.DepartmentID = e.DepartmentID
group by d.DepartmentName
having count(e.EmployeeID) > 5;

11.
select p.ProductID, p.ProductName from Products as p
left join Sales as s on p.ProductID = s.ProductID
where s.ProductID is null;

12.
select c.FirstName, c.LastName, count(o.OrderID) as TotalOrders from Customers as c
inner join Orders as o on o.CustomerID = c.CustomerID
group by c.FirstName, c.LastName
having count(o.OrderID) >=1;

13.
select e.Name as EmployeeName, d.DepartmentName from Employees as e
inner join Departments as d on e.DepartmentID = d.DepartmentID;

14.
select e1.Name as Employee1, e2.Name as Employee2, e2.ManagerID from Employees as e1
inner join Employees as e2 on e1.ManagerID = e2.ManagerID
where e1.EmployeeID < e2.EmployeeID
order by e1.ManagerID, Employee1, Employee2;

15.
select o.OrderID, o.OrderDate, c.FirstName, c.LastName from Orders as o
inner join Customers as c on c.CustomerID = o.CustomerID and year(o.OrderDate) = '2022';

16.
select e.Name as EmployeeName, e.Salary, d.DepartmentName from Employees as e
inner join Departments as d on d.DepartmentID = e.DepartmentID and d.DepartmentName='Sales' and e.Salary > 60000;

17.
select o.OrderDate, o.OrderID, p.PaymentDate, p.Amount from Orders as o
inner join Payments as p on p.OrderID = o.OrderID;

18.
select p.ProductID, p.ProductName from Products as p
left join Orders as o on o.ProductID = p.ProductID
where o.OrderID is null;

19.
SELECT
    E.Name AS EmployeeName,
    E.Salary
FROM
    Employees AS E
JOIN (
    SELECT
        DepartmentID,
        AVG(Salary) AS AverageDepartmentSalary
    FROM
        Employees
    GROUP BY
        DepartmentID
) AS DeptAvg ON E.DepartmentID = DeptAvg.DepartmentID
WHERE
    E.Salary > DeptAvg.AverageDepartmentSalary;

20.
select o.OrderID, o.OrderDate from Orders as o
left join Payments as p on p.OrderID = o.OrderID
where year(o.OrderDate) < '2020' and p.PaymentID is null;

21.
select p.ProductID, p.ProductName from Products as p
left join Categories as c on c.CategoryID = p.Category
where c.CategoryID is null;

22.
select e1.Name as Employee1, e2.Name as Employee2, e2.ManagerID, e1.Salary from Employees as e1
inner join Employees as e2 on e1.ManagerID = e2.ManagerID
where e1.EmployeeID < e2.EmployeeID and e1.Salary > 60000 AND E2.Salary > 60000
order by e1.ManagerID, Employee1, Employee2;

23.
select e.Name as EmployeeName, d.DepartmentName from Employees as e
inner join Departments as d on d.DepartmentID = e.DepartmentID
where d.DepartmentName like 'M%';

24.
select s.SaleID, p.ProductName, s.SaleAmount from Sales as s
inner join Products as p on p.ProductID = s.ProductID and s.SaleAmount > 500;

25.
select s.StudentID, s.Name as StudentName from Students as s
left join Enrollments as e on s.StudentID = e.StudentID
left join Courses as c on c.CourseID = e.CourseID and  c.CourseName= 'Math 101'
where c.CourseID is null;

26.
select o.OrderID, o.OrderDate, p.PaymentID from Orders as o
left join Payments as p on p.OrderID = o.OrderID
where p.PaymentID is null;

27.
select p.ProductID, p.ProductName, c.CategoryName from Products as p
inner join Categories as c on c.CategoryID = p.Category
where c.CategoryName in ('Electronics', 'Furniture');
