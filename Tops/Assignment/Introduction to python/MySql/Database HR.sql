-- Create DEPT table
CREATE TABLE DEPT (
    deptno INT PRIMARY KEY,
    dname VARCHAR(50),
    loc VARCHAR(50)
);
-- Insert sample data into DEPT
INSERT INTO DEPT (deptno, dname, loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- Create EMP table
CREATE TABLE EMP (
    empno INT PRIMARY KEY,
    ename VARCHAR(50),
    job_id VARCHAR(50),
    mgr INT,
    hire_date DATE,
    sal DECIMAL(10, 2),
    comm DECIMAL(10, 2),
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES DEPT(deptno)
);
-- Insert sample data into EMP
INSERT INTO EMP (empno, ename, job_id, mgr, hire_date, sal, comm, deptno) VALUES
(1001, 'John', 'MANAGER', NULL, '2010-06-15', 5000.00, NULL, 10),
(1002, 'Alice', 'CLERK', 1001, '2012-07-01', 2000.00, 500.00, 10),
(1003, 'Bob', 'ANALYST', 1001, '2011-09-23', 4500.00, NULL, 20),
(1004, 'Charlie', 'SALESMAN', 1003, '2013-11-15', 3000.00, 800.00, 30),
(1005, 'Diana', 'STOCK CLERK', 1003, '2014-02-10', 2800.00, NULL, 30),
(1006, 'Eva', 'SALES REPRESENTATIVE', 1004, '2015-05-20', 3500.00, NULL, 30),
(1007, 'Frank', 'OPERATIONS CLERK', 1003, '2016-03-01', 2200.00, NULL, 40),
(1008, 'Grace', 'CLERK', 1002, '2017-10-25', 1900.00, NULL, 10);

-- Create LOCATIONS table for specific AdventureWorks queries
CREATE TABLE LOCATIONS (
    loc_id INT PRIMARY KEY,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state_province VARCHAR(50),
    country_id CHAR(2)
);
-- Insert sample data into LOCATIONS
INSERT INTO LOCATIONS (loc_id, street_address, postal_code, city, state_province, country_id) VALUES
(1, '123 Main St', '10001', 'NEW YORK', 'NY', 'US'),
(2, '456 Oak Rd', '75201', 'DALLAS', 'TX', 'US'),
(3, '789 Pine Ln', '60601', 'CHICAGO', 'IL', 'US'),
(4, '321 Elm St', '02101', 'BOSTON', 'MA', 'US');

-- Additional imaginary data: PRODUCTS table for AdventureWorks
CREATE TABLE PRODUCTS (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    subcategory_id INT,
    unit_price DECIMAL(10, 2)
);
-- Insert data into PRODUCTS
INSERT INTO PRODUCTS (product_id, product_name, subcategory_id, unit_price) VALUES
(718, 'Widget A', 15, 12.50),
(719, 'Widget B', 15, 9.99),
(720, 'Widget C', 15, 14.00),
(721, 'Widget D', 16, 17.99);

-- Step 2: Write queries for all tasks from the document.

-- Task 1: Display all information in the tables EMP and DEPT
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- Task 2: Display only the hire date and employee name for each employee.
SELECT hire_date, ename FROM EMP;

-- Task 3: Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title.
SELECT CONCAT(ename, ', ', job_id) AS "Employee and Title" FROM EMP;

-- Task 4: Display the hire date, name, and department number for all clerks.
SELECT hire_date, ename, deptno FROM EMP WHERE job_id LIKE '%CLERK%';

-- Task 5: Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT.
SELECT CONCAT(empno, ',', ename, ',', job_id, ',', mgr, ',', hire_date, ',', sal, ',', comm, ',', deptno) AS "THE OUTPUT" FROM EMP;

-- Task 6: Display the names and salaries of all employees with a salary greater than 2000.
SELECT ename, sal FROM EMP WHERE sal > 2000;

-- Task 7: Display the names and dates of employees with the column headers "Name" and "Start Date".
SELECT ename AS "Name", hire_date AS "Start Date" FROM EMP;

-- Task 8: Display the names and hire dates of all employees in the order they were hired.
SELECT ename, hire_date FROM EMP ORDER BY hire_date ASC;

-- Task 9: Display the names and salaries of all employees in reverse salary order.
SELECT ename, sal FROM EMP ORDER BY sal DESC;

-- Task 10: Display 'ename' and 'deptno' who are all earned commission and display salary in reverse order.
SELECT ename, deptno, sal FROM EMP WHERE comm IS NOT NULL ORDER BY sal DESC;

-- Task 11: Display the last name and job title of all employees who do not have a manager.
SELECT ename, job_id FROM EMP WHERE mgr IS NULL;

-- Task 12: Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000.
SELECT ename, job_id, sal FROM EMP WHERE (job_id = 'SALES REPRESENTATIVE' OR job_id = 'STOCK CLERK') AND sal NOT IN (2500, 3500, 5000);

-- Task 13: Display the maximum, minimum, and average salary and commission earned.
SELECT MAX(sal) AS "Max Salary", MIN(sal) AS "Min Salary", AVG(sal) AS "Avg Salary", MAX(comm) AS "Max Commission", MIN(comm) AS "Min Commission", AVG(comm) AS "Avg Commission" FROM EMP;

-- Task 14: Display the department number, total salary payout, and total commission payout for each department.
SELECT deptno, SUM(sal) AS "Total Salary", SUM(comm) AS "Total Commission" FROM EMP GROUP BY deptno;

-- Task 15: Display the department number and number of employees in each department.
SELECT deptno, COUNT(empno) AS "Number of Employees" FROM EMP GROUP BY deptno;

-- Task 16: Display the department number and total salary of employees in each department.
SELECT deptno, SUM(sal) AS "Total Salary" FROM EMP GROUP BY deptno;

-- Task 17: Display the employee's name who doesn't earn a commission. Order the result set without using the column name.
SELECT ename FROM EMP WHERE comm IS NULL ORDER BY ename;

-- Task 18: Display the employee's name, department ID, and commission. If an employee doesn't earn a commission, display as 'No commission'. Name the columns appropriately.
SELECT ename AS "Employee Name", deptno AS "Department ID", COALESCE(comm, 'No Commission') AS "Commission" FROM EMP;

-- Task 19: Display the employee's name, salary, and commission multiplied by 2. If an employee doesn't earn a commission, display as 'No commission'. Name the columns appropriately.
SELECT ename AS "Employee Name", sal AS "Salary", COALESCE(comm * 2, 'No Commission') AS "Commission Multiplied by 2" FROM EMP;

-- Task 20: Display the sum of salaries of the employees working under each manager.
SELECT mgr AS "Manager", SUM(sal) AS "Sum of Salaries" FROM EMP GROUP BY mgr;

-- Task 21: Display the average of the sum of salaries grouped by department ID and ordered by department ID.
SELECT deptno AS Department, AVG(SUM(sal)) OVER (PARTITION BY deptno) AS AvgSalary
FROM EMP
GROUP BY deptno
ORDER BY deptno;

-- Task 22: Display the employee last name, department ID, department name for all employees.
SELECT e.ename AS EmployeeName, e.deptno, d.dname
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno;

-- Task 23: Create a unique list of all jobs that are in department 4, including the department location.
SELECT DISTINCT e.job_id, d.loc
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
WHERE e.deptno = 40;

-- Task 24: Write a query to display last name, department name, and city for employees earning a commission.
SELECT e.ename AS EmployeeName, d.dname AS DepartmentName, l.city
FROM EMP e
JOIN DEPT d ON e.deptno = d.deptno
JOIN LOCATIONS l ON d.loc = l.city
WHERE e.comm IS NOT NULL;

-- Task 25: Display the last name and department name of employees who have an "a" in their last name.
SELECT e.ename AS EmployeeName, d.dname AS DepartmentName
FROM EMP e
JOIN DEPT d ON e.deptno = d.deptno
WHERE e.ename LIKE '%a%';

-- Task 26: Write a query to display the last name, job, department number, and department name for employees working in ATLANTA.
SELECT e.ename AS LastName, e.job_id AS Job, e.deptno AS DepartmentID, d.dname AS DepartmentName
FROM EMP e
JOIN DEPT d ON e.deptno = d.deptno
WHERE d.loc = 'ATLANTA';

-- Task 27: Display the employee last name and number along with their manager's last name and manager number.
SELECT e.ename AS EmployeeName, e.empno AS EmployeeID, m.ename AS ManagerName, m.empno AS ManagerID
FROM EMP e
LEFT JOIN EMP m ON e.mgr = m.empno;

-- Task 28: Display the last name and email-style username (first letter of last name + @company.com).
SELECT e.ename AS LastName, CONCAT(LEFT(e.ename, 1), '@company.com') AS Email
FROM EMP e;

-- Task 29: Display the count of employees whose salary exceeds the average salary of their department.
SELECT COUNT(*) AS Count
FROM EMP e
WHERE e.sal > (
    SELECT AVG(sal)
    FROM EMP
    WHERE e.deptno = deptno
);

-- Task 30: Display employees who do not have a manager and work in SALES.
SELECT e.ename AS EmployeeName, d.dname AS Department
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
WHERE d.dname = 'SALES' AND e.mgr IS NULL;

-- Task 31: Select the employee numbers and last names of employees earning more than the average salary.
SELECT empno, ename
FROM EMP
WHERE sal > (SELECT AVG(sal) FROM EMP)
ORDER BY sal ASC;

-- Task 32: List employees whose last name contains 'u' and work in departments with employees whose salary exceeds 4000.
SELECT e1.empno, e1.ename
FROM EMP e1
WHERE e1.ename LIKE '%u%'
AND e1.deptno IN (
    SELECT DISTINCT e2.deptno
    FROM EMP e2
    WHERE e2.sal > 4000
);

-- Task 33: Display last name, department number, and job ID for employees in ATLANTA.
SELECT e.ename AS LastName, e.deptno, e.job_id
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
WHERE d.loc = 'ATLANTA';

-- Task 34: Display last name and salary of employees who report to "John".
SELECT e.ename AS LastName, e.sal AS Salary
FROM EMP e
INNER JOIN EMP m ON e.mgr = m.empno
WHERE m.ename = 'John';

-- Task 35: Show department number, last name, and job ID for employees in OPERATIONS.
SELECT e.deptno, e.ename AS LastName, e.job_id
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
WHERE d.dname = 'OPERATIONS';

-- Task 36: Modify Task 31 to also exclude employees whose department has no commission earners.
SELECT e.empno, e.ename
FROM EMP e
WHERE e.sal > (SELECT AVG(sal) FROM EMP)
AND e.deptno IN (
    SELECT DISTINCT deptno
    FROM EMP
    WHERE comm IS NOT NULL
);

-- Task 37: Find employees whose job title matches anyone in SALES.
SELECT e.ename, e.job_id
FROM EMP e
WHERE e.job_id IN (
    SELECT DISTINCT job_id
    FROM EMP
    INNER JOIN DEPT ON EMP.deptno = DEPT.deptno
    WHERE dname = 'SALES'
);

-- Task 38: Compute raises based on department: 5% (1,3), 10% (2), 15% (4,5), none (6).
SELECT empno, ename, sal,
CASE 
    WHEN deptno IN (1, 3) THEN sal * 1.05
    WHEN deptno = 2 THEN sal * 1.10
    WHEN deptno IN (4, 5) THEN sal * 1.15
    ELSE sal
END AS NewSalary
FROM EMP;

-- Task 39: Display the top three earners by last name and salary.
SELECT ename AS LastName, sal AS Salary
FROM EMP
ORDER BY sal DESC
LIMIT 3;

-- Task 40: Display the names and hire dates of employees who were hired before their managers, along with their managers' names and hire dates.
SELECT e.ename AS EmployeeName, e.hire_date AS EmployeeHireDate, m.ename AS ManagerName, m.hire_date AS ManagerHireDate
FROM EMP e
INNER JOIN EMP m ON e.mgr = m.empno
WHERE e.hire_date < m.hire_date;

-- Task 41: Write a query to display employees hired in the month of May.
SELECT ename AS EmployeeName, hire_date AS HireDate
FROM EMP
WHERE MONTH(hire_date) = 5;

-- Task 42: Write a query to display employee names and their salaries formatted as currency.
SELECT ename AS EmployeeName, CONCAT('$', FORMAT(sal, 2)) AS Salary
FROM EMP;

-- Task 43: Display employee names and hire dates in chronological order, earliest to latest.
SELECT ename AS EmployeeName, hire_date AS HireDate
FROM EMP
ORDER BY hire_date ASC;

-- Task 44: Write a query to find employees earning salaries divisible by 1000.
SELECT ename AS EmployeeName, sal AS Salary
FROM EMP
WHERE MOD(sal, 1000) = 0;

-- Task 45: Display employee names and commission amounts, show "No Commission" for NULL values.
SELECT ename AS EmployeeName, COALESCE(CONCAT('$', FORMAT(comm, 2)), 'No Commission') AS Commission
FROM EMP;

-- Task 46: List employees with a palindrome name.
SELECT ename AS EmployeeName
FROM EMP
WHERE ename = REVERSE(ename);

-- Task 47: Extract first letter from first name and append "@company.com" to create an email.
SELECT ename AS Name, CONCAT(LEFT(ename, 1), '@company.com') AS EmailAddress
FROM EMP;

-- Task 48: Find employees in departments where any colleague has "z" in their name.
SELECT DISTINCT e.ename AS EmployeeName, e.deptno AS DepartmentID
FROM EMP e
WHERE e.deptno IN (
    SELECT deptno
    FROM EMP
    WHERE ename LIKE '%z%'
);

-- Task 49: Display sum of salaries grouped by managers and count employees under them.
SELECT m.ename AS ManagerName, SUM(e.sal) AS TotalSalaries, COUNT(e.empno) AS EmployeeCount
FROM EMP e
JOIN EMP m ON e.mgr = m.empno
GROUP BY m.ename;

-- Task 50: Calculate the total duration in minutes and seconds for a flight from Rostov to Moscow.
SELECT flight_number, 
       TIMESTAMPDIFF(MINUTE, departure_time, arrival_time) AS DurationMinutes,
       TIMESTAMPDIFF(SECOND, departure_time, arrival_time) AS DurationSeconds
FROM FLIGHTS
WHERE departure_city = 'Rostov' AND arrival_city = 'Moscow';

-- Task 51: Display employees who are earning the minimum salary in their respective departments.
SELECT e.ename AS EmployeeName, e.sal AS Salary, e.deptno AS Department
FROM EMP e
WHERE e.sal = (
    SELECT MIN(sal)
    FROM EMP e2
    WHERE e2.deptno = e.deptno
);

-- Task 52: Display departments and the count of employees in each, only if the count exceeds 5.
SELECT d.dname AS DepartmentName, COUNT(e.empno) AS EmployeeCount
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) > 5;

-- Task 53: Find employees whose hire year matches their manager's hire year.
SELECT e.ename AS EmployeeName, m.ename AS ManagerName, YEAR(e.hire_date) AS HireYear
FROM EMP e
INNER JOIN EMP m ON e.mgr = m.empno
WHERE YEAR(e.hire_date) = YEAR(m.hire_date);

-- Task 54: List departments with no employees.
SELECT d.dname AS DepartmentName
FROM DEPT d
LEFT JOIN EMP e ON d.deptno = e.deptno
WHERE e.empno IS NULL;

-- Task 55: Calculate the percentage of employees working in each department compared to the total employees.
SELECT d.dname AS DepartmentName, ROUND((COUNT(e.empno) * 100.0 / (SELECT COUNT(*) FROM EMP)), 2) AS Percentage
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
GROUP BY d.dname;

-- Task 56: List the names of employees whose salary is below the average salary of their department.
SELECT 
    e.ename AS EmployeeName,
    e.sal AS Salary,
    d.dname AS Department
FROM
    EMP e
        INNER JOIN
    DEPT d ON e.deptno = d.deptno
WHERE
    e.sal < (SELECT 
            AVG(sal)
        FROM
            EMP e2
        WHERE
            e2.deptno = e.deptno);
            
-- Task 67: Identify employees who earn the same salary as someone in another department.
SELECT e1.ename AS EmployeeName, e1.sal AS Salary, d1.dname AS Department
FROM EMP e1
INNER JOIN DEPT d1 ON e1.deptno = d1.deptno
WHERE EXISTS (
    SELECT 1
    FROM EMP e2
    WHERE e1.sal = e2.sal AND e1.deptno <> e2.deptno
);

-- Task 68: Display employees who joined in the last 5 years.
SELECT ename AS EmployeeName, hire_date AS HireDate
FROM EMP
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- Task 69: List the top 3 departments by the number of employees.
SELECT d.dname AS DepartmentName, COUNT(e.empno) AS EmployeeCount
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
GROUP BY d.dname
ORDER BY EmployeeCount DESC
LIMIT 3;

-- Task 70: Retrieve the name and salary of the lowest-paid employee in each department.
SELECT e.ename AS EmployeeName, e.sal AS Salary, d.dname AS DepartmentName
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
WHERE e.sal = (
    SELECT MIN(sal)
    FROM EMP e2
    WHERE e2.deptno = e.deptno
);

-- Task 71: List all employees who do not report to anyone.
SELECT ename AS EmployeeName
FROM EMP
WHERE mgr IS NULL;

-- Task 72: Display employees along with the count of subordinates reporting to them.
SELECT m.ename AS ManagerName, COUNT(e.empno) AS SubordinateCount
FROM EMP e
INNER JOIN EMP m ON e.mgr = m.empno
GROUP BY m.ename;

-- Task 73: Retrieve all employees who are the only ones in their department.
SELECT e.ename AS EmployeeName, d.dname AS DepartmentName
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
WHERE (
    SELECT COUNT(*)
    FROM EMP e2
    WHERE e2.deptno = e.deptno
) = 1;

-- Task 74: Find all job roles where the average salary exceeds $4,000.
SELECT job_id, AVG(sal) AS AverageSalary
FROM EMP
GROUP BY job_id
HAVING AVG(sal) > 4000;

-- Task 75: Display departments where the total commission exceeds $5,000.
SELECT d.dname AS DepartmentName, SUM(e.comm) AS TotalCommission
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
WHERE e.comm IS NOT NULL
GROUP BY d.dname
HAVING SUM(e.comm) > 5000;

-- Task 76: Retrieve the details of the employee with the third-highest commission.
SELECT *
FROM EMP
WHERE comm IS NOT NULL
ORDER BY comm DESC
LIMIT 1 OFFSET 2;

-- Task 77: Identify employees who joined in the same month, regardless of the year.
SELECT e1.ename AS EmployeeName1, e2.ename AS EmployeeName2, MONTH(e1.hire_date) AS HireMonth
FROM EMP e1
INNER JOIN EMP e2 ON e1.empno <> e2.empno AND MONTH(e1.hire_date) = MONTH(e2.hire_date);

-- Task 78: Display employees who earn within $500 of their manager's salary.
SELECT e.ename AS EmployeeName, e.sal AS EmployeeSalary, m.ename AS ManagerName, m.sal AS ManagerSalary
FROM EMP e
INNER JOIN EMP m ON e.mgr = m.empno
WHERE ABS(e.sal - m.sal) <= 500;

-- Task 79: Retrieve the names of all employees whose names start and end with the same letter.
SELECT ename AS EmployeeName
FROM EMP
WHERE LEFT(ename, 1) = RIGHT(ename, 1);

-- Task 80: Find departments where no employees earn commission.
SELECT d.dname AS DepartmentName
FROM DEPT d
WHERE NOT EXISTS (
    SELECT 1
    FROM EMP e
    WHERE e.deptno = d.deptno AND e.comm IS NOT NULL
);

-- Task 81: Write a query to display all employees grouped by their department and sorted by their salary within each department.
SELECT e.ename AS EmployeeName, e.sal AS Salary, d.dname AS DepartmentName
FROM EMP e
INNER JOIN DEPT d ON e.deptno = d.deptno
ORDER BY d.dname, e.sal DESC;

