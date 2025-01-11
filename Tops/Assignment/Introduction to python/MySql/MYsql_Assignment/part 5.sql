
-- 1. Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who received an amount of 2000 in bonus.

SELECT 
  E.EMPNO AS `Employee Number`,
  CONCAT(SUBSTR(E.ENAME, 1, INSTR(E.ENAME, ' ') - 1), ' ', SUBSTR(E.ENAME, INSTR(E.ENAME, ' ') + 1)) AS `Employee Name`
FROM EMP E
WHERE E.JOB = 'Sales' AND E.SAL + E.COMM = 2000;

-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A.

SELECT 
  IFNULL(E.ADDRESS, 'N/A') AS `Address`
FROM EMP E
WHERE SUBSTR(E.ADDRESS, INSTR(E.ADDRESS, ',') + 1) = 'CA';

-- 3. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.

SELECT 
  P.PRODUCTID AS `Product ID`,
  P.PRODUCTNAME AS `Product Name`,
  IFNULL(SOH.SALESORDERID, 'No Order') AS `Sales Order ID`
FROM PRODUCT P
LEFT JOIN SALESORDERHEADER SOH ON P.PRODUCTID = SOH.PRODUCTID;

-- 4. Find the subcategories that have at least two different prices less than $15.

SELECT 
  SC.SUBCATEGORYID AS `Subcategory ID`,
  SC.SUBCATEGORYNAME AS `Subcategory Name`
FROM SUBCATEGORY SC
JOIN PRODUCT P ON SC.SUBCATEGORYID = P.SUBCATEGORYID
WHERE P.LISTPRICE < 15
GROUP BY SC.SUBCATEGORYID, SC.SUBCATEGORYNAME
HAVING COUNT(DISTINCT P.LISTPRICE) >= 2;

-- 5. A. Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name.

SELECT 
  E.EMPNO AS `Employee ID`,
  SUBSTR(E.ENAME, 1, INSTR(E.ENAME, ' ') - 1) AS `Employee First Name`,
  M.EMPNO AS `Manager ID`,
  SUBSTR(M.ENAME, 1, INSTR(M.ENAME, ' ') - 1) AS `Manager First Name`
FROM EMP E
JOIN EMP M ON E.MGR = M.EMPNO;

-- 5. B. Display the employee id and employee name of employees who do not have manager.

SELECT 
  E.EMPNO AS `Employee ID`,
  E.ENAME AS `Employee Name`
FROM EMP E
WHERE E.MGR IS NULL;

-- 6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors.

SELECT 
  P.PRODUCTNAME AS `Product Name`,
  V.VENDORNAME AS `Vendor Name`
FROM PRODUCT P
JOIN VENDOR V ON P.VENDORID = V.VENDORID
WHERE P.SUBCATEGORYID = 15;

-- 6. B. Find the products that have more than one vendor.

SELECT 
  P.PRODUCTNAME AS `Product Name`,
  COUNT(DISTINCT V.VENDORID) AS `Number of Vendors`
FROM PRODUCT P
JOIN VENDOR V ON P.VENDORID = V.VENDORID
GROUP BY P.PRODUCTNAME
HAVING COUNT(DISTINCT V.VENDORID) > 1;

-- 7. Find all the customers who do not belong to any store.

SELECT 
  C.CUSTOMERNAME AS `Customer Name`
FROM CUSTOMER C
WHERE C.STOREID IS NULL;

-- 8. Find sales prices of product 718 that are less than the list price recommended for that product.

SELECT 
  SOD.SALESORDERID AS `Sales Order ID`,
  SOD.UNITPRICE AS `Sales Price`
FROM SALESORDERDETAIL SOD
JOIN PRODUCT P ON SOD.PRODUCTID = P.PRODUCTID
WHERE P.PRODUCTID = 718 AND SOD.UNITPRICE < P.LISTPRICE;

-- 9. Display product number, description and sales of each product in the year 2001.

SELECT 
  P.PRODUCTID AS `Product Number`,
  P.PRODUCTNAME AS `Product Description`,
  SUM(SOD.UNITPRICE * SOD.QTY) AS `Sales`
FROM PRODUCT P
JOIN SALESORDERDETAIL SOD ON P.PRODUCTID = SOD.PRODUCTID
JOIN SALESORDERHEADER SOH ON SOD.SALESORDERID = SOH.SALESORDERID
WHERE YEAR(SOH.SHIPDATE) = 2001
GROUP BY P.PRODUCTID, P.PRODUCTNAME;

-- 10. Build the logic on the above question to extract sales for each category by year. Fetch Product Name, Sales_2001, Sales_2002, Sales_2003.

SELECT 
  P.PRODUCTNAME AS `Product Name`,
  SUM(CASE WHEN YEAR(SOH.SHIPDATE) = 2001 THEN SOD.UNITPRICE * SOD.QTY ELSE 0 END) AS `Sales_2001`,
  SUM(CASE WHEN YEAR(SOH.SHIPDATE) = 2002 THEN SOD.UNITPRICE * SOD.QTY ELSE 0 END) AS `Sales_2002`,
  SUM(CASE WHEN YEAR(SOH.SHIPDATE) = 2003 THEN SOD.UNITPRICE * SOD.QTY ELSE 0 END) AS `Sales_2003`
FROM PRODUCT P
JOIN SALESORDERDETAIL SOD ON P.PRODUCTID = SOD.PRODUCTID
JOIN SALESORDERHEADER SOH ON SOD.SALESORDERID = SOH.SALESORDERID
GROUP BY P.PRODUCTNAME;


