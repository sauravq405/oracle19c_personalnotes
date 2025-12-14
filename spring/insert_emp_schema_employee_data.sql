-- =====================================================================
-- File: insert_emp_schema_employee_data.sql
--
-- Purpose:
-- Insert initial seed data into EMP_SCHEMA.EMPLOYEE table
-- using EMPLOYEE_SEQ for primary key generation.
--
-- Assumptions:
-- - EMP_SCHEMA user already exists
-- - EMPLOYEE table exists
-- - EMPLOYEE_SEQ sequence exists
-- - Optional trigger may exist, but sequence is used explicitly here
-- =====================================================================


-- ---------------------------------------------------------------------
-- Insert employee records
-- ---------------------------------------------------------------------

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Alice', 'HR', 50000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Bob', 'IT', 70000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Charlie', 'Finance', 60000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Diana', 'HR', 55000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Evan', 'IT', 75000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Fiona', 'Finance', 65000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'George', 'HR', 52000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Helen', 'IT', 72000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Ian', 'Finance', 63000);

INSERT INTO emp_schema.employee (id, name, department, salary)
VALUES (emp_schema.employee_seq.NEXTVAL, 'Jane', 'HR', 54000);

COMMIT;

-- ---------------------------------------------------------------------
-- Verification queries (optional)
-- ---------------------------------------------------------------------

-- SELECT id, name, department, salary
-- FROM emp_schema.employee
-- ORDER BY id;

-- =====================================================================
-- END OF SCRIPT
-- =====================================================================
