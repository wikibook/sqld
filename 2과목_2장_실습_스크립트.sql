------------------------------------------------------
-- 2과목 
------------------------------------------------------

-- 2과목 2장 

-- 서브쿼리 

-- 메인쿼리 
SELECT
      칼럼1
    , 칼럼2
    , ...
FROM
      테이블
WHERE
      칼럼1 = 칼럼2;

--메인쿼리 내의 서브쿼리 
SELECT
      칼럼1
    , 칼럼2
    , ...
FROM
      테이블1
WHERE
      칼럼1 = 칼럼2
              ⇓
           = (
              SELECT 칼럼
                FROM 테이블2
               WHERE 조건
              );

--  WHERE 절에서의 단일행 서브쿼리 사용: 급여가 평균 이상인 사원 정보를 조회
SELECT 
      ENAME
    , SAL
FROM
      EMP
WHERE
      SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY 
      SAL DESC;

-- HAVING 절에서의 단일행 서브쿼리 사용: 부서의 평균 급여가 전체 평균 급여보다 높은 부서 조회
SELECT
      DEPTNO
    , AVG(SAL)
FROM
      EMP
GROUP BY
      DEPTNO
HAVING
      AVG(SAL) > (SELECT AVG(SAL) FROM EMP);

-- SELECT 절에서의 단일행 서브쿼리 사용: 각 행에서 전체 평균 급여를 함께 표시
SELECT
      ENAME
    , SAL
    , (SELECT AVG(SAL) FROM EMP) AS AVG_SAL
FROM
      EMP
ORDER BY 
      SAL DESC;

-- FROM 절에서의 단일행 서브쿼리 사용(인라인 뷰): 평균 급여를 FROM 절에서 조회하고 메인 쿼리에서 평균 급여보다 높은 급여를 받는 사원을 조회
SELECT
      E.ENAME
    , E.SAL
    , A.AVG_SAL
FROM
       EMP E
    , (SELECT AVG(SAL) AS AVG_SAL FROM EMP) A
WHERE
       E.SAL > A.AVG_SAL
ORDER BY 
      SAL DESC;

-- 서브쿼리 내부에 칼럼이 많을 경우
SELECT
      E.ENAME
    , E.SAL
    , A.AVG_SAL
FROM
     EMP E
    , (
       SELECT 
             ENAME
           , JOB
           , SAL
           , AVG(SAL) AS AVG_SAL
       FROM
             EMP
       ) A
WHERE
      E.SAL > A.AVG_SAL
ORDER BY 
      SAL DESC;

-- INSERT 문에서의 단일행 서브쿼리 사용: 새 사원을 추가할 때 자동으로 다음 사원 번호를 생성
INSERT INTO EMP (
      EMPNO
    , ENAME
    , SAL)
VALUES (
      (SELECT MAX(EMPNO) + 1 FROM EMP)
    , 'NEW_EMP'
    , 3000
       );

-- 신규 칼럼 추가하는 SQL
ALTER TABLE EMP 
    ADD NEW_SAL NUMBER(7,2);

-- SALES 부서의 모든 사원의 급여를 10% 인상하고 NEW_SAL에 값 입력
-- EMP테이블의 DEPTNO=30으로 해도 되지만, 여기서는 업데이트문에서 서브쿼리 예제이므로 WHERE 절에 서브쿼리를 사용함
UPDATE EMP
   SET SAL = SAL * 1.1
 WHERE DEPTNO = (
                SELECT DEPTNO 
                  FROM DEPT 
                 WHERE DNAME = 'SALES'
                );

-- 업데이트 후 조회
SELECT
      E.EMPNO 
    , E.ENAME 
    , E.DEPTNO 
    , D.DNAME
    , E.SAL 
    , E.NEW_SAL
FROM
      EMP E
      JOIN DEPT D 
          ON E.DEPTNO = D.DEPTNO 
WHERE
      D.DNAME = 'SALES';

-- DELETE 문에서의 사용: 평균 급여 미만을 받는 모든 사원을 삭제
- 실제 데이터를 삭제하는 것이므로 주의가 필요하다. 실제 데이터 삭제 후에는 EMP 테이블을 다시 생성해준다 
DELETE
FROM
      EMP
WHERE
      SAL < (SELECT AVG(SAL) FROM EMP);
 
-- [쿼리 수행 전] - EMP 테이블에 AVG 칼럼을 추가해서 누가 평균 미만의 SAL(급여)를 받는지 확인
SELECT
      ENAME
    , SAL
    , (SELECT AVG(SAL) FROM EMP) AVG 
FROM 
      EMP
ORDER BY 
      EMPNO DESC;
 
-- 스칼라 서브쿼리(칼럼 대신 값을 반환): 각 사원의 부서 이름을 함께 조회
SELECT
      ENAME
    , SAL
    , (
      SELECT DNAME
        FROM DEPT
       WHERE DEPT.DEPTNO = EMP.DEPTNO
      ) AS DEPT_NAME
FROM
      EMP
ORDER BY 
      EMPNO DESC;

-- 상관 서브쿼리: 메인 쿼리의 각 행에 의존하여 실행되는 형태의 서브쿼리다. 
-- 각 사원의 급여가 자신이 속한 부서의 평균 급여보다 높은 경우를 조회
SELECT
      ENAME,
      DEPTNO, 
      SAL
FROM
      EMP E1
WHERE
      SAL > (
             SELECT AVG(SAL)
               FROM EMP E2
              WHERE E1.DEPTNO = E2.DEPTNO
             )
ORDER BY 
      EMPNO DESC;

-- CASE 문에서의 사용: 각 사원의 급여가 평균 이상인지 미만인지 표시
SELECT
      ENAME
    , SAL
    , CASE 
          WHEN SAL > (SELECT AVG(SAL) FROM EMP) 
          THEN 'Above Average' 
          ELSE 'Below Average'
      END AS SALARY_STATUS
FROM
      EMP;
    
-- IN: 서브쿼리가 반환한 여러 행 중 하나라도 일치하면 조건을 만족. 예) 부서 위치가 뉴욕에 있는 사원의 정보를 조회
SELECT
      ENAME
    , DEPTNO
FROM
      EMP
WHERE
      DEPTNO IN (
                 SELECT DEPTNO
                   FROM DEPT
                  WHERE LOC = 'NEW YORK'
                 );

-- [쿼리 수행 전] - EMP 테이블과 DEPT 테이블을 DEPTNO로 조인하여 DNAME과 LOC를 조회
SELECT
      A.ENAME
    , A.DEPTNO
    , B.DNAME
    , B.LOC
FROM
      EMP A
    , DEPT B
WHERE
      A.DEPTNO = B.DEPTNO;

--  ANY 또는 SOME: 서브쿼리가 반환한 여러 행 중 하나라도 일치하면 조건을 만족. 
-- 예) 10번 부서에 속한 어떤 직원의 급여보다 더 높은 급여를 받는 사원을 조회
SELECT
      ENAME
    , SAL
FROM
      EMP
WHERE
      SAL > ANY (
                 SELECT SAL
                   FROM EMP
                  WHERE DEPTNO = 10
                 );

-- ALL: 서브쿼리가 반환한 모든 행이 조건을 만족. 예) 20번 부서에 속한 모든 직원의 급여보다 더 높은 급여를 받는 사원을 조회
-------------------------------------
SELECT
      ENAME
    , SAL
FROM
      EMP
WHERE
      SAL > ALL (
                 SELECT SAL
                   FROM EMP
                  WHERE DEPTNO = 20
                 );
   
-- EXISTS: 서브쿼리가 한 행이라도 반환하면 조건을 만족. 
-- 예) 두 테이블에서 동일한 부서이면서 부서의 위치가 'DALLAS'인 사원명과 부서번호를 조회
SELECT
      ENAME
    , DEPTNO
FROM
      EMP E
WHERE
      EXISTS (
              SELECT 1
                FROM DEPT D
               WHERE D.DEPTNO = E.DEPTNO
                     AND D.LOC = 'DALLAS'
             );
   
-- IN 연산자와 다중칼럼 서브쿼리: 
-- SAL이 3000보다 큰 직원들의 JOB과 DEPTNO를 서브쿼리로 찾고, 그 JOB과 DEPTNO를 가진 EMP 테이블의 직원들을 조회
SELECT
      ENAME
    , JOB
    , DEPTNO
FROM
      EMP
WHERE
      (JOB, DEPTNO) IN (
                        SELECT JOB, DEPTNO
                          FROM EMP
                         WHERE SAL > 3000
                       );
      
-- EXISTS 연산자와 다중칼럼 서브쿼리: 서브쿼리가 한 행이라도 반환하면 조건을 만족. 
-- 예) 'DALLAS'에 위치한 부서에 속한 모든 직원의 이름과 사원 번호를 조회
SELECT
      ENAME
    , DEPTNO
FROM
      EMP E
WHERE
      EXISTS (
              SELECT 1
                FROM DEPT D
               WHERE D.DEPTNO = E.DEPTNO
                 AND D.LOC = 'DALLAS'
             );

-- 연관 서브쿼리 #1: 각 직원의 급여가 동일한 부서의 평균 급여보다 높은 직원을 조회
SELECT
      ENAME
    , SAL
    , DEPTNO
FROM
      EMP E1
WHERE
      SAL > (
             SELECT AVG(SAL) 
               FROM EMP E2
              WHERE E1.DEPTNO = E2.DEPTNO
            );

-- 연관 서브쿼리 #2: 각 부서에서 가장 최근에 고용된 직원 조회
SELECT
      ENAME
    , HIREDATE
    , DEPTNO
FROM
      EMP E1
WHERE
      HIREDATE = (
                   SELECT MAX(HIREDATE)
                     FROM EMP E2
                    WHERE E1.DEPTNO = E2.DEPTNO
                 );

-- 뷰(View) 형식: SELECT 문을 기본으로 하며, 가장 첫 줄에 CREATE VIEW를 적고 뷰 이름을 지정하면 끝이다.  
CREATE VIEW 뷰이름 
SELECT
      칼럼1
    , 칼럼2
    , ...
FROM
      테이블
WHERE
      조건;

-- 뷰(View)의 예: 부서의 지역(LOC)이 ‘CHICAGO’인 부서의 직원 정보를 포함하는 뷰 생성
CREATE VIEW EMP_DEPT_VIEW AS
SELECT
      E.ENAME
    , E.JOB
    , D.DNAME
    , D.LOC
FROM
      EMP E
      JOIN DEPT D 
          ON E.DEPTNO = D.DEPTNO
WHERE
      D.LOC = 'CHICAGO';

-- 2. 집합 연산자

-- UNION 예
SELECT
      DEPTNO
    , DNAME
FROM
      DEPT
UNION 
SELECT
      DEPTNO
    , JOB
FROM
      EMP;

-- UNION ALL 예
SELECT
      DEPTNO
    , DNAME
FROM
      DEPT
UNION ALL
SELECT
      DEPTNO
    , JOB
FROM
      EMP; 

-- INTERSECT 예
SELECT
      DEPTNO
FROM
      EMP
INTERSECT
SELECT
      DEPTNO
FROM
      DEPT;

--  MINUS/EXCEPT 예
SELECT
      DEPTNO
FROM
      EMP
MINUS
SELECT
      DEPTNO
FROM
      DEPT;
  
-- 3. 그룹 함수

-- 다음의 예를 보면서 ROLLUP 함수의 원리를 알아보자     . 
SELECT
      DEPTNO
    , JOB
    , SUM(SAL) AS TOTAL_SALARY
FROM
      EMP
GROUP BY
      ROLLUP(DEPTNO, JOB)
ORDER BY
      DEPTNO;

-- [ROLLUP 적용 전: GROUP BY 적용]
SELECT
      DEPTNO
    , JOB
    , SUM(SAL) AS TOTAL_SALARY
FROM
      EMP
GROUP BY
      DEPTNO, JOB
ORDER BY
      DEPTNO;

-- CUBE 함수는 GROUP BY 뒤에 간단히 CUBE(칼럼명#1, 칼럼명#2, 칼럼명#3, …)을 적으면 된다. 
-- 형식은 ROLLUP 함수와 같다. 
SELECT
      DEPTNO
    , JOB
    , SUM(SAL) AS TOTAL_SALARY
FROM
      EMP
GROUP BY
      CUBE(DEPTNO, JOB)
ORDER BY
      DEPTNO;

-- GROUPING SETS 함수
SELECT 칼럼1, 칼럼2, ..., 집계 함수(칼럼)
  FROM 테이블
GROUP BY 
    GROUPING SETS (                   -- GROUPING SETS 함수 선언: 괄호로 묶음
                    (칼럼1, 칼럼2),   -- 칼럼1과 칼럼2 = 하나의 그룹별 합계
                    (칼럼1),          -- 칼럼1별 합계
                    (칼럼2),          -- 칼럼2별 합계
                    ()                -- 전체 합계
                   );

-- GROUPING SETS 함수의 예     
SELECT
      DEPTNO
    , JOB
    , SUM(SAL) AS TOTAL_SALARY
FROM
      EMP
GROUP BY
      GROUPING SETS (
                      (DEPTNO, JOB)
                    , (DEPTNO)
                    , (JOB)
                    , ()
                     )
ORDER BY DEPTNO, JOB;

--  GROUPING 함수 형식
-- GROUPING 함수는 SELECT 절에서 사용하며, 괄호로 칼럼명을 묶어준다.  
SELECT
      DEPTNO
    , JOB
    , SUM(SAL) AS TOTAL_SALARY
    , GROUPING(DEPTNO) AS DEPT_GROUPING
    , GROUPING(JOB) AS JOB_GROUPING
FROM
      EMP
GROUP BY
      GROUPING SETS (
                     (DEPTNO, JOB)
                   , (DEPTNO)
                   , (JOB)
                   , ()
                    )
ORDER BY 
      DEPTNO
    , JOB;
      
-- ROLLUP, GROUPING, CASE 함수를 함께 사용한 예
SELECT 
      DEPTNO
    , JOB
    , SUM(SAL) AS TOTAL_SALARY
    , GROUPING(DEPTNO) DEPTNO_GROUP
    , GROUPING(JOB) JOB_GROUP
    , CASE
        WHEN GROUPING(DEPTNO) = 1 AND GROUPING(JOB) = 1 THEN 'TOTAL_SUM'
        WHEN GROUPING(DEPTNO) = 0 AND GROUPING(JOB) = 1 THEN 'DEPT_GROUPING'
        WHEN GROUPING(JOB) = 0 AND GROUPING(DEPTNO) = 0 THEN 'DEPT_JOB_GROUPING'
    END AS GROUPING_LEVEL
FROM 
      EMP
GROUP BY ROLLUP(DEPTNO, JOB) 
ORDER BY DEPTNO, JOB;

-- DECODE 함수 형식
DECODE(expression, search1, result1, search2, result2, ..., default)

-- CASE 문 예
CASE
WHEN GROUPING(DEPTNO) = 1 AND GROUPING(JOB) = 1 THEN 'TOTAL_SUM'
        WHEN GROUPING(DEPTNO) = 0 AND GROUPING(JOB) = 1 THEN 'DEPT_GROUPING'
        WHEN GROUPING(JOB) = 0 AND GROUPING(DEPTNO) = 0 THEN 'DEPT_JOB_GROUPING'
END AS GROUPING_LEVEL

-- 위 CASE 문과 동일한 DECODE 함수 예
DECODE(
         GROUPING(DEPTNO) + GROUPING(JOB)
       , 2 , 'TOTAL_SUM'
       , 1 , DECODE(GROUPING(DEPTNO), 1, 'JOB_GROUPING', 'DEPT_GROUPING')
       , 0 , 'DEPT_JOB_GROUPING'
       ) AS GROUPING_LEVEL

-- 4. 윈도우 함수
       
-- 윈도우 함수의 형식
SELECT
      WINDOW_FUNCTION(ARGUMENTS) 
      OVER ([PARTITION BY 칼럼] [ORDER BY 절] [WINDOWING 절])
FROM
      테이블명;

-- 윈도우 함수의 예
SELECT 
      E.EMPNO 
    , E.ENAME 
    , E.DEPTNO 
    , D.DNAME
    , E.SAL
    , ROW_NUMBER() OVER(
                        PARTITION BY E.DEPTNO 
                        ORDER BY E.SAL DESC
                        ) AS SALARY_RANK
FROM 
      EMP E
      JOIN DEPT D 
          ON E.DEPTNO = D.DEPTNO;

-- ROW_NUMBER() 형식
ROW_NUMBER() OVER (PARTITION BY [파티션 기준] ORDER BY [정렬 기준])

-- ROW_NUMBER() 예시 #1: 전체 행에 대해 급여(SAL)가 높은 순으로 순위를 매기는 함수(PARTITION BY 옵션 지정 안함) 
SELECT 
      DEPTNO
    , ENAME
    , SAL
    , ROW_NUMBER() OVER (
                        ORDER BY SAL DESC
                        ) AS RANK
FROM 
      EMP;

-- ROW_NUMBER() 함수에서 동일한 순위를 해결하는 방법: ORDER BY 절에 추가로 칼럼을 지정
ROW_NUMBER() OVER (PARTITION BY [파티션 기준] ORDER BY [정렬 기준#1], [정렬 기준#2], … )

-- ORDER BY 타이브레이커(tie-breaker) 예시
SELECT 
      DEPTNO
    , ENAME
    , SAL
    , ROW_NUMBER() OVER (
                        ORDER BY SAL DESC, ENAME DESC
                        ) AS RANK
FROM 
      EMP;

-- ROW_NUMBER() 예시 #2: 부서별로 구분하고, 부서별로 급여(SAL)가 높은 순으로 순위를 매기는 함수(PARTITION BY 옵션 지정) 
SELECT 
      DEPTNO
    , ENAME
    , SAL
    , ROW_NUMBER() OVER (
                        PARTITION BY DEPTNO 
                        ORDER BY SAL DESC
                        ) AS RANK
FROM 
      EMP;

-- ROW_NUMBER() 예시 #3: 특정 부서에 대해서만 급여(SAL) 값이 높은 순으로 순위를 매기는 함수(WHERE 절에서 특정 부서의 조건을 정의) 
SELECT 
      DEPTNO
    , ENAME
    , SAL
    , ROW_NUMBER() OVER (
                        ORDER BY SAL DESC
                        ) AS RANK
FROM 
      EMP 
WHERE 
      DEPTNO = 30;

-- RANK() 형식
RANK() OVER (PARTITION BY [파티션 기준] ORDER BY [정렬 기준])

-- RANK()의 예시
SELECT
      DEPTNO
    , ENAME
    , SAL
    , RANK() OVER (
                   ORDER BY SAL DESC
                   ) AS RANK
FROM
      EMP;

-- DENSE_RANK() 형식
DENSE_RANK() OVER (PARTITION BY [파티션 기준] ORDER BY [정렬 기준])

-- DENSE_RANK()의 예시
SELECT
      DEPTNO
    , ENAME
    , SAL
    , DENSE_RANK() OVER (
                        ORDER BY SAL DESC
                        ) AS RANK
FROM
      EMP;

-- SUM()
SUM(COALESCE(column_name, 0))
SUM(NVL(column_name, 0))

-- SUM()의 예시
SELECT
      DEPTNO
    , SUM(SAL) AS DEPT_SAL_SUM
FROM
      EMP
GROUP BY
      DEPTNO;

-- NULL 값을 0으로 처리하고 싶다면, 다음과 같이 COALESCE 또는 NVL 함수를 사용해 바꿀 수 있다. 
SELECT
      DEPTNO
    , SUM(COALESCE(SAL, 0)) AS DEPT_SAL_SUM
FROM
      EMP
GROUP BY
      DEPTNO;

SELECT
      DEPTNO
    , SUM(NVL(SAL, 0)) AS DEPT_SAL_SUM
FROM
      EMP
GROUP BY
      DEPTNO;

-- [EMP 테이블]
SELECT
      DEPTNO
    , ENAME
    , SAL
    , COMM
    , COALESCE(COMM, 0) AS IF_COMM_NULL_0
FROM
      EMP
ORDER BY
      DEPTNO
    , ENAME ;

SELECT
      DEPTNO
    , AVG(COALESCE(COMM, 0)) AS COMM_AVG
FROM
      EMP
GROUP BY
      DEPTNO;

SELECT
      DEPTNO
    , AVG(COMM) AS COMM_AVG
FROM
      EMP
GROUP BY
      DEPTNO;

-- [COUNT(*)는 NULL을 포함]
SELECT
      COUNT(*) AS TOTAL_SAL
FROM
      EMP;

-- [특정 칼럼의 COUNT()는 기본적으로 NULL을 제외]
SELECT
      COUNT(COMM) AS TOTAL_SAL
FROM
      EMP;

-- [특정 칼럼의 NULL을 포함해서 COUNT하고 싶을 때]
SELECT
      COUNT(COALESCE(COMM, 0)) AS TOTAL_SAL
FROM
      EMP;

-- MAX()의 예시
SELECT
      DEPTNO
    , MAX(SAL) AS MAX_SAL
FROM
      EMP
GROUP BY
      DEPTNO
ORDER BY
      DEPTNO DESC;

-- MIN()의 예시
SELECT
      DEPTNO
    , MIN(SAL) AS MIN_SAL
FROM
      EMP
GROUP BY
      DEPTNO
ORDER BY
      DEPTNO;

-- ‘집계 함수 + OVER’ 예시
SELECT
      EMPNO
    , DEPTNO
    , ENAME
    , SAL
    , AVG(SAL) OVER (
                     PARTITION BY DEPTNO
                     ORDER BY DEPTNO
                     ) AS DEPT_SAL_AVG
FROM
      EMP;

-- LAG() 함수 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , LAG(SAL, 1, 0) OVER (
                           ORDER BY EMPNO
                           ) AS PRE_SAL
FROM
      EMP;

-- LEAD() 함수 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , LEAD(SAL, 1, 0) OVER (
                            ORDER BY EMPNO
                            ) AS NEXT_SAL
FROM
      EMP;

-- FIRST_VALUE() 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , FIRST_VALUE(SAL) OVER (
                             PARTITION BY DEPTNO
                             ORDER BY EMPNO
                             ) AS DEPT_FIRST_SAL
FROM
      EMP;

-- LAST_VALUE() 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , LAST_VALUE(SAL) OVER (
                             PARTITION BY DEPTNO
                             ORDER BY EMPNO
                             ) AS DEPT_LAST_VALUE
FROM
      EMP;

-- LAST_VALUE() 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , LAST_VALUE(SAL) OVER (
                             PARTITION BY DEPTNO
                             ORDER BY EMPNO
                             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                            ) AS DEPT_LAST_VALUE
FROM
      EMP;

-- NTH_VALUE() 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , NTH_VALUE(SAL, 2) OVER (
                               PARTITION BY DEPTNO
                               ORDER BY EMPNO 
                               ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                               ) AS SECOND_SAL
FROM
      EMP;

-- CUME_DIST() 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , CUME_DIST() OVER (
                         PARTITION BY DEPTNO
                         ORDER BY SAL
                         ) AS DEPT_CUME_DIST
FROM
      EMP;

-- PERCENT_RANK() 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , PERCENT_RANK() OVER (
                            PARTITION BY DEPTNO
                            ORDER BY SAL
                            ) AS DEPT_PERCENT_RANK
FROM
      EMP;

-- NTILE(n) 예시
SELECT
      DEPTNO
    , EMPNO
    , ENAME
    , SAL
    , NTILE(3) OVER (
                      PARTITION BY DEPTNO
                      ORDER BY SAL
                      ) AS DEPT_NTILE
FROM
      EMP;

-- 5. Top N 쿼리

-- ROWNUM 예시
SELECT
      ROWNUM
    , EMPNO
    , ENAME
    , SAL
FROM
      (
      SELECT
            EMPNO
          , ENAME
          , SAL
      FROM
            EMP
      ORDER BY
            SAL DESC
      );

-- TOP 절 예시
SELECT
      TOP (3) EMPNO
    , ENAME
    , SAL
FROM
      EMP
WHERE
      DEPTNO = 20
ORDER BY
      SAL DESC;

-- FETCH FIRST를 사용한 ROW LIMITING 절 예시
SELECT
      EMPNO
    , ENAME
    , SAL
FROM
      EMP
ORDER BY
      SAL DESC
FETCH FIRST 5 ROWS ONLY;

-- OFFSET를 사용한 ROW LIMITING 절 사용 예시
SELECT
      EMPNO
    , ENAME
    , SAL
FROM
      EMP
ORDER BY
      SAL DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;


-- 6. 셀프 조인과 계층형 질의

-- 자신의 MGR(매니저) 찾기
SELECT
      e1.EMPNO AS EmployeeID
    , e1.ENAME AS Employee_Name
    , e2.EMPNO AS ManagerID
    , e2.ENAME AS Manager_Name
FROM
      EMP e1
      LEFT OUTER JOIN EMP e2 
          ON e1.MGR = e2.EMPNO;

-- 오라클에서의 계층형 질의 형식
SELECT
      칼럼#1
    , 칼럼#2
    , ...
FROM
      테이블명
START WITH 
      조건#1 → 계층 구조의 시작점
CONNECT BY [PRIOR] 
      조건#2 → 부모-자식 관계를 정의하여 계층 구조를 연결하는 조건
ORDER SIBLINGS BY 
      칼럼명 [ ASC | DESC ];  → 형제 노드를 정렬하는 기준



-- 기본적인 계층형 질의 예시 
SELECT
      EMPNO
    , ENAME
    , MGR
    , LEVEL
FROM
      EMP
START WITH
      MGR IS NULL
CONNECT BY  
      PRIOR EMPNO = MGR
ORDER BY
      LEVEL;

-- ‘SYS_CONNECT_BY_PATH’ 계층형 질의 예시 
SELECT
      EMPNO
    , ENAME
    , MGR
    , LEVEL
    , SYS_CONNECT_BY_PATH(ENAME, '/') AS PATH
FROM
      EMP
START WITH
      MGR IS NULL
CONNECT BY 
      PRIOR EMPNO = MGR
ORDER BY
      LEVEL ;

-- ‘CONNECT_BY_ROOT’ 계층형 질의 예시 
SELECT
      CONNECT_BY_ROOT ENAME AS root_manager
    , SYS_CONNECT_BY_PATH(ENAME, '/') AS PATH
    , EMPNO
    , ENAME
    , MGR
    , LEVEL
FROM
      EMP
START WITH
      MGR IS NULL
CONNECT BY PRIOR 
      EMPNO = MGR;

-- ‘ORDER SIBLINGS BY’ 계층형 질의 예시 
SELECT
      EMPNO
    , ENAME
    , MGR
    , LEVEL
FROM
      EMP
START WITH
      MGR IS NULL
CONNECT BY PRIOR 
      EMPNO = MGR
ORDER SIBLINGS BY 
      ENAME;

-- ‘CONNECT_BY_ISLEAF’ 순방향 전개 계층형 질의 예시 
SELECT
      LEVEL
    , EMPNO
    , ENAME
    , MGR
    , CONNECT_BY_ISLEAF AS ISLEAF
FROM
      EMP
START WITH
      MGR IS NULL
CONNECT BY
      PRIOR EMPNO = MGR ;

-- ‘CONNECT_BY_ISLEAF’ 역방향 전개 계층형 질의 예시 
SELECT
      LEVEL
    , EMPNO
    , ENAME
    , MGR
    , CONNECT_BY_ISLEAF AS ISLEAF
FROM
      EMP
START WITH
      EMPNO = 7876
CONNECT BY
      EMPNO = PRIOR MGR;

-- 7. PIVOT 절과 UNPIVOT 절

-- PIVOT 절 형식
SELECT
      칼럼명
FROM 
      (
      SELECT
            [피벗할 원본 칼럼]
      FROM
            [피벗할 원본 테이블]
      ) AS [원본 테이블 별칭]
PIVOT ( 
      집계 함수( [집계할 칼럼] )
      FOR [피벗 완료된 칼럼명] IN ( [피벗할 칼럼들의 값] … )
      ) AS [피벗 테이블 별칭];

-- PIVOT 절 예시
SELECT
      *
FROM
      (
      SELECT
            DEPTNO
          , JOB
          , EMPNO
      FROM
            EMP
      ) 
PIVOT (
      COUNT(EMPNO)
      FOR JOB IN ('CLERK', 'SALESMAN', 'MANAGER', 'ANALYST', 'PRESIDENT')
      );

-- 먼저 FROM 절의 서브쿼리를 수행해보자. 그러면 다음과 같은 테이블이 조회된다. 
SELECT
      DEPTNO
    , JOB
    , EMPNO
FROM
      EMP;

-- UNPIVOT 절 형식
SELECT
      칼럼명
FROM
      (
      SELECT
            [피벗할 원본 칼럼]
      FROM
            [피벗할 원본 테이블]
      ) AS [원본 테이블 별칭]
UNPIVOT ( 
      [언피벗할 칼럼]
      FOR [피벗할 칼럼명] IN ( [반환할 칼럼#1], [반환할 칼럼#2] … )
      ) AS [언피벗 테이블 별칭];


-- 임의의 PIVOT ‘EMP_PIVOT’ 테이블 생성
CREATE TABLE EMP_PIVOT AS
SELECT
      *
FROM
      (
      SELECT
            JOB
          , DEPTNO
          , SAL
      FROM
            EMP
      WHERE
            JOB IN ('CLERK', 'MANAGER')
      )
PIVOT (
      SUM(SAL) AS SAL
    , COUNT(*) AS CNT
      FOR DEPTNO IN (10 AS DEPT10_ACCOUNTING
    , 20 AS DEPT20_RESEARCH)
      );

-- EMP_PIVOT 테이블을 UNPIVOT하기 
SELECT
      JOB
    , DEPTNO
    , SAL
FROM
      EMP_PIVOT
UNPIVOT (
      SAL FOR DEPTNO IN (DEPT10_ACCOUNTING_SAL, DEPT20_RESEARCH_SAL)
        )
ORDER BY
      JOB
    , DEPTNO;

-- 8. 정규표현식

-- . → dot 연산자 예시
SELECT 
      REGEXP_SUBSTR ('aab', 'a.b') AS C1
    , REGEXP_SUBSTR ('abb', 'a.b') AS C2
    , REGEXP_SUBSTR ('acb', 'a.b') AS C3
    , REGEXP_SUBSTR ('adc', 'a.b') AS C4
FROM DUAL; 

-- | → or 연산자 예시
SELECT 
      REGEXP_SUBSTR('apple', 'a|e') AS C1
    , REGEXP_SUBSTR('banana', 'a|b') AS C2
    , REGEXP_SUBSTR('abcdef', 'ab|cd') AS C3
    , REGEXP_SUBSTR('cdefgh', 'ab|cd') AS C4
FROM 
      DUAL;

-- ＼ (\) → backslash 연산자 예시
-------------------------------------
SELECT   
      REGEXP_SUBSTR('a.b', 'a\.b') AS C1
    , REGEXP_SUBSTR('aab', 'a\.b') AS C2
    , REGEXP_SUBSTR('a\\b', 'a\\\\b') AS C3
    , REGEXP_SUBSTR('a\b', 'a\\\\b') AS C4
FROM 
      DUAL;

-- ^, $ → 앵커(anchor) 연산자 예시
-- ^: 문자열의 시작을 의미(^는 꺽쇠 또는 캐럿(carrot)이라 부른다)     
-- $: 문자열의 끝을 의미(달러(dollar) 또는 스트링이라고 부른다)
SELECT 
      REGEXP_SUBSTR('apple', '^a') AS C1
    , REGEXP_SUBSTR('banana', '^a') AS C2
    , REGEXP_SUBSTR('apple pie', '^apple') AS C3
    , REGEXP_SUBSTR('apple', 'e$') AS C4
    , REGEXP_SUBSTR('banana', 'a$') AS C5
    , REGEXP_SUBSTR('apple pie', 'pie$') AS C6
    , REGEXP_SUBSTR('apple', '^apple$') AS C7
    , REGEXP_SUBSTR('apple pie', '^apple$') AS C8
    , REGEXP_SUBSTR('apple', '^a.*e$') AS C9
FROM 
      DUAL;

-- 수량자(quantifier) 연산자의 예시
SELECT 
      REGEXP_SUBSTR('ac', 'ab*c') AS C1 
    , REGEXP_SUBSTR('abc', 'ab*c') AS C2
    , REGEXP_SUBSTR('abbc', 'ab*c') AS C3
    , REGEXP_SUBSTR('ac', 'ab+c') AS C4 
    , REGEXP_SUBSTR('abc', 'ab+c') AS C5
    , REGEXP_SUBSTR('abbc', 'ab+c') AS C6
    , REGEXP_SUBSTR('ac', 'ab?c') AS C7
    , REGEXP_SUBSTR('abc', 'ab?c') AS C8
    , REGEXP_SUBSTR('abbc', 'ab?c') AS C9
FROM
      DUAL;

-- 중괄호 수량자(quantifier) 연산자의 예시
SELECT 
      REGEXP_SUBSTR('aaa', 'a{3}') AS C1 
    , REGEXP_SUBSTR('aaaa', 'a{3}') AS C2
    , REGEXP_SUBSTR('aaa', 'a{2,}') AS C3
    , REGEXP_SUBSTR('aaa', 'a{2,4}') AS C4
    , REGEXP_SUBSTR('aaaaa', 'a{2,4}') AS C5
FROM 
      DUAL;

-- ( ) → 괄호 연산자 예시
SELECT 
      REGEXP_SUBSTR('ababab', '(ab)+') AS C1  
    , REGEXP_SUBSTR('abcdabcd', '(ab)(cd) ＼1＼2') AS C2
    , REGEXP_SUBSTR('abcabc', '(abc){2}') AS C3  
FROM
      DUAL;
 
-- 문자 리스트 연산자 예시
SELECT 
      REGEXP_SUBSTR('apple', '[abc]') AS C1  
    , REGEXP_SUBSTR('cat', '[a-c]') AS C2
    , REGEXP_SUBSTR('zip code 12345', '[0-9]') AS C3  
    , REGEXP_SUBSTR('cherry', '[^abc]') AS C3
FROM 
      DUAL;
 
-- PERL 정규표현식 연산자 예시
SELECT 
      REGEXP_SUBSTR('abc123', '＼d') AS C1                       -- 1번: ＼d 사용
    , REGEXP_SUBSTR('abc123', '[[:digit:]]') AS C2               -- 1번: [[:digit:]] 사용
    , REGEXP_SUBSTR('123abc', '＼D') AS C3                       -- 2번: ＼D 사용
    , REGEXP_SUBSTR('123abc', '[^[:digit:]]') AS C4             -- 2번: [^[:digit:]] 사용
    , REGEXP_SUBSTR('Hello_World123!', '＼w') AS C5                 -- 3번: ＼w 사용
    , REGEXP_SUBSTR('Hello_World123!', '[[:alnum:]_]') AS C6     -- 3번: [[:alnum:]_] 사용
    , REGEXP_SUBSTR('Hello_World123!', '＼W') AS C7               -- 4번: ＼W 사용
    , REGEXP_SUBSTR('Hello_World123!', '[^[:alnum:]_]') AS C8   -- 4번: [^[:alnum:]_] 사용
    , REGEXP_SUBSTR('Hello World', '＼s') AS C9                      -- 5번: ＼s 사용
    , REGEXP_SUBSTR('Hello World', '[[:space:]]') AS C10          -- 5번: [[:space:]] 사용
    , REGEXP_SUBSTR('Hello World', '＼S') AS C11                     -- 6번: ＼S 사용
    , REGEXP_SUBSTR('Hello World', '[^[:space:]]') AS C12        -- 6번: [^[:space:]] 사용
FROM 
     DUAL;

-- 특정 패턴을 포함하는 행 찾기
SELECT
      ENAME
    , JOB
FROM
      EMP
WHERE
      REGEXP_LIKE(ENAME, '^A');
    
-- 대소문자를 구분하지 않고 패턴 일치
SELECT
      ENAME
    , JOB
FROM
      EMP
WHERE
      REGEXP_LIKE(ENAME, 'smith', 'i');

-- 숫자를 포함하는 행 찾기
SELECT
      ENAME
    , JOB
    , SAL
    , COMM
FROM
      EMP
WHERE
      REGEXP_LIKE(COMM, '\d');

-- 특정 형식의 패턴 찾기
SELECT
      LAST_NAME
    , EMAIL
    , PHONE
FROM
      EMPLOYEES
WHERE
      REGEXP_LIKE(PHONE, '^\d{3}.\d{3}.\d{4}$')
      AND ROWNUM <= 5;

-- 공백 또는 탭 문자를 포함하는 행 찾기
SELECT
      PRODUCT_NAME
    , DESCRIPTION
    , LIST_PRICE
FROM
      PRODUCTS
WHERE
      REGEXP_LIKE(PRODUCT_NAME, '\s')
      AND ROWNUM <= 5;

-- 특정 패턴을 다른 문자열로 대체
SELECT
      REGEXP_REPLACE('123abc456def', '\d', '#') AS RESULT
FROM
      DUAL;

-- 여러 개의 공백을 하나의 공백으로 대체
SELECT
      REGEXP_REPLACE('Hello   World   SQL', '\s+', ' ') AS RESULT
FROM
      DUAL;

-- 대소문자 구분 없이 문자열 대체
SELECT
      REGEXP_REPLACE('Hello World', 'world', 'Universe', 1, 0, 'i') AS RESULT
FROM
      DUAL;

-- 전화번호 형식 변환
SELECT 
      REGEXP_REPLACE('123-456-7890', '(\d{3})-(\d{3})-(\d{4})', '(\1) \2-\3') AS RESULT
FROM 
      DUAL;

-- 문자열에서 모든 숫자를 제거
SELECT
      REGEXP_REPLACE('Address 1234, ZIP 56789', '\d', '') AS RESULT
FROM
      DUAL;

-- REGEXP_INSTR 형식
REGEXP_INSTR
      (
        source_string
      , pattern [, position [, occurrence [, return_option [, match_parameter] ] ] ]
      )

-- REGEXP_INSTR 예시: 첫 번째 일치 위치 찾기
SELECT
      REGEXP_INSTR('오라클SQL Developer', 'SQL') AS RESULT
FROM
      DUAL;

-- REGEXP_INSTR 예시: 특정 위치에서 검색 시작
SELECT
      REGEXP_INSTR('SQL SQL SQL', 'SQL', 5) AS RESULT
FROM
      DUAL;

-- REGEXP_INSTR 예시: 여러 번째 일치 위치 찾기
SELECT 
    REGEXP_INSTR('SQL SQL SQL', 'SQL', 1, 2) AS RESULT
FROM 
    DUAL;

-- REGEXP_INSTR 예시: 대소문자 구분 없이 검색
SELECT 
     REGEXP_INSTR('오라클Sql Developer', 'sql', 1, 1, 0, 'i') AS RESULT
FROM 
    DUAL;

-- REGEXP_COUNT 함수 형식
REGEXP_COUNT(source_string, pattern [, position [, match_parameter]])

-- REGEXP_COUNT 함수 예시: 특정 패턴의 출현 횟수 계산
SELECT
      REGEXP_COUNT('abc123abc456abc', 'abc') AS RESULT
FROM
      DUAL;

-- REGEXP_COUNT 함수 예시: 숫자 패턴의 출현 횟수 계산
SELECT
      REGEXP_COUNT('abc123abc456abc789', '\d{3}') AS RESULT
FROM
      DUAL;

-- REGEXP_COUNT 함수 예시: 특정 위치에서 패턴의 출현 횟수 계산
SELECT
      REGEXP_COUNT('abc123abc456abc', 'abc', 5) AS RESULT
FROM
      DUAL;

-- REGEXP_COUNT 함수 예시: 대소문자 구분 없이 패턴의 출현 횟수 계산
SELECT
      REGEXP_COUNT('오라클SQL 오라클sql', 'oracle', 1, 'i') AS RESULT
FROM
      DUAL;


-----------------------------------------------
--2과목 2장 문제 16 보기 테이블 생성용 쿼리
CREATE TABLE SALES_2 (
    SALE_ID       NUMBER(10)     PRIMARY KEY, -- 판매 ID
    PRODUCT       VARCHAR2(50)   NOT NULL,    -- 제품 이름
    SALES_AMOUNT  NUMBER(10, 2)  NOT NULL     -- 판매 금액
);

INSERT INTO SALES_2 (SALE_ID, PRODUCT, SALES_AMOUNT) VALUES (1, 'Laptop', 500);
INSERT INTO SALES_2 (SALE_ID, PRODUCT, SALES_AMOUNT) VALUES (2, 'Tablet', 300);
INSERT INTO SALES_2 (SALE_ID, PRODUCT, SALES_AMOUNT) VALUES (3, 'Laptop', 700);
INSERT INTO SALES_2 (SALE_ID, PRODUCT, SALES_AMOUNT) VALUES (4, 'Tablet', 400);
------------------------------------------------
  
------------------------------------------------
--2과목 2장 문제 17 보기 테이블 생성용 쿼리
CREATE TABLE EMPLOYEE_SALARY (
    EMP_ID      NUMBER(10)     PRIMARY KEY, -- 직원 ID
    EMP_NAME    VARCHAR2(50)   NOT NULL,    -- 직원 이름
    JAN_SALARY  NUMBER(10, 2),              -- 1월 급여
    FEB_SALARY  NUMBER(10, 2),              -- 2월 급여
    MAR_SALARY  NUMBER(10, 2)               -- 3월 급여
);

INSERT INTO EMPLOYEE_SALARY (EMP_ID, EMP_NAME, JAN_SALARY, FEB_SALARY, MAR_SALARY) 
VALUES (1, '철수', 3000, 3200, 3100);

INSERT INTO EMPLOYEE_SALARY (EMP_ID, EMP_NAME, JAN_SALARY, FEB_SALARY, MAR_SALARY) 
VALUES (2, '영희', 2500, 2600, 2700);

INSERT INTO EMPLOYEE_SALARY (EMP_ID, EMP_NAME, JAN_SALARY, FEB_SALARY, MAR_SALARY) 
VALUES (3, '민수', 4000, 4200, 4100);
------------------------------------------------
  
-- end 



