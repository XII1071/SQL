--  JOIN : 수평적 결합으로 테이블 두 개를 붙인다.
-- 1.  JOIN 조건 없이 그냥 출력 ( EMP : 14개 / DEPT : 4개 )
-- 1-1. 데카르트 곱( 카테시안 곱 : CARTESIAN PRODUCT )
--      교차 조인 / 크로스 조인
SELECT
    *
FROM
    EMP,
    DEPT
ORDER BY
    EMPNO;

-- EMP와 DEPT 데이터 개 수 확인.
SELECT
    COUNT(*)
FROM
    EMP;

SELECT
    COUNT(*)
FROM
    DEPT;

-- 2. JOIN 조건 추가 ( 보통 두 테이블의 공통적인 컬럼을 엮는다 )
SELECT
    *
FROM
    EMP;

SELECT
    *
FROM
    DEPT;

SELECT
    *
FROM
    EMP,
    DEPT
WHERE
    EMP.DEPTNO = DEPT.DEPTNO -- 조인 조건
ORDER BY
    EMPNO;

-- 3. 테이블 별칭 지정 ( 테이블명 별칭명 ), 테이블 별칭 구분자는 공백이다.
-- 3-1. 하나의 테이블에만 있는 컬럼일 경우 테이블을 지정하지 않아도 된다.
SELECT
    ENAME,
    E.DEPTNO,
    DNAME
FROM
    EMP  E,
    DEPT D
WHERE
    E.DEPTNO = D.DEPTNO
ORDER BY
    E.EMPNO;

-- 하지만, 보통 SELECT 는 다 지정하고, 다 적어주는 게 좋다.
SELECT
    E.ENAME,
    E.DEPTNO,
    D.DEPTNO,
    D.DNAME
FROM
    EMP  E,
    DEPT D
WHERE
    E.DEPTNO = D.DEPTNO
ORDER BY
    E.EMPNO;

-- tip ) 보통은 select 문에 * 을 잘 작성하지 않고, 하나씩 명시하는게 좋다.
-- 쿼리 결과문이 어떤 순서로 나올지 알 수 없고,
-- 특정 열이 추가 또는 수정 또는 삭제될 수 있기 때문에.

-- 조인의 종류 ( 등가 / 비등가 / 자체 / 외부 )
-- 등가 조인(=) : 두 테이블의 의미상 같은 컬럼을 엮어준다.
-- equi join / simple join / inner join
SELECT
    E.EMPNO,
    E.ENAME,
    D.DEPTNO,
    D.DNAME,
    D.LOC
FROM
    EMP  E,
    DEPT D
WHERE
    E.DEPTNO = D.DEPTNO -- 등가 조인
ORDER BY
    D.DEPTNO,
    E.EMPNO;

-- 조인 조건 + 다른 출력 조건(급여가 3000 이상인 사람)
SELECT
    E.EMPNO,
    E.ENAME,
    D.DEPTNO,
    D.DNAME,
    D.LOC
FROM
    EMP  E,
    DEPT D
WHERE
    E.DEPTNO = D.DEPTNO -- 등가 조인
    AND SAL >= 3000
ORDER BY
    D.DEPTNO,
    E.EMPNO;

-- TIP)조인 테이블 개수와 조건식 개수의 관계
-- 최소, 테이블 N개 -> 조건 N-1개
-- 테이블 3개( A, B, C) -> A와 B를 엮고, AB 와 C를 엮으면 된다.


-- 비등가 조인 : 등가 조인(=)이 아닌 조건식으로 조인을 한다.
SELECT
    *
FROM
    SALGRADE;

SELECT
    E.EMPNO,
    E.ENAME,
    E.SAL,
    S.GRADE,
    S.LOSAL,
    S.HISAL
FROM
    EMP      E,
    SALGRADE S
WHERE
    E.SAL BETWEEN S.LOSAL AND S.HISAL -- 비등가 조인 조건
ORDER BY
    E.EMPNO;

-- 사원번호, 사원명, 부서번호, 부서명, 급여, 급여등급,
-- 등급의최소급여, 등급의최대급여
SELECT
    E.EMPNO,
    E.ENAME,
    E.DEPTNO,
    D.DNAME,
    E.SAL,
    S.GRADE,
    S.LOSAL,
    S.HISAL
FROM
    EMP      E,
    DEPT     D,
    SALGRADE S
WHERE
    E.DEPTNO = D.DEPTNO -- 1. EMP테이블과 DEPT테이블 등가 조인으로 엮음
    AND E.SAL BETWEEN S.LOSAL AND S.HISAL
 -- 2. AB 엮여진 상태에서 SALGRADE 테이블을
    --    비등가 조인으로 엮음
ORDER BY
    E.SAL;

-- 자체조인 : 같은 테이블을 조인한다.
SELECT
    *
FROM
    EMP;

SELECT
    E1.EMPNO,
    E1.ENAME,
    E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP E1,
    EMP E2
WHERE
    E1.MGR = E2.EMPNO;

-- 등가 조인 조건

-- 외부 조인 : NULL 이 있는 데이터도 출력함
-- 왼쪽 외부 조인(LEFT OUTER JOIN) / 오른쪽 외부 조인(RIGHT OUTER JOIN)
-- WHERE 절의 조인 기준 열 중 한 쪽에 (+) 를 작성한다.
SELECT
    *
FROM
    EMP
ORDER BY
    MGR;

-- LEFT OUTER JOIN ( 왼쪽 외부 조인 )
SELECT
    E1.EMPNO,
    E1.ENAME,
    E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP E1,
    EMP E2
WHERE
    E1.MGR = E2.EMPNO(+) -- 기준 반대편에 (+) 표시
ORDER BY
    E1.EMPNO;

-- RIGHT OUTER JOIN ( 오른쪽 외부 조인 )
SELECT
    E1.EMPNO,
    E1.ENAME,
    E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP E1,
    EMP E2
WHERE
    E1.MGR(+) = E2.EMPNO -- 기준 반대편에 (+) 표시
ORDER BY
    E1.MGR;

-- ORACLE 문법이 아닌 SQL-99 표준 문법
-- TABLE(A) NATURAL JOIN TABLE(B) : 등가 조인
-- 두 테이블에 이름과 자료형이 같은 컬럼을 찾은 후 그 열을 기준으로 등가 조인함.
-- 기준이 되는 COLUMN은 테이블 지정하면 안된다.
SELECT
    E.EMPNO,
    E.ENAME,
    DEPTNO,
    D.DNAME,
    D.LOC
FROM
    EMP  E
    NATURAL JOIN DEPT D
ORDER BY
    DEPTNO,
    E.EMPNO;

-- TABLE(A) JOIN TABLE(B) USING(COLUMN) : 등가 조인
-- USING(COLUMN)에 지정한 COLUMN을 기준으로 조인함
-- 기준이 되는 COLUMN은 테이블 지정하면 안된다.
SELECT
    E.EMPNO,
    E.ENAME,
    DEPTNO,
    D.DNAME,
    D.LOC
FROM
    EMP  E
    JOIN DEPT D
    USING(DEPTNO)
ORDER BY
    DEPTNO,
    E.EMPNO;

-- TABLE(A) JOIN TABLE(B) ON ( 조인조건식 ) : 조인 방법
-- ON(조인조건식)의 조인조건식에 따라 조건을 하는 방법
SELECT
    E.EMPNO,
    E.ENAME,
    D.DEPTNO,
    D.DNAME,
    D.LOC
FROM
    EMP  E
    JOIN DEPT D
    ON ( E.DEPTNO = D.DEPTNO )
ORDER BY
    E.DEPTNO;

-- JOIN - ON 문법의 경우에 비등가 조인도 사용할 수 있다.
SELECT
    E.EMPNO,
    E.ENAME,
    E.SAL,
    S.GRADE,
    S.LOSAL,
    S.HISAL
FROM
    EMP      E
    JOIN SALGRADE S
    ON ( E.SAL BETWEEN S.LOSAL
    AND S.HISAL )
ORDER BY
    E.SAL;

-- TABLE(A) LEFT/RIGHT/FULL OUTER JOIN TABLE(B) ON ( 조인조건 )
-- 왼쪽/오른쪽/전체 외부조인이며, ON( 조인조건 )의 조건에 따라 JOIN한다.

-- 왼쪽 외부 조인 ( LEFT OUTER JOIN )
SELECT
    E1.EMPNO,
    E1.ENAME,
    E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP E1
    LEFT OUTER JOIN EMP E2
    ON ( E1.MGR = E2.EMPNO )
ORDER BY
    E1.EMPNO;

-- 오른쪽 외부 조인
SELECT
    E1.EMPNO,
    E1.ENAME,
    E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP E1
    RIGHT OUTER JOIN EMP E2
    ON ( E1.MGR = E2.EMPNO )
ORDER BY
    E1.EMPNO;

-- 전체 외부 조인
SELECT
    E1.EMPNO,
    E1.ENAME,
    E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP E1
    FULL OUTER JOIN EMP E2
    ON ( E1.MGR = E2.EMPNO )
ORDER BY
    E1.EMPNO;

-- 표준 문법으로 2개 초과의 테이블을 사용할 때?
SELECT
    E.EMPNO,
    E.ENAME,
    D.DEPTNO,
    D.DNAME,
    E.SAL,
    S.GRADE
FROM
    EMP      E
    JOIN DEPT D
    ON ( E.DEPTNO = D.DEPTNO )
    JOIN SALGRADE S
    ON ( E.SAL BETWEEN S.LOSAL
    AND S.HISAL )
ORDER BY
    E.EMPNO;

-- HR계정에서 다른 표준 JOIN 방식으로 작성 ( JOIN 3가지 조건 )
--SELECT e.first_name , e.last_name, E.DEPARTMENT_ID, d.department_name,E.JOB_ID, j.job_title
--FROM EMPLOYEES E JOIN DEPARTMENTS D ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
--                 JOIN JOBS J ON (E.JOB_ID = J.JOB_ID)
--ORDER BY E.EMPLOYEE_ID;
--
--SELECT e.first_name , e.last_name, DEPARTMENT_ID, d.department_name,JOB_ID, j.job_title
--FROM EMPLOYEES E JOIN DEPARTMENTS D USING (DEPARTMENT_ID)
-- JOIN JOBS J USING (JOB_ID)
--ORDER BY E.EMPLOYEE_ID;
--
--SELECT e.first_name , e.last_name, DEPARTMENT_ID, d.department_name,JOB_ID, j.job_title
--FROM EMPLOYEES E NATURAL JOIN DEPARTMENTS D
--                 NATURAL JOIN JOBS J
--ORDER BY E.EMPLOYEE_ID;

-- 1-1. 급여(SAL)가 2000 초과인 사원들의 부서정보, 사원정보를 출력하세요
-- 1-2. 출력순서 : 부서번호, 부서이름, 사원번호, 사원이름, 급여
-- 1-3. SQL99 표준 버전과 아닌 버전 두 가지로 쿼리를 작성해보세요

SELECT
    D.DEPTNO,
    D.DNAME,
    E.EMPNO,
    E.ENAME,
    E.SAL
FROM
    EMP01  E,
    DEPT01 D
WHERE
    E.DEPTNO = D.DEPTNO -- JOIN 조건
    AND E.SAL > 2000
ORDER BY
    D.DEPTNO,
    E.EMPNO;

-- 1-2. SQL-99 표준 문법
SELECT
    D.DEPTNO,
    D.DNAME,
    E.EMPNO,
    E.ENAME,
    E.SAL
FROM
    EMP  E
    JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
WHERE
    E.SAL > 2000
ORDER BY
    D.DEPTNO,
    E.EMPNO;

-- 2.1 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력하세요.
-- 2.2 출력 순서 : 부서번호, 부서명, 평균급여(AVG_SAL), 최대급여 (MAX_SAL), 최소급여 (MIN_SAL), 부서의 사원수 (CNT)

-- SQL99 아닌 버전  
SELECT
    D.DEPTNO,
    D.DNAME,
    TRUNC(AVG(E.SAL), 2) AS AVG_SAL,
    MAX(E.SAL)           AS MAX_SAL,
    MIN(E.SAL)           AS MIN_SAL,
    COUNT(*)             AS CNT
FROM
    DEPT D,
    EMP  E
WHERE
    D.DEPTNO = E.DEPTNO
GROUP BY
    D.DEPTNO,
    D.DNAME;

-- SQL99 버전
SELECT
    D.DEPTNO,
    D.DNAME,
    TRUNC(AVG(E.SAL), 2) AS AVG_SAL,
    MAX(E.SAL)           AS MAX_SAL,
    MIN(E.SAL)           AS MIN_SAL,
    COUNT(*)             AS CNT
FROM
    EMP  E
    JOIN DEPT D
    USING (DEPTNO)
GROUP BY
    D.DEPTNO,
    D.DNAME;

-- 3-1. 모든 부서 정보와 사원 정보를 부서 번호, 사원이름 순으로 정렬하여 출력해보시오.
-- 3-2. 출력 순서 : 부서번호, 부서명, 사원번호, 사원명, 직책, 급여
-- 3-3. SQL-99 표준 문법과 ORACLE 문법 두 가지로 작성

-- Oracle 문법
SELECT
    D.DEPTNO,
    D.DNAME,
    E.EMPNO,
    E.ENAME,
    E.JOB,
    E.SAL
FROM
    EMP  E,
    DEPT D
WHERE
    E.DEPTNO(+) = D.DEPTNO
ORDER BY
    E.DEPTNO,
    E.ENAME;

-- SQL-99 문법
SELECT
    D.DEPTNO,
    D.DNAME,
    E.EMPNO,
    E.ENAME,
    E.JOB,
    E.SAL
FROM
    EMP  E
    RIGHT OUTER JOIN DEPT D
    ON (E.DEPTNO = D.DEPTNO)
ORDER BY
    E.DEPTNO,
    E.ENAME;

-- 4-1. 모든 부서정보, 사원정보, 급여등급정보, 각 사원의 직속 상관의 정보를 부서 번호,
-- 사원번호 순으로 정렬하시오
-- 출력 순서 : DEPTNO, DNAME, EMPNO, ENAME, MGR, SAL, DEPTNO, LOSAL, HISAL, GRADE,
-- MGR_EMPNO, MGR_ENAME
-- 4-3. ORACLE 문법 / SQL-99 표준 문법 두 가지로 작성

-- ORACLE 문법
SELECT
    D.DEPTNO,
    D.DNAME,
    E.EMPNO,
    E.ENAME,
    E.MGR,
    E.SAL,
    D.DEPTNO AS SAL_DEPTNO,
    S.LOSAL,
    S.HISAL,
    S.GRADE,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP      E,
    DEPT     D,
    SALGRADE S,
    EMP      E2
WHERE
    D.DEPTNO = E.DEPTNO(+)
    AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
    AND E.MGR = E2.EMPNO(+)
ORDER BY
    D.DEPTNO,
    E.EMPNO;

--SQL-99 표준 문법
SELECT
    D.DEPTNO,
    D.DNAME,
    E.EMPNO,
    E.ENAME,
    E.MGR,
    E.SAL,
    D.DEPTNO AS SAL_DEPTNO,
    S.LOSAL,
    S.HISAL,
    S.GRADE,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM
    EMP      E
    RIGHT OUTER JOIN DEPT D
    ON (E.DEPTNO = D.DEPTNO)
    LEFT OUTER JOIN SALGRADE S
    ON (E.SAL BETWEEN S.LOSAL
    AND S.HISAL)
    LEFT OUTER JOIN EMP E2
    ON (E.MGR = E2.EMPNO)
ORDER BY
    D.DEPTNO,
    E.EMPNO;