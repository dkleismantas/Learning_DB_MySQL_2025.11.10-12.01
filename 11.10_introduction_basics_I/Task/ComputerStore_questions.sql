-- 0 Select all products

SELECT * FROM Products;
	
-- 1 Select the names of all the products in the store.

SELECT Name FROM Products;

-- 2 Select the names and the prices of all the products in the store.

SELECT Name, Price FROM Products;

-- 3 Select the name of the products with a price less than or equal to $200.

SELECT Name FROM Products
where Price <= 200;

-- 4 Select all the products with a price between $60 and $120.

SELECT * FROM Products
WHERE Price BETWEEN 60 and 120;

-- 5 Select the name and price in cents (i.e., the price must be multiplied by 100).

SELECT Name, Price*100 AS 'Price in cents' FROM Products;

-- 6 Select all the products whose name begins with an "DVD"

SELECT * FROM Products
WHERE Name LIKE 'DVD%';

-- 7 Select all the products whose name ends with an "e"

SELECT * FROM Products
WHERE Name LIKE '%e';

-- 8 Select all the products whose names second letter is "o"

SELECT * FROM Products
WHERE Name LIKE '_e%';

-- 9 Compute the average price of all the products.

SELECT AVG (Price) AS 'Average price'
FROM Products;

-- 10 Compute the average price of all products with manufacturer code equal to 2.

SELECT AVG (Price) AS 'Average price not Man 2'
FROM Products
WHERE Manufacturer != 2;

-- 11 Compute the number of products with a price larger than or equal to $180.

SELECT COUNT(Name) AS 'More than $100'
FROM Products
WHERE Price >= 100;

-- 12 Select the name and price of all products with a price larger than or equal to $180,
-- and sort first by price (in descending order), and then by name (in ascending order).

SELECT Name, Price
FROM Products
WHERE Price >= 100
ORDER BY Price DESC, Name ASC;