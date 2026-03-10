
CREATE DATABASE IF NOT EXISTS executors_db; 
USE executors_db;


DROP TABLE IF EXISTS project_executions;
DROP TABLE IF EXISTS executors;
DROP TABLE IF EXISTS projects;


CREATE TABLE projects (
    project_id SMALLINT NOT NULL,
    project_name VARCHAR(70),
    importance VARCHAR(30),
    start_date DATE,
    duration SMALLINT,
    PRIMARY KEY (project_id)
);


CREATE TABLE executors (
    executor_id SMALLINT NOT NULL,
    last_name VARCHAR(40),
    qualification VARCHAR(50),
    category INT,
    education VARCHAR(50),
    PRIMARY KEY (executor_id)
);


CREATE TABLE project_executions (
    project_id SMALLINT NOT NULL,
    executor_id SMALLINT NOT NULL,
    role VARCHAR(40),
    hours INT,
    PRIMARY KEY (project_id, executor_id),
    CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_executor FOREIGN KEY (executor_id) REFERENCES executors(executor_id)
);





INSERT INTO executors (executor_id, last_name, qualification, category, education) VALUES
    (1, 'Jonaitis', 'Computer Scientist', 2, 'Vilnius University'),
    (2, 'Petraitis', 'Statistician', 3, 'Vilnius University'),
    (3, 'Gražulytė', 'Engineer', 1, NULL),
    (4, 'Onaitytė', 'Manager', 5, 'Vytautas Magnus University'),
    (5, 'Antanaitis', 'Computer Scientist', 3, 'Vilnius University');


INSERT INTO projects (project_id, project_name, importance, start_date, duration) VALUES
    (1, 'Student Accounting', 'High', '2023-01-01', 12),
    (2, 'Financial Accounting', 'Medium', '2023-03-01', 10),
    (3, 'Website', 'Special', '2023-06-01', 2);
	
	
INSERT INTO project_executions (project_id, executor_id, role, hours) VALUES
    (1, 1, 'Programmer', 30),
    (1, 2, 'Documenter', 100),
    (1, 3, 'Tester', 100),
    (1, 4, 'Manager', 100),
    (2, 1, 'Programmer', 300),
    (2, 2, 'Analyst', 250),
    (2, 4, 'Manager', 100),
    (3, 1, 'Programmer', 250),
    (3, 2, 'Manager', 400),
    (3, 3, 'Designer', 150);
