
------------------------------------------------------
-- 2과목 
------------------------------------------------------

-- 2과목 1장 

-- EMP 테이블에서 사원번호(EMPNO), 사원이름(ENAME), 직무(JOB) 칼럼을 조회하는 쿼리
SELECT
      EMPNO
    , ENAME
    , JOB
FROM
      EMP;

  -- 모든 칼럼을 조회할 때 *(asterisk) 사용
SELECT
      *
FROM
      EMP;

-- EMP 테이블에서 EMPNO를 ‘사원번호’, ENAME을 ‘사원이름’으로 별칭 사용 
SELECT
      EMPNO AS 사원번호
    , ENAME AS 사원이름
FROM
      EMP
ORDER BY
      EMPNO;
  
-- 별칭에 공백을 사용하는 예제(오라클)
SELECT
      EMPNO AS “사원 번호”
    , ENAME AS “사원 이름”
FROM
      EMP
ORDER BY
      EMPNO;

-- SQL Server 쿼리문(오라클에서 동작안함) 
SELECT
      EMPNO AS [사원 번호]
    , ENAME AS [사원 이름]
FROM
      EMP;

-- SELECT 문으로 EMP 테이블의 JOB 칼럼 조회 
SELECT 
      JOB 
FROM  
      EMP;

-- SELECT DISTINCT 문으로 EMP 테이블의 JOB 칼럼 조회 
SELECT DISTINCT 
      JOB
FROM
      EMP;

-- 덧셈 연산자 (+)
SELECT
      ENAME
    , SAL
    , COMM
    , (SAL + NVL(COMM, 0)) AS TOTAL_COMP
FROM
      EMP ;
  
-- 뺄셈 연산자 (-)
SELECT
      ENAME
    , SAL
    , COMM
    , (SAL - NVL(COMM, 0)) AS NET_SAL
FROM
      EMP;

-- 곱셈 연산자 (*)
SELECT
      ENAME
    , SAL
    , (SAL * 12) AS ANNUAL_SAL
FROM
      EMP;

-- 나눗셈 연산자(/)
SELECT
      ENAME
    , SAL
    , (SAL / 4) AS WEEKLY_SAL
FROM
      EMP;

-- % 연산자 사용(MySQL, PostgreSQL 등)
SELECT
      ENAME
    , EMPNO
    , CASE 
          WHEN 
          EMPNO % 2 = 0 THEN '짝수'
          ELSE '홀수'
      END AS ID_TYPE
FROM
      EMP;

-- MOD 함수 사용(오라클) 
SELECT
      ENAME
    , EMPNO
    , CASE
          WHEN MOD(EMPNO, 2) = 0 THEN '짝수'
          ELSE '홀수'
      END AS ID_TYPE
FROM
      EMP;

-- 사원의 이름(ENAME)과 직무(JOB)를 하나의 문자열로 합쳐서 조회
-- 오라클에서는 두 개의 버티컬 라인(||)을 문자 합성 연산자로 사용한다(shift + ‘\(\)’ → 두 번 누르기)
SELECT
      ENAME || ' is a ' || JOB AS EMPLOYEE_INFO
FROM
      EMP;

-- LOWER('문자열’')
SELECT
      LOWER('HELLO WORLD') AS lower_string
FROM
      DUAL;

-- UPPER('문자열')
SELECT
      UPPER('hello world') AS upper_string
FROM
      DUAL;
  
-- ASCII('문자')
SELECT
      ASCII('A') AS ascii_value
FROM
      DUAL;


-- CHR(ASCII 번호)
SELECT
      CHR(65) AS char_value
FROM
      DUAL;

  
-- CONCAT('문자열1', '문자열2')
SELECT
    CONCAT('Hello', ' World') AS concatenated_string
FROM
    DUAL;

  
-- SUBSTR(‘문자열’, m[, n]) 
SELECT
      SUBSTR('Hello World', 1, 5) AS substring
FROM
      DUAL;

--  LENGTH('문자열')
SELECT
      LENGTH('Hello World') AS string_length
FROM
      DUAL;

  
-- LTRIM('   Hello')
SELECT
      LTRIM('   Hello World') AS ltrim_string
FROM
      DUAL;

-- RTRIM('Hello   ')
SELECT
      RTRIM('Hello World   ') AS rtrim_string
FROM
      DUAL;

-- TRIM('   Hello   ')
SELECT
      TRIM('   Hello World   ') AS trimmed_string
FROM
      DUAL;

-- ABS(숫자)
SELECT
      ABS(-15) AS 절댓값
FROM
      DUAL;

-- SIGN(숫자)
SELECT
      SIGN(-10) AS sign_neg
    , SIGN(0) AS sign_zero
    , SIGN(10) AS sign_pos
FROM
      DUAL;

-- MOD(n2, n1)
SELECT
      MOD(17, 5) AS MOD
FROM
      DUAL;

-- CEIL(숫자)
SELECT
      CEIL(4.3) AS CEIL
FROM
      DUAL;

-- FLOOR(숫자)
SELECT
      FLOOR(4.7) AS floor
FROM
      DUAL;

  
-- ROUND(n [, m])
SELECT
      ROUND(3.14159, 2) AS round
FROM
      DUAL;

-- TRUNC(n [, m])
SELECT
      TRUNC(3.14159, 2) AS trunc
FROM
      DUAL;

-- SIN(숫자), COS(숫자), TAN(숫자)
SELECT
      SIN(1) AS sin
    , COS(1) AS cos
    , TAN(1) AS tan
FROM
      DUAL;

-- EXP(n)
SELECT
      EXP(1) AS EXP
FROM
     DUAL;

-- POWER(n2, n1)
SELECT
      POWER(2, 3) AS power
FROM
      DUAL;

-- SQRT(n)
SELECT
      SQRT(9) AS sqrt
FROM
      DUAL;

-- LOG(n2, n1)
SELECT
      LOG(2, 8) AS log
FROM
      DUAL;

-- LN(n)
SELECT
      LN(2.718281828459045) AS LN
FROM
      DUAL;

-- SYSDATE 
SELECT
      SYSDATE AS system_date
FROM
      DUAL;

-- CURRENT_DATE
SELECT
      CURRENT_DATE AS session_date
FROM
      DUAL;

-- ADD_MONTHS(date, n)
-------------------------------------
SELECT
      ADD_MONTHS(SYSDATE, 3) AS future_date
FROM
      DUAL;

-- MONTHS_BETWEEN(date1, date2)
-------------------------------------
SELECT
      MONTHS_BETWEEN(SYSDATE, '2024-01-01') AS months_diff
FROM
      DUAL;
 
-- NEXT_DAY(date, 'day')
-------------------------------------
SELECT
      NEXT_DAY(DATE '2024-07-20', '월요일')
FROM
      DUAL;

-- NLS 설정: 날짜, 언어, 지역, 문자 인코딩 
SELECT
      *
FROM
      NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = 'ENGLISH' ;


-- LAST_DAY(date)
SELECT
      LAST_DAY(SYSDATE) AS end_of_month
FROM
      DUAL;

-- TRUNC(date)
SELECT
      TRUNC(SYSDATE) AS truncated_date
FROM
      DUAL;

-- TO_CHAR 함수 사용
SELECT
    TO_CHAR(TRUNC(SYSDATE), 'YYYY-MM-DD') AS truncated_date
FROM
    DUAL;

-- ROUND(date, 'format')
SELECT
      ROUND(SYSDATE, 'MONTH') AS rounded_date
FROM
      DUAL;

-- EXTRACT(part FROM date)  → 오라클 
SELECT
      EXTRACT(YEAR FROM SYSDATE) AS current_year
FROM
      DUAL;
  
SELECT
      EXTRACT(MONTH FROM SYSDATE) AS current_month
FROM
      DUAL;

-- DATEPART(datepart, date) → SQL Server
SELECT
      DATEPART(YEAR, hiredate) AS YEAR
    , DATEPART(MONTH, hiredate) AS MONTH
    , DATEPART(DAY, hiredate) AS DAY
FROM
      EMP;

-- TO_CHAR(date, 'format')
SELECT
      TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS formatted_date
FROM
      DUAL;

-- 날짜를 문자열로 변환
SELECT
      TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM
      DUAL;

-- 숫자를 문자열로 변환
SELECT
      TO_CHAR(1234.56, '9,999.99')
FROM
      DUAL;

-- 문자열을 날짜로 변환
SELECT
      TO_DATE('2024-07-20 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
FROM
      DUAL;

-- TO_CHAR(date, 'format')
-------------------------------------
SELECT
      TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS formatted_date
FROM
      DUAL;
 
-- 숫자를 문자열로 변환
SELECT
      TO_CHAR(1234.56, '9,999.99')
FROM
      DUAL;
  
-- TO_DATE ([문자열], 'format')
SELECT
    TO_DATE('2024-07-21 20:25:22', 'YYYY-MM-DD HH24:MI:SS') AS formatted_date
FROM
    DUAL;

-- TO_NUMBER('string', 'format')
-------------------------------------
SELECT
      TO_NUMBER('12345') AS number_value
FROM
      DUAL;

-- CAST(value AS datatype)
SELECT
      CAST('12345' AS NUMBER) AS number_value
FROM
      DUAL;

-- CONVERT('string', 'dest_charset', 'source_charset')
-------------------------------------
SELECT
      CONVERT('가나다라마', 'AL32UTF8', 'UTF8') AS converted_string
FROM
      DUAL;

-- [참고] 변환 함수 예제 
SELECT 
      EMPNO AS "사원번호"
    , CAST(SAL AS INT) + CAST(NVL(COMM, 0) AS INT) AS "총 보수"
FROM
      EMP;

-- [참고] Java에서의 IF 조건문과 SQL에서의 CASE 문 
-- SQL
SELECT
      ENAME
    , SAL
    , CASE
          WHEN SAL < 1000 THEN 'Low Salary'
          WHEN SAL BETWEEN 1000 AND 3000 THEN 'Medium Salary'
          WHEN SAL > 3000 THEN 'High Salary'
          ELSE 'Unknown'
      END AS SALARY_GRADE
FROM
      EMP;

-- 표현식의 값을 조건과 비교하여 해당 조건이 참일 때 지정된 결과를 반환한다.
-- 【 형식 】
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ...
    ELSE default_result
END

-- [예시] EMP 테이블에서 사원의 직무(JOB)에 따라 다른 메시지를 출력하는 예
-------------------------------------
SELECT
      ENAME
    , JOB
    , CASE JOB
          WHEN 'CLERK' THEN 'Clerk Job'
          WHEN 'SALESMAN' THEN 'Sales Job'
          WHEN 'MANAGER' THEN 'Manager Job'
          ELSE 'Other Job'
      END AS JOB_DESCRIPTION
FROM
      EMP;
      
-- EMP 테이블에서 사원의 급여(SAL)가 특정 범위에 있을 때 다른 등급을 부여하는 예
SELECT
      ENAME
    , SAL
    , CASE
          WHEN SAL < 1000 THEN 'Low Salary'
          WHEN SAL BETWEEN 1000 AND 3000 THEN 'Medium Salary'
          WHEN SAL > 3000 THEN 'High Salary'
          ELSE 'Unknown'
      END AS SALARY_GRADE
FROM
      EMP ;

-- 직원의 부서와 급여를 기준으로 등급을 부여하고, 각 등급에 따라 추가 메시지를 표시
SELECT
      ENAME AS "사원명"
    , DEPTNO AS "부서번호"
    , SAL AS "급여"
    , CASE DEPTNO
          WHEN 10 THEN
              CASE
                  WHEN SAL < 3000 THEN '회계 부서 - 낮은 급여'
                  ELSE '회계 부서 - 높은 급여'
              END
          WHEN 20 THEN
              CASE
                  WHEN SAL < 3000 THEN '연구 부서 - 낮은 급여'
                  ELSE '연구 부서 - 높은 급여'
              END
          WHEN 30 THEN
              CASE
                  WHEN SAL < 3000 THEN '영업 부서 - 낮은 급여'
                  ELSE '영업 부서 - 높은 급여'
              END
          ELSE '기타 부서'
      END AS "부서급여메시지"
FROM
      EMP;

-- COALESCE(첫 번째 인자, 두 번째 인자, ..., N 번째 인자)
SELECT
      ENAME
    , COMM
    , SAL
    , COALESCE(COMM, SAL, 0) AS VALUE
FROM
    EMP;
    
-- IFNULL(첫 번째 인자, 두 번째 인자) - MySQL
SELECT
      ENAME
    , COMM
    , IFNULL(COMM, 0) AS IFNULL_VALUE
FROM
      EMP;    
    
-- ISNULL(첫 번째 인자, 두 번째 인자) - SQL Server
SELECT
      ENAME
    , COMM
    , ISNULL(COMM, 0) AS ISNULL_VALUE
FROM
      EMP;
    
-- WHERE 절은 기본적으로 FROM 다음에 위치하는 문법을 따른다.
SELECT
      *
FROM
      EMP
WHERE
      SAL > 2000
      AND DEPTNO = 10; 

-- SAL칼럼의 값이 1500과 3000 사이에 있고, 이 중에서 DEPTNO가 20인 값을 찾는 쿼리는  
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      SAL BETWEEN 1500 AND 3000
      AND DEPTNO = 20;    
    
-- ‘AND DEPTNO = 20’과 ‘OR DEPTNO = 20’의 차이
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      SAL BETWEEN 1500 AND 3000
      OR DEPTNO = 20;

-- 괄호는 순서에 상관없이 우선순위가 가장 높다.
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      SAL > 1000 AND (SAL < 2000 AND DEPTNO = 20);

-- 같다 (=): 숫자와 동일한 값을 가진 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      SAL = 3000;

-- 같지 않다 (<>, !=): 특정 숫자와 다른 값을 가진 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      SAL <> 3000;

-- 작거나 같다 (<=): 특정 숫자보다 작거나 같은 값을 가진 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      SAL >= 2000;

-- 복합 조건과 괄호 사용: 조건의 우선순위를 명확히 하기 위해 괄호를 사용
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      (SAL > 2000 AND DEPTNO = 10)
      OR
      (SAL BETWEEN 1500 AND 3000);

-- 같다 (=): 특정 문자열과 동일한 값을 가진 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME = 'SMITH';

--같지 않다 (!=또는 <>): 특정 문자열과 다른 값을 가진 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME != 'SMITH';

-- 작다 (<): 특정 문자열보다 사전 순으로 작은 값사( 전순으로 앞에 나오는 값)을 가진 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME > 'M';

-- 작거나 같다 (<=): 특정 문자열보다 사전 순으로 작거나 같은 값을 가진 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
    ENAME >= 'M';
    
-- BETWEEN 연산자: 특정 범위 내에 있는 값을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      SAL BETWEEN 1500 AND 3000;  
    
--IN(list): list 중 하나라도 열의 값과 일치하면 참T( RUE)을 반환
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      DEPTNO IN (10, 20, 30);

-- LIKE '비교문자열': ‘비교문자열’과 일치하면 참(TRUE)을 반환
-- (% 와일드카드는 0개 이상의 문자를, _ 와일드카드는 단일 문자를 의미)
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME LIKE 'S%';

-- LIKE 예: ENAME 칼럼 중 R이 포함된 모든 문자(문자 길이 상관없음)
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME LIKE '%R%';

-- LIKE 예: ENAME이 ‘JONES’, ‘JANES’ 등과 같이 ‘J’, ‘N’, ‘E’, ‘S’의 위치에 정확히 한 글자가 들어간 직원을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME LIKE 'J_NES';

-- LIKE 예: ENAME의 두 번째 문자가 A‘ ’인 모든 직원을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME LIKE '_A%';

-- LIKE 예: 대부분의 SQL 데이터베이스 시스템에서 LIKE 연산자는 대소문자를 구분하므로, 다음과 같이 소문자로 조회하면 아무것도 나오지 않는다.
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      ENAME LIKE '_a%';

-- LIKE 예: 대소문자를 구분하지 않고 검색하기 위해 대문자로 검색하고, 칼럼 앞에 UPPER를 붙여 준다. 
-- ENAME이 ‘A’ 또는 ‘a’로 시작하는 모든 직원을 선택한다.
-- UPPER 함수가 ENAME을 대문자로 변경하기 때문에 결과적으로 소문자도 함께 조회된다.
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      UPPER(ENAME) LIKE 'A%';

--IS NULL 예(SQL Server): COMM 열이 NULL인 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
    , COMM
FROM
      EMP
WHERE
      COMM IS NULL;

-- EMP 테이블에 와일드카드 문자가 들어간 임의의 데이터를 추가하는 SQL 쿼리
-- 새로운 행 추가 (ENAME에 %와 _ 포함)
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9991, 'S%_MITH', 'CLERK', 7902, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 800, NULL, 20);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9992, 'J%_NES', 'SALESMAN', 7698, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 1600, 300, 30);
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9993, 'A%_LLEN', 'MANAGER', 7839, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 2975, NULL, 20);

--ENAME에 %와 _를 포함한 데이터 검색
SELECT
      EMPNO
    , ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      ENAME LIKE 'A\%\_LLEN' ESCAPE '\';

-- 이스케이프 문자 실습 후, 다른 쿼리 결과에 영향을 줄 수 있으므로 실습이 끝나면 추가했던 개3의 행을 삭제합니다.
-- 추가된 행 삭제
DELETE
FROM
      EMP
WHERE
      EMPNO IN (9991, 9992, 9993);

-- AND 연산자를 사용한 복합 조건: 두 개 이상의 조건이 모두 참일 때 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
WHERE
      SAL >= 2000
      AND JOB = 'MANAGER';

-- OR 연산자를 사용한 복합 조건: 두 개 이상의 조건 중 하나라도 참일 때 행을 선택
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      SAL > 2000
      OR DEPTNO = 20;

-- 급여(SAL) 칼럼이 1000보다 크지 않거나 직무가 M‘ ANAGER’인 직원들을 선택
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE
      NOT SAL > 1000
      OR JOB = 'MANAGER';

-- 논리 연산자 우선 순위: NOT > AND > OR
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
WHERE (
      NOT (SAL > 2000 AND DEPTNO = 10)
      )
      OR JOB = 'CLERK';

-- 집계 함수 적용 예: EMP 테이블의 합계, 평균, 행 수, 최댓값, 최솟값 계산
SELECT
      SUM(SAL) AS TOTAL_SALARY
    , AVG(SAL) AS AVERAGE_SALARY
    , COUNT(*) AS EMPLOYEE_COUNT
    , MAX(SAL) AS MAX_SALARY
    , MIN(SAL) AS MIN_SALARY
FROM
      EMP;

--  GROUP BY 절, HAVING 절, ORDER BY 절

-- 여러 열을 사용한 그룹화 예
SELECT
      DEPTNO
    , JOB
    , SUM(SAL)
FROM
      EMP
GROUP BY
      DEPTNO
    , JOB
ORDER BY 
      DEPTNO;

-- GROUP BY 절에서 정의된 ALIAS를 사용할 경우 오류 발생
SELECT
      DEPTNO
    , JOB
    , SUM(SAL)
FROM
      EMP
GROUP BY
      DEPTNO
    , JOB AS JOB_NAME;

-- SELECT 절에서 정의된 ALIAS를 사용
SELECT
      DEPTNO AS NO
    , JOB AS JOB_NAME
    , SUM(SAL) AS SUM_SAL
FROM
      EMP
GROUP BY
      DEPTNO
    , JOB
ORDER BY
    NO;

-- GROUP BY와 HAVING 절 적용 예
SELECT
      DEPTNO
    , AVG(SAL)
FROM
      EMP
GROUP BY
      DEPTNO
HAVING
      AVG(SAL) > 2000;

-- 오라클에서 GROUP BY와 HAVING 절의 순서가 바뀐 경우의 예
SELECT
      DEPTNO
    , AVG(SAL)
FROM
      EMP
HAVING
      AVG(SAL) > 2000
GROUP BY
      DEPTNO;
 
-- WHERE 절에서 먼저 데이터를 필터링하고 집계하는 방법
SELECT
      DEPTNO
    , AVG(SAL)
FROM
      EMP
WHERE
      SAL > 1500
GROUP BY
      DEPTNO;
  
-- HAVING 절에서 데이터를 필터링하는 방법 
SELECT
      DEPTNO
    , AVG(SAL)
FROM
      EMP
GROUP BY
      DEPTNO
HAVING
      AVG(SAL) > 2000;

-- 단일 열을 기준으로 오름차순 정렬
SELECT
      ENAME
    , JOB AS JOB_NAME
    , SAL
FROM
      EMP
ORDER BY
      SAL ASC;

-- 단일 열을 기준으로 내림차순 정렬
-------------------------------------
SELECT
      ENAME
    , JOB
    , SAL
FROM
      EMP
ORDER BY
      SAL DESC;

-- 여러 열을 기준으로 정렬
SELECT
      ENAME
    , JOB
    , SAL
    , DEPTNO
FROM
      EMP
ORDER BY
      DEPTNO ASC
    , SAL DESC;

-- 부서별로 가장 최근에 고용된 직원 찾기
SELECT
      ENAME
    , JOB
    , HIREDATE
    , DEPTNO
FROM
      EMP
ORDER BY
      DEPTNO ASC
    , HIREDATE DESC;

-- 5. JOIN 

-- JOIN 문법
SELECT
      별칭1.칼럼명
    , 별칭2.칼럼명
FROM
      테이블1 AS 별칭1
      JOIN 테이블2 AS 별칭2 
          ON 별칭1.칼럼명 = 별칭2.칼럼명;

      -------------------------------------
-- [참고] JOIN을 설명하기 위한 샘플 테이블을 만들기 위한 쿼리
-- 기존의 EMP, DEPT 테이블을 약간 수정하여 EMP_NEW, DEPT_NEW 테이블을 만들어 보겠습니다. 
-- 아래 쿼리를 순차적으로 실행하면 됩니다. 
 
-- EMP_NEW 테이블 생성
CREATE TABLE EMP_NEW(
      EMPNO NUMBER(4) PRIMARY KEY
    , ENAME VARCHAR2(10)
    , DEPTNO NUMBER(2)
    , LOCATION VARCHAR2(13)
    );

-- DEPT_NEW 테이블 생성
CREATE TABLE DEPT_NEW (
    DEPTNO NUMBER(2) PRIMARY KEY
    , DNAME VARCHAR2(14)
    , LOCATION VARCHAR2(13)
    );

-- EMP_NEW 테이블에 데이터 삽입
-- 전체 블록 선택 후 ALT+X로 한 번에 실행
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7369, 'SMITH',  20, 'NEW YORK');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7499, 'ALLEN',  30, 'CHICAGO');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7521, 'WARD',   30, 'CHICAGO');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7566, 'JONES',  20, 'DALLAS');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7654, 'MARTIN', 30, 'CHICAGO');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7698, 'BLAKE',  30, 'BOSTON');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7782, 'CLARK',  10, 'NEW YORK');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7788, 'SCOTT',  20, 'DALLAS');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7839, 'KING',   10, 'BOSTON');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7844, 'TURNER', 30, 'CHICAGO');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7876, 'ADAMS',  20, 'DALLAS');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7900, 'JAMES',  30, 'CHICAGO');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7902, 'FORD',   20, 'DALLAS');
INSERT INTO EMP_NEW (EMPNO, ENAME, DEPTNO, LOCATION) VALUES (7934, 'MILLER', 10, 'NEW YORK');

-- DEPT_NEW 테이블에 데이터 삽입
-- 전체 블록 선택 후 ALT+X로 한 번에 실행
INSERT INTO DEPT_NEW (DEPTNO, DNAME, LOCATION) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT_NEW (DEPTNO, DNAME, LOCATION) VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT_NEW (DEPTNO, DNAME, LOCATION) VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT_NEW (DEPTNO, DNAME, LOCATION) VALUES (40, 'OPERATIONS', 'BOSTON');
-------------------------------------

-- 일반적인 식별자 관계 JOIN
SELECT
      e.ENAME
    , d.DNAME
FROM
      EMP_NEW e
      JOIN DEPT_NEW d 
          ON e.DEPTNO = d.DEPTNO;


-- 비식별자 관계 JOIN
SELECT
      e.ENAME
    , d.DNAME
FROM
      EMP_NEW e
      JOIN DEPT_NEW d 
          ON e.LOCATION = d.LOCATION;

-- [참고] 이어서 실습할 ‘③ JOIN의 종류’ 이해를 돕기 위한 실습 테이블 생성 쿼리
-------------------------------------
-- STUDENT 테이블 생성
CREATE TABLE STUDENT (
      ID NUMBER PRIMARY KEY
    , NAME VARCHAR2(50)
    , DEPTNO NUMBER
    , ENROLL_DATE DATE
    , GRADE NUMBER
    );

-- STUDENT 테이블에 데이터 삽입
INSERT INTO STUDENT (ID, NAME, DEPTNO, ENROLL_DATE, GRADE) VALUES (1, 'John', 10, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 90);
INSERT INTO STUDENT (ID, NAME, DEPTNO, ENROLL_DATE, GRADE) VALUES (2, 'Jane', 20, TO_DATE('2022-02-01', 'YYYY-MM-DD'), 85);
INSERT INTO STUDENT (ID, NAME, DEPTNO, ENROLL_DATE, GRADE) VALUES (3, 'Jim', 10, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 88);
INSERT INTO STUDENT (ID, NAME, DEPTNO, ENROLL_DATE, GRADE) VALUES (4, 'Jake', 30, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 92);
INSERT INTO STUDENT (ID, NAME, DEPTNO, ENROLL_DATE, GRADE) VALUES (5, 'Jill', NULL, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 75);

-- DEPARTMENT 테이블 생성
CREATE TABLE DEPARTMENT (
      DEPTNO NUMBER PRIMARY KEY
    , DNAME VARCHAR2(50)
    );
-- DEPARTMENT 테이블에 데이터 삽입
INSERT INTO DEPARTMENT (DEPTNO, DNAME) VALUES (10, 'Computer Science');
INSERT INTO DEPARTMENT (DEPTNO, DNAME) VALUES (20, 'Mathematics');
INSERT INTO DEPARTMENT (DEPTNO, DNAME) VALUES (30, 'Physics');
INSERT INTO DEPARTMENT (DEPTNO, DNAME) VALUES (40, 'Chemistry');
-------------------------------------

-- INNER JOIN : 두 테이블 간의 공통된 값을 가진 행만 반환. 
-- INNER 생략 가능(INNER JOIN = JOIN)  
SELECT
      S.ID
    , S.NAME
    , D.DNAME
FROM
      STUDENT S
      INNER JOIN DEPARTMENT D 
          ON S.DEPTNO = D.DEPTNO;

-- LEFT OUTER JOIN: 왼쪽 테이블의 모든 행과 오른쪽 테이블의 공통된 값을 가진 행을 반환
-- OUTER 생략 가능(LEFT JOIN = FULL OUTER JOIN) 
SELECT
      S.ID
    , S.NAME
    , D.DNAME
FROM
      STUDENT S
      LEFT OUTER JOIN DEPARTMENT D 
          ON S.DEPTNO = D.DEPTNO;

-- 오라클에서 LEFT OUTER JOIN 및 WHERE 조건에서 (+) 두 문법 모두 사용 가능하지만,
-- 다른 DBMS로 마이그레이션할 가능성이 있다면 ANSI 표준 문법을 사용하는 것이 좋다.
SELECT
      S.ID
    , S.NAME
    , D.DNAME
FROM
      STUDENT S
    , DEPARTMENT D
WHERE
    S.DEPTNO = D.DEPTNO(+);

-- RIGHT OUTER JOIN: 오른쪽 테이블의 모든 행과 왼쪽 테이블의 공통된 값을 가진 행을 반환
-- 왼쪽 테이블에 일치하는 값이 없으면 NULL로 표시
-- OUTER 생략 가능(RIGHT JOIN = RIGHT OUTER JOIN) 
SELECT
      S.ID
    , S.NAME
    , D.DNAME
FROM
      STUDENT S
      RIGHT OUTER JOIN DEPARTMENT D 
          ON S.DEPTNO = D.DEPTNO;

-- 오라클에서는 다음과 같이 WHERE절에서 (+) 기호를 기준이 되는 반대쪽 칼럼에 붙이면 RIGHT LEFT OUTER JOIN과 같은 결과가 나온다. 반드시 기준이 되는 테이블의 반대쪽 테이블에 붙여야 한다.  
SELECT
      S.ID
    , S.NAME
    , D.DNAME
FROM
      STUDENT S
    , DEPARTMENT D
WHERE
    S.DEPTNO(+) = D.DEPTNO;


-- FULL OUTER JOIN: 두 테이블의 모든 행을 반환
--공통된 값이 없는 경우에도 각각의 테이블에서 행을 반환하고 NULL로 표시
--OUTER 생략 가능(FULL JOIN = FULL OUTER JOIN)  
SELECT
      S.ID
    , S.NAME
    , D.DNAME
FROM
      STUDENT S
      FULL OUTER JOIN DEPARTMENT D 
          ON S.DEPTNO = D.DEPTNO;

-- UNION
SELECT
      ID
    , NAME
    , DEPTNO
FROM
      STUDENT
UNION
SELECT
      DEPTNO AS ID
    , DNAME AS NAME
    , NULL AS DEPTNO
FROM
      DEPARTMENT;

-- [참고] 이어서 나올 JOIN 학습 시 이해를 돕기 위한 실습 테이블 생성 쿼리
-------------------------------------
-- NEW_STUDENT 테이블 생성
CREATE TABLE NEW_STUDENT (
      ID NUMBER PRIMARY KEY
    , NAME VARCHAR2(50)
    , SCORE NUMBER
    );

-- NEW_STUDENT 테이블에 데이터 삽입
INSERT INTO NEW_STUDENT (ID, NAME, SCORE) VALUES (1, 'John', 85);
INSERT INTO NEW_STUDENT (ID, NAME, SCORE) VALUES (2, 'Jane', 92);
INSERT INTO NEW_STUDENT (ID, NAME, SCORE) VALUES (3, 'Jim', 78);
INSERT INTO NEW_STUDENT (ID, NAME, SCORE) VALUES (4, 'Jake', 89);
INSERT INTO NEW_STUDENT (ID, NAME, SCORE) VALUES (5, 'Mike', 90); 
INSERT INTO NEW_STUDENT (ID, NAME, SCORE) VALUES (6, 'Anna', 80);

-- NEW_DEPARTMENT 테이블 생성
CREATE TABLE NEW_DEPARTMENT (
      DEPT_ID NUMBER PRIMARY KEY
    , MIN_SCORE NUMBER
    , MAX_SCORE NUMBER
    , GRADE VARCHAR2(2)
);

-- NEW_DEPARTMENT 테이블에 데이터 삽입
INSERT INTO NEW_DEPARTMENT (DEPT_ID, MIN_SCORE, MAX_SCORE, GRADE) VALUES (1, 90, 100, 'A');
INSERT INTO NEW_DEPARTMENT (DEPT_ID, MIN_SCORE, MAX_SCORE, GRADE) VALUES (2, 80, 89, 'B');
INSERT INTO NEW_DEPARTMENT (DEPT_ID, MIN_SCORE, MAX_SCORE, GRADE) VALUES (3, 70, 79, 'C');
-------------------------------------

-- EQUI JOIN
SELECT
      S.ID
    , S.NAME
    , S.SCORE
    , D.DEPT_ID
    , D.GRADE
FROM
      NEW_STUDENT S
      JOIN NEW_DEPARTMENT D 
          ON S.SCORE = D.MIN_SCORE;

--Non EQUI JOIN
SELECT
      S.ID
    , S.NAME
    , S.SCORE
    , D.DEPT_ID
    , D.GRADE
FROM
      NEW_STUDENT S
      JOIN NEW_DEPARTMENT D
          ON S.SCORE 
          BETWEEN D.MIN_SCORE AND D.MAX_SCORE;

-- [TIP] ALIAS 사용 시 주의사항
-- ALIAS를 지정한 후에는 SQL 문 전체에서 일관되게 ALIAS를 사용해야 합니다. 
-- WHERE 절, SELECT 절, ORDER BY 절 등 모든 곳에서 원래 테이블 이름 대신 ALIAS를 사용해야 합니다. 
-- [잘못된 예]
SELECT
      EMPLOYEE.ENAME
    , d.DNAME
FROM
      EMPLOYEE e
    , DEPARTMENT d
WHERE
    e.DEPTNO = DEPARTMENT.DEPTNO ;

--[올바른 예] 
SELECT
      e.ENAME
    , d.DNAME
FROM
      EMPLOYEE e
    , DEPARTMENT d
WHERE
    e.DEPTNO = d.DEPTNO ;


-- ORDERS, EMPLOYEES, CUSTOMERS 테이블 JOIN 쿼리
SELECT
      O.ORDER_ID
    , O.ORDER_DATE
    , E.FIRST_NAME
    , E.LAST_NAME
    , C.NAME
    , C.ADDRESS
FROM
      ORDERS O
      JOIN EMPLOYEES E 
          ON O.SALESMAN_ID = E.EMPLOYEE_ID
      JOIN CUSTOMERS C 
          ON O.CUSTOMER_ID = C.CUSTOMER_ID;

-- NATURAL JOIN 형식은 다음과 같이 테이블만 지정하면 된다. 
SELECT
      *
FROM
      테이블A
      NATURAL JOIN 테이블B;

-- [참고] ◼ 공통된 칼럼명이 여러 개인 경우 예시 테이블 생성 쿼리 
-------------------------------------
-- 테이블A(주문) 생성
CREATE TABLE 테이블A (
      주문ID NUMBER PRIMARY KEY
    , 고객ID NUMBER
    , 날짜 DATE
    , 금액 NUMBER
    );

-- 테이블B(배송) 생성
CREATE TABLE 테이블B (
    배송ID NUMBER PRIMARY KEY
    , 주문ID NUMBER
    , 날짜 DATE
    , 상태 VARCHAR2(20)
    );

-- 테이블A에 데이터 삽입
INSERT INTO 테이블A (주문ID, 고객ID, 날짜, 금액) VALUES (1, 100, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 5000);
INSERT INTO 테이블A (주문ID, 고객ID, 날짜, 금액) VALUES (2, 101, TO_DATE('2024-01-02', 'YYYY-MM-DD'), 3000);
INSERT INTO 테이블A (주문ID, 고객ID, 날짜, 금액) VALUES (3, 102, TO_DATE('2024-01-03', 'YYYY-MM-DD'), 7000);

-- 테이블B에 데이터 삽입 
INSERT INTO 테이블B (배송ID, 주문ID, 날짜, 상태) VALUES (1, 1, TO_DATE('2024-01-03', 'YYYY-MM-DD'), '배송완료');
INSERT INTO 테이블B (배송ID, 주문ID, 날짜, 상태) VALUES (2, 2, TO_DATE('2024-01-04', 'YYYY-MM-DD'), '배송중');
INSERT INTO 테이블B (배송ID, 주문ID, 날짜, 상태) VALUES (3, 3, TO_DATE('2024-01-05', 'YYYY-MM-DD'), '준비중');
-------------------------------------

-- NATURAL JOIN 실행 
SELECT
      *
FROM
      테이블A
      NATURAL JOIN 테이블B;

-- JOIN 조건 사용 시 
SELECT
      *
FROM
      테이블A A
      JOIN 테이블B B 
          ON A.주문ID = B.주문ID;

-- EMP, DEPT 테이블에 NATURAL JOIN 대신 INNER JOIN 사용
-------------------------------------
SELECT
      *
FROM
      EMP A
      INNER JOIN DEPT B
          ON A.DEPTNO = B.DEPTNO;

-- USING 조건절에 공통 칼럼을 쓸 때는 다음 형식처럼 반드시 괄호로 묶어줘야 한다. 
SELECT
      *
FROM
      테이블A
      JOIN 테이블B
          USING (공통 칼럼);

-- EMP, DEPT 테이블 JOIN에 USING 조건절 사용
SELECT
      *
FROM
      EMP A
      JOIN DEPT B
          USING(DEPTNO);

-- ON 조건절 형식
SELECT
      별칭1.칼럼명
    , 별칭2.칼럼명
FROM
      테이블1 AS 별칭1
      JOIN 테이블2 AS 별칭2 
          ON 별칭1.칼럼명 = 별칭2.칼럼명 ;

-- USING 조건절 형식
SELECT
      *
FROM
      테이블A
      JOIN 테이블B
          USING (공통 칼럼);

-- CROSS JOIN 형식
SELECT
      *
FROM
      테이블A
      CROSS JOIN 테이블B;
  
  
SELECT SAL * 12 "연봉" FROM EMP;

-- end 























