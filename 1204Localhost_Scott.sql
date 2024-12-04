-- 다중행 함수
SELECT
        *
FROM
        EMP;

-- 1. SUM([DISTINCT, ALL] DATA) : 합계
SELECT
        SUM(SAL) AS SAL합계
FROM
        EMP;

-- SUM 중복 제거
SELECT
        SUM(DISTINCT SAL),
        SUM(ALL SAL),
        SUM(SAL)
FROM
        EMP;

-- NULL 이 있는 ROW 같은 경우에는 NULL은 무시하고 데이터만 합한다.
SELECT
        SUM(COMM)
FROM
        EMP;

-- 2. COUNT ([DISTINCT, ALL] DATA ) 함수 : 쿼리 결과 ROW의 데이터 수
SELECT
        COUNT(*)
FROM
        EMP;

-- 조건을 달아서 COUNT 하기
SELECT
        COUNT(*)
FROM
        EMP
WHERE
        DEPTNO = 30;

-- COUNT 중복제거
SELECT
        COUNT(DISTINCT SAL),
        COUNT(ALL SAL),
        COUNT(SAL)
FROM
        EMP;

-- COUNT도 NULL 이 있다면 ? NULL은 집계에 포함하지 않는다.
SELECT
        COMM
FROM
        EMP;

SELECT
        COUNT(COMM)
FROM
        EMP;

SELECT
        COUNT(COMM)
FROM
        EMP
WHERE
        COMM IS NOT NULL;

-- 3. MIN / MAX ( DATA ) : 최소값 / 최대값
SELECT
        MIN(SAL),
        MAX(SAL)
FROM
        EMP;

-- 조건 추가
SELECT
        MIN(SAL),
        MAX(SAL)
FROM
        EMP
WHERE
        DEPTNO = 10;

-- 날짜 데이터 기준 (오래된 날짜-최소값 / 가까운 날짜-최대값)
SELECT
        MIN(HIREDATE),
        MAX(HIREDATE)
FROM
        EMP;

-- AVG( [DISTINCT , ALL] DATA ) : 평균 값 계산
SELECT
        AVG(SAL)
FROM
        EMP;

-- 중복제거
SELECT
        AVG(DISTINCT SAL),
        AVG(ALL SAL),
        AVG(SAL)
FROM
        EMP;

-- GROUP BY 절
SELECT
        AVG(SAL)
FROM
        EMP
WHERE
        DEPTNO = 10;

SELECT
        AVG(SAL)
FROM
        EMP
WHERE
        DEPTNO = 20;

SELECT
        AVG(SAL)
FROM
        EMP
WHERE
        DEPTNO = 30;

SELECT
        '10'     AS DEPTNO,
        AVG(SAL)
FROM
        EMP
WHERE
        DEPTNO = 10
UNION
ALL
SELECT
        '20'     AS DEPTNO,
        AVG(SAL)
FROM
        EMP
WHERE
        DEPTNO = 20
UNION
ALL
SELECT
        '30'     AS DEPTNO,
        AVG(SAL)
FROM
        EMP
WHERE
        DEPTNO = 30;

-- 그룹화 ( GROUP BY 기준데이터1, 기준데이터2, ... , 기준데이터N)
-- 기본형
SELECT
        DEPTNO,
        AVG(SAL)
FROM
        EMP
WHERE
        DEPTNO != 10
GROUP BY
        DEPTNO
ORDER BY
        DEPTNO;

-- 기준이 되는 데이터가 2개 이상
SELECT
        DEPTNO,
        JOB,
        AVG(SAL)
FROM
        EMP
GROUP BY
        DEPTNO,
        JOB
ORDER BY
        DEPTNO,
        JOB;

SELECT
        DEPTNO,
        JOB,
        SAL
FROM
        EMP
ORDER BY
        DEPTNO;

-- GROUP BY 주의점
-- 그룹화를 할때엔 SELECT 절의 COLUMN 로 그룹화가 되어있어야한다.
SELECT
        DEPTNO,
        JOB,
        AVG(SAL)
FROM
        EMP
GROUP BY
        DEPTNO,
        JOB;

-- 각 부서별 가장 오래된 입사일과 가장 최근 입사일을 출력하세요.
-- 답
SELECT
        DEPTNO,
        MIN(HIREDATE),
        MAX(HIREDATE)
FROM
        EMP
GROUP BY
        DEPTNO
ORDER BY
        DEPTNO;

-- 검수
SELECT
        DEPTNO,
        HIREDATE
FROM
        EMP
ORDER BY
        DEPTNO,
        HIREDATE;

-- 직급별 사람의 수와 급여의 평균을 출력하세요.
-- 답
SELECT
        JOB,
        COUNT(JOB),
        AVG(SAL)
FROM
        EMP
GROUP BY
        JOB
ORDER BY
        JOB;

--검수
SELECT
        JOB,
        SAL
FROM
        EMP
ORDER BY
        JOB,
        SAL;

-- 사수의 직급번호(MGR)별 COUNT를 출력하세요.
-- 답
SELECT
        NVL(TO_CHAR(MGR), '없음'),
        COUNT(*) -- 모든 ROW를 카운트
FROM
        EMP
GROUP BY
        MGR
ORDER BY
        MGR;

-- 검수
SELECT
        NVL(TO_CHAR(MGR), '없음')
FROM
        EMP
ORDER BY
        MGR;

-- 각 부서-직급별 사원 이름의 두번째 자리에 A 또는 L 이 들어가는 사원의 수를 출력하세요.
-- 답
SELECT
        DEPTNO,
        JOB,
        COUNT(ENAME)
FROM
        EMP
WHERE
        ENAME LIKE '_A%'
        OR ENAME LIKE '_L%'
GROUP BY
        DEPTNO,
        JOB;

-- 검수
SELECT
        DEPTNO,
        JOB,
        ENAME
FROM
        EMP
WHERE
        ENAME LIKE '_A%'
        OR ENAME LIKE '_L%';

-- GROUP BY 그룹화에 조건 달기
-- 조건 없을때
SELECT
        DEPTNO,
        JOB,
        AVG(SAL)
FROM
        EMP
GROUP BY
        DEPTNO,
        JOB
ORDER BY
        DEPTNO,
        JOB;

-- Having 조건절 추가
SELECT
        DEPTNO,
        JOB,
        AVG(SAL)
FROM
        EMP
GROUP BY
        DEPTNO,
        JOB
HAVING
        AVG(SAL) >= 2000
ORDER BY
        DEPTNO,
        JOB;

-- HAVING 절의 조건을 WHERE절에 사용하면 에러난다.
SELECT
        DEPTNO,
        JOB,
        AVG(SAL)
FROM
        EMP
WHERE
        AVG(SAL) >= 2000
GROUP BY
        DEPTNO,
        JOB
ORDER BY
        DEPTNO,
        JOB;

-- QUERY 의 메커니즘
-- 1. 먼저 출력을 한다( SELECT FROM WHERE )
-- 2. 그룹화를 진행한다. ( GROUP BY )
-- 3. 다중행 함수를 진행한다. ( COUNT, MAX, MIN, AVG, SUM )
-- 4. 그룹화 조건을 확인한다. ( HAVING )
-- 5. 나온 값을 기준으로 정렬한다. ( ORDER BY )

SELECT
        DEPTNO,
        JOB,
        AVG(SAL)
FROM
        EMP
WHERE
        SAL <= 3000
GROUP BY
        DEPTNO,
        JOB
HAVING
        AVG(SAL) >= 2000
ORDER BY
        DEPTNO,
        JOB;

-- 그룹화와 관련된 함수

-- 1. ROLLUP(기준데이터1, 기준데이터2,...)
SELECT
        DEPTNO,
        JOB,
        COUNT(*),
        MAX(SAL),
        SUM(SAL),
        TRUNC(AVG(SAL), 2)
FROM
        EMP
GROUP BY
        ROLLUP(DEPTNO, JOB)
ORDER BY
        DEPTNO,
        JOB;

-- 2. CUBE(기준데이터1, 기준데이터2, ...)
SELECT
        DEPTNO,
        JOB,
        COUNT(*),
        MAX(SAL),
        SUM(SAL),
        TRUNC(AVG(SAL), 2)
FROM
        EMP
GROUP BY
        CUBE(DEPTNO, JOB)
ORDER BY
        DEPTNO,
        JOB;

SELECT
        *
FROM
        EMP;

-- 데이터 3개로 ROLLUP 실습
SELECT
        DEPTNO,
        JOB,
        MGR,
        COUNT(*)
FROM
        EMP
WHERE
        ENAME NOT LIKE 'KING'
GROUP BY
        ROLLUP(DEPTNO, JOB, MGR);

-- 데이터 3개로 CUBE 실습
SELECT
        DEPTNO,
        JOB,
        MGR,
        COUNT(*)
FROM
        EMP
WHERE
        ENAME NOT LIKE 'KING'
GROUP BY
        CUBE(DEPTNO, JOB, MGR)
ORDER BY
        DEPTNO,
        JOB,
        MGR;

-- 하나를 그룹화하고 ROLLUP 함수 지정하기
SELECT
        DEPTNO,
        JOB,
        COUNT(*)
FROM
        EMP
GROUP BY
        DEPTNO,
        ROLLUP(JOB);

SELECT
        DEPTNO,
        JOB,
        COUNT(*)
FROM
        EMP
GROUP BY
        ROLLUP(DEPTNO),
        JOB;

-- GROUPING SETS
-- 그룹화 컬럼이 여러개일때, 각 컬럼별 그룹화를 통해 결과 출력
SELECT
        DEPTNO,
        JOB,
        COUNT(*)
FROM
        EMP
GROUP BY
        GROUPING SETS(DEPTNO, JOB)
ORDER BY
        DEPTNO,
 
        -- GROUPING 함수
        -- ROLLUP, CUBE 소계가 되었는지 안되었는지 확인할 때 사용
        SELECT
                DEPTNO,
                JOB,
                COUNT(*),
                MAX(SAL),
                SUM(SAL),
                GROUPING(DEPTNO),
                GROUPING(JOB)
        FROM
                EMP
        GROUP BY
                CUBE(DEPTNO, JOB)
        ORDER BY
                DEPTNO,
                JOB;

-- GROUPING 예제
SELECT
        DECODE(GROUPING(DEPTNO), 1, 'ALL-DEPT', DEPTNO)AS DEPTNO,
        DECODE(GROUPING(JOB), 1, 'ALL-JOB', JOB)AS        JOB,
        COUNT(*),
        MAX(SAL),
        SUM(SAL)
FROM
        EMP
GROUP BY
        CUBE(DEPTNO, JOB)
ORDER BY
        DEPTNO,
        JOB;

-- GROUPING_ID 함수
-- ROLLUP, CUBE 에서 소계가 잘되었는지 나타내는 함수
-- 2진수 백터 값으로 나타낸다.
SELECT
        DEPTNO,
        JOB,
        COUNT(*),
        GROUPING(DEPTNO),
        GROUPING(JOB),
        GROUPING_ID(DEPTNO, JOB)
FROM
        EMP
GROUP BY
        CUBE(DEPTNO, JOB)
ORDER BY
        DEPTNO,
        JOB;

SELECT
        DECODE(GROUPING_ID(JOB), 2, 'ALL-DEPT', 3, 'ALL-DEPT', DEPTNO)AS DEPTNO,
        DECODE(GROUPING_ID(JOB), 1, 'ALL-JOB', 3, 'ALL-JOB', JOB)AS      JOB,
        COUNT(*)
FROM
        EMP
GROUP BY
        CUBE(DEPTNO, JOB)
ORDER BY
        DEPTNO,
        JOB;

-- LISTAGG(기준열, [구분자]) WITHIN GROUP (ORDER BY 기준열)
-- 데이터를 (정렬 기준에 맞춰) 일렬로 (구분자를 넣어서) 나열해준다.
SELECT
        DEPTNO,
        LISTAGG(ENAME, ', ') WITHIN GROUP(ORDER BY SAL DESC) AS ENAME
FROM
        EMP
GROUP BY
        DEPTNO;

-- 위의 QUERY 검수
SELECT
        DEPTNO,
        ENAME,
        SAL
FROM
        EMP
ORDER BY
        DEPTNO,
        SAL;

-- PIVOT / UNPIVOT
-- 기전 테이블 행을 열로 변경/ 기존 테이블 열을 행으로 변경
SELECT
        DEPTNO,
        JOB,
        MAX(SAL)
FROM
        EMP
GROUP BY
        DEPTNO,
        JOB
ORDER BY
        DEPTNO,
        JOB;

SELECT
        *
FROM
        (
                SELECT
                        DEPTNO,
                        JOB,
                        SAL
                FROM
                        EMP
        ) PIVOT (MAX(SAL) FOR DEPTNO IN (10,
        20,
        30) )
ORDER BY
        JOB;

SELECT
        *
FROM
        (
                SELECT
                        DEPTNO,
                        JOB,
                        SAL
                FROM
                        EMP
        ) PIVOT (MAX(SAL) FOR JOB IN ('CLERK' AS CLERK,
        'SALESMAN' AS SALESMAN,
        'PRESIDENT' AS PRESIDENT,
        'MANAGER' AS MANAGER,
        'ANALYST' AS ANALYST ) )
ORDER BY
        DEPTNO;

-- 위에 내용을 DECODE 방식
SELECT
        DEPTNO,
        MAX(DECODE(JOB, 'CLERK', SAL))AS     CLERK,
        MAX(DECODE(JOB, 'SALESMAN', SAL))AS  SALESMAN,
        MAX(DECODE(JOB, 'PRESIDENT', SAL))AS PRESIDENT,
        MAX(DECODE(JOB, 'MANAGER', SAL))AS   MANAGER,
        MAX(DECODE(JOB, 'ANALYST', SAL))AS   ANALYST
FROM
        EMP
GROUP BY
        DEPTNO
ORDER BY
        DEPTNO;

SELECT
        *
FROM
        (
                SELECT
                        DEPTNO,
                        MAX(DECODE(JOB, 'CLERK', SAL))AS     CLERK,
                        MAX(DECODE(JOB, 'SALESMAN', SAL))AS  SALESMAN,
                        MAX(DECODE(JOB, 'PRESIDENT', SAL))AS PRESIDENT,
                        MAX(DECODE(JOB, 'MANAGER', SAL))AS   MANAGER,
                        MAX(DECODE(JOB, 'ANALYST', SAL))AS   ANALYST
                FROM
                        EMP
                GROUP BY
                        DEPTNO
                ORDER BY
                        DEPTNO
        ) UNPIVOT ( SAL FOR JOB IN (CLERK,
        SALESMAN,
        PRESIDENT,
        MANAGER,
        ANALYST))
ORDER BY
        DEPTNO,
        JOB;

-- 7장 문제
-- 1. 각 부서별 급여 (SAL)의 평균, 최대, 최소 및 부서 인원을 출력하시오.
SELECT
        DEPTNO,
        TRUNC(AVG(SAL)),
        MAX(SAL),
        MIN(SAL),
        COUNT(*)
FROM
        EMP
GROUP BY
        DEPTNO
ORDER BY
        DEPTNO;

-- 2. 각 직책의 사원수가 3명인 이상인 직책과 사원 수를 출력하시오.
SELECT
        JOB,
        COUNT(*)
FROM
        EMP
GROUP BY
        JOB
HAVING
        COUNT(*) >=3;

-- 3. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력하시오.
-- HIRE_YEAR (입사연도), DEPTNO, CNT (명 수)
SELECT
        TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR, -- HIRE_DATE에서 연도 추출
        DEPTNO,
        COUNT(*)                  AS CNT -- 부서별 사원 수 계산
FROM
        EMP
GROUP BY
        TO_CHAR(HIREDATE, 'YYYY'),
        DEPTNO
ORDER BY
        HIRE_YEAR;

-- 4. 추가 수당 (COMM)이 있는 사람과 없는 사람의 수를 출력하시오.
-- 있는 사람은 'O' 없는 사람은 'X'로 하여 별치을 EXIST_COMM
-- 사람 수 컬럼에 대한 별칭은 CNT

SELECT
        NVL2(COMM, 'O', 'X') AS EXIST_COMM, -- COMM 값이 NULL이 아니면 'O', NULL이면 'X'
        COUNT(*)             AS CNT -- 각 그룹의 사람 수 계산
FROM
        EMP
GROUP BY
        NVL2(COMM, 'O', 'X') -- COMM 값에 따라 그룹화
ORDER BY
        EXIST_COMM;

-- NVL2(COMM, 'O', 'X'):
--      COMM 값이 NULL이 아니면 'O'를 반환 (추가 수당 있음).
--      COMM 값이 NULL이면 'X'를 반환 (추가 수당 없음).
--      COUNT(*): 각 그룹에 해당하는 사람 수를 계산합니다.
--      GROUP BY: NVL2(COMM, 'O', 'X') 결과를 기준으로 그룹화합니다.
--      ORDER BY: 결과를 'O'와 'X' 순서대로 정렬합니다.

-- 5. 각 부서의 입사 연도별 사원수, 최고 급여, 급여 합, 평균 급여를 출력하고
-- 각부서별 소계와 총계를 출력하세요.
SELECT
        DEPTNO,
        TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
        COUNT(*)                  AS CNT,
        MAX(SAL)                  AS MAX_SAL,
        SUM(SAL)                  AS SUM_SAL,
        TRUNC(AVG(SAL), 1)        AS AVG_SAL
FROM
        EMP
GROUP BY
        ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));