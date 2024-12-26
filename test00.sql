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

-- test_dept 테이블 데이터 확인
SELECT * FROM test_dept;

-- test_emp 테이블 데이터 확인
SELECT * FROM TEST_EMP;

--15 
CREATE INDEX IDX_NAME_TEST_EMP
ON TEST_EMP(name);

--16 
CREATE VIEW VW_TEST_EMP AS
SELECT e.empno, e.name, d.dname, e.salary
FROM TEST_EMP e
JOIN test_dept d ON e.deptno = d.deptno;

