1.
select top 1 cast(EMPLOYEE_ID as varchar)+'-'+FIRST_NAME+LAST_NAME from Employees

2.
update Employees
set PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
where PHONE_NUMBER like '%124%';

3.
select FIRST_NAME, LEN(FIRST_NAME) as Length from Employees
where FIRST_NAME like 'A%' or FIRST_NAME like 'M%' or FIRST_NAME like 'J%'
order by FIRST_NAME;

4.
select MANAGER_ID, sum(Salary) from Employees
group by MANAGER_ID;

5.
SELECT
    year1,
    (SELECT MAX(v) FROM (VALUES (Max1), (Max2), (Max3)) AS T(v)) AS MaxValue
FROM
    TestMax;

6.
select * from cinema
where id %2 != 0 and description <> 'boring';

7.
select * from SingleOrder
order by case id when 0 then 2147483647 else id end;

8.
select id,coalesce(ssn, passportid, itin, null) from person;

9.
WITH SplitNames AS (
    SELECT
        s.StudentID,
        s.FullName,
        value,
        ROW_NUMBER() OVER (PARTITION BY s.StudentID ORDER BY (SELECT NULL)) AS PartOrder -- Use s.ordinal if on SQL Server 2022+ and STRING_SPLIT is called with the 3rd parameter '1'
    FROM
        Students AS s
        CROSS APPLY STRING_SPLIT(s.FullName, ' ')
)
SELECT
    StudentID,
    MAX(CASE WHEN PartOrder = 1 THEN value END) AS FirstName,
    MAX(CASE WHEN PartOrder = 2 THEN value END) AS MiddleName,
    MAX(CASE WHEN PartOrder = 3 THEN value END) AS LastName
FROM
    SplitNames
GROUP BY
    StudentID, FullName;

10.
select o.* from Orders as o
where o.DeliveryState = 'TX' and o.CustomerID in (select CustomerID from Orders where DeliveryState = 'CA');

11.
select STRING_AGG(String, ' ') within group (order by SequenceNumber asc) as StringGroup from DMLTable;

12.
select concat(FIRST_NAME,' ', LAST_NAME) as FullName from Employees
where concat(FIRST_NAME,' ', LAST_NAME) like '%a%a%a%'

13.
select DEPARTMENT_ID, count(EMPLOYEE_ID) as CountEmployee, concat(cast(100.0*count(case when cast(year(GETDATE()) as int) - cast(year(HIRE_DATE) as int)>3 then EMPLOYEE_ID else null end)/count(EMPLOYEE_ID) as decimal(5,2)),'%') as More3Years from Employees
group by DEPARTMENT_ID;

14.
with RankedSpaceman as(
select SpacemanID,JobDescription, MissionCount,
ROW_NUMBER() over(Partition by JobDescription order by MissionCount desc, SpacemanID) as MostExperienced,
ROW_NUMBER() over(Partition by JobDescription order by MissionCount asc, SpacemanID) as LeastExperienced
from Personal
)
select JobDescription,
max(case when MostExperienced = 1 then MissionCount end) as MostExperienced,
max(case when LeastExperienced = 1 then MissionCount end)as LeastExperieced
from RankedSpaceman
group by JobDescription

15.
DECLARE @inputString VARCHAR(100) = 'tf56sd#%OqH';

WITH CharacterBreakdown AS (
    SELECT
        n.n AS Position,
        SUBSTRING(@inputString, n.n, 1) AS CharacterValue,
        ASCII(SUBSTRING(@inputString, n.n, 1)) AS AsciiValue
    FROM
        (SELECT TOP (LEN(@inputString)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n FROM sys.all_columns) AS n
)
SELECT
    STRING_AGG(CASE WHEN cb.AsciiValue BETWEEN 65 AND 90 THEN cb.CharacterValue ELSE NULL END, '') WITHIN GROUP (ORDER BY cb.Position) AS UppercaseLetters,
    STRING_AGG(CASE WHEN cb.AsciiValue BETWEEN 97 AND 122 THEN cb.CharacterValue ELSE NULL END, '') WITHIN GROUP (ORDER BY cb.Position) AS LowercaseLetters,
    STRING_AGG(CASE WHEN cb.AsciiValue BETWEEN 48 AND 57 THEN cb.CharacterValue ELSE NULL END, '') WITHIN GROUP (ORDER BY cb.Position) AS Numbers,
    STRING_AGG(CASE
                WHEN cb.AsciiValue NOT BETWEEN 65 AND 90
                 AND cb.AsciiValue NOT BETWEEN 97 AND 122
                 AND cb.AsciiValue NOT BETWEEN 48 AND 57
                THEN cb.CharacterValue
                ELSE NULL
               END, '') WITHIN GROUP (ORDER BY cb.Position) AS OtherCharacters
FROM
    CharacterBreakdown AS cb;

16.
SELECT
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningSumOfGrades
FROM
    Students;

17.
-- Create a temporary table to store the results
CREATE TABLE #EquationResults (
    Equation VARCHAR(200),
    CalculatedSum INT
);

DECLARE @Equation VARCHAR(200);
DECLARE @SQL NVARCHAR(MAX);
DECLARE equation_cursor CURSOR FOR
SELECT Equation FROM Equations;

OPEN equation_cursor;
FETCH NEXT FROM equation_cursor INTO @Equation;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Construct the dynamic SQL to calculate the sum of the equation
    SET @SQL = N'INSERT INTO #EquationResults (Equation, CalculatedSum) SELECT ''' + REPLACE(@Equation, '''', '''''') + ''', ' + @Equation + ';';

    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;

    FETCH NEXT FROM equation_cursor INTO @Equation;
END;

CLOSE equation_cursor;
DEALLOCATE equation_cursor;

-- Select the results
SELECT Equation, CalculatedSum FROM #EquationResults;

-- Clean up the temporary table
DROP TABLE #EquationResults;

18.
select s1.StudentName,s1.Birthday,s2.StudentName,s2.Birthday from Student as s1
inner join Student as s2 on s1.Birthday = s2.Birthday and s1.StudentName <> s2.StudentName

19.
SELECT
    CASE
        WHEN PlayerA < PlayerB THEN PlayerA
        ELSE PlayerB
    END AS NormalizedPlayer1,
    CASE
        WHEN PlayerA < PlayerB THEN PlayerB
        ELSE PlayerA
    END AS NormalizedPlayer2,
    SUM(Score) AS TotalScore
FROM
    PlayerScores
GROUP BY
    CASE
        WHEN PlayerA < PlayerB THEN PlayerA
        ELSE PlayerB
    END,
    CASE
        WHEN PlayerA < PlayerB THEN PlayerB
        ELSE PlayerA
    END;
