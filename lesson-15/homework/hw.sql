1.
select * from employees
where salary = (select min(salary) from employees) 

2.
select * from products
where price > (select avg(price) from products)

3.
SELECT *
FROM employees1 e -- Alias 'e' for employees1 for clarity in the subquery
WHERE EXISTS (
    SELECT 1 -- Select any constant, as we only care about existence
    FROM departments d
    WHERE d.id = e.department_id -- This is the correlation: matching department ID
      AND d.department_name = 'Sales'
);

4.
select * from customers as c
where not exists (
select 1 from orders as o 
where c.customer_id = o.customer_id)

5.
SELECT p.id, p.product_name, p.price, p.category_id
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM products p2
    WHERE p2.category_id = p.category_id -- Same category
      AND p2.price > p.price             -- Find a product in the same category with a higher price
);

6.
SELECT e.id, e.name, e.salary, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

7.
SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e.department_id -- Same department
    GROUP BY e2.department_id
    HAVING AVG(e2.salary) < e.salary      -- Check if the employee's salary is greater than the department's average
);

8.
SELECT s.student_id, s.name, g.course_id, g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE NOT EXISTS (
    SELECT 1
    FROM grades g2
    WHERE g2.course_id = g.course_id -- Same course
      AND g2.grade > g.grade         -- Find a higher grade in the same course
);

9.
SELECT p.id, p.product_name, p.price, p.category_id
FROM products p
WHERE EXISTS (
    SELECT COUNT(DISTINCT p2.price) AS HigherPricesCount
    FROM products p2
    WHERE p2.category_id = p.category_id
      AND p2.price > p.price
    HAVING COUNT(DISTINCT p2.price) = 2
);

10.
SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees avg_emp
    HAVING AVG(avg_emp.salary) < e.salary -- Check if employee's salary is greater than company average
)
AND NOT EXISTS (
    SELECT 1
    FROM employees max_emp
    WHERE max_emp.department_id = e.department_id -- Same department
      AND max_emp.salary > e.salary             -- Check if there's an employee in the same department with a higher salary
);
