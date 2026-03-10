-- 1. List all orders along with the customer's name who placed them.
-- Show the orderid, orderdate, and the contactname for each order.

SELECT OrderID, OrderDate, CompanyName FROM orders o
JOIN customers c
ON o.CustomerID = c.CustomerID;

-- 2. List all customers along with their orders, including customers who haven't placed any orders yet.
-- Show the customer contactname, orderid and orderdate.

SELECT ContactName, OrderID, OrderDate FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID;

-- 3. For each product, show the product name along with the total quantity ordered across all orders.
-- Only include products that have been ordered at least once.

SELECT ProductName, sum(Quantity) FROM products p
join order_details od
on p.ProductID = od.ProductID
group by ProductName
having count(od.ProductID) >= 1;

-- 4. Retrieve a list of customers along with their contact name and the total number of orders they have placed.
-- Only show customers who have placed more than 10 orders.

SELECT CompanyName, count(OrderID) FROM customers c
join orders o
on c.CustomerID = o.CustomerID
group by CompanyName
HAVING count(o.OrderID) > 10;

-- 5. Find the names of all suppliers and the total number of products they supply.
-- Display the supplier's name and the count of products for each supplier.

SELECT CompanyName, count(ProductID) FROM suppliers s
join products p
on s.SupplierID = p.SupplierID
GROUP BY CompanyName;

-- 6. Retrieve the average unit price of products supplied by each supplier.
-- Show the supplier's name and the average unit price of the products they supply. The average price should be above 20$.

SELECT CompanyName, avg(UnitPrice) FROM suppliers s
join products p
on s.SupplierID = p.SupplierID
group by CompanyName
having avg(UnitPrice) > 20;

-- 7. List the names of customers along with the total amount they’ve spent on all orders.

SELECT CompanyName, sum(UnitPrice * Quantity * (1 - Discount)) from customers c
join orders o
on c.CustomerID = o.CustomerID
join order_details od
on o.OrderID = od.OrderID
group by CompanyName;

-- 8. Find the category with the highest total sales (based on Quantity and UnitPrice). You can use LIMIT keyword to display only one row
-- Display the category name and the total sales value for each category, showing only the category with the highest total sales.

SELECT CategoryName, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as Revenue from categories c
join products p
on c.CategoryID = p.CategoryID
join order_details od
on p.ProductID = od.ProductID
group by CategoryName
order by Revenue desc
limit 1;