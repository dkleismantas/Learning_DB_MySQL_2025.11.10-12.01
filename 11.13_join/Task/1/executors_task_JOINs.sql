-- 1. Add a new column named "FirstName" to the "executors" table and populate it with data.

ALTER TABLE executors ADD COLUMN FirstName VARCHAR(40);

UPDATE executors SET FirstName = 'Jonas'   WHERE executor_id = 1;
UPDATE executors SET FirstName = 'Petras'  WHERE executor_id = 2; 
UPDATE executors SET FirstName = 'Gabija'  WHERE executor_id = 3; 
UPDATE executors SET FirstName = 'Ona'     WHERE executor_id = 4; 
UPDATE executors SET FirstName = 'Antanas' WHERE executor_id = 5; 

-- 2. Retrieve the executors' last names, qualifications, and the roles they hold in projects.

SELECT e.last_name, e.qualification, pe.role
FROM executors e
join project_executions pe
on e.executor_id = pe.executor_id;

-- 3. Retrieve the executors' first names and last names along with the name of the project they work on.

SELECT e.FirstName, e.last_name, p.project_name
From executors e
join project_executions pe
on e.executor_id = pe.executor_id
join projects p
on pe.project_id = p.project_id;

-- 4. Retrieve the first and last names of executors working on the 'Financial Accounting' project along with the project name.

SELECT e.FirstName, e.last_name, p.project_name
From executors e
join project_executions pe
on e.executor_id = pe.executor_id
join projects p
on pe.project_id = p.project_id
WHERE p.project_name = 'Financial Accounting';

-- 5. Retrieve all executors from the 'Student Accounting' project who have a qualification of 'Computer Scientist'.

SELECT e.FirstName, e.last_name, p.project_name
From executors e
join project_executions pe
on e.executor_id = pe.executor_id
join projects p
on pe.project_id = p.project_id
WHERE p.project_name = 'Student Accounting' AND e.qualification = 'Computer Scientist';

-- 6. Retrieve all female executors with the role of 'Manager' and display their first names, last names, and the project name.
--    (Assumes that gender identification is inferred from naming conventions.)

SELECT e.FirstName, e.last_name, p.project_name
From executors e
join project_executions pe
on e.executor_id = pe.executor_id
join projects p
on pe.project_id = p.project_id
WHERE e.FirstName LIKE '%a' AND pe.role = 'Manager';

-- 7. Retrieve project names, importance, and the total hours dedicated to each project.

SELECT p.project_name, p.importance, sum(pe.hours)
FROM projects p
join project_executions pe
on p.project_id = pe.project_id
group by project_name, importance;

-- 8. Retrieve project names along with the count of employees working on each project.

select p.project_name, count(*)
from projects p
join project_executions pe
on p.project_id = pe.project_id
group by p.project_id;

-- 9. Limit the results from query #8 to include only projects with no more than 3 employees.

select p.project_name, count(*)
from projects p
join project_executions pe
on p.project_id = pe.project_id
group by p.project_id
having count(*) > 3;

-- 10. Retrieve executors' first and last names along with the names of the projects they work on, excluding those who hold a 'Manager' role.

SELECT e.FirstName, e.last_name, p.project_name
From executors e
join project_executions pe
on e.executor_id = pe.executor_id
join projects p
on pe.project_id = p.project_id
WHERE pe.role != 'Manager';

-- 11. Create a new record in the "executors" table with:
--     executor_id: 6, FirstName: 'Pranas', last_name: 'Logis', qualification: NULL, category: NULL, and education: NULL.

insert into executors (executor_id, FirstName, last_name)
values (6, 'Pranas', 'Logis');

-- 12. Retrieve executors' first names and last names along with project names, including those executors who are not associated with any project.

SELECT e.FirstName, e.last_name, p.project_name
From executors e
left join project_executions pe
on e.executor_id = pe.executor_id
left join projects p
on pe.project_id = p.project_id;

-- 13. Retrieve executors' first names, last names, and project names for those with roles 'Programmer' or 'Analyst', who have logged at least 250 hours,
--     and where the project's duration is at least 10 weeks.

SELECT e.FirstName, e.last_name, p.project_name
From executors e
join project_executions pe
on e.executor_id = pe.executor_id
join projects p
on pe.project_id = p.project_id
WHERE pe.role IN ('Programmer', 'Analyst') and p.duration >= 10
group by firstname, last_name, project_name
having sum(hours) >= 250;