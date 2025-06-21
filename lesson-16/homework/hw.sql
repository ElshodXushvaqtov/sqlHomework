1.
with recursion as(
select 1 as n
union all
select n+1 from recursion
where n<1000
)
select n from recursion option (maxrecursion 1000)

2.
select * from (select e.EmployeeID,FirstName,LastName,sum(s.SalesAmount) as TotalSales from Employees as e
join Sales as s on s.EmployeeID = e.EmployeeID
group by e.EmployeeID, FirstName,LastName) as Total_Table

3.
with avg_salary as (
select avg(Salary) as Avg_Salary from Employees
)
select Avg_salary from avg_salary

4.
select * from (select p.ProductID,ProductName, max(s.SalesAmount) as HighestSale from Products as p
join Sales as s on s.ProductID = p.ProductID
group by p.ProductID,ProductName) as MaxSaleTable

5.
with doubleNumber as (
select 1 as n 
union all
select n * 2 from doubleNumber
where n < 524288
)
select n from doubleNumber
option (maxrecursion 19)

6.
with sales_cte as (
select EmployeeID, count(SalesID) as Count from Sales
group by EmployeeID
)
select FirstName from Employees as e
join sales_cte as s on s.EmployeeID = e.EmployeeID

7.
with product_sales as(
select distinct ProductName, p.ProductID from Products as p
join Sales as s on s.ProductID = p.ProductID
where SalesAmount > 500
)
select * from product_sales

8.
with avgSalary as(
select EmployeeID, FirstName,LastName,Salary from Employees
where Salary>(select avg(Salary) from Employees)
)
select * from avgSalary

9.
select * from (select top 5 e.EmployeeID,e.FirstName,e.LastName, count(s.SalesID) as OrderCount from Employees as e
join Sales as s on s.EmployeeID = e.EmployeeID
group by e.EmployeeID,e.FirstName,e.LastName) as MostOrders

10.
select * from (select p.CategoryID, sum(s.SalesAmount) as TotalSales from Products as p
join Sales as s on s.ProductID = p.ProductID
group by p.CategoryID) as SalesCategory

11.
DECLARE @MaxN INT;
SELECT @MaxN = MAX(Number) FROM Numbers1;
WITH FactorialCalculator AS (
        SELECT
            1 AS N_Value,
            CAST(1 AS BIGINT) AS Factorial_Value
        WHERE 1 <= @MaxN
        UNION ALL
        SELECT
            fc.N_Value + 1,
            CAST((fc.N_Value + 1) * fc.Factorial_Value AS BIGINT)
        FROM
            FactorialCalculator AS fc
        WHERE
            fc.N_Value < @MaxN
            AND fc.N_Value < 20
    )
    SELECT
        n.Number,
        fc.Factorial_Value AS Factorial
    FROM
        Numbers1 AS n
    JOIN
        FactorialCalculator AS fc ON n.Number = fc.N_Value

12.
WITH StringSplitter AS (
    SELECT
        Id,
        String,           
        1 AS CurrentPosition, 
        SUBSTRING(String, 1, 1) AS CharValue
    FROM
        Example
    WHERE
        LEN(String) >= 1
    UNION ALL
    SELECT
        ss.Id,
        ss.String,
        ss.CurrentPosition + 1,
        SUBSTRING(ss.String, ss.CurrentPosition + 1, 1)
    FROM
        StringSplitter AS ss
    WHERE
        ss.CurrentPosition < LEN(ss.String)
)
SELECT
    CharValue AS Character
FROM
    StringSplitter
ORDER BY
    id;

13.
WITH MonthlySales AS (
        SELECT
        CAST(FORMAT(SaleDate, 'yyyy-MM-01') AS DATE) AS MonthStart, -- Get the start of the month for grouping
        SUM(SalesAmount) AS TotalSales
    FROM
        Sales
    GROUP BY
        CAST(FORMAT(SaleDate, 'yyyy-MM-01') AS DATE) -- Group by the start of the month
),
SalesWithLaggedMonth AS (
     SELECT
        MonthStart,
        TotalSales AS CurrentMonthSales,
        LAG(TotalSales, 1, 0.00) OVER (ORDER BY MonthStart) AS PreviousMonthSales
    FROM
        MonthlySales
)
SELECT
    MonthStart,
    CurrentMonthSales,
    PreviousMonthSales,
    (CurrentMonthSales - PreviousMonthSales) AS SalesDifference
FROM
    SalesWithLaggedMonth
ORDER BY
    MonthStart;
14.
select * from Sales
select * from Employees
select * from (
select EmployeeID, sum(SalesAmount) as totalSales,DATEPART(QUARTER,SaleDate) as quarter from Sales
group by EmployeeID, DATEPART(QUARTER, SaleDate)
having sum(SalesAmount)>45000) as sales_quarter

15.
DECLARE @NthTerm INT = 10;
IF @NthTerm <= 0
BEGIN
    SELECT 'Please provide a positive integer for Nth term.' AS Result;
END
ELSE
BEGIN
    WITH FibonacciCTE AS (
          SELECT
            1 AS TermNumber,
            CAST(0 AS BIGINT) AS CurrentFib,  
            CAST(1 AS BIGINT) AS NextFib     
        WHERE 1 <= @NthTerm
        UNION ALL
        SELECT
            f.TermNumber + 1,
            f.NextFib,                         
            f.CurrentFib + f.NextFib           
        FROM
            FibonacciCTE AS f
        WHERE
            f.TermNumber < @NthTerm
            AND f.TermNumber < 90
    )
    SELECT
        TermNumber,
        CurrentFib AS FibonacciValue
    FROM
        FibonacciCTE
    WHERE
        TermNumber <= @NthTerm
    ORDER BY
        TermNumber;
END;

16.
SELECT
    Id,
    Vals
FROM
    FindSameCharacters
WHERE
    Vals IS NOT NULL
    AND LEN(Vals) > 1
    AND PATINDEX('%[^' + LEFT(Vals, 1) + ']%', Vals) = 0;

17.
DECLARE @n INT = 5;
    WITH NumberSequence AS (
        SELECT
            1 AS CurrentNum,
            CAST('1' AS VARCHAR(MAX)) AS SequenceValue
        WHERE 1 <= @n
        UNION ALL
        SELECT
            ns.CurrentNum + 1,
            ns.SequenceValue + CAST(ns.CurrentNum + 1 AS VARCHAR(MAX))
        FROM
            NumberSequence AS ns
        WHERE
            ns.CurrentNum < @n
    )
    SELECT
        SequenceValue
    FROM
        NumberSequence
    ORDER BY
        CurrentNum;

18.
declare @CurrentDate date
select @CurrentDate = GETDATE();
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    QuarterlySales.TotalSales AS SalesAmountLast6Months
FROM
    Employees AS e
JOIN
    (
        SELECT
            EmployeeID,
            SUM(SalesAmount) AS TotalSales,
            ROW_NUMBER() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank
        FROM
            Sales
        WHERE
            SaleDate >= DATEADD(month, -6, @CurrentDate)
            AND SaleDate <= @CurrentDate
        GROUP BY
            EmployeeID
    ) AS QuarterlySales
ON
    e.EmployeeID = QuarterlySales.EmployeeID
WHERE
    QuarterlySales.SalesRank = 1;

19.
WITH ReducedDuplicates AS (
    -- Anchor Member: Start with the original string.
    SELECT
        PawanName,
        -- FIX: Explicitly cast to VARCHAR(MAX) to ensure type compatibility
        CAST(Pawan_slug_name AS VARCHAR(MAX)) AS CurrentString,
        CAST(1 AS INT) AS IterationNum
    FROM
        RemoveDuplicateIntsFromNames

    UNION ALL

    -- Recursive Member: Repeatedly replace 'DD' with 'D' for each digit until no more duplicates are found.
    SELECT
        rd.PawanName,
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        REPLACE(
                                            REPLACE(
                                                rd.CurrentString, '00', '0'
                                            ), '11', '1'
                                        ), '22', '2'
                                    ), '33', '3'
                                ), '44', '4'
                            ), '55', '5'
                        ), '66', '6'
                    ), '77', '7'
                ), '88', '8'
            ), '99', '9'
        ),
        rd.IterationNum + 1
    FROM
        ReducedDuplicates AS rd
    WHERE
        -- Termination Condition: Continue if any double digit ('DD') pattern is still found.
        PATINDEX('%00%', rd.CurrentString) > 0 OR
        PATINDEX('%11%', rd.CurrentString) > 0 OR
        PATINDEX('%22%', rd.CurrentString) > 0 OR
        PATINDEX('%33%', rd.CurrentString) > 0 OR
        PATINDEX('%44%', rd.CurrentString) > 0 OR
        PATINDEX('%55%', rd.CurrentString) > 0 OR
        PATINDEX('%66%', rd.CurrentString) > 0 OR
        PATINDEX('%77%', rd.CurrentString) > 0 OR
        PATINDEX('%88%', rd.CurrentString) > 0 OR
        PATINDEX('%99%', rd.CurrentString) > 0
),
FinalReducedString AS (
    -- Select the final string after all consecutive duplicates have been reduced.
    SELECT
        PawanName,
        CurrentString
    FROM
        ReducedDuplicates
    WHERE
        -- This ensures we pick the last state (highest iteration) for each PawanName.
        IterationNum = (SELECT MAX(IterationNum) FROM ReducedDuplicates WHERE PawanName = ReducedDuplicates.PawanName)
)
SELECT
    frs.PawanName,
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        REPLACE(
                                            frs.CurrentString, '0', ''
                                        ), '1', ''
                                    ), '2', ''
                                ), '3', ''
                            ), '4', ''
                        ), '5', ''
                    ), '6', ''
                ), '7', ''
            ), '8', ''
        ), '9', ''
    ) AS Cleaned_Pawan_slug_name
FROM
    FinalReducedString AS frs;
