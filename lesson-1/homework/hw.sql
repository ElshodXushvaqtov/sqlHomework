1. Definitions: 

Data: Raw facts or figures without any context. For example, numbers, text, or dates like 42, "John", or 01/01/2025.
Database: A structured collection of data that can be easily accessed, managed, and updated. Think of it like a digital filing cabinet.
Relational Database: A type of database that stores data in tables with rows and columns, and uses relationships (via keys) between those tables. Example: SQL Server, MySQL.
Table: A set of data elements organized in rows (records) and columns (fields). Each table represents one entity, like Customers or Orders.



2. Five Key Features of SQL Server: 

Data Storage and Management: Efficiently stores large volumes of structured data.

T-SQL Support: Uses Transact-SQL, an enhanced SQL language, for querying and managing data.
Security Features: Includes features like authentication, encryption, and role-based access control.
Backup and Restore: Allows easy data backup and recovery options for disaster management.
Integration Services: Provides tools for ETL (Extract, Transform, Load) operations to integrate data from different sources.




3. Authentication Modes in SQL Server

Windows Authentication: Uses Windows user accounts. It's more secure because it integrates with the operating system's login.
SQL Server Authentication: Requires a separate login and password defined in SQL Server. Useful when Windows authentication is not available.





4. 
CREATE DATABASE SchoolDB;



5.
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);




6. Differences Between SQL Server, SSMS, and SQL

SQL Server:	A Relational Database Management System (RDBMS) developed by Microsoft. It stores and manages data using databases, tables, views, etc.
SSMS: (SQL Server Management Studio)	A graphical user interface (GUI) tool used to manage SQL Server databases. It helps users write and run SQL queries, manage databases, tables, security, and more.
SQL: (Structured Query Language)	A language used to query and manipulate data in relational databases like SQL Server. SQL works across many systems like MySQL, PostgreSQL, Oracle, etc.



7. Differences between SQL Commands

DQL: Data Query Language	Used to query data from the database	SELECT * FROM Students;
DML: Data Manipulation Language	Used to insert, update, delete data in tables	INSERT INTO Students VALUES (1, 'Ali', 20);
DDL: Data Definition Language	Used to create or modify the structure of database objects	CREATE TABLE Students (...);
DCL: Data Control Language	Used to grant or revoke access permissions	GRANT SELECT ON Students TO User1;
TCL: Transaction Control Language	Used to manage transactions in SQL	BEGIN TRANSACTION; COMMIT; ROLLBACK;



8.
INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Ali', 20),
(2, 'Sana', 19),
(3, 'Bekzod', 21);





9. First we should download AdventureWorksDW2022.bak file from the internet. Then, we should save it in specific Backup folder. In order to find a Beckup folder, we need to open the C disk->Program Files->Microsoft SQL Server folder-> MSSQL folder -> Backup folder and save this file in this folder.
After succesfully saving our file there, we need tp restore it in our Microsoft SQL Server Management Studio. To do it, we need to click the Databases folder in our server with the right click of our mouse. Then, we need to click the Restore Database. In the opened window, we need to choose Device as pur Source and click ... button. Then, click the Add button in the opened window. Choose the file that we have downloaded and click OK. Click OK again in the next window. Then, click OK again. Then, again click OK and Restore process will be finished. Click the Refresh button and check for our Database in the Databases folder.
