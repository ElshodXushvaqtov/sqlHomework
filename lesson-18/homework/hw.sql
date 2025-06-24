1.
create table #MonthlySales 
(ProductID int,
TotalQuantity int,
TotalRevenue Decimal(10,2))

insert into #MonthlySales
select * from (
select s.ProductID,sum(s.Quantity) as TotalQuantity, sum(p.Price * s.Quantity) as TotalRevenue from Sales as s
join Products as p on p.ProductID=s.ProductID
where year(s.SaleDate) = year(GETDATE()) and month(s.SaleDate) = month(GETDATE())
group by s.ProductID
) as Table1

2.
create view vw_ProductSalesSummary 
as 
select p.ProductID,p.ProductName,p.Category, sum(s.Quantity) as TotalQuantitySold from Products as p
join Sales as s on s.ProductID = p.ProductID
group by p.ProductID,p.ProductName,p.Category;

3.
CREATE FUNCTION dbo.fn_GetTotalRevenue (@ProductID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10,2);
    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID
    RETURN ISNULL(@TotalRevenue, 0.00)
END;

4.
create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table
as return
(
select p.ProductName, sum(s.Quantity) as TotalQuantity, cast(sum(p.Price*s.Quantity) as decimal(10,2)) as TotalRevenue from Products as p
join Sales as s on s.ProductID = p.ProductID
where p.Category = @Category
group by p.ProductName
)

5.
CREATE FUNCTION fn_IsPrime (@Number INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @a INT = 1;
    DECLARE @b INT = 0;
    DECLARE @isprime VARCHAR(50);
    WHILE @Number >= @a
    BEGIN
        IF @Number % @a = 0
        BEGIN
            SET @b = @b + 1;
        END;
        SET @a = @a + 1;
    END;
    IF @b = 2
    BEGIN
        SET @isprime = 'Yes';
    END
    ELSE
    BEGIN
        SET @isprime = 'No';
    END;
    RETURN @isprime;
END;

6.
create function fn_GetNumbersBetween(@Start INT,
@End INT)
returns @Result table (
Number int
)
as
begin
with NumbersCTE as(
select @Start as Number
union all 
select Number+1 from NumbersCTE
where Number+1<=@End
)
insert into @Result
select Number from NumbersCTE
return
end;

7.
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
     IF @N <= 0
        RETURN NULL;

    RETURN (
 SELECT Salary
        FROM (
            SELECT DISTINCT Salary
            FROM Employee
        ) AS DistinctSalaries
     ORDER BY Salary DESC
        OFFSET @N - 1 ROWS FETCH NEXT 1 ROWS ONLY
    );
END

8.
SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC;

9.
create view vw_CustomerOrderSummary 
as
select c.customer_id, c.name, count(o.order_id) as total_orders, sum(o.amount) as total_amount, max(o.order_date) as last_order_date from Customers as c
join Orders as o on o.customer_id = c.customer_id
group by c.customer_id, c.name

10.
SELECT 
    RowNumber,
    (
        SELECT TOP 1 TestCase
        FROM Gaps g2
        WHERE g2.RowNumber <= g1.RowNumber AND g2.TestCase IS NOT NULL
        ORDER BY g2.RowNumber DESC
    ) AS Workflow
FROM Gaps g1
ORDER BY RowNumber;
