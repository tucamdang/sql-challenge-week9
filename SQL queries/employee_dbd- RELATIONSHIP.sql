﻿department
---------
dept_no VARCHAR PK
dept_name VARCHAR

dept_emp
-------
emp_no INT FK >- employees.emp_no
dept_no VARCHAR FK >- department.dept_no

dept_manager
---------
dept_no VARCHAR FK >- department.dept_no
emp_no INT FK >- employees.emp_no

employees
--------
emp_no INT PK 
emp_title_id VARCHAR FK >- title.title_id
birth_date VARCHAR
first_name VARCHAR
last_name VARCHAR
sex VARCHAR
hire_date VARCHAR

salaries
--------
emp_no INT FK >- employees.emp_no
salary INT

title
-------
title_id VARCHAR PK
title VARCHAR