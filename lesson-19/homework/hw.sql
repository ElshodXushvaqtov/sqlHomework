1.
create proc Employee_Bonus_Proc
as
begin
create table #EmployeeBonus
(EmployeeID int,
FullName varchar(50),
Department varchar(50),
Salary float,
BonusAmount float)

insert into #EmployeeBonus
select e.EmployeeID,concat(e.FirstName,' ',e.LastName) as FullName,e.Department,e.Salary,e.Salary*d.BonusPercentage/100 as BonusAmount from Employees as e 
join DepartmentBonus as d on d.Department = e.Department

select * from #EmployeeBonus 
end
exec Employee_Bonus_Proc

2.
create proc Update_Employee_Salary @dept_name varchar(50), @bonus_percent int 
as
begin
update Employees
set Salary = Salary+Salary*@bonus_percent/100
where Department = @dept_name

select * from Employees
where Department = @dept_name
end

exec Update_Employee_Salary 'Sales', 10

3.
MERGE INTO Products_Current AS T
USING Products_New AS S
ON T.ProductID = S.ProductID

WHEN MATCHED THEN
    UPDATE SET
        T.ProductName = S.ProductName,
        T.Price = S.Price

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (S.ProductID, S.ProductName, S.Price)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
SELECT * FROM Products_Current;

4.
select id, case when p_id is null then 'Root' when id in (select p_id from Tree) then 'Inner' else 'Leaf' end as Type from Tree;

5.
select s.user_id, cast(isnull(sum(case when c.action = 'confirmed' then 1.0 else 0.0 end)/nullif(count(c.user_id),0.0),0.0) as decimal(3,2)) as confirmation_rate from Signups as s
left join Confirmations as c on s.user_id = c.user_id
group by s.user_id
order by confirmation_rate asc

6.
select *  from employees
where salary = (select min(salary) from employees)

7.
create proc GetProductSalesSummary @ProductID int
as 
begin
select p.ProductName, sum(s.Quantity) as TotalQuantitySold, sum(s.Quantity*p.Price) as TotalSalesAmount, min(s.SaleDate) as FirstSaleDate, max(s.SaleDate) as LastSaleDate  from Products as p 
left join Sales as s on p.ProductID = s.ProductID 
where p.ProductID = @ProductID
group by p.ProductID, p.ProductName, p.Price;
end
exec GetProductSalesSummary 20
