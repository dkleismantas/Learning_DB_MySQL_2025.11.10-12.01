-- Northwind products lentelė

-- 1. Išveskite visus produktus iš lentelės Products.

select * from products;

-- 2. Išveskite produktus, kurių kaina (UnitPrice) didesnė nei 50.

select * from products where UnitPrice > 30;

-- 3. Išveskite produktus, kurie yra nebeparduodami (Discontinued).

select * from products where Discontinued = 'y';

-- 4. Išveskite produktus, kurių pavadinime yra žodis "dried".

select * from products where ProductName like '%dried%';

-- 5. Išveskite produktus, kurie yra nebegaminami (Discontinued) bet dar yra pardavime (in stock).

select * from products where Discontinued = 'y' and UnitsInStock > 0;

-- 6. Išveskite produktus, kurių kaina yra tarp 20 ir 40.

select * from products where UnitPrice between 20 and 40;

-- 7. Išveskite produktus, kurie yra arba neparduodami, arba jų kaina mažesnė nei 10.

select * from products where UnitsInStock = 0 and Discontinued like 'y' or UnitPrice < 10;

-- 8. Išveskite visus produktus, kurių kategorijos ID yra 1, 2 arba 3 (naudojant IN).

select * from products where CategoryID in (1, 2, 3);

-- 9. Išveskite produktus, kurie neturi nurodyto tiekėjo (ar NULL, 0 rezultatų).

select * from products where SupplierID is null;

-- 10. Išveskite 5 brangiausius produktus pagal UnitPrice.

select * from products order by UnitPrice desc limit 5;

-- 11. Išveskite mažiausią ir didžiausią produkto kainą.

select max(UnitPrice) from products;
select min(UnitPrice) from products;

-- 12. Suskaičiuokite, kiek yra neparduodamų produktų.

select count(*) from products where UnitsInStock = 0 and Discontinued = 'y';

-- 13. Išveskite vidutinę produkto kainą tarp visų produktų.

select avg(UnitPrice) as 'Vidutine kaina' from products;

-- 14. Suskaičiuokite, kiek yra produktų kiekvienoje kategorijoje.

select CategoryName, count(*) as 'produktu kiekis' from products join categories using (CategoryID)
group by CategoryID;

-- 15. Išveskite kategorijas, kuriose yra daugiau nei 10 produktų.

select CategoryName from products join categories using (CategoryID) group by CategoryID having count(*) > 10;

-- 16. Išveskite kategorijas, kurių vidutinė produkto kaina didesnė nei 30.

select CategoryName from products join categories using (CategoryID) group by CategoryID having avg(UnitPrice) > 30; 

-- 17. Išveskite tiekėjus (SupplierID), kurių produktų kiekis sandėlyje viršija 200 vnt. (bendras kiekis per visus jų produktus).

select CompanyName from products join suppliers using (SupplierID)
group by SupplierID having sum(UnitsInStock) > 200;

-- 18. Išveskite produktus, kurie yra pigesni nei vidutinė visų produktų kaina.

select * from products where UnitPrice < (select avg(UnitPrice) from products);

-- 19. Išveskite kiekvienos kategorijos ID ir didžiausią produkto kainą toje kategorijoje (naudojant GROUP BY ir MAX).

select ProductID, max(UnitPrice) from products group by ProductID;

-- 20. Išveskite produktus, kurių tiekimo kiekis (UnitsOnOrder) yra didžiausias.

select * from products where UnitsOnOrder = (select max(UnitsOnOrder) from products);

-- 21. Išveskite produktus, kurių sandėlyje yra mažiau nei užsakytų vienetų (unitsinstock < unitsonorder).

select * from products where UnitsInStock < UnitsOnOrder;

-- 22. Išveskite kategorijos ID, kuriai priklauso daugiausiai produktų.

select CategoryID from products group by CategoryID having 
count(*) = (select count(*) from products group by CategoryID order by count(*) desc limit 1);

-- 23. Išveskite tiekėjų ID, kurie tiekia tik produktus, kurių kaina mažesnė nei visų produtų vidutinė kaina.

select SupplierID from products where UnitPrice < (select avg(UnitPrice) from products);

-- 24. Išveskite 5 tiekėjus, kurių produktų kainų vidurkis yra didžiausias.
-- Rodykite tik tuos tiekėjus, kurie tiekia bent 3 produktus.

select CompanyName from products join suppliers using (SupplierID) group by SupplierID
having count(*) > 2 order by avg(UnitPrice) desc limit 5;

-- 25. Įterpkite naują produktą pavadinimu "Organic Honey", kainuojantį 15.50, kuris priklauso kategorijai 2,
--     turi 100 vnt. sandėlyje, 20 vnt. užsakyta ir tiekėją su ID 5.

insert into products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, 
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values ("Organic Honey", 5, 2, 10, 15.50, 100, 20, 50, 'n');

-- 26. Atlikite kainos pakeitimą visiems produktams, kurių tiekėjas yra 3 – padidinkite kainą 10%.

update products set UnitPrice = UnitPrice * 1.1 where SupplierID = 3;

-- 27. Nustatykite, kad visi produktai, kurių sandėlio likutis yra 0, būtų pažymėti kaip discontinued.

update products set Discontinued = 'y' where UnitsInStock = 0;

-- 28. Pašalinkite visus produktus, kurių kaina yra mažesnė nei 1 ir jie neturi sandėlio likučio bei nėra užsakyti. 

delete from products where UnitPrice < 1 and UnitsInStock = 0 and UnitsOnOrder = 0;

-- 29. Įterpkite 3 naujus testinius produktus  su skirtingomis kategorijomis ir kainomis,
--     kurie būtų naudojami testavimui (žodis Test pavadinime), ir pažymėkite juos kaip neparduodamus.

insert into products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, 
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values ("Test1", 1, 1, 0, 10, 0, 0, 0, 'y'),
("Test2", 2, 2, 0, 20, 0, 0, 0, 'y'),
("Test3", 3, 3, 0, 30, 0, 0, 0, 'y');

-- 30. Pašalinkite visus produktus, kurių pavadinime yra žodis "Test".

delete from products where ProductName like '%Test%';