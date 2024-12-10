--  JOIN : 수평적 결합으로 테이블 두 개를 붙인다.
-- 1.  JOIN 조건 없이 그냥 출력 ( EMP : 14개 / DEPT : 4개 )
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
-- 등가 조인 : 두 테이블의 의미상 같은 컬럼을 엮어준다.
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
    