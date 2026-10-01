CREATE DATABASE WALE_ENTERPRISE;
USE WALE_ENTERPRISE;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Age INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Customers (CustomerID, CustomerName, City, Age)
VALUES
(1, 'John', 'Lagos', 28),
(2, 'Mary', 'Warri', 32),
(3, 'David', 'Abuja', 25),
(4, 'Sarah', 'Lagos', 30),
(5, 'Michael', 'Benin', 35),
(6, 'Grace', 'Ibadan', 27),
(7, 'Daniel', 'Lagos', 40),
(8, 'Esther', 'Abuja', 29);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2026-01-05', 150000),
(102, 2, '2026-01-12', 85000),
(103, 1, '2026-02-10', 200000),
(104, 3, '2026-02-18', 120000),
(105, 4, '2026-03-02', 95000),
(106, 2, '2026-03-15', 175000),
(107, 5, '2026-04-08', 300000),
(108, 6, '2026-04-20', 110000),
(109, 7, '2026-05-05', 250000),
(110, 8, '2026-05-18', 180000),
(111, 4, '2026-06-01', 90000),
(112, 5, '2026-06-15', 220000);






INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Laptop', 'Electronics', 500000),
(2, 'Phone', 'Electronics', 350000),
(3, 'Shoes', 'Fashion', 85000),
(4, 'Bag', 'Fashion', 60000),
(5, 'Watch', 'Accessories', 120000);

---Show me all customers whose city is Lagos
SELECT *
FROM Customers
WHERE City = 'lagos';

---Show me all customers that their age is 40years
SELECT *
FROM Customers
WHERE Age = 40;

---Show me all customers older than 30years
SELECT *
FROM Customers
WHERE Age > 30;

---Show me customers that live in Lagos and are older than 30years
---Note in AND both conditions must be true
SELECT *
FROM Customers
WHERE City = 'lagos'
AND Age > 30;

---Show me all customers that are either from lagos or Abuja
---Note in OR at least 1condition can be true or either condition
SELECT *
FROM Customers
WHERE City = 'lagos'
OR City = 'Abuja';

---Show all customers who are not from lagos
---How to use not 
SELECT *
FROM Customers
WHERE NOT City = 'Lagos';

---Show me all customers whose city is either Lagos Abuja and benin
---This is for IN Function
SELECT *
FROM Customers 
WHERE City IN ('Lagos', 'Abuja', 'benin');

SELECT *
FROM Customers
WHERE Age BETWEEN 25 AND 30;

---LIKE function is used to find customers whose names start with an Alphabet
---Select all customers whose name start with M
---Note to search for customers whose name end with an alphabeth put %sign before the alphabeth
SELECT *
FROM Customers 
WHERE CustomerName LIKE 'D%';

---SHOW ORDERS AFTER MARCH 1ST 2026
---
SELECT *
FROM Orders
WHERE OrderDate > '2026-03-01';

---SHOW ORDERS ON A PARTICULAR DATE
SELECT *
FROM Orders
WHERE OrderDate = '2026-06-15'


---different cities alphabetically:
SELECT DISTINCT City
FROM Customers
ORDER BY City ASC;


---How much has each customer spent?
SELECT. CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID;


—--Customers whose total spending is greater than ₦300,000.
SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 300000;


—---Show the customer’s name, city and age for customers older than 28, from oldest to youngest.
SELECT CustomerName, City, Age
FROM Customers
WHERE Age > 28
ORDER BY Age DESC;

---Show customer's name and address in one table.
SELECT CONCAT(CustomerName, ' - ', City) AS CustomerInfo
FROM Customers;


SELECT CustomerName,UPPER(CustomerName) AS UpperName
FROM Customers;

SELECT TRIM(CustomerName) AS CleanName
FROM Customers;


---mistake recheck
SELECT REPLACE(City, ' State', 'Porthacouth') AS CleanCity
FROM Customers;


---Suppose we want to classify customers according to age.
SELECT
    CustomerName,
    Age,
    CASE
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 35 THEN 'Adult'
        ELSE 'Older_person'
    END AS AgeGroup
FROM Customers;

---What is the total sales for orders above ₦100,000?
SELECT
    SUM(TotalAmount) AS TotalSales
FROM Orders
WHERE TotalAmount > 100000;



---First select orders worth at least ₦100,000, then calculate their average.
SELECT
    AVG(TotalAmount) AS AverageOrder
FROM Orders
WHERE TotalAmount >= 100000;

---Suppose we want to group orders by year and month (Annual Review Progress via month)
SELECT
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(TotalAmount) AS MonthlySales
FROM Orders
GROUP BY
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY
    OrderYear DESC,
    OrderMonth ASC;

----For orders above ₦100,000, show the total amount spent by each customer.

SELECT
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
FROM Orders
WHERE TotalAmount > 100000
GROUP BY CustomerID;




----For orders above ₦100,000, show customers whose total spending is above ₦250,000.



SELECT
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
FROM Orders
WHERE TotalAmount > 100000
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 250000
ORDER BY TotalSpent ASC;

---For each customer, show how many orders they made and how much they spent in total. Only include orders above ₦100,000.
SELECT
    CustomerID,
    COUNT(*) AS NumberOfOrders,
    SUM(TotalAmount) AS TotalSpent
FROM Orders
WHERE TotalAmount > 100000
GROUP BY CustomerID;

---For orders above ₦100,000, show customers who have made at least 2 qualifying orders.
SELECT
    CustomerID,
    COUNT(*) AS NumberOfOrders,
    SUM(TotalAmount) AS TotalSpent
FROM Orders
WHERE TotalAmount > 100000
GROUP BY CustomerID
HAVING COUNT(*) >= 2;

---Show each CustomerID, number of orders, and total spending, but only orders above ₦150,000.
SELECT
    CustomerID,
    COUNT(*) AS NumberOfOrders,
    SUM(TotalAmount) AS New_Total_table
FROM Orders
WHERE TotalAmount > 150000
GROUP BY CustomerID;

---Only orders above ₦100,000, then show customers whose total spending is above ₦250,000
----Orders above ₦100,000 → at least 2 qualifying orders → show count, total and average → highest total first
SELECT
    CustomerID,
    COUNT(*) AS NumberOfOrders,
    SUM(TotalAmount) AS TotalSpent,
    AVG(TotalAmount) AS AverageOrder
FROM Orders
WHERE TotalAmount > 100000
GROUP BY CustomerID
HAVING COUNT(*) >= 2
ORDER BY TotalSpent DESC;


---FJWGHSOL IS THE STANDARD FORMULAR THAT GUIDES YOU WHEN ARRANGING AN SQL QUERRY



---For orders made from April 2026 onward, show each customer’s total spending. Only show customers who spent more than ₦200,000.
SELECT
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
FROM Orders
WHERE OrderDate >= '2026-04-01'
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 200000;

---Show every customer and any order they have made.

SELECT
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;


    ----Show all customers, but only display orders above ₦150,000.

    SELECT
    c.CustomerName,
    o.OrderID,
    o.TotalAmount
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > 150000;

---Customers who have no orders.

SELECT
    c.CustomerID,
    c.CustomerName
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

----Show every customer and how many orders they have.


SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName;

---Show every customer who has made at least 2 orders.

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
HAVING COUNT(o.OrderID) >= 2
ORDER BY NumberOfOrders DESC;

----Show every order and the customer’s name if a matching customer exists.
SELECT
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    c.CustomerName
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;

-----Show every customer’s name, number of orders and total spending. Only count orders above ₦100,000. Only show customers with at least 2 qualifying orders.

SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS NumberOfOrders,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
    WHERE o.TotalAmount > 100000
GROUP BY
    c.CustomerID,
    c.CustomerName
HAVING COUNT(o.OrderID) >= 2
ORDER BY TotalSpent DESC;

SELECT *
FROM Orders;
SELECT *
FROM Products;
SELECT *
FROM Customers;

SELECT *
FROM Customers;