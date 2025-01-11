
-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES.

SELECT 
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  E.HIREDATE AS `Hire Date`
FROM EMP E
WHERE E.DEPTNO = (SELECT DEPTNO FROM EMP WHERE JOB = 'SALES');

-- 2. Create a query to display the employee numbers and last names of all employees who earn more than the average salary. Sort the results in ascending order of salary.

SELECT 
  E.EMPNO AS `Employee Number`,
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`
FROM EMP E
WHERE E.SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL ASC;

-- 3. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a 'u'.

SELECT 
  E.EMPNO AS `Employee Number`,
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`
FROM EMP E
WHERE E.DEPTNO IN (SELECT DEPTNO FROM EMP WHERE SUBSTR(ENAME, INSTR(ENAME, ' ') + 1) LIKE '%u%');

-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA.

SELECT 
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  E.DEPTNO AS `Department Number`,
  E.JOB AS `Job ID`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'ATLANTA';

-- 5. Display the last name and salary of every employee who reports to FILLMORE.

SELECT 
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  E.SAL AS `Salary`
FROM EMP E
WHERE E.MGR = (SELECT EMPNO FROM EMP WHERE ENAME = 'FILLMORE');

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department.

SELECT 
  E.DEPTNO AS `Department Number`,
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  E.JOB AS `Job ID`
FROM EMP E
WHERE E.DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'OPERATIONS');

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary and who work in a department with any employee with a 'u' in their name.

SELECT 
  E.EMPNO AS `Employee Number`,
  SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1) AS `Last Name`,
  E.SAL AS `Salary`
FROM EMP E
WHERE E.SAL > (SELECT AVG(SAL) FROM EMP)
AND E.DEPTNO IN (SELECT DEPTNO FROM EMP WHERE SUBSTR(ENAME, INSTR(ENAME, ' ') + 1) LIKE '%u%');

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept.

SELECT 
  E.ENAME AS `Employee Name`
FROM EMP E
WHERE E.JOB IN (SELECT JOB FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES'));

-- 9. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.

SELECT 
  CASE 
    WHEN DEPTNO IN (1, 3) THEN 0.05
    WHEN DEPTNO = 2 THEN 0.10
    WHEN DEPTNO IN (4, 5) THEN 0.15
    ELSE 0
  END AS `Raise Percentage`,
  EMPNO AS `Employee ID`,
  SAL AS `Salary`
FROM EMP;

-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.

SELECT 
  SUBSTR(ENAME, INSTR(ENAME, ' ') + 1) AS `Last Name`,
  SAL AS `Salary`
FROM EMP
ORDER BY SAL DESC
LIMIT 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column.

SELECT 
  ENAME AS `Employee Name`,
  SAL AS `Salary`,
  IFNULL(COMM, 0) AS `Commission`
FROM EMP;

-- 12. Display the Managers (name) with top three salaries along with their salaries and department information.

SELECT 
  ENAME AS `Manager Name`,
  SAL AS `Salary`,
  D.DNAME AS `Department Name`
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'MANAGER'
ORDER BY SAL DESC
LIMIT 3;

