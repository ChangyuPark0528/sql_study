
/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/

SELECT
    first_name, salary
FROM employees
WHERE salary > ANY(
                SELECT
                    AVG(salary)
                FROM employees
                )
ORDER BY salary DESC;
----------------------------------
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees
                WHERE job_id = 'IT_PROG');

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� �������
��� ������ ����ϼ���.
*/

SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100);

/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/

SELECT * FROM employees
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
                     WHERE first_name = 'James');

/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT * FROM
(
SELECT ROWNUM AS rn, tbl.first_name
    FROM(
        SELECT * FROM employees
        ORDER BY first_name DESC
        ) tbl
)
WHERE rn BETWEEN 41 AND 50;
/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȭ��ȣ, �Ի����� ����ϼ���.
*/

SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.*
        FROM
        (
            SELECT 
                employee_id, first_name, phone_number, hire_date
            FROM employees
            ORDER BY hire_date aSC
        ) tbl
    )
WHERE rn BETWEEN 31 AND 40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/

SELECT
    e.employee_id, e.first_name||' '||e.last_name AS full_name,
    e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id ASC;


/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT
    e.employee_id, e.first_name||' '||e.last_name AS full_name,
    e.department_id,
    (
    SELECT
        department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY employee_id ASC;

/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/

SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id ASC;



/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (
        SELECT
            loc.street_address
        FROM locations loc
        WHERE d.location_id = loc.location_id
    ) AS street_address,
    (
        SELECT
            loc.postal_code
        FROM locations loc
        WHERE d.location_id = loc.location_id
    ) AS postal_code,
    (
        SELECT
            loc.city
        FROM locations loc
        WHERE d.location_id = loc.location_id
    ) AS city
FROM departments d
ORDER BY d.department_id ASC;

/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/

SELECT
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name ASC;

/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT
    loc.location_id, loc.street_address, loc.city,
    (
        SELECT
            c.country_id
        FROM countries c
        WHERE c.country_id = loc.country_id
    ) AS country_id,
    (
        SELECT
            c.country_name
        FROM countries c
        WHERE c.country_id = loc.country_id
    ) AS country_name
FROM locations loc 
ORDER BY country_name ASC;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
1-10��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/

SELECT ROWNUM, TBL.* FROM 
(SELECT A.EMPLOYEE_ID, A.FIRST_NAME, A.PHONE_NUMBER, A.HIRE_DATE, A.DEPARTMENT_ID, B.DEPARTMENT_NAME 
FROM EMPLOYEES A LEFT JOIN DEPARTMENTS B 
ON A.DEPARTMENT_ID=B.DEPARTMENT_ID
ORDER BY A.HIRE_DATE) TBL WHERE ROWNUM < 11;


SELECT ROWNUM , A.* FROM 
(SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE) A WHERE ROWNUM <11;



SELECT ROWNUM, tbl.* FROM 
(SELECT e.employee_id, e.first_name, e.phone_number,
        e.hire_date, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.hire_date ASC) tbl
WHERE ROWNUM >= 1 AND ROWNUM < 11;



/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
1-10��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/

SELECT ROWNUM AS rn, tbl.* FROM
(SELECT
    e.employee_id, e.first_name||' '||e.last_name AS full_name,
    e.phone_number, e.hire_date, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.hire_date ASC)tbl
WHERE ROWNUM < 11;


/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/

SELECT
    e.last_name, e.job_id,
    e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE e.job_id = 'SA_MAN';


--SELECT
--    e.last_name, e.job_id,
--    e.department_id, 
--    (select department_name 
--    from departments d
--    JOIN employees e
--    ON d.department_id = e.department_id)
--FROM employees e
--WHERE e.job_id = 'SA_MAN';

SELECT
    e.last_name, e.job_id,
    e.department_id, 
    (select d.department_name 
    from departments d where e.department_id = d.department_id)
FROM employees e
WHERE e.job_id = 'SA_MAN';


/*
���� 14
--DEPARTMENT���̺��� �� �μ��� DEPARTMENT_ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/

SELECT
    d.department_id, d.department_name , d.manager_id,
    (
    SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) AS �����
FROM departments d
WHERE d.manager_id IS NOT NULL
ORDER BY ����� DESC;

SELECT * FROM (
SELECT
    d.department_id, d.department_name , d.manager_id,
    (
    SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) AS �����
FROM departments d) 
WHERE ����� IS NOT NULL
ORDER BY ����� DESC;


--��Ʈ: GROUP BY

/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/

select d.department_id, d.department_name, d.manager_id, d.location_id, 
round(nvl((select avg(e.salary) from employees e where e.department_id=d.department_id group by e.department_id),0),2) as avg_sal
,l.street_address, l.postal_code
from departments d left join locations l on d.location_id=l.location_id;

select * from LOCATIONS;


(select e.department_id, avg(e.salary) from employees e group by e.department_id);


desc departments;



SELECT * FROM departments d;

SELECT 
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.postal_code, loc.street_address,
    TRUNC(NVL((SELECT
    AVG(e.salary)
    FROM employees e
    WHERE e.department_id = d.department_id
    GROUP BY e.department_id
    ),0),2) AS sal_avg
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id;

/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/

SELECT ROWNUM,tbl.* FROM
(
SELECT 
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.postal_code, loc.street_address,
    TRUNC(NVL((SELECT
    AVG(e.salary)
    FROM employees e
    WHERE e.department_id = d.department_id
    GROUP BY e.department_id
    ),0),2) AS sal_avg
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id DESC
) tbl
WHERE ROWNUM <= 10;








