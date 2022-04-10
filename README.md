# SQL- EMPLOYEE DATABASE
## BACKGROUND
It’s a beautiful spring day, and it’s been two weeks since you were hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remains of the database of employees from that period are six CSV files.

You will perform:

  1. Data Modeling
  2. Data Engineering
  3. Data Analysis

#### Data Modeling
Firstly, we have to sketch the tables and columns of each table to check the relationship between the data.
Inspect the CSVs and sketch out an ERD of the tables by using the tool like http://www.quickdatabasediagrams.com.
![QuickDBD-export](https://user-images.githubusercontent.com/99168697/162622556-8d6838f1-3775-4e29-b217-e8da4da218ca.png)

And, export the schema from the link to import data (next step)

#### Data Modeling
Secondly, we open pdAdmin4/ PostpreSQL and run the schema code in order to CREATE TABLES.
After that we import data (6 CSV) into each SQL table, THEN run 'ALTER TABLE' to connect the related columns into each other.
- Specify data types, primary keys, foreign keys, and other constraints.
[Uploading employee_dbd- RELATIONSHIP.sql…]()

#### Data Analysis
After importing and connecting successully database, we can start to analyse or test the data by the following step:
1. List the following details of each employee: employee number, last name, first name, sex, and salary.


2. List first name, last name, and hire date for employees who were hired in 1986.


3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.


4. List the department of each employee with the following information: employee number, last name, first name, and department name.


5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."


6. List all employees in the Sales department, including their employee number, last name, first name, and department name.


7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.


8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
