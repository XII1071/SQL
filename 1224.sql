-- 14 -5

-- 5. CHECK 제약조건
-- 데이터 삽입에 대한 조건을 부여.
CREATE TABLE TABLE_CHECK(
    LOGIN_ID VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCHK_LOGINPW_CK CHECK(LENGTH(LOGIN_PWD)>3),
    TEL VARCHAR2(20)
);

-- 제약조건에 반하는 데이터 삽입
INSERT INTO TABLE_CHECK
VALUES('TEST_ID', '123', '010-1234-1234');
-- 제약조건에 맞춰서 데이터 삽입
INSERT INTO TABLE_CHECK
VALUES('TEST_ID', '1234', '010-1234-1234');
-- CHECK 제약조건을 데이터 사전에서 확인하기
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE 'TABLE_CHECK';

-- 6. DEFAULT
-- 기본 값을 설정
CREATE TABLE TABLE_DEFAULT(
    LOGIN_ID VARCHAR2(20) CONSTRAINT TBL_DEFAULT_PK PRIMARY KEY,
    LOGIN_PW VARCHAR2(20) DEFAULT '1234',
    TEL VARCHAR2(20)
);
-- 기본 값 데이터 넣기
INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL)
VALUES('TEST_01', '010-1234-1234');
SELECT * FROM TABLE_DEFAULT;
-- 데이터로 NULL 을 넣으면 ?
INSERT INTO TABLE_DEFAULT(LOGIN_ID, LOGIN_PW, TEL)
VALUES('TEST_02', NULL, '010-123-1234');
SELECT * FROM TABLE_DEFAULT;

-- 제약조건 일시적 활성화/비활성화
-- ALTER TABLE 테이블이름 ENABLE [NOVALIDATE / VALIDATE] 
-- CONSTRAINT 제약조건이름
-- ALTER TABLE 테이블이름 DISABLE [NOVALIDATE / VALIDATE]
-- CONSTRAINT 제약조건이름


-- ① DEPT_CONST 테이블 생성
-- 부서 정보(부서 번호, 부서 이름, 위치)를 저장하는 테이블입니다.
CREATE TABLE DEPT_CONST ( 
   DEPTNO NUMBER(2)    CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY, -- DEPTNO를 기본 키로 설정하여 고유하게 만듭니다.
   DNAME  VARCHAR2(14) CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,     -- DNAME을 유니크 제약 조건으로 설정하여 중복 방지.
   LOC    VARCHAR2(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL       -- LOC에 NOT NULL 제약 조건 추가.
);

-- ② EMP_CONST 테이블 생성
-- 직원 정보(직원 번호, 이름, 직책, 전화번호, 입사일, 급여, 보너스, 부서 번호)를 저장하는 테이블입니다.
CREATE TABLE EMP_CONST ( 
   EMPNO    NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY, -- EMPNO를 기본 키로 설정하여 고유하게 만듭니다.
   ENAME    VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL, -- ENAME에 NOT NULL 제약 조건 추가.
   JOB      VARCHAR2(9),                                       -- JOB(직책) 컬럼.
   TEL      VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE,    -- TEL에 유니크 제약 조건 추가로 중복 방지.
   HIREDATE DATE,                                               -- HIREDATE(입사일) 컬럼.
   SAL      NUMBER(7, 2) CONSTRAINT EMPCONST_SAL_CHK CHECK (SAL BETWEEN 1000 AND 9999), -- SAL에 CHECK 제약 조건 추가(급여 범위 1000~9999).
   COMM     NUMBER(7, 2),                                       -- COMM(보너스) 컬럼.
   DEPTNO   NUMBER(2) CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST (DEPTNO) -- DEPTNO에 외래 키 설정, DEPT_CONST의 DEPTNO 참조.
); 
	     
-- ③ 제약 조건 정보 조회
-- EMP_CONST와 DEPT_CONST 테이블에 설정된 제약 조건 정보를 조회합니다.
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE 
  FROM USER_CONSTRAINTS 
 WHERE TABLE_NAME IN ( 'EMP_CONST', 'DEPT_CONST' ) -- EMP_CONST, DEPT_CONST 테이블의 제약 조건 필터링.
ORDER BY CONSTRAINT_NAME; -- 제약 조건 이름 기준으로 정렬.

SELECT
    *
FROM
    ROLE_SYS_PRIVS
WHERE ROLE = 'RESOURCE';