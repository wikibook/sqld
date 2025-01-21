-- 스키마를 지정하지 않았을 경우
CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) 
);

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

-- 스키마를 지정하여 테이블 생성 
-- 해당 스키마는 개인 환경에 따라 다르게 입력
-- 여기서는 'C##OT' 스키마를 사용
-- 만약 'SQLD' 스키마 사용 시 -> '점(dot) 앞에 명칭을 'C##OT'에서 'SQLD'로 바꾸면 됩니다.   
CREATE TABLE C##OT.DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) 
);

INSERT INTO C##OT.DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO C##OT.DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO C##OT.DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO C##OT.DEPT VALUES (40, 'OPERATIONS', 'BOSTON');