-- 계정 : scott
-- 13장.객체 종류 (데이터사전, 인덱스, 뷰, 시퀀스, 동의어)
-- 오라클 데이터베이스에 2가지 테이블

-- 1.데이터 사전
-- 1. 사용자 테이블 : 데이터를 저장하는 테이블
-- 2. 데이터 사전: 데이터베이스가 운영하기 위해 필요한 정보
--      수정을 하면 안되기 때문에, 직접 접근 x, 뷰를 통해 보기만 가능.
--      SELECT 문으로 확인이 가능하다.
-- 1-3. 데이터 사전은 접두어를 통해서 용도를 알 수 있다.
--      - USER_XXXX : 사용자가 소유한 객체
--      - ALL_XXXX : 현 사용자가 가능한 모든 객체
--      - DBA_XXXX : DB 관리를 위한 정보(SYS,SYSTEM 계정 열람 가능.)
--      - V$_XXXX : 데이터베이스 성능 관련 정보

-- 데이터베이스 사전 출력하기
SELECT
    *
FROM
    DICT;
SELECT
    *
FROM
    DICTIONARY;

-- USER_ 접두어를 가진 데이터사전
SELECT
    *
FROM
    DICT
WHERE
    TABLE_NAME LIKE 'USER%';

-- 사용자 테이블 확인하기
SELECT
    TABLE_NAME, NUM_ROWS
FROM
    USER_TABLES;
SELECT
    TABLE_NAME
FROM
    USER_TABLES;

-- ALL_ 접두어를 가진 데이터사전
SELECT
    *
FROM
    DICTIONARY
WHERE
    TABLE_NAME LIKE 'ALL%';

-- 현 사용자가 볼 수 있는 테이블 확인
SELECT
    *
FROM
    ALL_TABLES;
SELECT
    OWNER, TABLE_NAME
FROM    
    ALL_TABLES;

-- DBA_ 접두어를 가진 데이터사전 
-- (SYS, SYSTEM 계정으로만 열람 가능. (Localhost_oraclexe11g))
-- SELECT * FROM DBA_TABLES; (SCOTT 계정이니 오류가뜸.)
-- SCOTT 계정에 대한 정보 확인 (SYS, SYSTEM 계정으로만 열람 가능.)


-- SELECT * FROM DBA_TABLES WHERE USERNAME = 'SCOTT'; (SCOTT 계정이니 오류가뜸.)

-- 2. 인덱스 (색인) : 검색 효율을 높이기 위해 사용
--          - 테이블의 컬럼에 사용하는 객체
--          - 인덱스를 사용해서 검색 : INDEX SCAN
--          - 인덱스를 사용하지 않고 검색 : TABLE FULL SCAN
--          - 데이터 사전 검색 가능 : USER_INDEXES, USER_IND_COLUMNS
--          - 기본키(PK), 고유키(UNIQUE KEY)를 설정하면 자동으로 인덱스가 설정된다.
SELECT
    *
FROM
    USER_INDEXES; -- 인덱스 자체에 대한 정보

SELECT
    *
FROM
    USER_IND_COLUMNS; -- 인덱스 걸린 컬럼의 정보


-- 2-1. 인덱스 생성
-- 기본 구문 : 
--      CREATE INDEX 인덱스이름 ON 테이블이름 (열1이름 ASC/DESC, 열2이름 ASC/DESC, ...)
--          열 이름 작성할 떄, ASC, DESC 작성가능 (기본값 : ASC)
CREATE INDEX EMP_IDX_SAL ON EMP(SAL);
-- 생성된 인덱스 확인
SELECT
    *
FROM
    USER_INDEXES; -- 인덱스 자체에 대한 정보

SELECT
    *
FROM
    USER_IND_COLUMNS; -- 인덱스 걸린 컬럼의 정보
-- 인덱스를 사용했다고 무조건 검색 효율이 좋아지는 것은 아니다.
-- 데이터 구조, 데이터 분포도, 조회하는 쿼리, 작업 빈도 등등 여러가지를 고려해야함.

-- 2-2. 인덱스 삭제 (DROP)
-- 기본 구문 : DROP INDEX 인덱스이름;
DROP INDEX EMP_IDX_SAL;

-- 인덱스에 관련해서 좀 알아보고 싶다? SQL 튜닝 관련 서적이나 구글검색


-- 3. 뷰 (VIEW) : 하나 이상의 테이블을 조회하는 SELECT 문을 저장한 객체.
--      - 가상 테이블
--      - 사용 목적 : 보안, 편리
--          = 편리 : 자주 사용하는 쿼리문을 저장해놓고 한 번에 확인.
--          == 보안 : 남에게 보여주기 힘든 데이터를 보여주지 않고 저장
--      서브쿼리문 예제
SELECT
    *
FROM
    (
        SELECT
            EMPNO,
            ENAME,
            JOB,
            DEPTNO
        FROM
            EMP
        WHERE
            DEPTNO = 20
    );

-- 3-1. 뷰 생성
-- 아래의 기본구문 중 [] 안에 있는 내용은 선택사항이다.
-- 기본 구문 : CREATE [OR REPLACE] [FORCE / NOFORCE] VIEW 뷰이름
--            AS (SELECT문)
--            [WITH CHECK OPTION]
--            [WITH READ ONLY]
CREATE VIEW VW_EMP20
AS 
    (   
        SELECT     
        EMPNO,
        ENAME,
        JOB,
        DEPTNO
        FROM
            EMP
        WHERE
            DEPTNO = 20
    );
 -- 에러 걸림 현재 뷰는 권한이 없어 시스템 계정으로 GRANT CREATE VIEW TO SCOTT;실핼한 후 접속해야 함

-- VW_EMP20 조회
SELECT
    *
FROM
    VW_EMP20;

-- VIEW 데이터 사전 조회 (CMD 에서는 쿼리문을 작성한 대로 볼 수 있음.)
SELECT
    *
FROM
    USER_VIEWS;

-- 3-2. 뷰(VIEW) 삭제
-- 기본 구문 : DROP VIEW 뷰이름;
DROP VIEW VW_EMP20;

-- 3-3. 뷰에는 UPDATE, DELETE 사용 가능할까?
--      WITH READ ONLY 가 아닌 이상 가능하다.
--      VIEW 에서 데이터를 변경하면 원 테이블에서도 변경이된다.
--      데이터를 변경하거나, VIEW를 생성할 때의 옵션을 잘 고려해야한다.

CREATE VIEW VW_EMP20
AS 
    (   
        SELECT     
        EMPNO,
        ENAME,
        JOB,
        DEPTNO
        FROM
            EMP
        WHERE
            DEPTNO = 20
    );

UPDATE VW_EMP20
SET
    ENAME='SSSSS'
WHERE
    EMPNO = 7788;

SELECT * FROM VW_EMP20;
SELECT * FROM EMP;

ROLLBACK;

-- 3-4. 인라인 뷰를 사용한 TOP-N SQL문
--      ROWNUM : 조회할 때 불러오는 숫자 (행 번호)
SELECT
    ROWNUM,
    E. *
FROM
    EMP E;

SELECT
    ROWNUM,
    E. *
FROM
    EMP E ORDER BY SAL;
SELECT
    ROWNUM,
    E.*
FROM
    (
        SELECT
            *
        FROM
            EMP
        ORDER BY
            SAL
    ) E
WHERE
    ROWNUM <= 5;

WITH E AS (SELECT * FROM EMP ORDER BY SAL)
SELECT ROWNUM, E. *
FROM E
WHERE ROWNUM <=5;

-- 4. 시퀀스(SEQUENCE) : 특정 규칙에 맞게 숫자를 생성해주는 객체
SELECT
    COUNT(*)
FROM
    EMP;
-- 4-1. 시퀀스 생성
-- 아래 기본구문의 []는 선택사항이며, n은 숫자 입력이다.
-- 기본구문 : CREATE SEQUENCE 시퀀스 이름
--              [INCREMENT BY n]         : 증가폭 얼마만큼 증가할 것인가
--              [START WITH n]           : 시작 값
--              [MAXVALUE n]             : 최대 값
--              [MINVALUE n]             : 최소 값
--              [CYCLE / NOCYCLE]        : 다시 돌아갈 것인가?
--              [CACHE n / NOCACHE]      : 생성할 번호를 메모리에 미리 활당할것인가?

-- 예제 테이블 : DEPT 테이블의 구조만 가져온다.
-- 테이블 명 : DEPT_SEQUENCE
CREATE TABLE DEPT_SEQUENCE AS
    SELECT
        *
    FROM
        DEPT
    WHERE
        1<>1;

SELECT
    *
FROM
    DEPT_SEQUENCE;

-- 시퀀스 생성 : 10씩 증가, 10부터 시작, 최대값 90, 최소값 0
--             사이클 없음. 캐시 2
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
    INCREMENT BY 10
    START WITH 10
    MAXVALUE 90
    MINVALUE 0
    NOCYCLE
    CACHE 2;
 
-- 4-2. 시퀀스 사용
-- 시퀀스이름. CURRVAL : 시퀀스가 마지막으로 생성한 번호(현재 번호, CURRENT VALUE)
-- 시퀀스이름. NEXTVAL : 시퀀스가 다음으로 출력할 번호(다음 번호, NEXT VALUE)
INSERT INTO DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
-- 시퀀스 이름.NEXTVAL 를 사용하기만 하면 시퀀스는 증가한다.
SELECT
    SEQ_DEPT_SEQUENCE.CURRVAL -- 10 출력
FROM
    DUAL;
SELECT
    SEQ_DEPT_SEQUENCE.CURRVAL, SEQ_DEPT_SEQUENCE.NEXTVAL -- 20, 20 출력
FROM
    DUAL;
SELECT
    *
FROM
    DEPT_SEQUENCE;

-- 시퀀스 수정
-- 기본구문 : ALTER SEQUENCE 시퀀스이름

--              [INCREMENT BY n]         : 증가폭 얼마만큼 증가할 것인가
--              [MAXVALUE n / NOMAXVALUE]: 최대 값
--              [MINVALUE n / NOMINVALUE]: 최소 값
--              [CYCLE / NOCYCLE]        : 다시 돌아갈 것인가?
--              [CACHE n / NOCACHE]  
-- ***** START WITH 는 수정할 수 없다.

ALTER SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 3
MAXVALUE 99
CYCLE;

INSERT INTO DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');

SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO;

-- 4-3. 시퀀스 삭제
-- 기본구문 : DROP SEQUENCE 시퀀스이름;

DROP SEQUENCE SEQ_DEPT_SEQUENCE;

-- 4-4. 시퀀스 데이터 사전 조회 ( USER_SEQUENCES )

SELECT * FROM USER_SEQUENCES;

-- 5. 동의어 (SYNONYM) : 테이블, 뷰, 시퀀스 등의 객체 이름을 다른 이름으로 부여
--          - 주로 이름이 너무 길어서 불편할 때 사용.
-- 5-1. 동의어 생성
-- 기본구문 : CREATE [PUBLIC] SYNONYM 동의어이름
--              FOR [사용자.][객체이름];
--              예제) HR계정의 EMPLOYEES 라는 객체(테이블블)를 가져올 때,
--                  FOR HR.EMPLOYEES 라고 작성
CREATE SYNONYM E FOR EMP;
SELECT
    *
FROM
    E;

-- 5-2. 동의어 삭제
-- 기본구문 : DROP SYNONYM 동의어 이름;
DROP SYNONYM E;

-- 5-3. 데이터 사전 조회
SELECT
    *
FROM
    USER_SYNONYMS;

-- 13장 1번문제

-- 1-1 EMP 테이블과 같은 구조와 데이터를 가진 EMP IDX 테이블을 만들어보세요.
-- 1-2. 생성한 EMPIDX 테이블의 EMPNO 열에 IDX_EMPIDX_EMPNO 인덱스를 만들어보세요.
-- 1-3. 마지막으로 인덱스가 잘 생성되었는지, 데이터 사전 뷰를 통해 확인해보세요.

CREATE TABLE EMPIDX AS
    SELECT
        *
    FROM
        EMP;
CREATE INDEX IDX_EMPIDX_EMPNO ON EMPIDX(EMPNO);

SELECT
    *
FROM
    USER_INDEXES
WHERE
    INDEX_NAME = 'IDX_EMPIDX_EMPNO';
SELECT * FROM USER_IND_COLUMNS WHERE INDEX_NAME = 'IDX_EMPIDX_EMPNO';

-- 13장 2번문제

-- 2-1 EMPIDX 테이블의 데이터 중 급여(SAL)가 1500 초과인 사원들만 출력하는
--  EMPIDX_OVER15K 뷰를 생성하세요
-- 2-2 이름이 같은 뷰가 이미 존재할 때는 새로운 내용으로 대체 가능해야하며,
-- 2-3 EMPIDX_OVER15K 뷰는 사원번호(EMPNO), 사원이름(ENAME), 직책(JOB)
-- 부서번호(DEPTNO), 급여(SAL), 추가수당(COMM) 열을 가진다.
-- 2-4 추가수당 열의 경우, 데이터를 가지고 있으면 'O' 아니면 'X'를 출력

CREATE OR REPLACE VIEW EMPIDX_OVER15K
AS 
    (   
        SELECT     
        EMPNO,
        ENAME,
        JOB,
        DEPTNO,
        SAL,
        NVL2(COMM, 'O', 'X')AS COMM
        FROM
            EMPIDX
        WHERE
            SAL > 1500
    );
    SELECT
    *
FROM
    EMPIDX_OVER15K;

-- 13장 3번 문제

-- 3-1. DEPT 테이블과 같은 열과 행 구성을 가지는 DEPTSEQ 테이블 생성
-- 3-2. 생성한 DEPTSEQ의 테이블에 시퀀스 생성
            시작값 : 1 / 증가폭 : 1 / 최대값 : 99 / 최소값 : 1
            최대값에서 생성 중단 / 캐시 없음
-- 3-3. DEPTSEQ 테이블에 아래(좌)와 같이 세개의 부서를 입력하여 아래(우)의 결과물을 나타내어라.

CREATE TABLE DEPTSEQ AS
    SELECT
        *
    FROM
        DEPT;

CREATE SEQUENCE SEQ_DEPTSEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 99
    MINVALUE 1
    NOCYCLE
    NOCACHE;

INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC)
VALUES(SEQ_DEPTSEQ.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC)
VALUES(SEQ_DEPTSEQ.NEXTVAL, 'WEB', 'BUSAN');
INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC)
VALUES(SEQ_DEPTSEQ.NEXTVAL, 'MOBILE', 'ILSAN');

SELECT * FROM DEPTSEQ;

INSERT INTO TABLE_PK(
    LOGIN_ID,
    LOGIN_PW,
    TEL
) VALUES (
    'ID_01',
    'PWD01',
    '01012341234'
);


-- 제약조건 추가 (CREATE TABLE 시)
-- : 컬럼명 자료형 제약조건종류

-- 제약조건 추가 (CREATE TABLE 시)
-- : 컬럼명 자료형 제약조건종류

-- 제약조건 이름과 함께 넣기 (CREATE TABLE 시)
-- : 컬럼명 자료형 CONSTRAINT 제약조건이름 제약조건종류

-- 이미 있는 테이블에 제약조건 추가하기
-- : 
-- : ALTER TABLE 테이블명 MODIFY (컬럼명 CONSTRAINT 이름 종류)
-- 이름수정 
--      (ALTER TABLE 테이블명 RENAME CONSTRAINT 제약조건이름 TO 바꿀이름)