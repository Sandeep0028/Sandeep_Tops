-- 1. Display the maximum, minimum, and average salary and commission earned.
SELECT 
  MAX(SAL) AS `Maximum Salary`,
  MIN(SAL) AS `Minimum Salary`,
  AVG(SAL) AS `Average Salary`,
  MAX(COMM) AS `Maximum Commission`,
  MIN(COMM) AS `Minimum Commission`,
  AVG(COMM) AS `Average Commission`
FROM EMP;

-- 2. Display the department number, total salary payout, and total commission payout for each department.
SELECT 
  DEPTNO,
  SUM(SAL) AS `Total Salary Payout`,
  SUM(COMM) AS `Total Commission Payout`
FROM EMP
GROUP BY DEPTNO;

-- 3. Display the department number and number of employees in each department.
SELECT 
  DEPTNO,
  COUNT(EMPNO) AS `Number of Employees`
FROM EMP
GROUP BY DEPTNO;

-- 4. Display the department number and total salary of employees in each department.
SELECT 
  DEPTNO,
  SUM(SAL) AS `Total Salary`
FROM EMP
GROUP BY DEPTNO;

-- 5. Display the employee's name who doesn't earn a commission. Order the result set without using the column name.
SELECT ENAME FROM EMP WHERE COMM IS NULL ORDER BY EMPNO;

-- 6. Display the employee's name, department id, and commission. If an Employee doesn't earn a commission, then display as 'No commission'. Name the columns appropriately.
SELECT 
  ENAME AS `Employee Name`,
  DEPTNO AS `Department ID`,
  IFNULL(COMM, 'No commission') AS `Commission`
FROM EMP;

-- 7. Display the employee's name, salary, and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately.
SELECT 
  ENAME AS `Employee Name`,
  SAL AS `Salary`,
  IFNULL(COMM * 2, 'No commission') AS `Commission (x2)`
FROM EMP;

-- 8. Display the employee's name, department id who have the first name same as another employee in the same department.
SELECT 
  E1.ENAME AS `Employee Name`,
  E1.DEPTNO AS `Department ID`
FROM EMP E1
JOIN EMP E2 ON E1.ENAME = E2.ENAME AND E1.EMPNO != E2.EMPNO AND E1.DEPTNO = E2.DEPTNO;

-- 9. Display the sum of salaries of the employees working under each manager.
SELECT 
  MGR AS `Manager ID`,
  SUM(SAL) AS `Total Salary`
FROM EMP
WHERE MGR IS NOT NULL
GROUP BY MGR;

-- 10. Select the Manager's name, the count of employees working under, and the department ID of the manager.
SELECT 
  E1.ENAME AS `Manager Name`,
  COUNT(E2.EMPNO) AS `Number of Employees`,
  E1.DEPTNO AS `Department ID`
FROM EMP E1
JOIN EMP E2 ON E1.EMPNO = E2.MGR
GROUP BY E1.ENAME, E1.DEPTNO;

-- 11. Select the employee name, department id, and salary. Group the result with the manager's name and the employee's last name should have the second letter 'a'.
SELECT 
  E1.ENAME AS `Employee Name`,
  E1.DEPTNO AS `Department ID`,
  E1.SAL AS `Salary`
FROM EMP E1
JOIN EMP E2 ON E1.MGR = E2.EMPNO
WHERE SUBSTR(E1.ENAME, 2, 1) = 'a'
GROUP BY E2.ENAME, E1.ENAME, E1.DEPTNO, E1.SAL;

-- 12. Display the average of the sum of salaries and group the result with the department id. Order the result with the department id.
SELECT 
  DEPTNO AS `Department ID`,
  AVG(SAL) AS `Average Salary`
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 13. Select the maximum salary of each department along with the department id.
SELECT 
  DEPTNO AS `Department ID`,
  MAX(SAL) AS `Maximum Salary`
FROM EMP
GROUP BY DEPTNO;

-- 14. Display the commission; if not null, display 10% of the salary, and if null, display a default value of 1.
SELECT 
  IFNULL(COMM, 0.1 * SAL) AS `Commission`
FROM EMP;
