-- 사용 계정 : 시스템 계정
-- 15장. 사용자, 권한, 롤
-- 사용자 = 계정
-- 사용자 > 스키마 ( 데이터간 관계, 구조, 제약조건, 객체 등등 )
-- 1. 사용자
-- 기본 구문
-- CREATE USER 사용자이름 (필수)
-- IDENTIFIED BY 패스워드 (필수)
-- DEFAULT TABLESPACE 테이블스페이스이름 (선택)
-- TEMPORARY TABLESPACE 테이블스페이스그룹이름 (선택)
-- QUOTA 테이블스페이스크기 ON 테이블스페이스 이름 (선택)
-- PROFILE 프로파일이름(선택)
-- PASSWORD EXPIRE(선택)
-- ACCOUNT [LOCK/UNLOCK](선택)

-- 19C 버전 이상일 경우
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- USERNAME : STUDYORCL / PASSWORD = 1234
CREATE USER STUDYORCL IDENTIFIED BY 1234;
-- 연결을 위한 권한 부여
GRANT CONNECT, RESOURCE TO STUDYORCL;

-- 데이터사전에서 사용자(유저,계정) 찾기
-- 계정이름, 계정번호, 생성일자 확인 
SELECT * FROM ALL_USERS WHERE USERNAME = 'ORCLSTUDY';
-- 위 쿼리문보다 더 많은 정보를 조회
SELECT * FROM DBA_USERS WHERE USERNAME = 'ORCLSTUDY';
-- 사용자가 소유하고 있는 객체를 조회
SELECT * FROM DBA_OBJECTS WHERE OWNER = 'SCOTT';


-- 사용자(유저,계정)의 비밀번호 변경 ( 정보 수정 )
ALTER USER ORCLSTUDY IDENTIFIED BY 4321;

-- 사용자 삭제
-- 다른 곳에 접속되어 있는 계정은 삭제 안됨
DROP USER STUDYORCL;
-- 계정에 객체가 있으면 삭제 안됨 ( CASCADE 사용시 가능 )
DROP USER STUDYORCL CASCADE;
--------------------------------------------------------------------
-- 2. 권한( 책 p.403 또는 알려드린 링크, 구글링 )
--    계정 접속, 테이블 생성, 시퀀스 생성, 뷰 생성, 동의어 생성 등등의 권한
--    CREATE SESSION - 접속을 가능하게
--    CREATE TABLE - 테이블,인덱스,제약조건 생성,수정,삭제
--    CREATE VIEW(SEQUENCE, SYNONYM)
--          - 뷰(시퀀스, 동의어, 롤) 생성,수정,삭제
--    CREATE ANY TABLE, ALTER ANY TABLE, DROP ANY TABLE
--       ANY 라는 단어가 들어가 있으면, 
--       현재 사용자 외의 사용자의 테이블도 생성할 수 있다.

-- 권한 부여
-- 기본 구문 : GRANT [ 권한종류 ] TO [ 사용자 이름 / 롤 이름 / PUBLIC ] 
--            [ WITH ADMIN OPTION ]
--              권한 종류와 사용자이름/롤이름 = 필수
--              WITH ADMIN OPTION = 선택
--                 = 내가 받은 권한을 다른 계정에게 부여 가능
CREATE USER GRANTSTUDY IDENTIFIED BY 1234;
-- 접속에 필요한 권한
GRANT CREATE SESSION TO GRANTSTUDY;
-- 테이블을 만들기 위해 필요한 권한
GRANT CREATE TABLE TO GRANTSTUDY;
GRANT UNLIMITED TABLESPACE TO GRANTSTUDY;

-- 객체 권한 ( 책 p.407 )
-- 테이블, 인덱스, 뷰, 시퀀스, 동의어 등에 관한 권한
-- INSERT, UPDATE, DELETE, INDEX, REFERENCES, SELECT  - 테이블
-- DELETE, INSERT, REFERENCES, SELECT, UPDATE - 뷰
-- 객체 권한 부여
-- 기본 구문 ( 테이블을 예시 )
-- GRANT [ 객체권한 / ALL PRIVILEGES ] ON (열어주는)유저명.객체이름 
-- TO [ (권한을받을)유저명/롤이름/PUBLIC ] [ WITH ADMIN OPTION ]
-- 여기서, PUBLIC 은 전체사용자 라는 뜻이다.
GRANT SELECT,INSERT,UPDATE,DELETE ON SCOTT.EMP TO GRANTSTUDY, SCOTT, HR;

-- 권한을 부여할 때는 줄 권한과 받을 사용자 모두 (,)를 구분자로 사용해서 
-- 여러 개(명)를 부여 가능

-- 권한 취소(삭제)
-- 기본 구문 : REVOKE [권한 종류] FROM [권한취소할사용자/롤/PUBLIC]

-- 접속 권한을 삭제한다.
REVOKE CREATE SESSION FROM GRANTSTUDY;

-- 객체 권한 취소
-- 기본 구문 : REVOKE [객체권한 종류] ON [사용자명.객체명]
--            FROM [권한취소할사용자/롤/PUBLIC]
-- SCOTT.EMP 테이블을 조회하는 권한을 삭제한다.
REVOKE SELECT ON SCOTT.EMP FROM GRANTSTUDY;
----------------------------------------------------------------------
-- 3. 롤 ( ROLE )
--    여러가지 권한을 한 번에 묶은 그룹
--    대표적으로 쓰이는 롤 ( CONNECT , RESOURCE )
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'RESOURCE';
-- CONNECT ( CREATE SESSION )
-- RESOURCE( CREATE TABLE, INDEXTYPE, TRIGGER 등등 )
-- 보통은 리소스로 권한을 부여하지만, 뷰, 동의어는 따로 부여해야한다.

-- 롤 생성 및 사용자에게 부여 과정
-- 1. CREATE ROLE [롤 이름] : 롤(객체) 생성
-- 2. GRANT [권한] TO [롤 이름] : 롤에게 권한 넣기
-- 3. GRANT [롤이름] TO [사용자] : 사용자에게 롤 부여하기
-- 4. REVOKE [롤이름] FROM [사용자] : 부여한 롤 삭제
-- 5. DROP ROLE [롤 이름] : 롤(객체) 삭제
CREATE ROLE NORMAL_USER;
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE SYNONYM TO NORMAL_USER;
GRANT NORMAL_USER TO GRANTSTUDY;
REVOKE NORMAL_USER FROM GRANTSTUDY;
DROP ROLE NORMAL_USER;

-- 사용자에게 부여된 권한(롤) 조회
SELECT * FROM USER_SYS_PRIVS; -- 유저에게 부여된 시스템 권한 조회
SELECT * FROM USER_ROLE_PRIVS;-- 유저에게 부여된 롤 조회
SELECT * FROM USER_TAB_PRIVS; -- 유저에게 부여된 객체 권한 조회

