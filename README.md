# SQL- EMPLOYEE DATABASE: MAIN (SQL) & BONUS PART (SQLAIchemy)
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

````
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS title CASCADE;

CREATE TABLE "department" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "title" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_title" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "title" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT * FROM department;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM title;
````

#### Data Analysis
After importing and connecting successully database, we can start to analyse or test the data by the following step:
1. List the following details of each employee: employee number, last name, first name, sex, and salary.
`````
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON
e.emp_no = s.emp_no;
``````

2. List first name, last name, and hire date for employees who were hired in 1986.
`````
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;
`````

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
`````
SELECT dm.dept_no, dt.dept_name, dm.emp_no, e.first_name, e.last_name 
FROM dept_manager as dm
JOIN department as dt ON dm.dept_no = dt.dept_no
JOIN employees as e ON dm.emp_no = e.emp_no;
`````

4. List the department of each employee with the following information: employee number, last name, first name, and department name.
`````
SELECT de.emp_no, e.last_name, e.first_name, dt.dept_name
FROM employees as e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN department AS dt ON de.dept_no = dt.dept_no;
`````

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
`````
SELECT first_name, last_name, sex
FROM employees
WHERE first_name= 'Hercules'
AND last_name LIKE 'B%';
`````

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
`````
SELECT e.emp_no, e.last_name, e.first_name, dmt.dept_name
FROM employees as e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN department AS dmt ON de.dept_no = dmt.dept_no
WHERE dmt.dept_name='Sales';
`````

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
`````
SELECT e.emp_no, e.last_name, e.first_name, dmt.dept_name
FROM employees as e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN department AS dmt ON de.dept_no = dmt.dept_no
WHERE dmt.dept_name='Sales'
OR dmt.dept_name='Development';
`````

8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
`````
SELECT last_name, COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
`````

# BONUS PART
--------------
As you examine the data, you begin to suspect that the dataset is fake. Maybe your boss gave you spurious data in order to test the data engineering skills of a new employee? To confirm your hunch, you decide to create a visualization of the data to present to your boss. Follow these steps:
## FIRSTLY (create ENGINE to connect SQL server with JUPYTER notebook)  
````
pip install psycopg2
````
````
from sqlalchemy import create_engine
import psycopg2
from config import pass_key
----------
# create engine, and DON'T FORGET to import pass_key from config.py TO HIDE OUR PASSWORD/ USERNAME/ PORT.
engine = create_engine(f'postgresql://{username}:{pass_key}@localhost:5432/hw-sql-w9-Employee')
connection = engine.connect()
````
## SECONDLY, we can start to clean data and create GRAPH by import matplotlib.pyplot as plt
Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.)

## THIRDLY, create a histogram to visualize the most common salary ranges for employees.
Clean data and create histogram to overview the salary ranges of employees.

![employee_salary_ranges](https://user-images.githubusercontent.com/99168697/162624382-265bf351-3d6d-4dd3-85e1-68a666d7c1f1.png)

## FINALLY, create a bar chart of average salary by title.
Clean data and create a bar chart of average salary by title.

![average_salary_by_title](https://user-images.githubusercontent.com/99168697/162624388-5b53c5eb-e62d-4844-bad1-0b4bbb09b97c.png)

