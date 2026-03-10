-- 1. IŠRINKTI PRODUKTŲ VARDUS, KURIŲ DAR YRA SANDĖLYJE, BET JŲ PERVEŽIMAS NUTRAUKTAS.

SELECT ProductName FROM products
WHERE UnitsInStock > 0 AND Discontinued = 'y';

-- 2. IŠRINKTI PRODUKTŲ VARDUS, KURIŲ NĖRA SANDĖLYJE, BET JŲ PERVEŽIMAS VIS DAR VYKDOMAS.

SELECT ProductName FROM products
WHERE UnitsInStock = 0 AND Discontinued = 'n';

-- 3. IŠRINKTI PRODUKTŲ VARDUS, KURIŲ ARBA PERVEŽIMAS NUTRAUKTAS, ARBA NĖRA SANDĖLYJE IR NĖRA UŽSAKYTŲ.

SELECT ProductName FROM products
WHERE Discontinued = 'y' OR UnitsInStock = 0 AND UnitsOnOrder = 0;

-- 4. Įveskite į konsolę (SQL) šiuos sakinius. Kodėl vienais atvejais atsakymas true (1), kitais false (0)?
SELECT 1 AND 0; -- 0
SELECT 1 OR 0; -- 1
SELECT 1 AND 0 OR 1; -- 1
SELECT NOT 1 AND 1; -- 0
SELECT NOT (1 AND 1); -- 0
SELECT NOT (NOT 1 AND 1 OR NOT 0 AND 1); -- 0
	  -- 0		0	  0	 1	   1	 1
	  -- 6		1	  2	 5	   3	 4