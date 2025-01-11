-- 1. Display all information in the tables EMP and DEPT
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- 2. Display only the hire date and employee name for each employee
SELECT HIREDATE, ENAME FROM EMP;

-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title
SELECT CONCAT(ENAME, ', ', JOB) AS `Employee and Title` FROM EMP;

-- 4. Display the hire date, name, and department number for all clerks
SELECT HIREDATE, ENAME, DEPTNO FROM EMP WHERE JOB = 'Stock Clerk';

-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT
SELECT CONCAT(EMPNO, ',', ENAME, ',', JOB, ',', MGR, ',', HIREDATE, ',', SAL, ',', COMM, ',', DEPTNO) AS `THE OUTPUT` FROM EMP;

-- 6. Display the names and salaries of all employees with a salary greater than 2000
SELECT ENAME, SAL FROM EMP WHERE SAL > 2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date"
SELECT ENAME AS `Name`, HIREDATE AS `Start Date` FROM EMP;

-- 8. Display the names and hire dates of all employees in the order they were hired
SELECT ENAME, HIREDATE FROM EMP ORDER BY HIREDATE;

-- 9. Display the names and salaries of all employees in reverse salary order
SELECT ENAME, SAL FROM EMP ORDER BY SAL DESC;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order
SELECT ENAME, DEPTNO FROM EMP WHERE COMM IS NOT NULL ORDER BY SAL DESC;

-- 11. Display the last name and job title of all employees who do not have a manager
SELECT ENAME, JOB FROM EMP WHERE MGR IS NULL;

-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
SELECT ENAME, JOB, SAL FROM EMP WHERE JOB IN ('Sales Representative', 'Stock Clerk') AND SAL NOT IN (2500.00, 3500.00, 5000.00);