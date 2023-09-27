
/*
view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� �����Դϴ�.
��� �⺻ ���̺��� ������ ���� ���̺��̱� ������
�ʿ��� �÷��� ������ �θ� ������ ������ ���ϴ�.
��� �������̺��� ���� �����Ͱ� ���������� ����� ���´� �ƴմϴ�.
�並 ���ؼ� �����Ϳ� �����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ֽ��ϴ�.
*/
SELECT * FROM user_sys_privs; -- ���� Ȯ��

-- �ܼ� ��: �ϳ���(����) ���̺��� �̿��Ͽ� ������ ��
-- ���� �÷� �̸��� �Լ� ȣ�⹮, ����� �� ���� ���� ǥ�����̸� �ȵ˴ϴ�.
SELECT
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;

CREATE VIEW view_emp AS (
    SELECT
        employee_id,
        first_name || ' ' || last_name AS full_name,
        job_id,
        salary
    FROM employees
    WHERE department_id = 60
);

SELECT * FROM view_emp
WHERE salary >= 6000;

-- ���� ��
-- ���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���.
CREATE VIEW view_emp_dept_jobs AS(
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name AS full_name,
        d.department_name,
        j.job_title
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

-- ���� ���� (CREATE REPLACE VIEW)
-- ���� �̸����� �ش� ������ ����ϸ� �����Ͱ� ����Ǹ鼭 ���Ӱ� �����˴ϴ�.
CREATE OR REPLACE VIEW view_emp_dept_jobs AS(
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name AS full_name,
        d.department_name,
        j.job_title,
        e.salary -- �߰�
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;
    
SELECT 
    job_title,
    AVG(salary) AS avg
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC; -- SQL������ ª����

-- �� ����
DROP VIEW view_emp;

/*
VIEW�� INSET�� �Ͼ�� ��� ���� ���̺����� �ݿ��� �˴ϴ�.
�׷��� VIEW�� INSET, UPDATE, DELETE�� ���� ���� ������ �����ϴ�.
���� ���̺��� NOT NULL�� ��쿡�� VIEW�� INSERT�� �Ұ����մϴ�.
VIEW���� ����ϴ� �÷��� ������ ��쿡�� �ȵ˴ϴ�.
*/

-- �� ��° �÷��� 'full_name'�� ����(virtual column) �̱� ������ INSET �ȵ˴ϴ�.
INSERT INTO view_emp_dept_jobs
VALUES (300, 'test', 'test', 'test', 10000); -- �ȵ�


-- JOIN�� ���� ��� �� ���� ������ �� �����ϴ�.
INSERT INTO view_emp_dept_jobs
(employee_id, department_id, job_title, salary)
VALUES (300, 'test', 'test', 10000); -- �ȵ�


-- ���� ���̺��� NULL�� ������� �ʴ� �÷� ������ �� �� �����ϴ�.
INSERT INTO view_emp
(employee_id, job_id, salary)
VALUES (300, 'test', 10000); -- �ȵ�

DELETE FROM view_emp
WHERE employee_id = 107;

-- ����, ����, ���� ���� �� ���� ���̺��� �ݿ��˴ϴ�.
SELECT * FROM view_emp;
SELECT * FROM employees;
ROLLBACK;

-- WITH CHECK OPTION -> ���� ���� �÷�
-- �並 ������ �� ����� ���� �÷��� �並 ���ؼ� ������ �� ���� ���ִ� Ű����

CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

UPDATE view_emp_test
SET department_id = 100
WHERE employee_id = 107;

SELECT * FROM view_emp_test;

UPDATE view_emp_test
SET job_id = 'AD_VP'
WHERE employee_id = 107;

-- �б� ���� �� -> WITH READ ONRY (DML ������ ���� -> SELECT�� ���)
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;




