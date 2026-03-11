# Databases. Writing queries in MySQL Workbench. DB design
## Overview
In this module, I learned how to write queries for MySQL databases. I also practiced CRUD queries, designed databases, created users, and assigned permissions. I had one lesson on MongoDB and writing queries for it.

# Technologies used

- Docker, MySQL Workbench

# How to run the assignments
**Warning:** Some assignments are provided in Lithuanian.

## Preparation

- Download and install Docker.
- In Docker or another terminal, run the command: `docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d -p 3306:3306 mysql:lts`
Replace my-secret-pw with your chosen password (you will need it later).
- Download and install MySQL Workbench Visual Database Designer.
- Create a new Connection. In the Password field, choose Store in Vault and enter the password you used when creating the Docker container.
- Connect to your newly created virtual server.

## Running the assignments

- Clone the repository.
- Open MySQL Workbench and connect using your created connection.
- In the top-left corner, click Open a SQL script file in a new query tab.
- Select the folder of the topic you want, then open the Task folder. Inside, you may find one or several assignments.
Always start by opening the file that contains “script” in its name — this imports the database you will be working with.
If such a file does not exist, the database was likely imported in a previous topic.
- After opening the file, execute its code to import the database.
- Then repeat the file‑opening steps in MySQL and open the next file, which contains the tasks and their solutions.
- Execute each task line separately so you can see the results at the bottom of the program.

## For DB design tasks
**Warning:** All DB design assignments in Word files are provided in Lithuanian.
- Open the designed databases in MySQL Workbench by selecting File > Open Model… and choosing the file with the .mwb extension.
- After opening the file, you will see the designed database
