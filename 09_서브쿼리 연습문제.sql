
/*
문제 1.
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 데이터를 출력 하세요 
(AVG(컬럼) 사용)
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 수를 출력하세요
-EMPLOYEES 테이블에서 job_id가 IT_PROG인 사원들의 평균급여보다 높은 사원들의 
데이터를 출력하세요
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
문제 2.
-DEPARTMENTS테이블에서 manager_id가 100인 부서에 속해있는 사람들의
모든 정보를 출력하세요.
*/

SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100);

/*
문제 3.
-EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 
출력하세요
-EMPLOYEES테이블에서 “James”(2명)들의 manager_id를 갖는 모든 사원의 데이터를 출력하세요.
*/

SELECT * FROM employees
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
                     WHERE first_name = 'James');

/*
문제 4.
-EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 
행 번호, 이름을 출력하세요
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
문제 5.
-EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 
행 번호, 사원id, 이름, 전화번호, 입사일을 출력하세요.
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
문제 6.
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬
*/

SELECT
    e.employee_id, e.first_name||' '||e.last_name AS full_name,
    e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id ASC;


/*
문제 7.
문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
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
문제 8.
departments테이블 locations테이블을 left 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬
*/

SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id ASC;



/*
문제 9.
문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
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
문제 10.
locations테이블 countries 테이블을 left 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬
*/

SELECT
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name ASC;

/*
문제 11.
문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
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
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 
1-10번째 데이터만 출력합니다.
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 
부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
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
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 
1-10번째 데이터만 출력합니다.
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 
부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
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
문제 13. 
--EMPLOYEES 와 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요.
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
문제 14
--DEPARTMENT테이블에서 각 부서의 DEPARTMENT_ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
--인원수 기준 내림차순 정렬하세요.
--사람이 없는 부서는 출력하지 뽑지 않습니다.
*/

SELECT
    d.department_id, d.department_name , d.manager_id,
    (
    SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) AS 사원수
FROM departments d
WHERE d.manager_id IS NOT NULL
ORDER BY 사원수 DESC;

SELECT * FROM (
SELECT
    d.department_id, d.department_name , d.manager_id,
    (
    SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) AS 사원수
FROM departments d) 
WHERE 사원수 IS NOT NULL
ORDER BY 사원수 DESC;


--힌트: GROUP BY

/*
문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--부서별 평균이 없으면 0으로 출력하세요.
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
문제 16
-문제 15 결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 
ROWNUM을 붙여 1-10 데이터 까지만 출력하세요.
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








