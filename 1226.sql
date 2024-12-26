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





