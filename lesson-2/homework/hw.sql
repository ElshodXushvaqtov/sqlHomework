1.
create table Employees (EmpID int, name varchar(50), salary decimal(10,2));

2.
insert into Employees values (1,'John', 1000.50);
insert into Employees values (2,'Alex', 800.90), (3,'Sara',990.75);

3.
update Employees 
set salary = 7000
where EmpID = 1;

4.
delete from Employees
where EmpID = 2;

5.
Think of it like cleaning up your bookshelf:
DELETE: This is like carefully taking out specific books you no longer want. You can choose which books to remove based on certain criteria. The bookshelf itself and the other books remain untouched. Importantly, the record of which books were there before is often kept in the background (in the transaction log).
TRUNCATE: Imagine sweeping all the books off the shelf in one go. The bookshelf remains, but all the books are gone instantly. There is generally no record kept of the individual books that were removed. It is a much faster way to empty the shelf completely.
DROP: This is like getting rid of the entire bookshelf itself. Not only are all the books gone, but the shelf structure is also removed. You cannot put any new books there until you bring in a new bookshelf. Similarly, the entire table and its definition are removed from the database.


6. 
alter table Employees
alter column name varchar(100);

7.
alter table Employees
add Department varchar(50);

8.
alter table Employees
alter column salary float;

9.
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

10.
TRUNCATE TABLE Employees;

11.
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'Sales' UNION ALL
SELECT 2, 'Marketing' UNION ALL
SELECT 3, 'Engineering' UNION ALL
SELECT 4, 'Human Resources' UNION ALL
SELECT 5, 'Finance';

12.
update Employees 
set Department = 'Management'
where salary > 5000;

13.
DELETE FROM StaffMembers;

14.
alter table Employees
drop column Department;

15.
EXEC sp_rename 'Employees', 'StaffMembers';

16.
DROP TABLE Departments;

17,18.
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(200),
    Category VARCHAR(100),   
    Price DECIMAL(10, 2),
    CHECK (Price > 0)
);

19.
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

20.
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

21.
insert into Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
values (1, 'Samsung', 'Technology', 100.5, 200),
       (2, 'Creatine', 'Sport Nutrition', 150.5,30),
       (3, 'Asus', 'Technology', 355.5,100),
       (4, 'Apple', 'Food', 10.5,1000),
       (5, 'IPhone', 'Technology', 150.5,100);

22.
select * into Products_Backup from Products;

23.
exec sp_rename 'Products', 'Inventory';

24.
ALTER TABLE Inventory
DROP CONSTRAINT CK_InventoryPrice;

alter table Inventory
alter column Price float;

ALTER TABLE Inventory
ADD CONSTRAINT CK_InventoryPrice CHECK (Price > 0);

25.
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
