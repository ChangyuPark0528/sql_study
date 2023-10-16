/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/

CREATE OR REPLACE PROCEDURE emp_salary_proc (
    e_id   IN employees.employee_id%TYPE,
    e_salary OUT NUMBER
) IS
    v_cnt NUMBER := 0;
    v_salary employees.salary%TYPE;
BEGIN
    SELECT
        salary
    INTO v_salary
    FROM
        employees
    WHERE
        employee_id = e_id;

    e_salary := trunc((sysdate - v_hire_date) / 365);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(e_id || '(은) 는 없는 데이터 입니다.');
        COMMIT;
END;

DECLARE
    e_salary NUMBER;
BEGIN
    emp_salary_proc(136, e_year);
    dbms_output.put_line(e_year || '년');
END;



CREATE OR REPLACE PROCEDURE emp_salary_proc
    (p_employee_id IN employees.employee_id%TYPE,
    p_result OUT NUMBER)
IS
    v_calc_salary NUMBER :=0 ;
BEGIN
    SELECT
        salary * 1300
    INTO v_calc_salary
    FROM employees
    WHERE employee_id = p_employee_id;
        p_result := v_calc_salary;
    
    EXCEPTION WHEN OTHERS THEN 
        dbms_output.put_line('ERROR MSG:' || SQLERRM);
        ROLLBACK;
END;

DECLARE
    msg NUMBER(10):=0;
BEGIN
    emp_salary_proc(200, msg);
    dbms_output.put_line('임금: '||msg||'원');
END;

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE emp_salary_proc(
    p_employee_id IN employees.employee_id%TYPE,
    p_salary OUT employees.salary%TYPE) -- 달러
IS
    p_salary_out employees.salary%TYPE := 100; -- 원화
BEGIN
    SELECT salary 
    INTO p_salary 
    FROM employees 
    WHERE employee_id = p_employee_id;
    
    p_salary := p_salary_out * 1300;
EXCEPTION 
 WHEN NO_DATA_FOUND THEN  
      p_salary := NULL;
END;

--------------------------------------------------------------------------------
DECLARE
   v_employee_id employees.employee_id%TYPE := 110;
   v_salary employees.salary%TYPE;
BEGIN
   emp_salary_proc(v_employee_id, v_salary);
   IF v_salary IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('월급 : ' || v_salary || '원'); -- 결과
   ELSE
      DBMS_OUTPUT.PUT_LINE('사원이 존재하지 않습니다.');      
   END IF;

EXCEPTION 
     WHEN OTHERS THEN  
          dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE); -- 에러, 오류 코드
          dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);  -- 에러, 오류 메세지
          
END;

SELECT * FROM employees;


---------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE emp_salary_proc(
    p_employee_id IN employees.employee_id%TYPE,
    p_salary OUT NUMBER) -- 원화
IS
BEGIN
    SELECT salary 
    INTO p_salary 
    FROM employees
    WHERE employee_id = p_employee_id;
    
    p_salary := p_salary * 1300;
EXCEPTION 
 WHEN NO_DATA_FOUND THEN  
      p_salary := NULL;
END;

DECLARE
   v_employee_id employees.employee_id%TYPE := 101;
   v_salary employees.salary%TYPE := 0;
BEGIN
   emp_salary_proc(v_employee_id, v_salary);
   IF v_salary IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('월급 : ' || v_salary || '원'); -- 결과
   ELSE
      DBMS_OUTPUT.PUT_LINE('사원이 존재하지 않습니다.');      
   END IF;

EXCEPTION 
     WHEN OTHERS THEN  
          dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE); -- 에러, 오류 코드
          dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);  -- 에러, 오류 메세지
END;