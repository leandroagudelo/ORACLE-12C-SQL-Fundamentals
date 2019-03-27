/*
--Clase 1
-- Scrips para la creacion de un usuario en Oracle 12C Pluggable
-- Para poder ejecutar estos scrips se debe ingresar a la base de datos con un usuario SYS o SYSTEM
https://livesql.oracle.com/apex/f?p=590:1000

Practices for Lesson 1: Introduction
In this practice, you start SQL Developer, create a new database connection, and browse your HR tables. 
You also set some SQL Developer preferences.
*/

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
/*
Practices for Lesson 2: Retrieving Data Using the SQL SELECT Statement

This practice covers the following topics:
• Selecting all data from different tables
• Describing the structure of tables
• Performing arithmetic calculations and specifying column names
*/

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


/*
Practices for Lesson 3: Restricting and Sorting Data
This practice covers the following topics:
• Writing a query that displays the current date
• Creating queries that require the use of numeric, character, and date functions
• Performing calculations of years and months of service for an employee

*/				
						
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
Practices for Lesson 4: 
Using Single-Row Functions to Customize Output
This practice covers the following topics:
• Writing a query that displays the current date
• Creating queries that require the use of numeric, character, and date functions
• Performing calculations of years and months of service for an employee
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
Practices for Lesson 5: 
Using Conversion Functions and Conditional Expressions

This practice covers the following topics:
• Creating queries that use the TO_CHAR and TO_DATE functions.
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
Practice Overview
This practice covers the following topics:
• Writing queries that use group functions
• Grouping by rows to achieve multiple results
• Restricting groups by using the HAVING clause


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

This practice covers the following topics:
• Joining tables using an equijoin
• Performing outer and self-joins
• Adding conditions

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
Using Subqueries to Solve Queries

This practice covers the following topics:
• Creating subqueries to query values based on unknown criteria
• Using subqueries to find values that exist in one set of data and not in another
*/

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


SELECT last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   departments
                         WHERE  location_id = 1700);


SELECT last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
							FROM   departments
							WHERE  location_id =
							&Enter_location);


SELECT last_name, salary
FROM   employees
WHERE  manager_id = (SELECT employee_id
                     FROM   employees
                     WHERE  last_name = 'King');
					

Select department_id, last_name, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
						FROM   departments
						WHERE  department_name =
						'Executive');

SELECT last_name FROM employees
WHERE salary > ANY (SELECT salary
                      FROM employees
                      WHERE department_id=60);


SELECT employee_id, last_name, salary
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
					     WHERE last_name like '%u%') 
AND salary > (SELECT AVG(salary) FROM   employees);
										
			
		
/*
Practices for Lesson 9: Using the Set Operators
In this practice, you create reports by using the following:
• UNION operator
• INTERSECT operator
• MINUS operator
*/		

SELECT department_id
FROM   departments
MINUS
SELECT department_id
FROM   employees
WHERE  job_id = 'ST_CLERK';


SELECT country_id,country_name
FROM countries
MINUS
SELECT l.country_id,c.country_name
FROM locations l 
     JOIN countries c ON (l.country_id = c.country_id)
     JOIN departments d ON d.location_id=l.location_id;	
			

SELECT employee_id, job_id, department_id
FROM EMPLOYEES
WHERE department_id=50
UNION ALL
SELECT employee_id, job_id, department_id
FROM EMPLOYEES
WHERE department_id=80;
				

SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE JOB_ID='SA_REP'
INTERSECT
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID=80;

SELECT last_name,department_id,TO_CHAR(null) dept_name 
FROM employees
UNION
SELECT TO_CHAR(null),department_id,department_name 
FROM departments;
			

/*
Practices for Lesson 10: Manipulating Data
Lesson Overview
This practice covers the following topics:
• Inserting rows into tables
• Updating and deleting rows in a table
• Controlling transactions
Create a table called MY_EMPLOYEE.
*/	


CREATE TABLE MY_EMPLOYEE 
(
  ID NUMBER GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 START WITH 1 NOT NULL 
, LAST_NAME VARCHAR2(2000) NOT NULL 
, FIRST_NAME VARCHAR2(2000) NOT NULL 
, USERID VARCHAR2(20) NOT NULL 
, SALARY NUMBER DEFAULT 0 NOT NULL 
, CONSTRAINT MY_EMPLOYEE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE MY_EMPLOYEE
ADD CONSTRAINT MY_EMPLOYEE_UK1 UNIQUE 
(
  USERID 
)
ENABLE;

COMMENT ON TABLE MY_EMPLOYEE IS 'TABLA DE EJEMPLO PARA LOS EJERCICIOS DE CREACION DE TABLAS Y MANIPULACION DE DATOS';

COMMENT ON COLUMN MY_EMPLOYEE.ID IS 'PK '' LLAVE PRIMARIA';

COMMENT ON COLUMN MY_EMPLOYEE.LAST_NAME IS 'APELLIDO';

COMMENT ON COLUMN MY_EMPLOYEE.FIRST_NAME IS 'NOMBRE';

COMMENT ON COLUMN MY_EMPLOYEE.USERID IS 'NOMBRE DE USUARIO';

COMMENT ON COLUMN MY_EMPLOYEE.SALARY IS 'SALARIO';



DESCRIBE my_employee;

-- CUANDO EL ID ES CREADO CON BY DEFAULT
INSERT INTO my_employee
  VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);


INSERT INTO my_employee 
         (last_name, first_name, userid, salary)
  VALUES ('Agudelo', 'carlos', 'carlos', 900);


INSERT INTO my_employee 
         (id, last_name, first_name,userid, salary)
  VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);


SELECT   *
FROM     my_employee;


INSERT INTO my_employee
       (last_name, first_name, userid, salary)
VALUES ( '&p_last_name', '&p_first_name', '&p_userid', &p_salary);
 

COMMIT;


UPDATE  my_employee
SET     last_name = 'Drexler'
WHERE   id = 3;

UPDATE  my_employee
SET     first_name = INITCAP (first_name)
WHERE   id = 3;


UPDATE  my_employee
SET     salary = 1000
WHERE   salary < 900;


DELETE
FROM  my_employee
WHERE last_name = 'Dancs';

COMMIT;



/*
Practices for Lesson 11: 
Using DDL Statements to Create and Manage Tables
Lesson Overview
This practice covers the following topics:
• Creating new tables
• Creating a new table by using the CREATE TABLE AS syntax
• Verifying that tables exist
• Altering tables
• Adding columns
• Dropping columns
• Setting a table to read-only status
• Dropping tables
*/
		

--Crear Tabla AUTHOR	
CREATE TABLE AUTHOR
    (
      Author_ID VARCHAR2 (10)  NOT NULL ,
      Author_Name VARCHAR2 (20)
    )
;
COMMENT ON TABLE AUTHOR IS 'Author'
;
ALTER TABLE AUTHOR
ADD CONSTRAINT AUTHOR_PK PRIMARY KEY (Author_ID);

--Crear Tabla BOOKS
CREATE TABLE BOOKS
    (
     Book_ID VARCHAR2 (10)  NOT NULL ,
     Book_Name VARCHAR2 (50) ,
     Author_ID VARCHAR2 (10)  NOT NULL ,
     Price NUMBER (10) ,
     Publisher_ID VARCHAR2 (10)  NOT NULL
    )
;
COMMENT ON TABLE BOOKS IS 'Books'
;
ALTER TABLE BOOKS
    ADD CONSTRAINT books_PK PRIMARY KEY ( Book_ID );		
	
--Crear Tabla CUSTOMER
CREATE TABLE CUSTOMER
    (
      Customer_ID VARCHAR2 (6)  NOT NULL ,
      Customer_Name VARCHAR2 (40) ,
      Street_Address VARCHAR2 (50) ,
      City VARCHAR2 (25) ,
      Phone_Number VARCHAR2 (15) ,
      Credit_Card_Number VARCHAR2 (20)  NOT NULL
    )
;
COMMENT ON TABLE CUSTOMER IS 'Customer'
;
ALTER TABLE CUSTOMER
ADD CONSTRAINT Customer_PK PRIMARY KEY ( Customer_ID ) ;

--Crear Tabla CREDIT_CARD_DETAILS
CREATE TABLE CREDIT_CARD_DETAILS
    (
     Credit_Card_Number VARCHAR2 (20)  NOT NULL ,
     Credit_Card_Type VARCHAR2 (10) ,
     Expiry_Date DATE
) ;
COMMENT ON TABLE CREDIT_CARD_DETAILS IS 'Credit Card Details' ;
ALTER TABLE CREDIT_CARD_DETAILS
ADD CONSTRAINT Credit_Card_Details_PK PRIMARY KEY ( Credit_Card_Number) ;				
				

--Crear Tabla ORDER_DETAILS
CREATE TABLE ORDER_DETAILS
   (
Order_ID VARCHAR2 (6) NOT NULL , Customer_ID VARCHAR2 (6) NOT NULL ,
    Shipping_Type VARCHAR2 (10)  NOT NULL ,
 Date_of_Purchase DATE ,
    Shopping_Cart_ID varchar2(6)  NOT NULL
) ;
COMMENT ON TABLE ORDER_DETAILS IS 'Order Details' ;
ALTER TABLE ORDER_DETAILS
   ADD CONSTRAINT ORDER_DETAILS_PK PRIMARY KEY (Order_ID ) ;

--Crear Tabla PUBLISHER
CREATE TABLE PUBLISHER
    (
      Publisher_ID VARCHAR2 (10)  NOT NULL ,
      Publisher_Name VARCHAR2 (50)
    )
;
COMMENT ON TABLE PUBLISHER IS 'Publisher'
;
ALTER TABLE PUBLISHER
ADD CONSTRAINT PUBLISHER_PK PRIMARY KEY ( Publisher_ID) ;		
		

CREATE TABLE PURCHASE_HISTORY
(
 Customer_ID VARCHAR2 (6)  NOT NULL ,
 Order_ID VARCHAR2 (6)  NOT NULL
)
;
COMMENT ON TABLE PURCHASE_HISTORY IS 'Purchase History' ;				
				

CREATE TABLE SHIPPING_TYPE
    (
     Shipping_Type VARCHAR2 (10)  NOT NULL ,
     Shipping_Price NUMBER (6)
    )
;
COMMENT ON TABLE SHIPPING_TYPE IS 'Shipping Type'
;
ALTER TABLE SHIPPING_TYPE
ADD CONSTRAINT SHIPPING_TYPE_PK PRIMARY KEY ( Shipping_Type );


CREATE TABLE SHOPPING_CART
    (
     Shopping_Cart_ID VARCHAR2 (6)  NOT NULL ,
     Book_ID VARCHAR2 (10)  NOT NULL ,
     Price NUMBER (10) ,
     Shopping_cart_Date DATE ,
     Quantity NUMBER (6)
    )
;
COMMENT ON TABLE SHOPPING_CART IS 'Shopping Cart'
;
ALTER TABLE SHOPPING_CART
ADD CONSTRAINT SHOPPING_CART_PK PRIMARY KEY (SHOPPING_CART_ID) ;


/*
Adding Additional Referential Integrity Constraints
*/


ALTER TABLE BOOKS
    ADD CONSTRAINT BOOKS_AUTHOR_FK FOREIGN KEY (Author_ID ) REFERENCES AUTHOR (Author_ID );


 ALTER TABLE BOOKS
    ADD CONSTRAINT BOOKS_PUBLISHER_FK FOREIGN KEY (Publisher_ID) REFERENCES PUBLISHER (Publisher_ID);


ALTER TABLE ORDER_DETAILS 
    ADD CONSTRAINT Order_ID_FK FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER (Customer_ID);


ALTER TABLE ORDER_DETAILS  
    ADD CONSTRAINT Order_Details_fk FOREIGN KEY (Shopping_Cart_ID) REFERENCES SHOPPING_CART (Shopping_Cart_ID) ;


ALTER TABLE PURCHASE_HISTORY
    ADD CONSTRAINT Pur_Hist_ORDER_DETAILS_FK FOREIGN KEY (Order_ID) REFERENCES ORDER_DETAILS (Order_ID) ;
				


ALTER TABLE PURCHASE_ HISTORY
    ADD CONSTRAINT Purchase_History_CUSTOMER_FK FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER (Customer_ID );


ALTER TABLE SHOPPING_CART
    ADD CONSTRAINT SHOPPING_CART_BOOKS_FK FOREIGN KEY (Book_ID ) REFERENCES BOOKS (Book_ID ) ;		
		


CREATE SEQUENCE order_id_seq
START WITH 100
NOCACHE;



SELECT * FROM user_sequences;

/*
CREAR VISTAS
*/

CREATE VIEW customer_details AS
SELECT c.customer_name, c.street_address, o.order_id, o.customer_id, o.shipping_type, o.date_of_purchase, o.shopping_cart_id
   FROM     customer c 
   JOIN order_details o ON c.customer_id = o.customer_id;


SELECT   *
FROM     customer_details
ORDER BY customer_id;


