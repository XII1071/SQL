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
    -- SELECT 문을 이용해서 한 줄의 ROW 데이터를 넣는다.
    SELECT
        DEPTNO,
        DNAME,
        LOC INTO V_DEPT_ROW
    FROM
        DEPT
    WHERE
        DEPTNO = 40;
    -- 위 쿼리문을 사용해서 INTO 구문을 이용해 결과값 (한 줄 ROW)을 변수에 대입한다.
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : '
                         || V_DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_DEPT_ROW.DEPTNO : '
                         || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('V_DEPT_ROW.DNAME : '
                         || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('V_DEPT_ROW.LOC : '
                         || V_DEPT_ROW.LOC);
END;
/

-- 조건 제어문 ( IF-ELSEIF-ELSE / CASE-WHEN-ELSE)
-- 1. IF 조건문 THEN 실행문         -- 첫 번째 실행 조건 (필수)
--    ELSEIF 조건문 THEN 실행문     -- 다른 실행 조건 (선택)
--    ELSE 실행문                  -- 위 조건문과 모두 다를 때 실행 (선택)
DECLARE
    V_NUMBER NUMBER(4) := 200;
BEGIN
    IF V_NUMBER > 50 AND V_NUMBER < 101 THEN
        DBMS_OUTPUT.PUT_LINE('높다');
    ELSIF V_NUMBER > 100 THEN
        DBMS_OUTPUT.PUT_LINE('많이 높다');
    ELSE
        DBMS_OUTPUT.PUT_LINE('낮다');
        END IF;
    END;
/

-- 2. CASE 문
-- CASE 비교기준
--  WHEN 값1 THEN 실행문
--  WHEN 값2 THEN 실행문
--  ELSE 실행문
-- END CASE;
-- 비교기준이 없다면 WHEN 조건문을 THEN 실행문으로 사용.
DECLARE
    V_NUMBER := 4;
BEGIN
    CASE MOD(V_NUMBER, 2) -- 1, 0 값만 나온다.
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('홀수입니다.');
        -- WHEN 0 THEN DBMS_OUTPUT.PUT_LINE('짝수입니다.');
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

-- 반복문 ( 기본 LOOP, WHILE LOOP, FOR LOOP )
-- 1. 기본 LOOP
DECLARE
    V_NUM NUMBER(4) := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 4;
        -- IF V_NUM > 4 THEN EXIT;
        -- END IF;
        -- END IF;
        -- LOOP 문을 종료 시키는 2가지 구문 ( EXIT, EXIT WHEN )
        -- EXIT = LOOP문을 바로 종료 ( IF 문과 함께 사용 권장 )
        -- EXIT WHEN [조건식] = 조건식에 맞으면 LOOP문을 종료
    END LOOP;
END;
/

-- 2. WHILE LOOP ( 조건식에 맞으면 실행문을 실행  )
-- WHILE 조건식
--      실행문
-- END LOOP;
DECLARE
    V_NUM NUMBER(4) := 0;
BEGIN