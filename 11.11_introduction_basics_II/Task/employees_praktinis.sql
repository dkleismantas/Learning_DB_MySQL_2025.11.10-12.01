-- 1. Išrinkite visus duomenis iš lentelės “EMPLOYEES”.

SELECT * FROM employees;

-- 2. Išrinkite visus duomenis iš stulpelio “EMPLOYEEID” - lentelėje “EMPLOYEES”.

SELECT EmployeeID FROM employees;

-- 3. Išrinkite visus duomenis iš stulpelių “LASTNAME”,”FIRSTNAME”, “TITLE” - lentelėje “EMPLOYEES”.

SELECT LastName, FirstName, Title FROM employees;

-- 4. Išrinkite skirtingas reikšmes iš stulpelio “CITY” - lentelėje “EMPLOYEES”. 

SELECT DISTINCT City FROM employees;

-- 5. Išrinkite visus duomenis apie darbuotojus, kurie dirba Mieste Seattle.

SELECT * FROM employees
WHERE City = 'Seattle';

-- 6. Išrinkite duomenis, kokias pareigas užima Andrew.

SELECT Title FROM employees
WHERE FirstName = 'Andrew';

-- 7. Išrinkite visus duomenis apie darbuotojus, kurių gimimo data – 1963-07-02.

SELECT * FROM employees
WHERE BirthDate = '1963-07-02';

-- 8. Išrinkite darbuotojų vardus, kurių pavardės yra Leverling.

SELECT FirstName FROM employees
WHERE LastName = 'Leverling';

-- 9. Išrinkite visus duomenis apie darbuotojus, kurių pavardė prasideda raide 'D'.

SELECT * FROM employees
WHERE LastName LIKE 'D%';

-- 10. Išrinkite duomenis (vardą ir pavardę) darbuotojų, kurių vardo antroji raidė yra 'a'.

SELECT FirstName, LastName FROM employees
WHERE FirstName LIKE '_a%';

-- 11. Išrinkite duomenis (vardą ir pavardę) apie pardavimų atstovus iš Jungtinių Amerikos Valstijų.

SELECT FirstName, LastName FROM employees
WHERE Country = 'USA' AND Title = 'Sales Representative';

-- 12. Išrinkite visus duomenis apie darbuotojus, kurie dirba Londone arba Seattle. Išrikiuokite pagal pavardę.

SELECT * FROM employees
WHERE City IN ('London', 'Seattle')
ORDER BY LastName;

-- 13. Suskaičiuokite, kiek įmonėje dirba pardavimų atstovų.

SELECT COUNT(*) AS 'Pardavimu atstovai' FROM employees
WHERE Title = 'Sales Representative';

-- 14. Suraskite vyriausio darbuotojo gimimo datą

SELECT MAX(BirthDate) FROM employees;

-- 15. Išrinkite visus duomenis apie 3 jauniausius darbuotojus.

SELECT BirthDate FROM employees
ORDER BY BirthDate DESC
LIMIT 3;