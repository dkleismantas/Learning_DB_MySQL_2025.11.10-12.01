/* =============================================================
   VARTOTOJAI IR ROLĖS — naudojame warehouse_demo DB
  
   ============================================================= */

/* -------------------------------------------------------------
   1. Prisijunkite prie duomenų bazės warehouse_demo
   ------------------------------------------------------------- */
use warehouse_demo;

/* -------------------------------------------------------------
   2. Sukurkite vartotoją vardu worker1
   ------------------------------------------------------------- */
create user worker1 identified by 'labas';

/* -------------------------------------------------------------
   3. Sukurkite lenteles pavadinimu table_items (id, item_name, quantity) ir projects (id, project_name, importance, duration_days)
   ------------------------------------------------------------- */
create table table_items (
	id int primary key auto_increment,
    item_name varchar(50),
    quantity int);
    
create table projects (
    id int primary key auto_increment,
    project_namre varchar(200),
    importance varchar(20),
    duration_days int);

/* -------------------------------------------------------------
   4. Suteikite vartotojui worker1 teises trinti, atnaujinti, įterpti ir išrinkti
      duomenis iš lentelės table_items
   ------------------------------------------------------------- */
grant delete, update, insert, select on table_items to worker1;

/* -------------------------------------------------------------
   5. Persijunkite į vartotoją worker1 
   ------------------------------------------------------------- */

-- +

-- 6. Išbandykite įrašo įterpimą, ištrynimą, duomenų išrinkimą, lentelės trynimą (turėtų nepavykti).

-- +

/* -------------------------------------------------------------
   7. Pabandykite pridėti naują stulpelį prie lentelės.
      Kadangi neturite ALTER teisės, turėtų nepavykti.
   ------------------------------------------------------------- */
-- +

/* -------------------------------------------------------------
   8. Sukurkite rolę pavadinimu role_editor
   ------------------------------------------------------------- */
-- Reconnect as administrator
create role role_editor;

/* -------------------------------------------------------------
   9. Suteikite role_editor teises atnaujinti lentelę projects
   ------------------------------------------------------------- */
grant alter on warehouse_demo.table_items to role_editor;

/* -------------------------------------------------------------
   10. Priskirkite rolę role_editor vartotojui worker1
   ------------------------------------------------------------- */
grant role_editor to worker1;
set default role role_editor to worker1;

/* -------------------------------------------------------------
   11. Prisijunkite kaip worker1 ir išbandykite duomenų išrinkimą
       bei atnaujinimą lentelėje projects.
   ------------------------------------------------------------- */
-- +

/* -------------------------------------------------------------
   12. Suteikite vartotojui worker1 administratoriaus teises.
   ------------------------------------------------------------- */
-- Reconnect as administrator:
Grant all on *.* to worker1 WITH GRANT OPTION;

/* -------------------------------------------------------------
   13. Prisijunkite kaip worker1 ir sukurkite vartotoją worker2
   ------------------------------------------------------------- */
-- +
/* Papildomai: galite suteikti worker2 tam tikras teises */

-- +
/* -------------------------------------------------------------
   Patikrinkite teises
   ------------------------------------------------------------- */
select * from mysql.user;