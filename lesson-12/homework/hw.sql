1.
select p.firstname, p.lastname, a.city, a.state from Person as p
left join Address as a on p.PersonID = a.PersonID;

2.
select e.name as Employee from Employee as e
inner join Employee as m on e.managerID = m.id
where e.salary > m.salary;

3.
select email as Email from Person
group by email
having count(email) > 1;

4.
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);

5.
SELECT DISTINCT g.ParentName
FROM girls AS g
WHERE g.ParentName NOT IN (SELECT ParentName FROM boys);

6.
SELECT o.custid, SUM(CASE WHEN o.freight > 50 THEN o.freight ELSE 0 END) AS TotalSalesAmount, MIN(o.freight) AS LeastFreightAmount
FROM TSQL2012.Sales.Orders AS o
GROUP BY o.custid;

7.
select isnull (c1.item,'') as [Item Cart 1], isnull(c2.item, '') as [Item Cart 2] from Cart1 as c1
full join Cart2 as c2 on c1.item = c2.item
ORDER BY
   CASE
        WHEN c1.item IS NOT NULL AND c2.item IS NOT NULL THEN 1
        WHEN c1.item IS NOT NULL AND c2.item IS NULL THEN 2
        WHEN c1.item IS NULL AND c2.item IS NOT NULL THEN 3
    END,
    COALESCE(c1.item, c2.item);

8.
SELECT C.name AS Customers FROM Customers AS C
LEFT JOIN Orders AS O ON C.id = O.customerId
WHERE O.customerId IS NULL;

9.
select st.student_id, st.student_name, su.subject_name, count(e.student_id) as attended_exams from Students as st
cross join Subjects as su
left join Examinations as e on st.student_id = e.student_id and su.subject_name = e.subject_name
group by st.student_id , st.student_name , su.subject_name
order by st.student_id, su.subject_name;
