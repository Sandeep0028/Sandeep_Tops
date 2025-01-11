
-- 1. Write a query to display the last name, department number, department name for all employees.

SELECT 
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  E.DEPTNO AS `Department Number`,
  D.DNAME AS `Department Name`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

-- 2. Create a unique list of all jobs that are in department 4. Include the location of the department in the output.

SELECT DISTINCT 
  E.JOB AS `Job`,
  D.LOC AS `Location`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 4;

-- 3. Write a query to display the employee last name, department name, location id and city of all employees who earn commission.

SELECT 
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  D.DNAME AS `Department Name`,
  D.LOC AS `Location ID`,
  L.CITY AS `City`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN LOCATIONS L ON D.LOC = L.LOCATION_ID
WHERE E.COMM IS NOT NULL;

-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name.

SELECT 
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  D.DNAME AS `Department Name`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) LIKE '%a%';

-- 5. Write a query to display the last name, job, department number and department name for all employees who work in ATLANTA.

SELECT 
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  E.JOB AS `Job`,
  E.DEPTNO AS `Department Number`,
  D.DNAME AS `Department Name`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN LOCATIONS L ON D.LOC = L.LOCATION_ID
WHERE L.CITY = 'ATLANTA';

-- 6. Display the employee last name and employee number along with their manager's last name and manager number.

SELECT 
  E.ENAME AS `Employee Name`,
  E.EMPNO AS `Employee Number`,
  M.ENAME AS `Manager Name`,
  M.EMPNO AS `Manager Number`
FROM EMP E
JOIN EMP M ON E.MGR = M.EMPNO;

-- 7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager).

SELECT 
  E.ENAME AS `Employee Name`,
  E.EMPNO AS `Employee Number`,
  IFNULL(M.ENAME, 'No Manager') AS `Manager Name`,
  IFNULL(M.EMPNO, 'No Manager') AS `Manager Number`
FROM EMP E
LEFT JOIN EMP M ON E.MGR = M.EMPNO;

-- 8. Create a query that displays employees last name, department number, and all the employees who work in the same department as a given employee.

SELECT 
  E.ENAME AS `Employee Name`,
  E.DEPTNO AS `Department Number`,
  M.ENAME AS `Colleague Name`
FROM EMP E
JOIN EMP M ON E.DEPTNO = M.DEPTNO
WHERE E.ENAME = 'Smith';

-- 9. Create a query that displays the name, job, department name, salary, grade for all employees. Derive grade based on salary (>=50000=A, >=30000=B, <30000=C).

SELECT 
  E.ENAME AS `Employee Name`,
  E.JOB AS `Job`,
  D.DNAME AS `Department Name`,
  E.SAL AS `Salary`,
  CASE
    WHEN E.SAL >= 50000 THEN 'A'
    WHEN E.SAL >= 30000 THEN 'B'
    ELSE 'C'
  END AS `Grade`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

-- 10. Display the names and hire date for all employees who were hired before their managers along with their manager names and hire date. Label the columns as Employee name, emp_hire_date, manager name, man_hire_date.

SELECT 
  E.ENAME AS `Employee Name`,
  E.HIREDATE AS `emp_hire_date`,
  M.ENAME AS `Manager Name`,
  M.HIREDATE AS `man_hire_date`
FROM EMP E
JOIN EMP M ON E.MGR = M.EMPNO
WHERE E.HIREDATE < M.HIREDATE;
