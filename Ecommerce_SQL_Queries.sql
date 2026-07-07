CREATE TABLE ecommerce (
    CustomerID VARCHAR(20),
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(20),
    Location VARCHAR(100),
    OrderID VARCHAR(20),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    OrderDate DATE,
    PaymentMethod VARCHAR(50),
    ReviewScore INT
);
SELECT COUNT(*) AS Total_Orders
FROM ecommerce;

SELECT SUM(TotalAmount) AS Revenue
FROM ecommerce;

SELECT AVG(TotalAmount) AS Avg_Order_Value
FROM ecommerce;

SELECT COUNT(DISTINCT CustomerID) AS Customers
FROM ecommerce;
SELECT Product,
SUM(Quantity) AS Quantity_Sold
FROM ecommerce
GROUP BY Product
ORDER BY Quantity_Sold DESC;

SELECT Category,
SUM(TotalAmount) AS Revenue
FROM ecommerce
GROUP BY Category
ORDER BY Revenue DESC;

SELECT PaymentMethod,
COUNT(*) AS Orders,
SUM(TotalAmount) AS Revenue
FROM ecommerce
GROUP BY PaymentMethod;

SELECT Gender,
SUM(TotalAmount) AS Revenue
FROM ecommerce
GROUP BY Gender;

SELECT Category,
ROUND(AVG(ReviewScore),2) AS Avg_Rating
FROM ecommerce
GROUP BY Category;

SELECT Name,
SUM(TotalAmount) AS TotalSpent
FROM ecommerce
GROUP BY Name
ORDER BY TotalSpent DESC
LIMIT 10;

SELECT
    EXTRACT(MONTH FROM OrderDate) AS Month,
    SUM(TotalAmount) AS Revenue
FROM ecommerce
GROUP BY EXTRACT(MONTH FROM OrderDate)
ORDER BY Month;

SELECT Location,
SUM(TotalAmount) AS Revenue
FROM ecommerce
GROUP BY Location
ORDER BY Revenue DESC
LIMIT 5;

SELECT Product,
SUM(TotalAmount) AS Revenue,
RANK() OVER(ORDER BY SUM(TotalAmount) DESC) AS Ranking
FROM ecommerce
GROUP BY Product;

WITH CategorySales AS
(
SELECT Category,
SUM(TotalAmount) AS Revenue
FROM ecommerce
GROUP BY Category
)
SELECT *
FROM CategorySales
ORDER BY Revenue DESC;

SELECT Name,
TotalAmount,
CASE
WHEN TotalAmount>10000 THEN 'High Value'
WHEN TotalAmount BETWEEN 5000 AND 10000 THEN 'Medium Value'
ELSE 'Low Value'
END AS CustomerType
FROM ecommerce;

SELECT
    e1.Product,
    e1.Name AS Customer1,
    e2.Name AS Customer2
FROM ecommerce e1
JOIN ecommerce e2
ON e1.Product = e2.Product
AND e1.CustomerID <> e2.CustomerID;

SELECT Name, SUM(TotalAmount) AS TotalSpent
FROM ecommerce
GROUP BY Name
HAVING SUM(TotalAmount) =
(
    SELECT MAX(CustomerTotal)
    FROM
    (
        SELECT SUM(TotalAmount) AS CustomerTotal
        FROM ecommerce
        GROUP BY CustomerID
    ) AS t
);

