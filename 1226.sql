-- PL/SQL
-- SQL 문을 프로그래밍 언어처럼 사용
-- 변수, 상수를 이용해서 조건문, 반복문을 사용할 수 있다.
-- PL/SQL은 선언부, 실행부, 예외처리부 구성.
-- 각각의 하나의 블록으로 이루어 진다.
-- DECLARE ( 선언부 : 변수나 상수를 선언 및 초기화 )
-- BEGIN ( 실행부 : 변수나 상수 값 할당, 조건문, 반복문을 사용 )
-- EXCEPTION ( 예외처리부 : 예상할 수 있는 예외를 코드로 처리 )
-- END; ( PL/SQL 구문의 끝을 알린다. )
-- / ( 더 이상 이어서 PL/SQL 을 사용하지 않는다. )

SET SERVEROUTPUT ON;
-- SET SERVEROUTPUT ON; 구문 옆에는 주석이 있으면 실행 안됨
-- 서버에서 출력을 가능하게 한다
-- 계정 로그인 할 때마다 작성을 해줘야한다

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, WORLD');
END;
/

-- DECLARE ( 선언부 : 변수 및 상수를 선언, 값을 초기화하는 부분 )
-- 변수 선언 구문 : 변수명 자료형(크기) := 값(DATA);
DECLARE
    V_EMPNO NUMBER(4) := 7788; 
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    -- V_EMPNO : 7788 이렇게 출력이된다.
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/
-- PL/SQL 에서의 주석
-- 한줄 주석 : -- 주석내용
-- 블럭 주석 : /* 주석내용 */

-- PL/SQL에서의 변수와 상수
-- 변수 선언 ( 변수명 자료형(크기) := 할당할 값 )
-- 상수 선언 ( 변수명 CONSTANT 자료형(크기) := 할당할 값 )
-- 변수는 값을 계속 변경해서 할당 가능
-- 상수는 값을 한 번 할당하면 다른 값으로 변경 불가능
-- 변수에 기본 값 지정 ( 변수명 자료형(크기) DEFAULT 기본값 )
-- 변수에 NULL 값 넣지 못하게 지정 ( 변수명 자료형(크기) NOT NULL := 값 )
DECLARE
    V_EMPNO NUMBER(4) := 1234;
    V_ENAME VARCHAR2(10) := '홍길동';
    V_MGR CONSTANT NUMBER(4) := 0000;
    V_DEPTNO NUMBER(4) DEFAULT 1234;
    V_SAL01 NUMBER(7,2) NOT NULL := 2000;
    V_SAL02 NUMBER(7,2) NOT NULL DEFAULT 2000;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_MGR : ' || V_MGR);
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_SAL01 : ' || V_SAL01);
    DBMS_OUTPUT.PUT_LINE('V_SAL02 : ' || V_SAL02);
END;
/

-- PL/SQL 의 자료형 ( 스칼라, 복합, 참조 , LOB )
-- 1. 스칼라형 ( NUMBER, VARCHAR2, DATE, BOOLEAN ) : 기본적인 자료형
-- 2. 참조형 : 테이블의 열 또는 행의 자료형을 참조
--          ( 테이블.컬럼%TYPE : 열의 자료형을 참조 )
--          ( 테이블%ROWTYPE : 행의 자료형을 참조 )
-- 3. 복합형 / LOB
--    복합형 : RECORD / COLLECTION  ( 17장에서 다룰 예정 )
--    LOB : LARGE OBJECT 사진 또는 동영상, 음악파일을 저장하는 자료형

-- 참조 자료형 예제
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50; 
    -- V_DEPTNO 라는 변수는 DEPT 테이블의 DEPTNO 열의 자료형을 쓴다.
    V_DEPT_ROW DEPT%ROWTYPE;
    -- SELECT 문을 이용해서 한 줄의 ROW의 데이터를 넣는다.
BEGIN
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
    FROM DEPT
    WHERE DEPTNO = 40;
    -- 위 쿼리문을 사용해서 INTO구문을 이용해 결과값(한 줄의 ROW)을 변수에 대입한다.
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_DEPT_ROW.DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_DEPT_ROW.DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('V_DEPT_ROW.LOC : ' || V_DEPT_ROW.LOC);
END;
/

-- 조건 제어문 ( IF-ELSIF-ELSE / CASE-WHEN-ELSE )
-- 1. IF 조건문 THEN 실행문       -- 첫 번째 실행 조건 ( 필수 )
--    ELSIF 조건문 THEN 실행문    -- 다른 실행 조건 ( 선택 )
--    ELSE 실행문                -- 위 조건문과 모두 다를 때 실행 ( 선택 )
--    END IF;
DECLARE
    V_NUMBER NUMBER(4) := 50;
BEGIN
    IF V_NUMBER > 50 AND V_NUMBER < 101 THEN DBMS_OUTPUT.PUT_LINE('높다');
    ELSIF V_NUMBER > 100 THEN DBMS_OUTPUT.PUT_LINE('많이 높다');
    ELSE DBMS_OUTPUT.PUT_LINE('낮다');
    END IF;
END;
/

-- 2. CASE 문 ( 기본문 )
-- CASE 비교기준
--     WHEN 값1 THEN 실행문
--     WHEN 값2 THEN 실행문
--     ELSE 실행문
-- END CASE;
-- 비교기준이 없다면 WHEN 조건식 THEN 실행문 으로 사용.
DECLARE
    V_NUMBER NUMBER(3) := 4;
BEGIN
    CASE MOD(V_NUMBER,2) -- 1, 0 값만 나온다.
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('홀수입니다.');
        --WHEN 0 THEN DBMS_OUTPUT.PUT_LINE('짝수입니다.');
        ELSE DBMS_OUTPUT.PUT_LINE('짝수입니다.');
    END CASE;
END;
/

DECLARE
    V_NUMBER NUMBER(4) := 87;
BEGIN
    CASE
        WHEN V_NUMBER >= 90 THEN DBMS_OUTPUT.PUT_LINE('A');
        WHEN V_NUMBER >= 80 THEN DBMS_OUTPUT.PUT_LINE('B');
        WHEN V_NUMBER >= 70 THEN DBMS_OUTPUT.PUT_LINE('C');
        WHEN V_NUMBER >= 60 THEN DBMS_OUTPUT.PUT_LINE('D');
        ELSE DBMS_OUTPUT.PUT_LINE('F');
    END CASE;
END;
/

-- 반복문 ( 기본 LOOP , WHILE LOOP, FOR LOOP )
-- 1. 기본 LOOP
DECLARE
    V_NUM NUMBER(4) := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 4;
--      IF V_NUM > 4 THEN EXIT;
--      END IF;
--      LOOP 문을 종료 시키는 2가지 구문 ( EXIT, EXIT WHEN )
--      EXIT = LOOP 문을 바로 종료 ( IF 문과 함께 사용 권장 )
--      EXIT WHEN [조건식] = 조건식에 맞으면 LOOP 문을 종료
    END LOOP;
END;
/

-- 2. WHILE LOOP ( 조건식에 맞으면 실행문을 실행 )
-- WHILE 조건식 LOOP
--      실행문
-- END LOOP;
DECLARE 
    V_NUM NUMBER(4) := 0;
BEGIN
    WHILE V_NUM < 4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM );
        V_NUM := V_NUM + 1;
    END LOOP;
END;
/

-- 3. FOR LOOP
-- FOR 변수명 IN 시작값..종료값 LOOP
--      실행문
-- END LOOP;
BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i 값 : ' || i);
    END LOOP;
END;
/
-- IN 옆에 REVERSE 를 작성하면 종료값 부터 시작값으로 실행한다.
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i 값 : ' || i);
    END LOOP;
END;
/

-- 반복문에 필요한 건너뛰기 ( CONTINUE , CONTINUE WHEN )
-- CONTINUE : 현재 단계를 건너뛰고 다음 단계를 수행한다.
-- CONTINUE WHEN [조건식] : 조건식이 TRUE 면 다음 단계를 수행한다.
BEGIN
    FOR i IN 0..10 LOOP
        --CONTINUE WHEN MOD(i, 2) = 1; -- 홀수면 CONTINUE 하라.
        IF MOD(i,2) = 1 THEN CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('현재 i 값 : ' || i);
    END LOOP;
END;
/

-- 반복문 : LOOP , WHILE LOOP , FOR LOOP
-- LOOP : EXIT, EXIT WHEN을 이용해서 종료
-- WHILE LOOP : WHILE 옆의 조건식이 FALSE 가 되면 반복 종료
-- FOR LOOP : 내가 지정한 시작값과 종료값을 기준으로 반복이 종료
-- 다음 단계로 뛰어넘기는 CONTINUE 와 CONTINUE WHEN 을 사용해서
-- 단계를 뛰어넘을 수 있다.


-- 1번 문제
BEGIN
    FOR i IN 0..10 LOOP
        CONTINUE WHEN MOD(i , 2) = 0;
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/

-- 2번 문제
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    IF V_DEPTNO = 10 THEN DBMS_OUTPUT.PUT_LINE('ACCOUNTING');
    ELSIF V_DEPTNO = 20 THEN DBMS_OUTPUT.PUT_LINE('RESEARCH');
    ELSIF V_DEPTNO = 30 THEN DBMS_OUTPUT.PUT_LINE('SALES');
    ELSIF V_DEPTNO = 40 THEN DBMS_OUTPUT.PUT_LINE('OPERATIONS');
    ELSE DBMS_OUTPUT.PUT_LINE('N/A');
    END IF;
END;
/


-- 17장. 레코드와 컬렉션
-- 레코드 : 각기 다른 데이터를 하나의 변수에 저장
-- TYPE 레코드이름 IS RECORD(
--      변수명 자료형 [NOT NULL] [DEFAULT 또는 := 값];
--      변수명 자료형 [NOT NULL] [DEFAULT 또는 := 값];
--      ...
-- );
DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    
    V_DEPT_REC REC_DEPT;
BEGIN
    V_DEPT_REC.DNAME := 'DATABASE';
    V_DEPT_REC.LOC := 'SEOUL';
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_REC.LOC);
END;
/
-- RECORD 를 가지고 테이블에 INSERT, UPDATE 하기
-- 예제 테이블
CREATE TABLE DEPT_RECORD AS SELECT * FROM DEPT;
SELECT * FROM DEPT_RECORD;
-- 레코드를 이용해서 INSERT 하기
DECLARE
    TYPE REC_DEPT IS RECORD (
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    V_DEPT_REC REC_DEPT;
BEGIN
    V_DEPT_REC.DEPTNO := 99;
    V_DEPT_REC.DNAME := 'JAVA';
    V_DEPT_REC.LOC := 'BUSAN';
    
    INSERT INTO DEPT_RECORD VALUES V_DEPT_REC;
END;
/
SELECT * FROM DEPT_RECORD;

-- 레코드를 사용해서 UPDATE 하기
DECLARE
    TYPE REC_DEPT IS RECORD (
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    V_DEPT_REC REC_DEPT;
BEGIN
    V_DEPT_REC.DEPTNO := 60;
    V_DEPT_REC.DNAME := 'DB';
    V_DEPT_REC.LOC := 'SEOUL';
    
    UPDATE DEPT_RECORD
    SET ROW = V_DEPT_REC
    WHERE DEPTNO = 99;
END;
/
SELECT * FROM DEPT_RECORD;

-- 레코드를 포함하는 레코드
DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    TYPE REC_EMP IS RECORD(
        EMPNO EMP01.EMPNO%TYPE,
        ENAME EMP01.ENAME%TYPE,
        DINFO REC_DEPT
    );
    V_EMP_REC REC_EMP;
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
        INTO V_EMP_REC.EMPNO, 
             V_EMP_REC.ENAME, 
             V_EMP_REC.DINFO.DEPTNO,
             V_EMP_REC.DINFO.DNAME, 
             V_EMP_REC.DINFO.LOC
    FROM EMP01 E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.EMPNO = 7788;
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || V_EMP_REC.EMPNO);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || V_EMP_REC.ENAME);
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_EMP_REC.DINFO.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_EMP_REC.DINFO.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_EMP_REC.DINFO.LOC);
END;
/

-- 컬렉션 : 자료형이 같은 여러 데이터를 저장 ( 배열 )
-- TYPE [이름] IS TABLE OF 자료형[NOT NULL]
-- INDEX BY 인덱스형;
-- 위의 자료형에는 스칼라형, 참조형이 들어갈 수 있다.
-- 위의 인덱스형에는 BINARY_INTEGER(이진수), PLS_INTEGER(정수),
--      VARCHAR2(문자)가 들어갈 수 있다.
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;
    
    TEXT_ARR ITAB_EX;
BEGIN
    TEXT_ARR(1) := '1ST';
    TEXT_ARR(2) := '2ND';
    TEXT_ARR(3) := '3RD';
    TEXT_ARR(4) := '4TH';
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(1) : ' || TEXT_ARR(1));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(2) : ' || TEXT_ARR(2));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(3) : ' || TEXT_ARR(3));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(4) : ' || TEXT_ARR(4));
END;
/
    
-- %ROWTYPE 으로 배열 저장하기
DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    DEPT_ARR ITAB_DEPT;
    idx PLS_INTEGER := 0;
BEGIN
    FOR i IN (SELECT * FROM DEPT) LOOP
    -- i 에는 deptno, dname, loc 가 한 줄씩 저장된다.
        idx := idx + 1;
        DEPT_ARR(idx).DEPTNO := i.DEPTNO;
        DEPT_ARR(idx).DNAME := i.DNAME;
        DEPT_ARR(idx).LOC := i.LOC;
        
        DBMS_OUTPUT.PUT_LINE('DEPT_ARR(idx).DEPTNO : ' 
                    || DEPT_ARR(idx).DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DEPT_ARR(idx).DNAME : ' 
                    || DEPT_ARR(idx).DNAME);
        DBMS_OUTPUT.PUT_LINE('DEPT_ARR(idx).LOC : ' 
                    || DEPT_ARR(idx).LOC);
    END LOOP;
    
    -- 컬렉션 관련한 메서드 ( P.455 참고 )
    DBMS_OUTPUT.PUT_LINE('DEPT_ARR.COUNT : ' || DEPT_ARR.COUNT);
    DBMS_OUTPUT.PUT_LINE('DEPT_ARR.FIRST : ' || DEPT_ARR.FIRST);
    DBMS_OUTPUT.PUT_LINE('DEPT_ARR.LAST : ' || DEPT_ARR.LAST);
    DBMS_OUTPUT.PUT_LINE('DEPT_ARR.PRIOR(5) : ' || DEPT_ARR.PRIOR(5));
    DBMS_OUTPUT.PUT_LINE('DEPT_ARR.NEXT(5) : ' || DEPT_ARR.NEXT(5));
END;
/