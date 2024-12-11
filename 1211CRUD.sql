-- SCOTT 계정
-- 10장. 데이터 CRUD 란 ?
-- 데이터를 넣고(CREATE) 읽고(READ) 수정하고(UPDATE) 삭제하기(DELETE)
-- Create Read Update Delete 의 앞 글자 = CRUD
-- 개발자에게 꼭 필요한, 기초의 기술.

-- 테스트 테이블 하나 생성 ( 12장 )
CREATE TABLE DEPT_TEMP AS
    SELECT
        *
    FROM
        DEPT;

COMMIT;

-- <<< 테이블 데이터 추가하기 >>>
-- INSERT INTO 테이블이름 ( 열1, 열2, 열3, ... )
-- VALUES ( 데이터1, 데이터2, 데이터3, ... )

INSERT INTO DEPT_TEMP (
    DEPTNO,
    DNAME,
    LOC
) VALUES (
    50,
    'DATABASE',
    'BUSAN'
);

SELECT
    *
FROM
    DEPT_TEMP;

-- 2. 테이블의 열을 작성하지 않고 데이터로 삽입하기
--    ** 테이블의 모든 열의 데이터를 맞게 작성해야한다.
INSERT INTO DEPT_TEMP VALUES (
    60,
    'ORACLE',
    'SEOUL'
);

SELECT
    *
FROM
    DEPT_TEMP;

-- 3. 오류 발생 시나리오
-- 3-1. 지정한 열보다 데이터의 수가 적을 때(NOT ENOUGH VALUES)
--      지정한 열만큼의 데이터가 없다.
INSERT INTO DEPT_TEMP(
    DEPTNO,
    DNAME,
    LOC
) VALUES (
    60,
    'NETWORK'
);

-- 3-2. 지정한 열보다 데이터의 수가 많을 때 ( TOO MANY VALUES )
--      지정한 열보다 데이터가 더 많다.
INSERT INTO DEPT_TEMP(
    DEPTNO,
    DNAME,
    LOC
) VALUES (
    60,
    'NETWORK',
    'SEOUL',
    'WRONG'
);

-- 3-3. 지정한 컬럼의 자료형(DATA TYPE) 다를 경우 ( INVALID NUMBER )
INSERT INTO DEPT_TEMP(
    DEPTNO,
    DNAME,
    LOC
) VALUES (
    'WRONG',
    'NETWORK',
    'SEOUL'
);

-- 3-4. 지정한 컬럼의 자료형 크기보다 크게 작성했을 때
INSERT INTO DEPT_TEMP(
    DEPTNO,
    DNAME,
    LOC
) VALUES (
    600,
    'NETWORK',
    'SEOUL'
);

-- 4. 테이블에 NULL 값 넣기
-- 4-1. NULL 값 명시하기
INSERT INTO DEPT_TEMP(
    DEPTNO,
    DNAME,
    LOC
) VALUES (
    70,
    'WEB',
    NULL
);

INSERT INTO DEPT_TEMP(
    DEPTNO,
    DNAME,
    LOC
) VALUES (
    80,
    'JAVA',
    ''
);

-- 4-2. 열을 입력할 때 열을 빼버리기
INSERT INTO DEPT_TEMP(
    DEPTNO,
    DNAME
) VALUES (
    90,
    'SPRING'
);

INSERT INTO DEPT_TEMP(
    DEPTNO,
    LOC
) VALUES (
    90,
    'INCHEON'
);

SELECT
    *
FROM
    DEPT_TEMP;

-- 5. 테이블에 날짜 데이터 넣기
-- 5-1. 예제 테이블 만들기
CREATE TABLE EMP_TEMP AS
    SELECT
        *
    FROM
        EMP
    WHERE
        1 <> 1;

COMMIT;

-- 5-2. 날짜 데이터 추가하기

INSERT INTO EMP_TEMP (
    EMPNO,
    ENAME,
    JOB,
    MGR,
    HIREDATE,
    SAL,
    COMM,
    DEPTNO
) VALUES (
    9999,
    '홍길동',
    'PRESIDENT',
    NULL,
    '2001/01/01',
    5000,
    1000,
    10
);

INSERT INTO EMP_TEMP (
    EMPNO,
    ENAME,
    JOB,
    MGR,
    HIREDATE,
    SAL,
    COMM,
    DEPTNO
) VALUES (
    1111,
    '길동이',
    'MANAGER',
    9999,
    '2001-01-05',
    4000,
    NULL,
    20
);

-- 5-3. 날짜 형변환을 통해서 데이터 넣기

INSERT INTO EMP_TEMP(
    EMPNO,
    ENAME,
    JOB,
    MGR,
    HIREDATE,
    SAL,
    COMM,
    DEPTNO
) VALUES(
    2222,
    '흰둥이',
    'SALESMAN',
    1111,
    TO_DATE('01/01/2004', 'DD/MM/YYYY'),
    5000,
    NULL,
    30
);

-- 5-4. 현재 날짜를 추가하기

INSERT INTO EMP_TEMP(
    EMPNO,
    ENAME,
    JOB,
    MGR,
    HIREDATE,
    SAL,
    COMM,
    DEPTNO
) VALUES(
    3333,
    '짱구',
    'MANAGER',
    2222,
    SYSDATE,
    5001,
    NULL,
    20
);

SELECT
    *
FROM
    EMP_TEMP;

-- 6. 서브쿼리를 사용해서 한 번에 여러 데이터를 추가하기

INSERT INTO EMP_TEMP(
    EMPNO,
    ENAME,
    JOB,
    MGR,
    HIREDATE,
    SAL,
    COMM,
    DEPTNO
)
    SELECT
        E.EMPNO,
        E.ENAME,
        E.JOB,
        E.MGR,
        E.HIREDATE,
        E.SAL,
        E.COMM,
        E.DEPTNO
    FROM
        EMP      E,
        SALGRADE S
    WHERE
        E.SAL BETWEEN S.LOSAL AND S.HISAL
        AND S.GRADE = 1;

SELECT
    E.EMPNO,
    E.ENAME,
    E.JOB,
    E.MGR,
    E.HIREDATE,
    E.SAL,
    E.COMM,
    E.DEPTNO
FROM
    EMP      E,
    SALGRADE S
WHERE
    E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND S.GRADE = 1;

SELECT
    *
FROM
    EMP_TEMP;

-- 데이터 INSERT를 서브쿼리로 사용할 때 유의점
-- 1. VALUES 라는 예약어를 사용하지 않고 서브쿼리를 바로 작성
-- 2. 지정한 열(컬럼)의 개 수 만큼 서브쿼리의 열(컬럼) 개 수가 맞아야한다.
-- 3. 지정한 열(컬럼)의 자료형과 서브쿼리 열의 자료형이 같아야한다.
--      여기서 자료형이란 ? 문자, 숫자, 날짜를 비롯한 크기까지 생각해야한다.


-- <<< 테이블의 데이터를 수정하기 >>>
-- 1. 예제 테이블 만들기
CREATE TABLE DEPT_TEMP2 AS
    SELECT
        *
    FROM
        DEPT;

COMMIT;

SELECT
    *
FROM
    DEPT_TEMP2;

-- 2. 데이터 수정 기본 사용법
-- UPDATE   테이블명
-- SET      변경할 열1 = [데이터], 변경할 열2 = [데이터], ...
-- WHERE    변경할 대상을 지정할 조건식;
--  * WHERE은 선택사항이다.

-- 3. 테이블의 전체 데이터 수정하기
--     = WHERE을 작성하지 않는다.
UPDATE DEPT_TEMP2
SET
    LOC = 'SEOUL';

-- 4. 테이블의 일부 데이터만 수정하기
--     = WHERE을 사용해서 일부 데이터를 추출해낸다.
UPDATE DEPT_TEMP2
SET
    DNAME = 'DATABASE',
    LOC = 'BUSAN'
WHERE
    DEPTNO = 40;

-- 예제) EMP_TEMP 테이블의 사원들 중 급여(SAL)이 2500 이하인 사원만
--      추가 수당을 50으로 수정
UPDATE EMP_TEMP
SET
    COMM = 50
WHERE
    SAL <= 2500;

-- 5. 서브쿼리를 이용해서 수정하기
UPDATE DEPT_TEMP2
SET
    (
        DNAME,
        LOC
    ) = (
        SELECT
            DNAME,
            LOC
        FROM
            DEPT
        WHERE
            DEPTNO = 40
    )
WHERE
    DEPTNO = 40;

UPDATE DEPT_TEMP2
SET
    DNAME = (
        SELECT
            DNAME
        FROM
            DEPT
        WHERE
            DEPTNO = 30
    ),
    LOC = (
        SELECT
            LOC
        FROM
            DEPT
        WHERE
            DEPTNO = 30
    )
WHERE
    DEPTNO = 30;

-- 5-1. WHERE 절에 서브쿼리 넣기
UPDATE DEPT_TEMP2
SET
    LOC = 'BUSAN'
WHERE
    DEPTNO = (
        SELECT
            DEPTNO
        FROM
            DEPT_TEMP2
        WHERE
            DNAME = 'OPERATIONS'
    );

SELECT
    *
FROM
    DEPT_TEMP2;

-- <<< 테이블에 있는 데이터를 삭제하기 >>>
-- 1. 예제 테이블 생성하기
CREATE TABLE EMP_TEMP2 AS
    SELECT
        *
    FROM
        EMP;

COMMIT;

SELECT
    *
FROM
    EMP_TEMP2;

-- 2. 데이터 삭제 기본 사용법
-- DELETE FROM [테이블명]
-- WHERE 행을 지정할 조건식;
--   ** WHERE 은 선택사항입니다.

-- 3. 지정한 데이터를 삭제하기
DELETE FROM EMP_TEMP2
WHERE
    JOB = 'MANAGER';

-- 4. 서브쿼리를 사용해서 삭제하기
DELETE FROM EMP_TEMP2
WHERE
    EMPNO IN (
        SELECT
            E.EMPNO
        FROM
            EMP_TEMP2 E,
            SALGRADE  S
        WHERE
            E.SAL BETWEEN S.LOSAL AND S.HISAL
            AND S.GRADE = 3
            AND DEPTNO = 30
    );

SELECT
    E.EMPNO
FROM
    EMP_TEMP2 E,
    SALGRADE  S
WHERE
    E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND S.GRADE = 3
    AND DEPTNO = 30;

-- 5. 테이블의 전체 데이터 삭제하기
DELETE FROM EMP_TEMP2;

SELECT
    *
FROM
    EMP_TEMP2
ORDER BY
    JOB;