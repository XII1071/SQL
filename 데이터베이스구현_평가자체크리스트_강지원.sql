CREATE USER test00 IDENTIFIED BY 1234;
-- 3. 필요한 권한 부여
GRANT CONNECT TO test00; -- 기본 접속 권한
GRANT RESOURCE TO test00; -- 리소스 생성 권한
GRANT CREATE SESSION TO test00; -- 세션 생성 권한
GRANT CREATE VIEW TO test00; -- 뷰 생성 권한
GRANT CREATE SYNONYM TO test00; -- 동의어 생성 권한
GRANT CREATE SEQUENCE TO test00;
-- 4. 롤을 생성하고 권한을 롤에 부여
CREATE ROLE test_role;

GRANT CONNECT TO test_role; -- 접속 권한
GRANT RESOURCE TO test_role; -- 리소스 생성 권한
GRANT CREATE SESSION TO test_role; -- 세션 생성 권한
GRANT CREATE VIEW TO test_role; -- 뷰 생성 권한
GRANT CREATE SYNONYM TO test_role; -- 동의어 생성 권한

-- 5. 롤을 사용자에게 부여
GRANT test_role TO test00;

--3번
ALTER USER test00 IDENTIFIED BY oracle;


-- 4번
CREATE TABLE TEST_DEPT(
DEPTNO VARCHAR2(6),
DNAME VARCHAR2(6)
);
-- 5번
ALTER TABLE TEST_DEPT
ADD LOC VARCHAR2(10);

--6
ALTER TABLE TEST_DEPT MODIFY DNAME VARCHAR2(10);

--7
ALTER TABLE TEST_DEPT DROP COLUMN LOC;

--8
ALTER TABLE TEST_DEPT MODIFY DEPTNO PRIMARY KEY;

-- 9


SELECT * FROM TEST_DEPT;

--  10. 

CREATE TABLE TEST_EMP (

EMPNO NUMBER(4) PRIMARY KEY,
NAME VARCHAR2(10) NOT NULL,  
SALARY NUMBER(10) NOT NULL,
POSITION VARCHAR2(10) CONSTRAINT CK_POSITION CHECK (position IN ('사원', '대리', '과장', '부장')),
DEPTNO VARCHAR2(6)
); 
DESC TEST_EMP;      

-- 11.
SELECT * FROM test_emp;

-- 12.
-- 외래키 제약 조건 추가
ALTER TABLE TEST_EMP
ADD CONSTRAINT FK_DEPTNO_TEST_EMP FOREIGN KEY (deptno)
REFERENCES TEST_DEPT (deptno);

-- 확인: 외래키 제약 조건 조회
SELECT constraint_name, constraint_type, table_name, r_constraint_name
FROM user_constraints
WHERE table_name = 'TEST_EMP' AND constraint_type = 'R';


--13. 

-- SEQ_TEST_EMP 시퀀스 생성
CREATE SEQUENCE SEQ_TEST_EMP
START WITH 1000         -- 시작 값
INCREMENT BY 10         -- 증가 값
MAXVALUE 9990           -- 최대 값
MINVALUE 0              -- 최소 값
NOCYCLE;                -- 최대 값에 도달하면 종료 (순환하지 않음)

-- 확인: 시퀀스 정의 조회
SELECT sequence_name, min_value, max_value, increment_by, cycle_flag 
FROM user_sequences 
WHERE sequence_name = 'SEQ_TEST_EMP';

--14.
-- test_emp 테이블에 데이터 삽입 (empno는 시퀀스를 사용)
INSERT INTO TEST_DEPT (DEPTNO, dname) VALUES (101, '영업부');
INSERT INTO TEST_DEPT (DEPTNO, dname) VALUES (102, '개발부');

INSERT INTO TEST_EMP (EMPNO, NAME, SALARY, POSITION, DEPTNO) 
VALUES (SEQ_TEST_EMP.NEXTVAL, '홍길동', 1000, '사원', 101);

INSERT INTO TEST_EMP (EMPNO, NAME, SALARY, POSITION, DEPTNO) 
VALUES (SEQ_TEST_EMP.NEXTVAL, '전우치', 1500, '대리', 102);

INSERT INTO TEST_EMP (EMPNO, NAME, SALARY, POSITION, DEPTNO) 
VALUES (SEQ_TEST_EMP.NEXTVAL, '실리안', 2000, '과장', 101);

INSERT INTO TEST_EMP (EMPNO, NAME, SALARY, POSITION, DEPTNO) 
VALUES (SEQ_TEST_EMP.NEXTVAL, '김또치', 1500, '부장', 102);

SELECT * FROM test_dept;

SELECT * FROM TEST_EMP;

--15 
CREATE INDEX IDX_NAME_TEST_EMP
ON TEST_EMP(name);

--16 
CREATE VIEW VW_TEST_EMP AS
SELECT e.empno, e.name, d.dname, e.salary
FROM TEST_EMP e
JOIN test_dept d ON e.deptno = d.deptno;








--17번
-- 1. test02 사용자 생성
CREATE USER test02 IDENTIFIED BY 4321;

-- 2. test01 사용자의 test_emp 테이블에 대한 권한 부여
GRANT SELECT, INSERT, UPDATE, DELETE ON test00.test_emp TO test02;

--18

-- 1. NORMAL_USER01 롤 생성
CREATE ROLE NORMAL_USER01;

-- 2. 롤에 권한 부여
GRANT CREATE SESSION, CREATE VIEW, CREATE SYNONYM, CREATE RESOURCE TO NORMAL_USER01;

-- 3. test02 사용자에게 롤 부여
GRANT NORMAL_USER01 TO test02;  

--19

-- 1. test02 사용자에게서 NORMAL_USER01 롤 철회
REVOKE NORMAL_USER01 FROM test02;

-- 2. NORMAL_USER01 롤에서 권한 제거
REVOKE CREATE SESSION, CREATE VIEW, CREATE SYNONYM, CREATE RESOURCE FROM NORMAL_USER01;

--20
-- test02 계정 삭제
DROP USER test02 CASCADE;



