--Clase 1
-- Scrips para la creacion de un usuario en Oracle 12C Pluggable
-- Para poder ejecutar estos scrips se debe ingresar a la base de datos con un usuario SYS o SYSTEM
https://livesql.oracle.com/apex/f?p=590:1000


alter session set "_ORACLE_SCRIPT"=true;
CREATE USER LEO IDENTIFIED BY "oracle";
alter user leo identified by "oracle2" account unlock;
ALTER USER leo DEFAULT TABLESPACE users
              QUOTA UNLIMITED ON users;
ALTER USER leo TEMPORARY TABLESPACE temp;
GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO leo;
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE TO leo;
GRANT execute ON sys.dbms_stats TO leo;



--Clase 2
Retrieving Data Using the SQL SELECT Statement 
						
SELECT last_name, job_id, salary AS Sal 
FROM employees; 

						
SELECT    employee_id, last_name
sal x 12  ANNUAL SALARY
FROM      employees;

						
DESCRIBE departments;
						
SELECT *
FROM   departments;
						
SELECT last_name||', '||job_id "Employee and Title"
FROM   employees;

						
SELECT employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' || phone_number || ','|| job_id|| ',' || manager_id || ',' || hire_date || ','  || salary || ',' || commission_pct || ',' ||
Department_id  THE_OUTPUT
FROM   employees;
				
						
SELECT  last_name, salary
FROM    employees
WHERE   salary > 12000;

					
SELECT  last_name, department_id
FROM    employees
WHERE   employee_id = 176;

						
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 and 12000;
					
					
						
SELECT   last_name, job_id, hire_date
FROM     employees
WHERE    last_name IN ('Matos', 'Taylor')
ORDER BY hire_date;
				
						
SELECT   last_name, department_id
FROM     employees
WHERE    department_id IN (20, 50)
ORDER BY last_name ASC;

						
SELECT last_name "Employee", salary "Monthly Salary" FROM employees
WHERE salary BETWEEN 5000 AND 12000
AND department_id IN (20, 50); 
					


Clase 3				
						
Restricting and Sorting Data 				
					
						
SELECT last_name, hire_date
FROM employees
WHERE hire_date >= '01-01-06' AND hire_date < '01-01-07'; 
										
						
SELECT   last_name, job_id
FROM     employees
WHERE    manager_id IS NULL;

						
SELECT last_name, salary, commission_pct FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY 2 DESC, 3 DESC; 
					
						
SELECT employee_id, last_name, salary, department_id FROM employees
WHERE manager_id = &mgr_num
ORDER BY &order_col; 
						 	 	 		
						
SELECT   last_name
FROM     employees						
WHERE    last_name LIKE '__a%';
					
						
SELECT   last_name
FROM     employees
WHERE    last_name LIKE 	'%a%';
AND      last_name '%e%';
						
Select  last_name, job_id, salary
FROM     employees
WHERE    job_id IN ('SA_REP', 'ST_CLERK')						
AND salary NOT IN (2500, 3500, 7000); 
									
						
SELECT   last_name "Employee", salary "Monthly Salary",
  commission_pct
FROM     employees
WHERE    commission_pct = .20;

										
/*						
Using Single-Row Functions to Customize Output 
*/				
						
SELECT  sysdate "Date"
FROM    dual;

						
SELECT  employee_id, last_name, salary,
        ROUND(salary * 1.155, 0) "New Salary"
FROM    employees;
				
						
SELECT  employee_id, last_name, salary,
        ROUND(salary * 1.155, 0) "New Salary",
        ROUND(salary * 1.155, 0) - salary "Increase"						
FROM    employees;

						
SELECT  INITCAP(last_name) "Name",
        LENGTH(last_name) "Length"						
FROM    employees
WHERE   last_name LIKE 'J%'
OR      last_name LIKE 'M%'
OR      last_name LIKE 'A%'						
ORDER BY last_name;
					
						
SELECT  INITCAP(last_name) "Name",
        LENGTH(last_name) "Length"
FROM    employees
WHERE   last_name LIKE '&start_letter%'
ORDER BY last_name;

						
SELECT  INITCAP(last_name) "Name",
LENGTH(last_name) "Length"
FROM    employees
WHERE   last_name LIKE UPPER('&start_letter%' )
ORDER BY last_name;
				
						
SELECT last_name, ROUND(MONTHS_BETWEEN(
       SYSDATE, hire_date)) MONTHS_WORKED
FROM   employees
ORDER BY months_worked;

		 	 	 		
SELECT last_name,
 LPAD(salary, 15, '$') SALARY
FROM   employees;

											
SELECT last_name,
 rpad(' ', salary/1000, '*')
               EMPLOYEES_AND_THEIR_SALARIES
FROM  employees
ORDER BY salary DESC;
				
						
SELECT last_name, trunc((SYSDATE-hire_date)/7) AS TENURE 
FROM employees
WHERE department_id = 90
ORDER BY TENURE DESC; 
					
				
SELECT  employee_id, last_name, salary,
        ROUND(salary * 1.155, 0) "New Salary",
        ROUND(nvl (salary,0) * 1.155, 0) - nvl (salary,1) "Increase"						
FROM    employees;

		
/*
Creating queries that use the TO_CHAR and TO_DATE functions.
• Creating queries that use conditional expressions such as CASE , SEARCHED CASE, and DECODE
*/			
			
SELECT  last_name || ' earns '
        || TO_CHAR(salary, 'fm$99,999.00')
        || ' monthly but wants '
        || TO_CHAR(salary * 3, 'fm$99,999.00')
        || '.' "Dream Salaries"
FROM    employees;	
			

--VER FORMATOS DE NUMEROS Y FECHAS 
https://docs.oracle.com/cd/B14117_01/server.101/b10759/sql_elements004.htm

SELECT last_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),'MONDAY'), 'fmDay, "the" Ddspth "of" Month, YYYY') REVIEW
FROM    employees;

/*
VER URL PARA MAS INFORMACION SOBRE FUNCION DECODE
https://www.techonthenet.com/oracle/functions/decode.php
https://www.techonthenet.com/oracle/index.php
*/

SELECT last_name,
NVL(TO_CHAR(commission_pct), 'No Commission') COMM
FROM   employees;

SELECT job_id, CASE job_id
               WHEN 'ST_CLERK' THEN 'E'
               WHEN 'SA_REP'   THEN 'D'
               WHEN 'IT_PROG'  THEN 'C'
               WHEN 'ST_MAN'   THEN 'B'
               WHEN 'AD_PRES'  THEN 'A'
               ELSE '0'  END  GRADE
FROM employees;


SELECT job_id, CASE
               WHEN job_id = 'ST_CLERK' THEN 'E'
               WHEN job_id = 'SA_REP'   THEN 'D'
               WHEN job_id = 'IT_PROG'  THEN 'C'
               WHEN job_id = 'ST_MAN'   THEN 'B'
               WHEN job_id = 'AD_PRES'  THEN 'A'
               ELSE '0'  END  GRADE
FROM employees;
				

SELECT job_id, decode (job_id,
                   'ST_CLERK',  'E',
'SA_REP',    'D',
'IT_PROG',   'C',
'ST_MAN',    'B',
'AD_PRES',   'A',
'0')GRADE
FROM employees;


/*Practices for Lesson 6: 
Reporting Aggregated Data Using the Group Functions
*/	
					
SELECT ROUND(MAX(salary),0) "Maximum",
       ROUND(MIN(salary),0) "Minimum",
       ROUND(SUM(salary),0) "Sum",
       ROUND(AVG(salary),0) "Average"
FROM   employees;


SELECT job_id, ROUND(MAX(salary),0) "Maximum",
               ROUND(MIN(salary),0) "Minimum",
               ROUND(SUM(salary),0) "Sum",
               ROUND(AVG(salary),0) "Average"
FROM   employees
GROUP BY job_id;

SELECT job_id, COUNT(*)
FROM   employees
GROUP BY job_id;

SELECT job_id, COUNT(*)
FROM   employees
WHERE  job_id = '&job_title'
GROUP BY job_id;

SELECT COUNT(DISTINCT manager_id) "Number of Managers"
FROM   employees;

SELECT   MAX(salary) - MIN(salary) DIFFERENCE
FROM     employees;


SELECT manager_id, MIN(salary) FROM employees
WHERE manager_id IS NOT NULL GROUP BY manager_id
HAVING   MIN(salary) > 6000
ORDER BY MIN(salary) DESC;


SELECT COUNT(*) total,
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2005,1,0))"2005", 
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2006,1,0))"2006", 
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2007,1,0))"2007", 
SUM(DECODE(TO_CHAR(hire_date, 'YYYY'),2008,1,0))"2008"
FROM    employees;


SELECT
job_id "Job",
SUM(DECODE(department_id , 20, salary)) "Dept 20", 
SUM(DECODE(department_id , 50, salary)) "Dept 50", 
SUM(DECODE(department_id , 80, salary)) "Dept 80",
SUM(DECODE(department_id , 90, salary)) "Dept 90",
SUM(salary) "Total"
FROM     employees
GROUP BY job_id;
		
			
/*Practices for Lesson 7: 
Displaying Data from Multiple Tables Using Joins
https://ingenieriadesoftware.es/tipos-sql-join-guia-referencia/
http://www.tutorialesprogramacionya.com/oracleya/temarios/descripcion.php?cod=214&punto=1&inicio=
*/		
				
			
SELECT location_id, street_address, city, state_province, country_name
FROM   locations
NATURAL JOIN  countries;

SELECT last_name, department_id, department_name
FROM   employees
JOIN   departments
USING (department_id);



SELECT e.last_name, e.job_id, e.department_id, d.department_name 
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
USING  (location_id)
WHERE LOWER(l.city) = 'toronto';


SELECT  w.last_name "Employee", w.employee_id "EMP#", m.last_name "Manager", m.employee_id "Mgr#"
FROM   employees w JOIN employees m
ON     (w.manager_id = m.employee_id);


SELECT w.last_name "Employee", w.employee_id "EMP#", m.last_name "Manager", m.employee_id "Mgr#"
FROM   employees w
LEFT   OUTER JOIN employees m
ON     (w.manager_id = m.employee_id)
ORDER BY 2;

SELECT e.department_id department, e.last_name employee, c.last_name colleague
FROM employees e JOIN employees c
ON (e.department_id = c.department_id)
WHERE e.employee_id <> c.employee_id
ORDER BY e.department_id, e.last_name, c.last_name;

SELECT e.last_name, e.job_id, d.department_name,
       e.salary, j.grade_level
FROM   employees e JOIN departments d
ON     (e.department_id = d.department_id)
JOIN   job_grades j
ON    (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

SELECT w.last_name, w.hire_date, m.last_name, m.hire_date
FROM 
 employees w JOIN employees m
ON (w.manager_id = m.employee_id)
WHERE   w.hire_date <  m.hire_date;


/*Practices for Lesson 8: 
Using Subqueries to Solve Queries*/
SELECT last_name, hire_date
FROM employees
WHERE department_id = (SELECT department_id
                        FROM   employees
                        WHERE  last_name = '&&Enter_name')
AND    last_name <> '&Enter_name';



SELECT employee_id, last_name, salary FROM employees
WHERE salary > (SELECT AVG(salary)
				FROM   employees)
ORDER BY salary;				
				

SELECT employee_id, last_name
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  last_name like '%u%');


		
					
				
			
		
					
				
			
		
				
			
		
			
		
	

					
				
			
		

					
				
			
		
	
		
	
				
			
		


