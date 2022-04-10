--- QUERIES
SELECT * FROM department;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;
SELECT * FROM salaries;
SELECT * FROM title;
----1. list details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON
e.emp_no = s.emp_no;

SELECT * FROM employees;

----2.List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;


---3.List manager of each department with info: department number, department name, the manager's employee number, last name, first name.

-- SELECT dt.dept_no, dt.dept_name, dm.emp_no, e.first_name, e.last_name 
-- FROM department as dt
-- JOIN dept_manager as dm ON dt.dept_no = dm.dept_no
-- JOIN employees as e ON dm.emp_no = e.emp_no; 

SELECT dm.dept_no, dt.dept_name, dm.emp_no, e.first_name, e.last_name 
FROM dept_manager as dm
JOIN department as dt ON dm.dept_no = dt.dept_no
JOIN employees as e ON dm.emp_no = e.emp_no; 

SELECT * FROM department;
SELECT * FROM dept_manager;
SELECT * FROM employees;

---4.List the department of each employee with info: employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, dt.dept_name
FROM employees as e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN department AS dt ON de.dept_no = dt.dept_no;


SELECT * FROM department;
SELECT * FROM employees;
SELECT * FROM dept_emp;
---5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name= 'Hercules'
AND last_name LIKE 'B%';

---6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
-- Sales department = d007
SELECT e.emp_no, e.last_name, e.first_name, dmt.dept_name
FROM employees as e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN department AS dmt ON de.dept_no = dmt.dept_no
WHERE dmt.dept_name='Sales';

---7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dmt.dept_name
FROM employees as e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN department AS dmt ON de.dept_no = dmt.dept_no
WHERE dmt.dept_name='Sales'
OR dmt.dept_name='Development';

---8.List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

