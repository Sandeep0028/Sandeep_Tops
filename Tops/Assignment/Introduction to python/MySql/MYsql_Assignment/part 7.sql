
-- 1. Find the date difference between the hire date and resignation_date for all the employees. Display in no. of days, months and year (1 year 3 months 5 days).

SELECT 
  Emp_ID,
  Hire_Date,
  Resignation_Date,
  DATEDIFF(Resignation_Date, Hire_Date) AS `Days`,
  FLOOR(DATEDIFF(Resignation_Date, Hire_Date) / 30.44) AS `Months`,
  FLOOR(DATEDIFF(Resignation_Date, Hire_Date) / 365.25) AS `Years`
FROM Employees;

-- 1. a. To format the output as "1 year 3 months 5 days", you can use a combination of the FLOOR function and string concatenation:

SELECT 
  Emp_ID,
  Hire_Date,
  Resignation_Date,
  CONCAT(
    FLOOR(DATEDIFF(Resignation_Date, Hire_Date) / 365.25), 
    ' year(s) ',
    FLOOR(MOD(DATEDIFF(Resignation_Date, Hire_Date), 365.25) / 30.44), 
    ' month(s) ',
    MOD(DATEDIFF(Resignation_Date, Hire_Date), 30.44), 
    ' day(s)'
  ) AS `Date Difference`
FROM Employees;

-- 2.  Format the hire date as mm/dd/yyyy (09/22/2003) and resignation_date as mon dd, yyyy (Aug 12th, 2004). Display the null as (DEC, 01th 1900).

SELECT 
  Emp_ID,
  DATE_FORMAT(Hire_Date, '%m/%d/%Y') AS `Hire Date`,
  IFNULL(DATE_FORMAT(Resignation_Date, '%M %d, %Y'), 'DEC 01, 1900') AS `Resignation Date`
FROM Employees;

-- 3. Calculate experience of the employee till date in Years and months (example 1 year and 3 months). Use Getdate() as input date for the below three questions.

SELECT 
  Emp_ID,
  Hire_Date,
  GETDATE() AS `Current Date`,
  CONCAT(
    FLOOR(DATEDIFF(GETDATE(), Hire_Date) / 365.25), 
    ' year(s) ',
    FLOOR(MOD(DATEDIFF(GETDATE(), Hire_Date), 365.25) / 30.44), 
    ' month(s)'
  ) AS `Experience`
FROM Employees;

-- 4. Display the count of days in the previous quarter.

SELECT 
  QUARTER(GETDATE()) - 1 AS `Previous Quarter`,
  DATEDIFF(
    DATE_FORMAT(GETDATE(), '%Y-%m-01') - INTERVAL 1 QUARTER,
    DATE_FORMAT(GETDATE(), '%Y-%m-01') - INTERVAL 1 QUARTER + INTERVAL 3 MONTH
  ) AS `Days in Previous Quarter`
FROM DUAL;

-- 5. Fetch the previous Quarter's second week's first day's date.

SELECT 
  DATE_FORMAT(
    DATE_FORMAT(GETDATE(), '%Y-%m-01') - INTERVAL 1 QUARTER + INTERVAL 1 WEEK,
    '%Y-%m-%d'
  ) AS `Previous Quarter's Second Week's First Day's Date`
FROM DUAL;

-- 6. Fetch the financial year's 15th week's dates (Format: Mon DD YYYY).

SELECT 
  DATE_FORMAT(
    DATE_FORMAT(GETDATE(), '%Y-%m-01') - INTERVAL 3 MONTH + INTERVAL 15 WEEK,
    '%W %m %d, %Y'
  ) AS `Financial Year's 15th Week's Dates`
FROM DUAL;

-- 7. Find out the date that corresponds to the last Saturday of January, 2015 using with clause.

WITH dates AS (
  SELECT 
    '2015-01-01' AS `Date`
  UNION ALL
  SELECT 
    DATE_ADD(`Date`, INTERVAL 1 DAY)
  FROM dates
  WHERE `Date` < '2015-01-31'
)
SELECT 
  MAX(`Date`) AS `Last Saturday of January, 2015`
FROM dates
WHERE DAYOFWEEK(`Date`) = 7;

-- 8. Find the number of days elapsed between first and last flights of a passenger.

SELECT 
  Passenger_ID,
  MIN(Flight_Date) AS `First Flight`,
  MAX(Flight_Date) AS `Last Flight`,
  DATEDIFF(MAX(Flight_Date), MIN(Flight_Date)) AS `Days Elapsed`
FROM Flights
GROUP BY Passenger_ID;

-- 9. Find the total duration in minutes and in seconds of the flight from Rostov to Moscow.

SELECT 
  SUM(Flight_Duration_Minutes) AS `Total Duration in Minutes`,
  SUM(Flight_Duration_Minutes) * 60 AS `Total Duration in Seconds`
FROM Flights
WHERE Departure_City = 'Rostov' AND Arrival_City = 'Moscow';
