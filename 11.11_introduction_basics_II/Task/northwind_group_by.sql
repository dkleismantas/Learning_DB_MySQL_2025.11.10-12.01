-- Northwind customers lentelė

-- 1. Suskaičiuokite, kiek yra viso klientų lentelėje customers.

SELECT COUNT(CustomerID) AS 'Klientu skaicius' FROM customers;

-- 2. Išrinkite unikalių šalių (Country) skaičių lentelėje customers.

SELECT DISTINCT Country FROM customers;

-- 3. Išrinkite, kiek klientų yra kiekvienoje šalyje.

SELECT Country, COUNT(CustomerID) FROM customers
GROUP BY Country;

-- 4. Išrinkite, kiek klientų yra kiekvienoje šalyje, surikiuokite nuo daugiausia klientų turinčių iki mažiausiai, o tada – pagal šalį.

SELECT Country, COUNT(CustomerID) FROM customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC, Country;

-- 5. TOP 5 šalys pagal klientų skaičių.

SELECT Country AS 'TOP 5 pagal klientus' FROM customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC
LIMIT 5;

-- 6. Šalys, kuriose > 5 klientų. Pateikite šalį ir klientų skaičių.

SELECT Country, COUNT(CustomerID) AS 'Salys su daugiau nei 5 klientais' FROM customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;

-- 7. Išrinkite miestus, kuriuose yra tarp 2 ir 5 klientų.

SELECT City, COUNT(CustomerID) FROM customers
GROUP BY City
HAVING COUNT(CustomerID) BETWEEN 2 AND 5;

-- 8. Išrinkite miestus, kurių pavadinimas prasideda raide "B" ir kiek ten yra klientų.

SELECT City, COUNT(CustomerID) FROM customers
WHERE City LIKE 'B%'
GROUP BY City;

-- 9. Išrinkite kiek klientų turi faksą (ne null ir ne tuščias), suskaičiuoti bendrą kiekį.

SELECT COUNT(*) FROM customers
WHERE Fax LIKE '_%' AND Fax IS NOT NULL;

-- 10. Miestai, kur bent 2 klientai turi telefoną, prasidedantį „(1)“

SELECT City FROM customers
WHERE Phone LIKE '(1)%'
GROUP BY City
HAVING COUNT(CustomerID) >= 2;

-- 11. Šalys, kuriuose dirba klientai, kurių CompanyName turi žodį „Market“, ir jų skaičius

SELECT Country, COUNT(CustomerID) AS 'Klientu skaicius' FROM customers
WHERE CompanyName LIKE '%Market%'
GROUP BY Country;