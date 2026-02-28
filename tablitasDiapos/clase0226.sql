SELECT * 
FROM(
    SELECT name, salary, ID
    FROM INSTRUCTOR
    WHERE salary > 80000) A, advisor
WHERE A.ID = advisor.I_ID;

WITH A as (
    SELECT id,name,salary
    FROM INSTRUCTOR)
SELECT * 
FROM A;

WITH A as (
    SELECT id, name, salary
    FROM INSTRUCTOR
    WHERE salary > 80000)
SELECT * FROM A, ADVISOR
WHERE A.id = ADVISOR.I_ID;

WITH A as (
    SELECT id,name,salary
    FROM INSTRUCTOR
    WHERE salary > 80000),
B as (
    SELECT id, name
    FROM student
    WHERE tot_cred < 100
)
SELECT A.name, B.name
FROM A, Advisor, B
WHERE A.id = Advisor.i_id AND Advisor.S_ID = B.ID;