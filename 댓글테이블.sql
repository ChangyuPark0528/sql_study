
CREATE TABLE tbl_reply(
    reply_no NUMBER PRIMARY KEY,
    reply_text VARCHAR2(1000) NOT NULL,
    reply_writer VARCHAR2(100) NOT NULL,
    reply_date DATE DEFAULT sysdate,
    bno NUMBER,
    update_date DATE DEFAULT NULL,
    
    CONSTRAINT reply_bno_fk FOREIGN KEY(bno) REFERENCES freeboard(bno)
    ON DELETE CASCADE -- 참조하고 있는 부모값이 삭제될 때 자식의 값도 같이 삭제.
);

CREATE SEQUENCE reply_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10000
    NOCYCLE
    NOCACHE;
    
SELECT * FROM tbl_reply;











