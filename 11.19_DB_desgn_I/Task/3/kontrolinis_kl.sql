insert into vets (name, surname, phone, email)
values 
('Petras', 'Jonaitis', '+37000', 'petras.j@gmail.com'),
('Vilmantas', 'Ramanauskas', '+37044', 'vilmantas.r@gmail.com'),
('Robertas', 'Kavoliukas', '+370565465', 'robertas.ka@gmail.com');

select o.name, pr.service, 2025 - YEAR(p.birth_date) as Age from owners o
join patients p on o.id = p.owners_id
join visits v on p.id = v.patients_id
join services_per_visit s on v.id = s.visits_id
join prices pr on pr.id = s.prices_id
where visit_date = '2025.11.18';