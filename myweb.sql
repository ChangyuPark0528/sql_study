    
CREATE USER spring IDENTIFIED BY spring;

GRANT CREATE SESSION TO spring;
GRANT CONNECT, RESOURCE, DBA TO spring;


CREATE TABLE freeboard(
    bno NUMBER PRIMARY KEY,
    title VARCHAR2(300) NOT NULL,
    writer VARCHAR2(50) NOT NULL,
    content VARCHAR2(3000),
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL
);

CREATE SEQUENCE freeboard_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;

DROP SEQUENCE freeboare_seq;

SELECT * FROM freeboard;

