-- Create EMP table
CREATE TABLE EMP (
  EMPNO INT PRIMARY KEY,
  ENAME VARCHAR(20),
  JOB VARCHAR(20),
  MGR INT,
  HIREDATE DATE,
  SAL DECIMAL(10, 2),
  COMM DECIMAL(10, 2),
  DEPTNO INT
);

-- Create DEPT table
CREATE TABLE DEPT (
  DEPTNO INT PRIMARY KEY,
  DNAME VARCHAR(20),
  LOC VARCHAR(20)
);

-- Insert sample data into DEPT
INSERT INTO DEPT (DEPTNO, DNAME, LOC)
VALUES
  (10, 'Accounting', 'New York'),
  (20, 'Sales', 'Chicago'),
  (30, 'Marketing', 'Los Angeles'),
  (40, 'IT', 'Houston');

-- Insert sample data into EMP
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES
  (1, 'John Smith', 'Manager', NULL, '2020-01-01', 5000.00, NULL, 10),
  (2, 'Jane Doe', 'Sales Representative', 1, '2020-02-01', 2500.00, 500.00, 20),
  (3, 'Bob Johnson', 'Stock Clerk', 1, '2020-03-01', 2000.00, NULL, 30),
  (4, 'Alice Brown', 'Marketing Manager', 1, '2020-04-01', 4000.00, NULL, 40),
  (5, 'Mike Davis', 'IT Specialist', 1, '2020-05-01', 3500.00, NULL, 10),
  (6, 'Emily Chen', 'Sales Representative', 1, '2020-06-01', 3000.00, 750.00, 20),
  (7, 'David Lee', 'Stock Clerk', 1, '2020-07-01', 2200.00, NULL, 30),
  (8, 'Sophia Patel', 'Marketing Specialist', 1, '2020-08-01', 2800.00, NULL, 40),
  (9, 'Kevin White', 'IT Specialist', 1, '2020-09-01', 3200.00, NULL, 10),
  (10, 'Olivia Martin', 'Sales Representative', 1, '2020-10-01', 2500.00, 500.00, 20);
