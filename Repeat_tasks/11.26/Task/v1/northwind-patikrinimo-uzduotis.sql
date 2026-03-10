-- 1. Išrinkite visus duomenis iš lentelės "ORDERS"

select * from orders;

-- 2. Išrinkite duomenis, kiek iš viso buvo įvykdyta užsakymų

select count(OrderID) from orders;

-- 3. Išrinkite duomenis (užsakymo datą ir laivo vardą) apie visus krovinius į Prancūziją

select OrderDate, ShipName from orders where ShipCountry = 'France';

-- 4. Išrinkite užsakymus (užsakymo ID, užsakymo datą ir šalį) apie visus krovinius, išsiųstus į šalis, prasidedančias raidėmis G, B arba A

select OrderID, OrderDate, ShipCountry from orders where ShipCountry like 'G%' or  ShipCountry like 'B%' or  ShipCountry like 'A%';

-- 5. Išrinkite duomenis (adresas, laivo vardas, šalis) apie užsakymus, kurių ORDERID yra nuo 10248 iki 10300

select ShipAddress, ShipName, ShipCountry from orders where OrderID between 10248 and 10300;

-- 6. Išrinkite visus duomenis apie užsakymus, kurių numeriai yra 10250, 10260, 10270 (operatorius IN)

select * from orders where OrderID in (10250, 10260, 10270);

-- 7. Išrinkite visus duomenis apie užsakymus ir išrikiuokite duomenis pagal užsakymo datą nuo seniausios iki naujausios

select * from orders order by ShippedDate;

-- 8. Išveskite stulpelio FREIGHT vidurkį

select avg(Freight) from orders;

-- 9. Išrinkite duomenis (šalis ir skaičius), kiek krovinių buvo išplukdyta į kiekvieną šalį

select ShipCountry, count(OrderID) from orders group by ShipCountry;

-- 10. Išrinkite duomenis (šalis ir skaičius), kiek produktų buvo išplukdyta į kiekvieną šalį (produktai lentelėje ORDER_DETAILS)

select ShipCountry, count(Quantity) from orders join order_details using (orderid) group by ShipCountry;

-- 11. #9 punkto užklausą pataisykite taip, kad rodytų tik tas šalis, į kurias buvo išplukdyta daugiau nei 20 krovinių

select ShipCountry, count(OrderID) from orders group by ShipCountry having count(OrderID) > 20;

-- 12. Įterpkite į lentelę PRODUCTS naują įrašą, užpildydami visus laukus, skirdami ID=1000, bei priskirkite produktą 'Seafood' kategorijai (lentelė CATEGORIES)

insert into products values (1000, 'Fish', 23, 8, 10, 2, 50, 20, 50, 'n');

-- 13. Atnaujinkite duomenis apie produktą, priskirdami jį 'Beverages' kategorijai, kurio ID yra 23

update products set CategoryID = 1 where ProductID = 23;

-- 14. Išrinkite duomenis (produkto pavadinimas, vieneto kaina, užsakymo numeris ir aptarnavęs darbuotojas),
-- kokie produktai buvo užsakyti bei apie tuos, kurių niekas neužsakė

select ProductName, od.UnitPrice, od.OrderID, concat(e.FirstName, ' ', e.LastName) as Employee from products p
left join order_details od using (ProductID)
left join orders o using (OrderID)
left join employees e using (EmployeeID);

select ProductName, count(ID) from products join order_details using (ProductID) group by ProductName;

-- 15. Ištrinkite iš lentelės PRODUCTS įrašą, kurį sukūrėte #12 užklausoje

delete from products where ProductID = 1000;

-- PAPILDOMAI: Sujunkite visas NORTHWIND duomenų bazės lenteles į vieną naudojant JOIN (išskyrus CUSTOMERCUSTOMERDEMO, CUSTOMERDEMOGRAPHICS, USSTATES lenteles)

