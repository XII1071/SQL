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

