


CREATE TABLE test_location(
    area1 VARCHAR2(50),
    area2 VARCHAR2(50),
    nx NUMBER,
    ny NUMBER,
    latitude NUMBER(20,15),
    longitude NUMBER(20,15)
);

SELECT * FROM
    (
        SELECT ROWNUM AS rn, nx, ny
        FROM test_location
        WHERE area1 = '��õ������'
        AND area2 LIKE '%����%'
    )
WHERE ROWNUM = 1;

