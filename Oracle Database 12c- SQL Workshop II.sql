
--How to Use the Dictionary Views 

DESCRIBE DICTIONARY ;

SELECT *
FROM dictionary
WHERE table_name = 'USER_OBJECTS';

SELECT object_name, object_type, created, status 
FROM user_objects
ORDER BY object_type; 


-- Table Information 
DESCRIBE user_tables ;
SELECT table_name
FROM   user_tables;
DESCRIBE user_tab_columns ;

SELECT column_name, data_type, data_length, data_precision, data_scale, nullable
FROM   user_tab_columns
WHERE table_name = 'EMPLOYEES';


-- Constraint Information 

DESCRIBE user_constraints;

SELECT constraint_name, constraint_type, search_condition, r_constraint_name, delete_rule, status
FROM user_constraints
WHERE table_name = 'EMPLOYEES';

-- Querying USER_CONS_COLUMNS 

DESCRIBE user_cons_columns;

SELECT constraint_name, column_name FROM user_cons_columns
WHERE table_name = 'EMPLOYEES';


-- Adding Comments to a Table

COMMENT ON COLUMN employees.first_name IS 'First name of the employee';

– ALL_COL_COMMENTS 
– USER_COL_COMMENTS
– ALL_TAB_COMMENTS
– USER_TAB_COMMENTS


--Creating Sequences, Synonyms, and Indexes

CREATE SEQUENCE
dept_deptid_seq
START WITH 280
INCREMENT BY 10
MAXVALUE 9999
NOCACHE
NOCYCLE;



INSERT INTO departments(department_id, department_name, location_id)
VALUES (dept_deptid_seq.NEXTVAL, 'Support', 2500);


 SELECT dept_deptid_seq.CURRVAL FROM dual;

ALTER SEQUENCE dept_deptid_seq
INCREMENT BY 20
MAXVALUE 999999
NOCACHE
NOCYCLE;

DROP SEQUENCE dept_deptid_seq;


DESCRIBE user_sequences;

SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;



CREATE SYNONYM  d_sum
FOR  dept_sum_vu;


DROP SYNONYM d_sum;


CREATE PUBLIC SYNONYM dept  FOR    alice.departments;

DROP PUBLIC SYNONYM dept;

DESCRIBE user_synonyms;

SELECT *
FROM   user_synonyms;


-- Function-Based Indexes

CREATE INDEX upper_dept_name_idx
ON dept2(UPPER(department_name));


SELECT *
FROM   dept2
WHERE  UPPER(department_name) = 'SALES';


CREATE INDEX  upper_last_name_idx ON emp2 (UPPER(last_name));

-- Example of Creating Multiple Indexes on the Same Set of Columns

CREATE INDEX emp_id_name_ix1
ON employees(employee_id, first_name);

 
ALTER INDEX emp_id_name_ix1 INVISIBLE;

CREATE BITMAP INDEX emp_id_name_ix2
ON employees(employee_id, first_name);


 DESCRIBE user_ind_columns;

SELECT index_name, column_name,table_name FROM user_ind_columns
WHERE index_name = 'LNAME_IDX';

-- Removing an Index

 DROP INDEX index;

 DROP INDEX emp_last_name_idx;



CREATEVIEW empvu80
AS SELECT employee_id, last_name, salary
FROM    employees
WHERE   department_id = 80;


 DESCRIBE empvu80;


CREATEVIEW salvu50
AS SELECT employee_id ID_NUMBER, last_name NAME,
salary*12 ANN_SALARY
FROM    employees
WHERE   department_id = 50;


CREATE OR REPLACE VIEW salvu50 (ID_NUMBER, NAME, ANN_SALARY) AS SELECT employee_id, last_name, salary*12
          FROM    employees
          WHERE   department_id = 50;

--Modifying a View

CREATE OR REPLACE VIEW empvu80
(id_number, name, sal, department_id) AS SELECT employee_id, first_name || ' '
           || last_name, salary, department_id
   FROM    employees
   WHERE   department_id = 80;


-- Creating a Complex View

CREATE OR REPLACE VIEW dept_sum_vu
(name, minsal, maxsal, avgsal)
AS SELECT d.department_name, MIN(e.salary),
MAX(e.salary),AVG(e.salary) FROM employees e JOIN departments d USING (department_id)
GROUP BY d.department_name;

SELECT  *
          FROM    dept_sum_vu;

DESCRIBE user_views;

SELECT view_name FROM user_views;

SELECT text FROM user_views
WHERE view_name = 'EMP_DETAILS_VIEW';



UPDATE empvu20
SET department_id = 10 WHERE employee_id = 201;



CREATE OR REPLACE VIEW empvu10 (employee_number, employee_name, job_title)
AS SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id = 10 WITH READ ONLY ;



-- Removing a View

DROP VIEW view;

DROP VIEW empvu80;

-- Manag Schema Objects

DROP TABLE emp_new_sal PURGE; 


SELECT department_name, city
FROM departments
NATURAL JOIN (SELECT l.location_id, l.city, l.country_id
              FROM   locations l
JOIN countries c ON(l.country_id = c.country_id) JOIN regions
USING(region_id)
WHERE region_name = 'Europe');



SELECT employee_id, last_name, job_id, department_id 
FROM employees outer
WHERE EXISTS ( SELECT NULL
                 FROM   employees
                 WHERE  manager_id =outer.employee_id);



WITH CNT_DEPT AS
(
SELECT department_id,
COUNT(1) NUM_EMP
FROM EMPLOYEES
GROUP BY department_id )
SELECT employee_id,
SALARY/NUM_EMP
FROM EMPLOYEES E
JOIN CNT_DEPT C
ON (e.department_id = c.department_id);


-- Inserting by Using a Subquery as a Target

INSERT INTO (SELECT l.location_id, l.city, l.country_id FROM loc l
             JOIN   countries c
ON(l.country_id = c.country_id) JOIN regions USING(region_id) WHERE region_name = 'Europe')
VALUES (3300, 'Cardiff', 'UK');


INSERT INTO ( SELECT location_id, city, country_id FROM loc
WHERE  country_id IN
              (SELECT country_id
               FROM countries
               NATURAL JOIN regions
WHERE region_name = 'Europe')
WITH CHECK OPTION ) VALUES (3600, 'Washington', 'US');



ALTER TABLE empl6
ADD(department_name VARCHAR2(25));

UPDATE empl6 e
SET    department_name =
(SELECT department_name
FROM departments d
WHERE e.department_id = d.department_id);



UPDATE empl6
          SET    salary = (SELECT empl6.salary + rewards.pay_raise
                           FROM   rewards
                           WHERE  employee_id  =
                                  empl6.employee_id
                           AND  payraise_date =
(SELECT MAX(payraise_date)
FROM rewards
WHERE employee_id=empl6.employee_id))
          WHERE  empl6.employee_id
          IN     (SELECT employee_id FROM rewards);


DELETE FROM job_history JH
          WHERE employee_id =
(SELECT employee_id
FROM employees E
WHERE JH.employee_id = E.employee_id AND START_DATE =
                       (SELECT MIN(start_date)
                        FROM job_history JH
                        WHERE JH.employee_id = E.employee_id)
                        AND 5 >  (SELECT COUNT(*)
                                  FROM job_history JH
                                  WHERE JH.employee_id = E.employee_id
                                  GROUP BY EMPLOYEE_ID
                                  HAVING COUNT(*) >= 4));



DELETE FROM empl6 E WHERE employee_id =
(SELECT employee_id
FROM emp_history
WHERE employee_id = E.employee_id);




