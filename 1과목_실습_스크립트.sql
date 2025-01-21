------------------------------------------------------
-- 1과목 
------------------------------------------------------

-- 1과목 1장(스크립트 없음) 

-- 1과목 2장 

-------------------------------------------------------
-- 스크립트로 SQL 테이블 생성하기 <create_emp.sql> 

-- 스키마를 지정하지 않았을 경우
CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) 
 );

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,TO_DATE('1981-11-17','YYYY-MM-DD'),5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('1981-05-01','YYYY-MM-DD'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('1981-05-09','YYYY-MM-DD'),2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,TO_DATE('1981-04-01','YYYY-MM-DD'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('1981-09-10','YYYY-MM-DD'),1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('1981-02-11','YYYY-MM-DD'),1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('1981-08-21','YYYY-MM-DD'),1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,TO_DATE('1981-12-11','YYYY-MM-DD'),950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('1981-02-23','YYYY-MM-DD'),1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,TO_DATE('1981-12-11','YYYY-MM-DD'),3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,TO_DATE('1980-12-09','YYYY-MM-DD'),800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('1982-12-22','YYYY-MM-DD'),3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('1983-01-15','YYYY-MM-DD'),1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,TO_DATE('1982-01-11','YYYY-MM-DD'),1300,NULL,10);


-- 스키마를 지정하여 테이블 생성 
-- 해당 스키마는 개인 환경에 따라 다르게 입력
-- 여기서는 'C##OT' 스키마를 사용
-- 만약 'SQLD' 스키마 사용 시 -> '점(dot) 앞에 명칭을 'C##OT'에서 'SQLD'로 바꾸면 됩니다.  
CREATE TABLE C##OT.EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) 
 );

INSERT INTO C##OT.EMP VALUES (7839,'KING','PRESIDENT',NULL,TO_DATE('1981-11-17','YYYY-MM-DD'),5000,NULL,10);
INSERT INTO C##OT.EMP VALUES (7698,'BLAKE','MANAGER',7839,TO_DATE('1981-05-01','YYYY-MM-DD'),2850,NULL,30);
INSERT INTO C##OT.EMP VALUES (7782,'CLARK','MANAGER',7839,TO_DATE('1981-05-09','YYYY-MM-DD'),2450,NULL,10);
INSERT INTO C##OT.EMP VALUES (7566,'JONES','MANAGER',7839,TO_DATE('1981-04-01','YYYY-MM-DD'),2975,NULL,20);
INSERT INTO C##OT.EMP VALUES (7654,'MARTIN','SALESMAN',7698,TO_DATE('1981-09-10','YYYY-MM-DD'),1250,1400,30);
INSERT INTO C##OT.EMP VALUES (7499,'ALLEN','SALESMAN',7698,TO_DATE('1981-02-11','YYYY-MM-DD'),1600,300,30);
INSERT INTO C##OT.EMP VALUES (7844,'TURNER','SALESMAN',7698,TO_DATE('1981-08-21','YYYY-MM-DD'),1500,0,30);
INSERT INTO C##OT.EMP VALUES (7900,'JAMES','CLERK',7698,TO_DATE('1981-12-11','YYYY-MM-DD'),950,NULL,30);
INSERT INTO C##OT.EMP VALUES (7521,'WARD','SALESMAN',7698,TO_DATE('1981-02-23','YYYY-MM-DD'),1250,500,30);
INSERT INTO C##OT.EMP VALUES (7902,'FORD','ANALYST',7566,TO_DATE('1981-12-11','YYYY-MM-DD'),3000,NULL,20);
INSERT INTO C##OT.EMP VALUES (7369,'SMITH','CLERK',7902,TO_DATE('1980-12-09','YYYY-MM-DD'),800,NULL,20);
INSERT INTO C##OT.EMP VALUES (7788,'SCOTT','ANALYST',7566,TO_DATE('1982-12-22','YYYY-MM-DD'),3000,NULL,20);
INSERT INTO C##OT.EMP VALUES (7876,'ADAMS','CLERK',7788,TO_DATE('1983-01-15','YYYY-MM-DD'),1100,NULL,20);
INSERT INTO C##OT.EMP VALUES (7934,'MILLER','CLERK',7782,TO_DATE('1982-01-11','YYYY-MM-DD'),1300,NULL,10);

-- 스크립트로 SQL 테이블 생성하기 <create_dept.sql> 

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
-------------------------------------------------------

-- 집계함수에서의 NULL 처리 
-- 실습을 위해 다음의 ‘테이블 생성’ 쿼리와 ‘데이터 삽입’ 쿼리를 실행

-- 테이블 생성 SQL
CREATE TABLE 주문정보 
      (
      주문번호 VARCHAR2(20)
    , 주문금액 NUMBER
    , 주문취소금액 NUMBER
    , 최종주문금액 NUMBER
      );

-- 데이터 삽입 SQL
INSERT INTO 주문정보 (주문번호, 주문금액, 주문취소금액, 최종주문금액) VALUES ('1100001',
100000, 35000, 65000);
INSERT INTO 주문정보 (주문번호, 주문금액, 주문취소금액, 최종주문금액) VALUES ('1100002',
15000, NULL, NULL);
INSERT INTO 주문정보 (주문번호, 주문금액, 주문취소금액, 최종주문금액) VALUES ('1100003',
40000, NULL, NULL);
INSERT INTO 주문정보 (주문번호, 주문금액, 주문취소금액, 최종주문금액) VALUES ('1100004',
45000, 5000, 40000);
INSERT INTO 주문정보 (주문번호, 주문금액, 주문취소금액, 최종주문금액) VALUES ('1100005',
100000, 10000, 90000);

-- 데이터 삽입 확인을 위한 SELECT 문
SELECT * FROM 주문정보 ;

-- AVG 함수 예시
SELECT
      AVG(최종주문금액) AS COL1
    , AVG(NVL(최종주문금액, 0)) AS COL2
    , AVG(NVL(주문금액, 0)) - AVG(NVL(주문취소금액, 0)) AS COL3
FROM
      주문정보;

-- COUNT 함수 예시
SELECT
      COUNT(최종주문금액) AS COL1
    , COUNT(NVL(최종주문금액, 0)) AS COL2
    , COUNT(NVL(주문금액, 0)) - COUNT(NVL(주문취소금액, 0)) AS COL3
    , (NVL(COUNT(주문금액), 0) - NVL(COUNT(주문취소금액), 0)) AS COL4
FROM
      주문정보 ;

-- MAX 함수 예시
SELECT
      MAX(최종주문금액) AS COL1
    , NVL(MAX(최종주문금액), 0) AS COL2
    , (NVL(MAX(주문금액), 0) - NVL(MAX(주문취소금액), 0)) AS COL3
    , MAX(NVL(주문금액, 0)) - MAX(NVL(주문취소금액, 0)) AS COL4
FROM
      주문정보;

-- MIN 함수 예시
SELECT
      MIN(최종주문금액) AS COL1
    , NVL(MIN(최종주문금액), 0) AS COL2
    , (NVL(MIN(주문금액), 0) - NVL(MIN(주문취소금액), 0)) AS COL3
    , MIN(NVL(주문금액, 0)) - MIN(NVL(주문취소금액, 0)) AS COL4
FROM
      주문정보;

-- end 