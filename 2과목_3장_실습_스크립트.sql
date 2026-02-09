
------------------------------------------------------
-- 2과목 
------------------------------------------------------

-- 2과목 3장 

-- DML(데이터 조작어: Data Manipulation Language)
  
  
-- INSERT 문 예시: EMP 테이블에 새로운 직원 데이터를 추가하는 예시
INSERT INTO EMP (EMPNO, ENAME, JOB, HIREDATE)
         VALUES (101, 'YONGMOON', 'MANAGER', '2023-08-01') ;

-- INSERT 문 예시: 모든 칼럼을 지정하지 않고 삽입
INSERT INTO EMP
         VALUES (102, 'YONGMOON2', 'CLERK', '7902', '2023-08-03', 2000, NULL, 20) ;

--[EMP_MNG 테이블 생성]
CREATE TABLE EMP_MNG 
      (
      EMPNO NUMBER(4,0)
    , ENAME VARCHAR2(10)
    , JOB VARCHAR2(9)
    , MGR NUMBER(4,0)
    , HIREDATE DATE
    , SAL NUMBER(7,2)
    , COMM NUMBER(7,2)
    , DEPTNO NUMBER(2,0)
      ) ; 

-- [서브쿼리]
SELECT
      EMPNO
    , ENAME
    , JOB
    , HIREDATE
    , DEPTNO
FROM
      EMP
WHERE
      DEPTNO = 20;

-- [서브 쿼리를 이용한 다중 행 INSERT 문] 
INSERT INTO EMP_MNG 
      (
      EMPNO
    , ENAME
    , JOB
    , HIREDATE
    , DEPTNO)
SELECT
        EMPNO
      , ENAME
      , JOB
      , HIREDATE
      , DEPTNO
FROM
      EMP
WHERE
      DEPTNO = 20;

-- 여러 칼럼을 동시에 UPDATE
UPDATE
      EMP
SET
      SAL = 200
    , COMM = 300
WHERE
      ENAME = 'YONGMOON';

-- 서브쿼리를 이용한 UPDATE: ‘YONGMOON’의 SAL 값을 DEPTNO가 10인 부서의 SAL 평균값으로 UPDATE하는 예시
UPDATE EMP
SET SAL = (SELECT AVG(SAL) 
             FROM EMP 
            WHERE DEPTNO = 10)
WHERE ENAME = 'YONGMOON';

-- 여러 칼럼을 동시에 DELETE 
DELETE FROM
      EMP
WHERE
      ENAME = 'YONGMOON';

--  MERGE 문 기본 형식
MERGE INTO 타깃_테이블 타깃(별칭)
      USING 소스_테이블 소스(별칭)
          ON (타깃.조건_칼럼 = 소스.조건_칼럼)
          WHEN MATCHED THEN 
              UPDATE SET 타깃.칼럼1 = 소스.칼럼1
                        , ...
          WHEN NOT MATCHED THEN
              INSERT (칼럼1, 칼럼2, ...)
              VALUES (소스.칼럼1, 소스.칼럼2, … ) ;

-- ② MERGE 예시  
MERGE INTO EMP_MNG M
      USING EMP E
          ON (M.EMPNO = E.EMPNO)
          WHEN MATCHED THEN
              UPDATE SET 
                    M.SAL = E.SAL
                  , M.COMM = E.SAL
          WHEN NOT MATCHED THEN
              INSERT (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO) ;

-- COMMIT 예시
-- 1. EMP_MNG 테이블의 YONGMOON, YONGMOON2를 삭제 
DELETE FROM
      EMP
WHERE
      ENAME = 'YONGMOON'
      OR ENAME = 'YONGMOON2' ;

-- 2. 새로운 직원을 EMP 테이블에 추가
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7935, 'JAMESBOND', 'ANALYST', 7566, TO_DATE('2023-08-19', 'YYYY-MM-DD'), 3500, NULL, 20) ;

INSERT INTO
      EMP 
      (
      EMPNO
    , ENAME
    , JOB
    , MGR
    , HIREDATE
    , SAL
    , COMM
    , DEPTNO
      )
VALUES 
      (
      7935
    , 'JAMESBOND'
    , 'ANALYST'
    , 7566
    , TO_DATE('2023-08-19', 'YYYY-MM-DD')
    , 3500
    , NULL
    , 20
      ) ;

-- 3. 특정 직원의 급여를 10% 인상 (EMPNO가 7935인 'JAMESBOND')
UPDATE
      EMP
SET
      SAL = SAL * 1.1
WHERE
      EMPNO = 7935;

-- 4. 특정 직원의 부서 번호를 30번으로 변경 (EMPNO가 7902인 FORD)
UPDATE
      EMP
SET
      DEPTNO = 30
WHERE
      EMPNO = 7902;

-- ② ROLLBACK 예시 
-- 1. 특정 직원의 급여를 40% 인상 (EMPNO가 7935인 ‘JAMESBOND’)
UPDATE
      EMP
SET
      SAL = SAL * 1.4
WHERE
      EMPNO = 7935;

-- 2. 특정 직원의 부서 번호를 30번으로 변경 (EMPNO가 7935인 ‘JAMESBOND’)
UPDATE
      EMP
SET
      DEPTNO = 30
WHERE
      EMPNO = 7935;

-- ② SAVEPOINT 예시 
-- 트랜잭션 시작 
BEGIN;

-- 1. 첫 번째 INSERT
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
VALUES (8001, 'AAAAA', 'CLERK', 1500, 10);

-- 2. 첫 번째 SAVEPOINT 설정
SAVEPOINT sp1;

-- 3. 두 번째 INSERT
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
VALUES (8002, 'BBBBB', 'MANAGER', 2500, 20);

-- 4. 두 번째 SAVEPOINT 설정
SAVEPOINT sp2;

-- 5. 세 번째 INSERT
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
VALUES (8003, 'CCCCC', 'ANALYST', 3000, 30);

-- 6. 오류 발생으로 인해 두 번째 SAVEPOINT로 롤백
ROLLBACK TO sp2;

-- 7. COMMIT 실행으로 나머지 트랜잭션 확정
COMMIT;

-- CREATE TABLE 예시
CREATE TABLE STUDENT 
      (
      STUDENT_ID NUMBER(5) PRIMARY KEY
    , NAME VARCHAR2(50) NOT NULL
    , AGE NUMBER(3)
    , ENROLL_DATE DATE DEFAULT SYSDATE
    , DEPT_ID NUMBER(3) REFERENCES DEPARTMENT(DEPT_ID)
      ) ;

-- CASCADE: 부모 테이블의 행이 삭제되거나 업데이트될 때 자식 테이블의 해당 외래 키를 참조하는 행들도 자동으로 삭제되거나 업데이트된다. 이 옵션은 외래 키에 ON DELETE CASCADE 또는 ON UPDATE CASCADE와 함께 사용된다.
CREATE TABLE CHILD_TABLE_CASCADE 
      (
      CHILD_ID NUMBER PRIMARY KEY
    , PARENT_ID NUMBER
    , CONSTRAINT FK_PARENT_CASCADE FOREIGN KEY (PARENT_ID) 
      REFERENCES PARENT_TABLE (PARENT_ID) ON DELETE CASCADE
      );

-- SET NULL: 부모 테이블에서 행이 삭제되면 자식 테이블의 해당 외래 키가 NULL로 설정된다. 
CREATE TABLE CHILD_TABLE_CASCADE 
      (
      CHILD_ID NUMBER PRIMARY KEY
    , PARENT_ID NUMBER
    , CONSTRAINT FK_PARENT_CASCADE FOREIGN KEY (PARENT_ID)
      REFERENCES PARENT_TABLE (PARENT_ID) ON DELETE
      SET NULL 
      );

-- SET DEFAULT: 부모 테이블에서 행이 삭제되면 자식 테이블의 해당 외래 키가 기본값으로 설정된다. 
CREATE TABLE CHILD_TABLE_CASCADE 
      (
      CHILD_ID NUMBER PRIMARY KEY
    , PARENT_ID NUMBER
    , CONSTRAINT FK_PARENT_CASCADE FOREIGN KEY (PARENT_ID)
      REFERENCES PARENT_TABLE (PARENT_ID) ON DELETE SET DEFAULT 
      );

-- ◼ NO ACTION: 부모 테이블에서 행이 삭제되거나 업데이트될 때 자식 테이블의 외래 키는 아무런 작업도 수행되지 않는다. 
CREATE TABLE CHILD_TABLE_CASCADE 
      (
      CHILD_ID NUMBER PRIMARY KEY
    , PARENT_ID NUMBER
    , CONSTRAINT FK_PARENT_CASCADE FOREIGN KEY (PARENT_ID) 
      REFERENCES PARENT_TABLE (PARENT_ID) ON DELETE NO ACTION 
      );

-- RESTRICT: 부모 테이블에서 행이 삭제되거나 업데이트될 때 자식 테이블의 외래 키는 아무런 작업도 수행되지 않으며, 부모 테이블의 행이 참조 중이면 삭제할 수 없다. NO ACTION과 유사하다.
CREATE TABLE CHILD_TABLE_CASCADE 
      (
      CHILD_ID NUMBER PRIMARY KEY
    , PARENT_ID NUMBER
    , CONSTRAINT FK_PARENT_CASCADE FOREIGN KEY (PARENT_ID)
      REFERENCES PARENT_TABLE (PARENT_ID) ON DELETE RESTRICT 
      );

  
  
  
  
  
  
  
  

