1.
SELECT DISTINCT
    CustomerName
FROM
    #Sales AS s
WHERE
    EXISTS (
        SELECT 1
        FROM #Sales AS s2
        WHERE
            s.CustomerName = s2.CustomerName
            AND MONTH(s2.SaleDate) = 3
            AND YEAR(s2.SaleDate) = 2024
    );

2.
SELECT TOP 1
    Product
FROM
    #Sales
GROUP BY
    Product
ORDER BY
    SUM(Quantity * Price) DESC;

3.
SELECT MAX(Quantity * Price)
FROM #Sales
WHERE (Quantity * Price) < (SELECT MAX(Quantity * Price) FROM #Sales);

4.
SELECT
    DATENAME(month, SaleDate) AS SalesMonth,
    SUM(Quantity) AS TotalQuantity
FROM
    #Sales
GROUP BY
    DATENAME(month, SaleDate),
    MONTH(SaleDate)
ORDER BY
    MONTH(SaleDate);

5.
SELECT DISTINCT
    s1.CustomerName
FROM
    #Sales AS s1
WHERE
    EXISTS (
        SELECT 1
        FROM #Sales AS s2
        WHERE
            s1.CustomerName <> s2.CustomerName
            AND s1.Product = s2.Product
    );

6.
SELECT
    Name,
    SUM(IIF(Fruit = 'Apple', 1, 0)) AS Apple,
    SUM(IIF(Fruit = 'Orange', 1, 0)) AS Orange,
    SUM(IIF(Fruit = 'Banana', 1, 0)) AS Banana
FROM
    Fruits
GROUP BY
    Name;

7.
SELECT
    p.ParentId AS PID,
    c.ChildID AS CHID
FROM
    Family AS p
JOIN
    Family AS c ON p.ChildID = c.ParentId
UNION
SELECT
    ParentId AS PID,
    ChildID AS CHID
FROM
    Family
ORDER BY
    PID, CHID;

8.
SELECT
    CustomerID,
    OrderID,
    DeliveryState,
    Amount
FROM
    #Orders AS o
WHERE
    o.DeliveryState = 'TX'
    AND EXISTS (
        SELECT 1
        FROM #Orders AS o2
        WHERE
            o.CustomerID = o2.CustomerID
            AND o2.DeliveryState = 'CA'
    );

9.
UPDATE #residents
SET fullname = PARSENAME(REPLACE(REPLACE(address, ' ', '.'), 'name=', ''), 1)
WHERE fullname IS NULL;

SELECT * FROM #residents;

10.
WITH RoutesCTE AS (
    SELECT
        DepartureCity AS FromCity,
        ArrivalCity AS ToCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        Cost
    FROM
        #Routes
    WHERE
        DepartureCity = 'Tashkent'

    UNION ALL

    SELECT
        cte.FromCity,
        r.ArrivalCity,
        CAST(cte.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)),
        cte.Cost + r.Cost
    FROM
        RoutesCTE AS cte
    JOIN
        #Routes AS r ON cte.ToCity = r.DepartureCity
    WHERE
        cte.Route NOT LIKE '%' + r.ArrivalCity + '%' -- Prevent cycles
)
SELECT
    Route,
    Cost
FROM
    RoutesCTE
WHERE
    ToCity = 'Khorezm'
ORDER BY
    Cost;

11.
SELECT
    ID,
    Vals,
    SUM(IIF(Vals = 'Product', 1, 0)) OVER (ORDER BY ID) AS Rank
FROM
    #RankingPuzzle
ORDER BY
    ID;

12.
SELECT
    es.EmployeeName,
    es.Department,
    es.SalesAmount
FROM
    #EmployeeSales AS es
JOIN (
    SELECT
        Department,
        AVG(SalesAmount) AS AvgSales
    FROM
        #EmployeeSales
    GROUP BY
        Department
) AS DeptAvg ON es.Department = DeptAvg.Department
WHERE
    es.SalesAmount > DeptAvg.AvgSales;

13.
SELECT DISTINCT
    es.EmployeeName,
    es.Department,
    es.SalesAmount,
    es.SalesMonth,
    es.SalesYear
FROM
    #EmployeeSales AS es
WHERE
    EXISTS (
        SELECT 1
        FROM #EmployeeSales AS es2
        WHERE
            es.SalesMonth = es2.SalesMonth
            AND es.SalesYear = es2.SalesYear
        GROUP BY
            es2.SalesMonth, es2.SalesYear
        HAVING
            es.SalesAmount = MAX(es2.SalesAmount)
    );

14.
SELECT DISTINCT
    EmployeeName
FROM
    #EmployeeSales AS es_main
WHERE
    NOT EXISTS (
        SELECT 1
        FROM (
            SELECT DISTINCT SalesMonth, SalesYear FROM #EmployeeSales
        ) AS all_months
        WHERE
            NOT EXISTS (
                SELECT 1
                FROM #EmployeeSales AS es_sub
                WHERE
                    es_main.EmployeeName = es_sub.EmployeeName
                    AND all_months.SalesMonth = es_sub.SalesMonth
                    AND all_months.SalesYear = es_sub.SalesYear
            )
    );

15.
SELECT
    Name
FROM
    Products
WHERE
    Price > (SELECT AVG(Price) FROM Products);

16.
SELECT
    Name,
    Stock
FROM
    Products
WHERE
    Stock < (SELECT MAX(Stock) FROM Products);

17.
SELECT
    Name
FROM
    Products
WHERE
    Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

18.
SELECT
    Name,
    Price
FROM
    Products
WHERE
    Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics');

19.
SELECT
    p.Name,
    p.Category,
    p.Price
FROM
    Products AS p
JOIN (
    SELECT
        Category,
        AVG(Price) AS AvgPrice
    FROM
        Products
    GROUP BY
        Category
) AS cat_avg ON p.Category = cat_avg.Category
WHERE
    p.Price > cat_avg.AvgPrice;

20.
SELECT DISTINCT
    p.Name
FROM
    Products AS p
JOIN
    Orders AS o ON p.ProductID = o.ProductID;

21.
SELECT
    p.Name
FROM
    Products AS p
JOIN
    Orders AS o ON p.ProductID = o.ProductID
WHERE
    o.Quantity > (SELECT AVG(Quantity) FROM Orders);

22.
SELECT
    p.Name
FROM
    Products AS p
WHERE
    NOT EXISTS (SELECT 1 FROM Orders AS o WHERE p.ProductID = o.ProductID);

23.
SELECT TOP 1
    p.Name
FROM
    Products AS p
JOIN
    Orders AS o ON p.ProductID = o.ProductID
GROUP BY
    p.Name
ORDER BY
    SUM(o.Quantity) DESC;
