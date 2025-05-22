1.
BULK INSERT is a powerful Transact-SQL (T-SQL) command in SQL Server used to efficiently import a large number of rows from a data file into a database table or view. It provides a high-performance way to load external data into SQL Server, significantly faster than using individual INSERT statements, especially for large datasets.

Purpose of BULK INSERT:

The primary purpose of BULK INSERT is to streamline and accelerate the process of loading substantial amounts of data into SQL Server. Here is a breakdown of its key benefits and uses:

Performance: It is optimized for bulk data loading, minimizing transaction logging (can be controlled) and using efficient data transfer mechanisms. This makes it much faster than inserting rows one by one.

Loading Large Datasets: It is ideal for scenarios where you need to import data from large files, such as:

Migrating data from legacy systems.
Loading data from external partners or data feeds.
Populating data warehouses or data marts.
Flexibility in File Formats: BULK INSERT supports various file formats, allowing you to import data from common sources.

Data Transformation Options: While primarily for loading, it offers some options for basic data transformations during the import process, such as specifying field terminators, row terminators, and handling null values.

Integration with SQL Server: It is a native T-SQL command, making it easy to integrate into scripts, stored procedures, and other SQL Server processes.

In essence, BULK INSERT is the go-to command in SQL Server when you need to efficiently move a large volume of data from an external file into a SQL Server table.

2.
Four File Formats that can be Imported into SQL Server using BULK INSERT:

Comma-Separated Values (.csv): This is a very common format where data fields are separated by commas and records are typically on separate lines.

Tab-Separated Values (.tsv or .txt with tab delimiters): Similar to CSV, but uses tabs instead of commas to separate fields. Plain text files with other delimiters can also be used by specifying the delimiter in the BULK INSERT command.

XML (.xml): BULK INSERT can import data from XML files, allowing you to load structured data represented in XML format. You can use XPath queries within the BULK INSERT statement to specify which parts of the XML document to import and how to map them to table columns.

Native and Formatted Data Files: These are specific to SQL Server and are often used for high-speed data transfer between SQL Server instances.

Native Format: Data is stored in the internal SQL Server data format for each column. This is very fast but not portable to other systems.
Formatted Format: Similar to native format but includes metadata about the data types and lengths, making it slightly more portable.

3.
create table Products(
ProductID int primary key, ProductName varchar(50), Price decimal(10,2)
)

4.
insert into Products values (1,'Samsung', 100.50), (2, 'IPhone', 110.50), (3, 'Xiaomi', 90.50)

5.
NULL:
Definition: NULL is a special marker in SQL that indicates that a data value does not exist in a particular column for a specific row. It is not the same as zero for numeric types or an empty string for character types. NULL literally means "unknown," "missing," or "not applicable."
Purpose:
Representing Missing Information: It allows you to insert records even if you do not have a value for every column. For example, if you are recording customer information and do not have a phone number for every customer, that PhoneNumber column can be NULL.
Handling Unknown Values: Sometimes, you know a piece of information should exist, but you do not have it at the time of data entry. Using NULL signifies this absence without assigning a potentially misleading default value.
Flexibility in Data Entry: It provides flexibility in data entry, allowing you to add records with only the information you currently possess.


NOT NULL:
Definition:
NOT NULL is a constraint that you can apply to a column when defining a table. It enforces that every row in the table must have a valid, non-NULL value in that specific column.
Purpose:
Ensuring Data Integrity: It helps maintain data integrity by guaranteeing that certain critical pieces of information are always present. For example, in an Employees table, you might want the EmpID and Name columns to be NOT NULL because these are essential identifiers.
Enforcing Business Rules: It can be used to enforce business rules at the database level. For instance, if your business logic requires every product to have a price, you would define the Price column as NOT NULL.
Simplifying Queries: Knowing that a column is NOT NULL can sometimes simplify your SQL queries, as you do not need to account for the possibility of missing values.
Behavior:

Data Insertion and Updates: If you try to insert a new row or update an existing row and leave a NOT NULL column without a value, the database will throw an error, and the operation will fail.
No Missing Values: Columns defined as NOT NULL are guaranteed to always contain a value (though that value could be an empty string or zero if those are valid within the column data type and any other constraints).
In Simple Terms:
Imagine a form you need to fill out. If a field is marked as optional, you can leave it blank (this is analogous to allowing NULL values).
If a field is marked as required, you must provide some information in it (this is analogous to defining a column as NOT NULL).

6.
ALTER TABLE Products
ADD CONSTRAINT UC_ProductName UNIQUE (ProductName);

7.
-- Purpose of adding a UNIQUE constraint to the Products table and ProductName column is to ensure that one specific ProductName is used only once. So is to avoid repetition and making sure that each productname is unique.

8.
create table Categories (
CategoryID int primary key, CategoryName varchar(50) unique
)

9.
Identity column is used when we want to automize the process of incrementation and decrementation in most cases. It will automatically change the vlue increment or decrement it whenever we add a neww value to the table. It is mostly used with int type. For example, lets take a column:
ID and we want make it incremented each time when we add a new value. So in this case we use identity-> id int identity. it will make it automated. Starting from 1 and adding 1 each time. We can change the numbers also: IDENTITY(a,b) -> a is the starting number, b is the increment/decrement number -> a = a+b or a = a-b

10.
bulk insert Products
from 'C:\Users\Msi\Downloads\Telegram Desktop\Customers.txt'
with (
firstrow = 2,
fieldterminator = ',',
rowterminator = '\n'
);

11.
alter table Products
add CategoryID int;

alter table Products
add constraint FK_Products_Category
foreign key (CategoryID)
references Categories (CategoryID)
on delete set null 
on update cascade;
	
12.
PRIMARY KEY

Definition: A primary key is a column or a set of columns in a database table that uniquely identifies each row in that table. It is a fundamental concept for ensuring data integrity and for establishing relationships between tables.   
Purpose:
Uniqueness: Its primary purpose is to guarantee that every record in the table is distinct. No two rows can have the same primary key value.   
No NULL Values: Primary key columns cannot contain NULL values. This ensures that every record has a defined identifier.   
Indexing: Most database systems automatically create a clustered index on the primary key columns, which helps in faster data retrieval.   
Relationship Establishment: Primary keys are often referenced by foreign keys in other tables to create relationships between them, enforcing referential integrity.   
Number of Keys: A table can have only one primary key. This primary key can consist of one or more columns (a composite primary key).   
UNIQUE KEY
Definition: A unique key is a constraint that ensures all values in a column or a set of columns are unique. It prevents duplicate entries in the specified columns.
Purpose:
Uniqueness: Like the primary key, it enforces uniqueness of values within the specified column(s).
Allows One NULL Value: Unlike the primary key, a unique key constraint allows one NULL value in the column(s). The reasoning is that NULL represents an absence of a value, and thus, having multiple "absent" values does not violate the uniqueness rule in the same way as having multiple identical non-NULL values.   
Indexing: Unique key constraints typically create a unique index (usually non-clustered by default), which helps in faster data retrieval based on the unique columns.
Alternative Identification: Unique keys can serve as alternative identifiers for records in a table, especially when a single column does not naturally provide a unique and always-present identifier suitable for a primary key.
Number of Keys: A table can have multiple unique key constraints.   
In essence:
A primary key is the main identifier of a row in a table, ensuring each row is uniquely identifiable and has no missing identifier.   
A unique key is used to ensure that specific columns have unique values across all rows, allowing for one instance where a value might be unknown or not applicable (NULL).
The choice between using a primary key and a unique key depends on the specific requirements of the data and the tables role in the database schema. Every table should have a primary key to ensure entity integrity, while unique keys can be used on other columns where uniqueness is required but NULL might be a valid entry.

13.
alter table Products
add constraint Pr_price check(Price>0)

14.
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0; -- A suitable default for stock when not provided

15.
UPDATE Products
SET Price = isnull(Price, 0)
WHERE Price is null;

16.
core purpose of a foreign key: to establish and enforce a link or relationship between two tables in a relational database.   

Here is a more detailed explanation:

Connecting Tables: A foreign key in one table (the "child" or "referencing" table) references the primary key (or a unique key) in another table (the "parent" or "referenced" table). This link tells the database how records in the two tables are related.   

Enforcing Referential Integrity: The primary benefit of a foreign key is that it helps maintain referential integrity. This means that the database ensures the relationships between tables remain consistent and valid. Specifically, it typically enforces the following:   

Values in the foreign key column(s) must either match existing values in the referenced primary key column(s) of the parent table or be NULL (if the foreign key column allows NULLs). This prevents the creation of "orphan" records in the child table that refer to non-existent records in the parent table.   
Restrictions on operations in the parent table that would violate the relationship. For example, you can configure the database to prevent deleting a record in the parent table if there are still related records in the child table (or to automatically update or delete the related records based on the ON DELETE and ON UPDATE rules you define).   
Think of it like this analogy:

Imagine you have two lists:

Departments List: Contains unique department IDs (primary key) and department names.
Employees List: Contains employee IDs, employee names, and a "Department ID" for each employee.
The "Department ID" column in the "Employees List" would be a foreign key referencing the "Department ID" column (primary key) in the "Departments List." This ensures:

Every employee is associated with a valid department in the "Departments List." You can not accidentally assign an employee to a department that does not exist.
If you try to delete a department from the "Departments List" that still has employees assigned to it in the "Employees List" (depending on the ON DELETE rule), the database can prevent this action to maintain data consistency.
In summary, foreign keys are crucial for building well-structured relational databases because they:

Define how tables are logically connected.
Enforce rules to maintain the accuracy and consistency of the data across related tables.
Help prevent data anomalies and ensure data integrity.


17.
create table Customers(
ID int, Name varchar(50), Age int check(Age>=18) 
)

18.
create table School(
ID int identity(100, 10), teacherName varchar(50), studentName varchar(50)
)

19.
create table OrderDetails(
OrderID int, ProductID int, Quantity int
constraint PK_OrderDetails primary key (OrderID, ProductID)
)

20.
Both COALESCE and ISNULL are SQL functions used to handle NULL values by providing a replacement value. However, they have some key differences in their behavior and portability.

ISNULL(check_expression, replacement_value)

Purpose: ISNULL is a function specific to Microsoft SQL Server and MS Access. It checks if check_expression is NULL. If it is, the function returns replacement_value; otherwise, it returns the value of check_expression.
Syntax: It accepts exactly two arguments.
Data Type: The data type of the returned value is the same as the data type of check_expression.
NULLability: The ISNULL return value is always considered NOT NULLable if the replacement_value is non-nullable.

COALESCE (expression1, expression2, ... expressionN)

Purpose: COALESCE is part of the ANSI SQL standard and is supported by most major database systems (including SQL Server, PostgreSQL, MySQL, Oracle, etc.). It evaluates the expressions in the order they are listed and returns the first non-NULL expression. If all expressions evaluate to NULL, then COALESCE returns NULL.
Syntax: It can accept one or more arguments.
Data Type: The data type of the returned value is determined by the data type with the highest precedence among the non-NULL expressions.
NULLability: The COALESCE return value is considered NULLable if all the input expressions are NULLable.

When to Use Which:

Use COALESCE when you need a more portable solution that works across different database systems or when you need to check multiple expressions for the first non-NULL value.
Use ISNULL if you are specifically working with SQL Server or MS Access and need a more concise way to handle a single potential NULL with a direct replacement. However, for better portability and flexibility, COALESCE is generally the preferred choice in modern SQL development.

21.
create table Employees (
EmpID int primary key, Email varchar(50) unique
);

22.
alter table OrderDetails
add constraint FK_Products_Orders
foreign key (ProductID)
references Products (ProductID)
on delete cascade
on update cascade;
