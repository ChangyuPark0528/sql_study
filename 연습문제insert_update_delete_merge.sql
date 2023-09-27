
CREATE TABLE DEPTS AS
(SELECT * FROM departments);

-- 문제1
INSERT INTO DEPTS
    (department_id, department_name, location_id)
VALUES
    (280, '개발', 1800);
    
INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
VALUES
    (290, '회계부', null, 1800);

INSERT INTO DEPTS VALUES
    (300, '재정', 301, 1800);
    
INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
VALUES
    (310, '인사', 302, 1800);
    
INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
VALUES
    (320, '영업', 303, 1700);

SELECT * FROM DEPTS;

-- 문제 2
-- 2-1

UPDATE DEPTS 
SET department_name =  'IT bank'
WHERE department_name = 'IT Support';

-- 2-2
UPDATE DEPTS 
SET manager_id = 301
WHERE department_id =  290;

-- 2-3
UPDATE DEPTS
SET 
    department_name = 'TI Help',
    mamager_id = 303,
    location_id = 1800
WHERE department_id = 'TI Helpdesk';

-- 2-4
UPDATE DEPTS
SET
    manager_id = 301
WHERE department_id IN(290, 300, 310, 320);

SELECT * FROM depts;

-- 문제 3
DELETE FROM DEPTS WHERE department_id = (SELECT department_id FROM DEPTS
                                         WHERE department_name = '영업');

DELETE FROM DEPTS WHERE department_id = (SELECT department_id FROM DEPTS
                                         WHERE department_name = 'NOC');

-- 문제 4
-- 4-1
DELETE FROM DEPTS WHERE department_id > 200;

-- 4-2
UPDATE DEPTS
SET manager_id = 100
WHERE manager_id IS NOT NULL;

-- 4-3
MERGE INTO DEPTS a
    USING (SELECT * FROM departments) d
    ON (a.department_id = d.department_id)
WHEN MATCHED THEN
    UPDATE SET
    a.department_name = d.department_name,
    a.manager_id = d.manager_id,
    a.location_id = b.location_id

WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.department_id,
     b.department_name, 
     b.manager_id,
     b.location_id
     );
    
--------------------------------------------------------------------------------

-- 문제 5
-- 5-1
CREATE TABLE jobs_it AS
(SELECT * FROM jobs WHERE min_salary > 6000);
    
SELECT * FROM job_it;
SELECT * FROM jobs;    
    
-- 5-2

INSERT INTO jobs_it VALUES ('IT_DEV', '아이티개발팀', 6000, 20000);

INSERT INTO jobs_it VALUES ('NET_DEV', '네트워크개발팀', 5000, 20000);

INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES
    ('SEC_DEV', '보안개발팀', 6000, 19000);
    
-- 5-4

MERGE INTO jobs_it a
    USING (SELECT * FROM jobs WHERE min_salary > 5000) b
    ON (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET
       a.min_salary = b.min_salary,
       a.max_salary = b.max_salary
        
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.job_id, b.job_title, b.min_salary, b.max_salary);
    
    
    
    
    
    



