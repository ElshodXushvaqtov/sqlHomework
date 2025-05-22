1.
In order to get this result we can use first a method using LEAST and Greatest. LEAST will choose the least elemnt from the compariosn and GREATEST will do the vice versa. For example first we will compare a and b -> LEAST(a,b) it will choose a and GREATEST(a,b) it will choose b. So it will put a in the first column and b in the second column. So, we will continue doing this.
Second method looks like the first one but we also use group by. GROUP BY LEAST(col1, col2), GREATEST(col2, col2): The GROUP BY clause groups the rows based on these ordered pairs. All rows that result in the same ordered pair after applying LEAST and GREATEST will fall into the same group.

1. 
SELECT DISTINCT LEAST(col1, col2) as col1, GREATEST(col1, col2) as col2 
FROM InputTbl;

2.
SELECT LEAST(col1, col2) as col1, GREATEST(col1, col2) as col2
FROM InputTbl
GROUP BY LEAST(col1, col2), GREATEST(col1, col2);

2.
select * from TestMultipleZero
where A+B+C+D != 0;

3.
select * from section1
where id%2 = 1;

4.
select * from section1
where id = (select min(id) from section1);

5.
select * from section1
where id = (select max(id) from section1);

6.
select * from section1
where name like 'B%';

7.
SELECT *
FROM ProductCodes
WHERE Code LIKE '%_%';
