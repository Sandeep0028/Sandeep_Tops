
-- 1. Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
SELECT 
  UPPER(SUBSTR(ENAME, 2, 4)) AS `Last Name`
FROM EMP;

-- 2. Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
SELECT 
  CONCAT(SUBSTR(ENAME, 1, INSTR(ENAME, ' ') - 1), '-', SUBSTR(ENAME, INSTR(ENAME, ' ') + 1)) AS `Full Name`,
  MONTH(HIREDATE) AS `Joining Month`
FROM EMP;

-- 3. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label.
SELECT 
  SUBSTR(ENAME, INSTR(ENAME, ' ') + 1) AS `Last Name`,
  IF(SAL / 2 > 10000, SAL * 1.10, SAL * 1.115) AS `New Salary`,
  1500 AS `Bonus`
FROM EMP;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$'.
SELECT 
  CONCAT(SUBSTR(EMPNO, 1, 2), '00', SUBSTR(EMPNO, 3), 'E') AS `Employee ID`,
  DEPTNO AS `Department ID`,
  SAL AS `Salary`,
  REPLACE(UPPER(E2.ENAME), 'Z', '$') AS `Manager Name`
FROM EMP E1
LEFT JOIN EMP E2 ON E1.MGR = E2.EMPNO;

-- 5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the names, for all employees whose name starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names.

SELECT 
  INITCAP(SUBSTR(ENAME, INSTR(ENAME, ' ') + 1)) AS `Last Name`,
  LENGTH(SUBSTR(ENAME, INSTR(ENAME, ' ') + 1)) AS `Name Length`
FROM EMP
WHERE SUBSTR(ENAME, 1, 1) IN ('J', 'A', 'M')
ORDER BY `Last Name`;

-- 6. Create a query to display the last name and salary for all employees. Format the salary to be 15 characters long, left-padded with $. Label the column SALARY.

SELECT 
  SUBSTR(ENAME, INSTR(ENAME, ' ') + 1) AS `Last Name`,
  LPAD(SAL, 15, '$') AS `SALARY`
FROM EMP;

-- 7. Display the employee's name if it is a palindrome.

SELECT ENAME AS `Palindromic Name`
FROM EMP
WHERE ENAME = REVERSE(ENAME);

-- 8. Display First names of all employees with initcaps.

SELECT INITCAP(SUBSTR(ENAME, 1, INSTR(ENAME, ' ') - 1)) AS `First Name`
FROM EMP;

-- 9. From LOCATIONS table, extract the word between first and second space from the STREET_ADDRESS column.

SELECT 
  SUBSTR(STREET_ADDRESS, INSTR(STREET_ADDRESS, ' ') + 1, INSTR(STREET_ADDRESS, ' ', INSTR(STREET_ADDRESS, ' ') + 1) - INSTR(STREET_ADDRESS, ' ') - 1) AS `Second Word`
FROM LOCATIONS;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.

SELECT 
  SUBSTR(ENAME, 1, 1) AS `First Letter`,
  LOWER(CONCAT(SUBSTR(ENAME, 1, 1), SUBSTR(ENAME, INSTR(ENAME, ' ') + 1), '@systechusa.com')) AS `e-mail address`,
  SUBSTR(ENAME, 1, INSTR(ENAME, ' ') - 1) AS `First Name`
FROM EMP;

-- 11. Display the names and job titles of all employees with the same job as Trenna.

SELECT 
  E1.ENAME AS `Employee Name`,
  E1.JOB AS `Job Title`
FROM EMP E1
JOIN EMP E2 ON E1.JOB = E2.JOB
WHERE E2.ENAME = 'Trenna';

-- 12. Display the names and department name of all employees working in the same city as Trenna.

SELECT 
  E1.ENAME AS `Employee Name`,
  D.DNAME AS `Department Name`
FROM EMP E1
JOIN DEPT D ON E1.DEPTNO = D.DEPTNO
JOIN EMP E2 ON E1.DEPTNO = E2.DEPTNO
WHERE E2.ENAME = 'Trenna';

-- 13. Display the name of the employee whose salary is the lowest.

SELECT ENAME AS `Lowest Paid Employee`
FROM EMP
ORDER BY SAL ASC
LIMIT 1;

-- 14. Display the names of all employees except the lowest paid.

SELECT ENAME AS `Employee Name`
FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP);

