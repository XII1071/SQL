-- 계정 : SCOTT
-- 11장 트랜잭션 제어와 세션
-- 트랜잭션 : 하나의 최소 수행 단위
--           최소 1개 이상의 DML ( 데이터 CRUD )
--           ALL OR NOTHING

-- 1. 테이블 데이터 확인

SELECT * FROM DEPT_TEMP2;

-- 2. 하나의 DML 작성

UPDATE DEPT_TEMP2
SET LOC = 'MASAN'
WHERE DEPTNO = 10;

-- 3. 데이터 확인

SELECT * FROM DEPT_TEMP2; 

-- 4. 트랜잭션 취소

ROLLBACK;

-- 5. 테이블 데이터 확인

SELECT * FROM DEPT_TEMP2;

-- 6. 데이터 변경

UPDATE DEPT_TEMP2
SET LOC = 'CHANGWON'
WHERE DEPTNO = 10;
DELETE FROM DEPT_TEMP2
WHERE DEPTNO = 20;

-- 7. 테이블 데이터 확인

SELECT * FROM DEPT_TEMP2;

-- 8. 트랙잭션 취소

ROLLBACK;

-- 9. 테이블 데이터 확인

SELECT * FROM DEPT_TEMP2;

-- 10. 데이터 수정

UPDATE DEPT_TEMP2
SET DNAME = 'DATABASE', LOC = 'BUSAN'
WHERE DEPTNO = 10;

-- 11. 데이터 확인

SELECT * FROM DEPT_TEMP2;

-- 12. 트랜잭션 반영

COMMIT;

-- 13. 데이터 확인

SELECT * FROM DEPT_TEMP2;


-- 세션(SESSION)
--      데이터베이스 접속 시작부터 접속이 종료하기까지의 전체 기간
--      하나의 세션에는 여러 개의 트랜잭션이 존재

-- 읽기 일관성
--    특정 세션에서 수행하는 트랜잭션이 
--    완료되기 전까지는 다른 세션에서는 원래의 데이터를 보여준다.

-- CMD와 SQL DEVELOPER 동시 진행 ( CMD 밑에는 CMD 명령/DEVELOPER 밑에는 DEVELOPER 명령 )

-- 1. 데이터 확인

-- CMD
SELECT * FROM DEPT_TEMP2;
-- SQL DEVELOPER
SELECT * FROM DEPT_TEMP2;

-- 2. 데이터 수정 ( SQL DEVELOPER 만 )

UPDATE DEPT_TEMP2
SET DNAME = 'SESSION', LOC='SEOUL'
WHERE DEPTNO = 10;

-- 3. 데이터확인 ( 읽기 일관성에 의해 CMD 와 DEVELOPER 의 데이터가 다름 )

-- CMD
SELECT * FROM DEPT_TEMP2;
-- DEVELOPER
SELECT * FROM DEPT_TEMP2;

-- 4. CMD 데이터 수정 ( SQLDEVELOPER 의 트랜잭션이 끝날때까지 기다림)

-- CMD 만
UPDATE DEPT_TEMP2 SET DNAME='TEST' WHERE DEPTNO = 10;

-- 5. SQL DEVELOPER 트랜잭션 취소

-- SQL DEVELOPER
ROLLBACK;
-- CMD 에서는 1 ROW UPDATED 라고 출력됨

-- 6. 데이터 확인 ( 읽기 일관성에 의해 DEVELOPER와 CMD가 데이터가 다름 )

-- CMD
SELECT * FROM DEPT_TEMP2;
-- DEVELOPER
SELECT * FROM DEPT_TEMP2;

-- 7. CMD 에 영구적 반영 명령어를 입력

-- CMD
COMMIT;

-- 8. CMD와 DEVELOPER 데이터 확인
-- ( COMMIT 에 의해 반영되었으므로 둘 다 같은 데이터 출력 )

-- CMD
SELECT * FROM DEPT_TEMP2;
-- DEVELOPER
SELECT * FROM DEPT_TEMP2;

-- LOCK 
-- 하나의 세션에서 트랜잭션을 실행할 떄, 
-- 다른 세션에서 트랜잭션을을 수해하지 못하게 한다.
-- 행 레벨 LOCK : 특정 행에만 LOCK이 발생한다.
-- 테이블 레벨 LOCK : 테이블 자체에 LOCK이 발생한다.

UPDATE DEPT_TEMP2
SET
    DNAME = 'ABCDE'
WHERE
    DEPTNO = 10;

ROLLBACK;

UPDATE DEPT_TEMP2
SET
    DNAME = 'TESTTEST'
WHERE
    DEPTNO = 20;

ROLLBACK;

UPDATE DEPT_TEMP2
SET
    DNAME = 'DATABASE',
    LOC = 'SEOUL'
WHERE
    DEPTNO = 30;
SELECT
    *
FROM
    DEPT_TEMP2;

    SELECT * 
FROM DEPT_TEMP2
ORDER BY DEPTNO ASC;

COMMIT;


-- 쿼리문 (DQL DATA QUERY LANGUAGE)
-- 데이터 조작어 (DML DATA MANIFULATION)
-- 데이터 정의어 (DDL DATA DEFINTION LANGUAGE)
-- 12장 ,객체를 생성, 변경, 삭제하는 데이터 정의어

-- 데이터 정의어를 사용할 때 유의점.
-- 데이터 정의어는 사용되자마자 COMMIT이 이루어진다.

-- 데이터 정의어에는 어떤 것이 있을까?
-- 1. 객체 생성 CREATE
-- 2. 객체 수정 ALTER
-- 3. 객체 삭제 DROP

-- 테이블을 생성, 수정, 삭제 명령어

-- 1. 테이블 생성
-- 1-1. 기본 사용법
--      CREATE TABLE 계정명. 테이블명 (
--      열1이름 열1자료형(크기),
--      열2이름 열2자료형(크기), VARCHAR2
--      ...
--)

CREATE TABLE EMP_DDL(
    EMPNO NUMBER(4),ㅅ
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2)
); 
-- DESC 다른 애디터에 사용할 수 없을수도 있다,
DESC EMP_DDL;

-- 1-2. 테이블 및 열 명명법(이름 정하는 법)
--      1.테이블의 이름은 문자로 시작해야한다.
CREATE TABLE 90AAAA(TEST_COL NUMBER(2));
-- 2. 테이블 이름은 30BYTE 이하
-- 3. 같은 사용자 내에 있을 경우, 테이블 이름은 같을 수 없다.
-- 4. 테이블 이름은 영문자(한글), 숫자, 특수문자($,#,_) 사용할 수 있다.
-- 5. SQL키워드는 이름으로 사용할 수 없다. (SELECT, FROM, WHERE 등등)

-- 1-3. 기본 테이블의 열 구조와 데이터까지 같이 복사
CREATE TABLE DEPT_DDL AS
    SELECT
        *
    FROM
        DEPT;
        SELECT
    *
FROM
    DEPT; -- DEPT 에 있는 데이터를 모두 출력하라.
-- 1-4. 기존 테이블 열 구조와 일부 데이터만 복사.
CREATE TABLE EMP_DDL_30 AS
    SELECT
        *
    FROM
        EMP
    WHERE
        DEPTNO =30;
-- 1.5 기존 테이블의 열 구조만 가져오기
CREATE TABLE EMP_DDL_DESC AS
    SELECT
        *
    FROM
        EMP
    WHERE
        1 <> 1;

-- 2. 테이블 변경 (ALTER)
-- 예제 테이블 생성
CREATE TABLE EMP_ALTER AS
    SELECT
        *
    FROM
        EMP;
SELECT
    *
FROM
    EMP_ALTER;

-- 2-1. 테이블에 열(컬럼)을 추가하기 - ADD
ALTER TABLE EMP_ALTER
ADD HP VARCHAR2(20);

-- 2-2. 열 이름을 변경하기 - RENAME
ALTER TABLE EMP_ALTER 
RENAME COLUMN HP TO TEL;

-- 2-3. 열의 자료형을 변경하기 - MODIFY
ALTER TABLE EMP_ALTER 
MODIFY EMPNO NUMBER(5);

--2.4 특정 열을 삭제하기 - DROP
ALTER TABLE EMP_ALTER 
DROP COLUMN TEL;

SELECT
    *
FROM
    EMP_ALTER;

-- 3. 테이블 이름을 변경 - RENAME
RENAME EMP_ALTER TO EMP_RENAME;

SELECT
    *
FROM
    EMP_RENAME;

-- 4. 테이블의 데이터를 삭제 - TRUNCATE
TRUNCATE TABLE EMP_RENAME;
-- *** 이거는 DML 문에서 DELETE 로도 가능,
-- *** TRUNCATE 문을 사용하면 DDL 이기 때문에 ROLLBACK 불가능

-- 5. 테이블 삭제하기 - DROP
DROP TABLE EMP_RENAME;
-- *** 사용시 바로 COMMIT이 되기 때문에 주의해야함.

CREATE TABLE EMP_HW(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2)
); 
ALTER TABLE EMP_HW
ADD BIGO VARCHAR2(20);

ALTER TABLE EMP_HW 
MODIFY BIGO VARCHAR2(30);

ALTER TABLE EMP_HW 
DROP COLUMN BIGO;

ALTER TABLE EMP_HW 
RENAME COLUMN BIGO TO REMARK;

CREATE TABLE EMP_HW AS
    SELECT
        *
    FROM
        EMP;
        SELECT
    *
FROM
    EMP_HW; 

INSERT INTO EMP_HW (
    EMPNO,
    ENAME,
    JOB,
    MGR,
    HIREDATE,
    SAL,
    COMM, DEPTNO
)
    SELECT
        EMPNO,
        ENAME,
        JOB,
        MGR,
        HIREDATE,
        SAL,
        COMM,
        DEPTNO
    FROM
        EMP;

SELECT
    *
FROM
    EMP_HW;





