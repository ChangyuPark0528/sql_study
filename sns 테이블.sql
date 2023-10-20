

CREATE TABLE snsboard(
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(50) NOT NULL,
    upload_path VARCHAR2(100),
    file_loca VARCHAR2(100),
    file_name VARCHAR2(100),
    file_real_name VARCHAR2(100),
    content VARCHAR2(4000),
    reg_date DATE DEFAULT sysdate
);

CREATE SEQUENCE snsboard_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100000
    NOCYCLE
    NOCACHE;

SELECT * FROM snsboard;