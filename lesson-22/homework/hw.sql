1.
select *, sum(Total_Amount) over (Partition by Customer_id order by order_date, sale_id) as Total_Sales from sales_data

2.
select *,  count(Sale_id) over (Partition by Product_Category) as Order_Count from sales_data

3.
select *,  max(Total_Amount) over (Partition by Product_Category) as Max_Amount from sales_data

4.
select *, min(unit_price) over (Partition by Product_Category) as Min_Price from sales_data

5.
SELECT
    *,AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS ThreeDayMovingAverageOfIndividualSales
FROM
    sales_data
6.
select *, sum(Total_Amount) over (Partition by region) as Total_Sales from sales_data

7.
select *, rank() over( order by Total_Sales desc) as Customer_Rank from (select customer_id, customer_name,sum(Total_amount) as Total_Sales from sales_data group by customer_id,customer_name) as Customer_Total

8.
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount AS CurrentSaleAmount,
    LAG(total_amount, 1, 0) OVER (PARTITION BY customer_id ORDER BY order_date, sale_id) AS PreviousSaleAmount,
    (total_amount - LAG(total_amount, 1, 0) OVER (PARTITION BY customer_id ORDER BY order_date, sale_id)) AS DifferenceFromPreviousSale
FROM
    sales_data
ORDER BY
    customer_id, order_date, sale_id;

9.
WITH RankedProducts AS (
    SELECT
        sale_id,
        product_category,
        product_name,
        unit_price,
        total_amount,
        ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY unit_price DESC, sale_id ASC) AS ProductRank
        -- Using DENSE_RANK() would include all products with the same 3rd highest price
        -- DENSE_RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS ProductRank
    FROM
        sales_data
)
SELECT
    sale_id,
    product_category,
    product_name,
    unit_price,
    total_amount,
    ProductRank
FROM
    RankedProducts
WHERE
    ProductRank <= 3
ORDER BY
    product_category, ProductRank;

10.
SELECT
    sale_id,
    customer_id,
    product_category,
    total_amount,
    order_date,
    region,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date, sale_id) AS CumulativeSalesByRegion
FROM
    sales_data
ORDER BY
    region, order_date, sale_id;

11.
SELECT
    sale_id,
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date, sale_id) AS CumulativeRevenue
FROM
    sales_data
ORDER BY
    product_category, order_date, sale_id;

12.
SELECT
    sale_id AS ID,
    SUM(sale_id) OVER (ORDER BY sale_id) AS SumPreValues
FROM
    sales_data
ORDER BY
    sale_id;

13.
select *, sum(value) over(order by value rows between 1 preceding and current row) as Sum_of_Previous from OneColumn

14.
SELECT
    customer_id,
    customer_name
FROM
    sales_data
GROUP BY
    customer_id,
    customer_name
HAVING
    COUNT(DISTINCT product_category) > 1
ORDER BY
    customer_id;

15.
SELECT
    sd.sale_id,
    sd.customer_id,
    sd.customer_name,
    sd.total_amount,
    sd.region,
    AVG(sd.total_amount) OVER (PARTITION BY sd.region) AS AverageSaleAmountInRegion
FROM
    sales_data sd
WHERE
    sd.total_amount > AVG(sd.total_amount) OVER (PARTITION BY sd.region)
ORDER BY
    sd.region, sd.total_amount DESC;

16.
WITH CustomerRegionalSpending AS (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS TotalSpending
    FROM
        sales_data
    GROUP BY
        customer_id,
        customer_name,
        region
)
SELECT
    customer_id,
    customer_name,
    region,
    TotalSpending,
    RANK() OVER (PARTITION BY region ORDER BY TotalSpending DESC) AS CustomerRankInRegion
FROM
    CustomerRegionalSpending
ORDER BY
    region, CustomerRankInRegion, customer_id;

17.
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date, sale_id) AS cumulative_sales
FROM
    sales_data
ORDER BY
    customer_id, order_date, sale_id;

18.
WITH MonthlySales AS (
    SELECT
        FORMAT(order_date, 'yyyy-MM') AS SaleMonth,
        SUM(total_amount) AS MonthlyTotalSales
    FROM
        sales_data
    GROUP BY
        FORMAT(order_date, 'yyyy-MM')
),
SalesWithPreviousMonth AS (
    SELECT
        SaleMonth,
        MonthlyTotalSales,
        LAG(MonthlyTotalSales, 1, 0) OVER (ORDER BY SaleMonth) AS PreviousMonthSales
    FROM
        MonthlySales
)
SELECT
    SaleMonth,
    MonthlyTotalSales,
    PreviousMonthSales,
    CASE
        WHEN PreviousMonthSales > 0 THEN (MonthlyTotalSales - PreviousMonthSales) / PreviousMonthSales
        ELSE NULL -- Handle division by zero for the first month or if previous month had 0 sales
    END AS growth_rate
FROM
    SalesWithPreviousMonth
ORDER BY
    SaleMonth;

19.
WITH CustomerSalesOrdered AS (
    SELECT
        sale_id,
        customer_id,
        customer_name,
        order_date,
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date, sale_id) AS LastOrderAmount
    FROM
        sales_data
)
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LastOrderAmount
FROM
    CustomerSalesOrdered
WHERE
    total_amount > LastOrderAmount
ORDER BY
    customer_id, order_date;

20.
SELECT
    DISTINCT product_name,
    unit_price
FROM
    sales_data
WHERE
    unit_price > (SELECT AVG(unit_price) FROM sales_data)
ORDER BY
    unit_price DESC;

21.
SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Tot
FROM
    MyData
ORDER BY
    Grp, Id;

22.
SELECT
    ID,
    SUM(Cost) AS Cost,
    CASE
        WHEN COUNT(DISTINCT Quantity) > 1 THEN SUM(Quantity)
        ELSE MIN(Quantity) -- Or MAX(Quantity), as they are all the same
    END AS Quantity
FROM
    TheSumPuzzle
GROUP BY
    ID
ORDER BY
    ID;

23.
WITH OrderedSeats AS (
    SELECT
        SeatNumber,
        LAG(SeatNumber, 1, 0) OVER (ORDER BY SeatNumber) AS PrevSeat,
        LEAD(SeatNumber, 1, 99999) OVER (ORDER BY SeatNumber) AS NextSeat -- Use a large number for LEAD default
    FROM Seats
),
GapsDetected AS (
    -- Gaps between existing seats
    SELECT
        PrevSeat + 1 AS GapStart,
        SeatNumber - 1 AS GapEnd
    FROM OrderedSeats
    WHERE SeatNumber - PrevSeat > 1

    UNION ALL

    -- Gap before the first seat (if it doesn't start at 1)
    SELECT
        1 AS GapStart,
        (SELECT MIN(SeatNumber) FROM Seats) - 1 AS GapEnd
    WHERE (SELECT MIN(SeatNumber) FROM Seats) > 1

    UNION ALL

    -- Gap after the last seat (assuming an implicit end, e.g., 54 from the expected output)
    SELECT
        (SELECT MAX(SeatNumber) FROM Seats) + 1 AS GapStart,
        54 AS GapEnd -- Explicitly set the maximum possible seat number based on problem context
    WHERE (SELECT MAX(SeatNumber) FROM Seats) < 54
)
SELECT
    GapStart,
    GapEnd
FROM
    GapsDetected
WHERE
    GapStart <= GapEnd -- Filter out invalid gaps (e.g., if a gap start is greater than its end)
ORDER BY
    GapStart;
