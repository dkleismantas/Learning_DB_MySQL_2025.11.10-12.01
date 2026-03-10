-- 1. Išrinkti, kiek iš viso pajamų atnešė užsakymai (lentelė ORDER_DETAILS, paskaičiuojant nuolaidas).

SELECT sum(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) FROM order_details;

-- 2. Išrinkti, kiek kiekvienas produktas atnešė pajamų, paskaičiuojant nuolaidas.

SELECT sum(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) FROM order_details
GROUP BY ProductID;

-- 3. Išrinkti, kiek iš viso pajamų atnešė užsakymai, kuriems nebuvo taikyta nuolaida.

SELECT sum(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) FROM order_details
WHERE Discount = 0;

-- 4. Išrinkti, kiek kiekvienas užsakymas atnešė pajamų (užsakymo nr ir skaičius).

SELECT OrderID, sum(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) FROM order_details
GROUP BY OrderID;

-- 5. Išrinkti, kuriais produktais, išskirstytais pagal kategorijas, vis dar tęsiama prekyba (kategorija ir skaičius).

SELECT CategoryID AS Kategorija, COUNT(UnitsInStock) AS 'Prekiaujamu produktu skaicius'
FROM products
WHERE UnitsInStock > 0
GROUP BY CategoryID;

-- 6.* Į kurias šalis įvykdyta daugiausiai užsakymų, į kurias mažiausiai (lentelė ORDERS)?

SElECT ShipCountry FROM orders
GROUP BY ShipCountry
ORDER BY COUNT(ShipCountry) DESC;

SElECT ShipCountry FROM orders
GROUP BY ShipCountry
ORDER BY COUNT(ShipCountry);

-- 7.* Paskaičiuoti pajamų ir įvykdytų užsakymų į šalį santykį.

SELECT o.ShipCountry, sum(od.UnitPrice * od.Quantity - (od.UnitPrice * od.Quantity * od.Discount)) / count(o.OrderID)
FROM orders As o
INNER JOIN order_details AS od
ON o.OrderID = od.OrderID
group by ShipCountry;

-- 8.* Išrinkti, koks produktas atnešė maksimalias pajamas kiekviename užsakyme bei išvesti tas pajamas (užsakymo nr, produkto nr ir pajamos). 
--     (pvz. 10262 užsakymo 7 produktas atnešė 360 pajamų.)

WITH RevenuePerItem AS (
  SELECT 
    OrderID, 
    ProductID, 
    SUM(UnitPrice * Quantity * (1 - Discount)) AS Revenue
  FROM order_details
  GROUP BY OrderID, ProductID
),
MaxRevenuePerOrder AS (
  SELECT 
    OrderID, 
    MAX(Revenue) AS MaxRevenue
  FROM RevenuePerItem
  GROUP BY OrderID
)
SELECT 
  r.OrderID, 
  r.ProductID, 
  r.Revenue
FROM RevenuePerItem r
JOIN MaxRevenuePerOrder m
  ON r.OrderID = m.OrderID AND r.Revenue = m.MaxRevenue;


-- Per sunkus. Padaryta su AI.