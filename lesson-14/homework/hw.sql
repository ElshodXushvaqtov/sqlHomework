1.
select trim(substring(name, 1, CHARINDEX(',',name)-1)) as name, trim(substring(name, CHARINDEX(',',name)+1, len(name))) as surname from TestMultipleColumns

2.
select * from TestPercent
where CHARINDEX('%', Strs)>0

3.
select trim(value) as Splitted from Splitter outer apply string_split(Vals, '.')

4.
select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace('1234ABC123456XYZ1234567890ADS','0', 'X'),'1','X'),'2','X'),'3','X'),'4','X'),'5','X'),'6','X'),'7','X'),'8','X'),'9','X')

5.
select * from testDots
where len(Vals)-len(replace(Vals, '.',''))>2;

6.
select *, len(texts)-len(replace(texts,' ','')) as SpaceCount from CountSpaces;

7.
select E.name as Emp_Name, E.Salary as Emp_Salary, M.name as Mgr_Name, M.Salary as Mgr_Salary from Employee as E
inner join Employee as M on E.ManagerId = M.Id
where M.Salary<E.Salary;

8.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, year(getdate())-year(HIRE_DATE) as Years_of_Service from Employees
where year(getdate())-year(HIRE_DATE) between 10 and 15;

9.
SELECT
    CASE
        WHEN PATINDEX('%[0-9]%', 'rtcfvty34redt') > 0 THEN
            SUBSTRING(
                'rtcfvty34redt',
                PATINDEX('%[0-9]%', 'rtcfvty34redt'),
                CASE
                    WHEN PATINDEX('%[^0-9]%', SUBSTRING('rtcfvty34redt', PATINDEX('%[0-9]%', 'rtcfvty34redt'), LEN('rtcfvty34redt'))) = 0
                    THEN LEN('rtcfvty34redt') - PATINDEX('%[0-9]%', 'rtcfvty34redt') + 1
                    ELSE PATINDEX('%[^0-9]%', SUBSTRING('rtcfvty34redt', PATINDEX('%[0-9]%', 'rtcfvty34redt'), LEN('rtcfvty34redt'))) - 1
                END
            )
        ELSE NULL
    END AS IntegerPart,
    TRIM(
        CONCAT(
            CASE
                WHEN PATINDEX('%[0-9]%', 'rtcfvty34redt') > 1 THEN SUBSTRING('rtcfvty34redt', 1, PATINDEX('%[0-9]%', 'rtcfvty34redt') - 1)
                ELSE ''
            END,
            CASE
                WHEN PATINDEX('%[0-9]%', REVERSE('rtcfvty34redt')) > 1 THEN REVERSE(SUBSTRING(REVERSE('rtcfvty34redt'), 1, PATINDEX('%[0-9]%', REVERSE('rtcfvty34redt')) - 1))
                ELSE ''
            END
        )
    ) AS StringPart;

10.
select w1.Id from weather as w1
inner join weather as w2 on w1.Id != w2.Id
where day(w2.RecordDate)-day(w1.RecordDate) = 1 and w2.Temperature<w1.Temperature

11.
SELECT
    player_id,
    MIN(event_date) AS first_login_date
FROM
    Activity
GROUP BY
    player_id;

12.
WITH SplitFruits AS (
    SELECT
        [value],
        -- ROW_NUMBER() generates an arbitrary row number.
        -- While STRING_SPLIT doesn't guarantee order without 'ordinal',
        -- in practice, it often preserves it for simple cases like this.
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as rn
    FROM
        fruits
    CROSS APPLY
        STRING_SPLIT(fruit_list, ',')
)
SELECT
    [value] AS third_fruit
FROM
    SplitFruits
WHERE
    rn = 3;

13.
WITH CharacterSplit AS (
    SELECT
        1 AS Position,
        SUBSTRING('sdgfhsdgfhs@121313131', 1, 1) AS CharacterValue,
        'sdgfhsdgfhs@121313131' AS OriginalString
    WHERE LEN('sdgfhsdgfhs@121313131') > 0 -- Ensure string is not empty
    UNION ALL
    SELECT
        cs.Position + 1,
        SUBSTRING(cs.OriginalString, cs.Position + 1, 1),
        cs.OriginalString
    FROM
        CharacterSplit cs
    WHERE
        cs.Position < LEN(cs.OriginalString)
)
SELECT
    CharacterValue
FROM
    CharacterSplit
ORDER BY Position
OPTION (MAXRECURSION 0); -- Allows unlimited recursion for very long strings

14.
SELECT
    p1.id,
    CASE
        WHEN p1.code = 0 THEN p2.code
        ELSE p1.code
    END AS final_code
FROM
    p1
JOIN
    p2 ON p1.id = p2.id;

15.
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    CASE
        -- Using DATEDIFF in years to calculate tenure.
        -- GETDATE() is used for SQL Server; SYSDATE for Oracle; CURRENT_DATE for standard SQL/PostgreSQL/MySQL.
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) >= 1 AND DATEDIFF(year, HIRE_DATE, GETDATE()) < 5 THEN 'Junior'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) >= 5 AND DATEDIFF(year, HIRE_DATE, GETDATE()) < 10 THEN 'Mid-Level'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) >= 10 AND DATEDIFF(year, HIRE_DATE, GETDATE()) < 20 THEN 'Senior'
        WHEN DATEDIFF(year, HIRE_DATE, GETDATE()) >= 20 THEN 'Veteran'
        ELSE 'Undefined' -- Handle cases where HIRE_DATE might be in the future or invalid
    END AS EmploymentStage
FROM
    Employees;

16.
SELECT
    Id,
    VALS,
    CASE
        WHEN VALS IS NULL OR VALS = '' THEN NULL
        ELSE
            CAST(SUBSTRING(VALS, 1,
                PATINDEX('%[^0-9]%', VALS + 'a') - 1) AS INT)
                -- Adding 'a' to VALS ensures PATINDEX always finds a non-digit,
                -- preventing issues with purely numeric strings.
    END AS ExtractedInteger
FROM
    GetIntegers;

17.
WITH SplitVals AS (
    SELECT
        Id,
        TRIM(value) AS ValPart,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) as rn -- Ordinal for SQL Server 2017+, otherwise requires more complex splitting
    FROM
        MultipleVals
    CROSS APPLY
        STRING_SPLIT(Vals, ',') -- STRING_SPLIT is SQL Server. Use unnest for PostgreSQL, or recursive CTE for others.
),
SwappedParts AS (
    SELECT
        Id,
        rn,
        CASE
            WHEN LEN(ValPart) >= 2 THEN
                SUBSTRING(ValPart, 2, 1) + SUBSTRING(ValPart, 1, 1) + SUBSTRING(ValPart, 3, LEN(ValPart) - 2)
            ELSE ValPart
        END AS SwappedValPart
    FROM
        SplitVals
)
SELECT
    Id,
    STRING_AGG(SwappedValPart, ',') WITHIN GROUP (ORDER BY rn) AS SwappedVals -- STRING_AGG is SQL Server/PostgreSQL. Use GROUP_CONCAT for MySQL.
FROM
    SwappedParts
GROUP BY
    Id;

18.
WITH PlayerFirstLogin AS (
    SELECT
        player_id,
        MIN(event_date) AS first_event_date
    FROM
        Activity
    GROUP BY
        player_id
)
SELECT
    a.player_id,
    a.device_id,
    a.event_date AS first_login_date
FROM
    Activity a
JOIN
    PlayerFirstLogin pfl ON a.player_id = pfl.player_id AND a.event_date = pfl.first_event_date

19.
SELECT
    Area,
    [Date],
    SalesLocal,
    SalesRemote,
    [DayName],
    [DayOfWeek],
    FinancialWeek,
    [MonthName],
    FinancialYear,
    -- Calculate total sales for the day
    (COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0)) AS DailyTotalSales,
    -- Calculate total sales for the area in that financial week
    SUM(COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0)) OVER (PARTITION BY Area, FinancialYear, FinancialWeek) AS WeeklyAreaTotalSales,
    -- Calculate percentage of daily sales to weekly area total sales
    CAST(
        (COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0)) * 100.0 /
        NULLIF(SUM(COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0)) OVER (PARTITION BY Area, FinancialYear, FinancialWeek), 0)
    AS DECIMAL(10, 2)) AS DailyPercentageOfWeeklyAreaSales
FROM
    WeekPercentagePuzzle
ORDER BY
    Area, FinancialYear, FinancialWeek, [Date];
