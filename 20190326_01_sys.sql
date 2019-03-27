
--1줄 주석문 처리(단일행 주석문 처리)

/*
여러줄
(다중 행)
주서문
처리
*/

--○ 현재 오라클 서버에 접속한 자신의 계정 조회
show user;
--==>> USER이(가) "SYS"입니다.
--> sqlplus 상태일 때 사용하는 명령어


SELECT USER
FROM DUAL;
--==>> 

SELECT 1+2
FROM DUAL;
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

SELECT '쌍용강북F강의장'
FROM DUAL;
--==>> 쌍용강북F강의장


SELECT '아직은 지루한 오라클 수업';
--==>>
/*
ORA-00923: FROM keyword not found where expected
00923. 00000 -  "FROM keyword not found where expected"
*Cause:    
*Action:
34행, 23열에서 오류 발생
*/

SELECT '아직은 지루한 오라클 수업'
FROM DUAL;
--==>> 아직은 지루한 오라클 수업

SELECT 3.14 + 1.36
FROM DUAL;
--==>> 4.5

SELECT 1.234 + 2.345
FROM DUAL;
--==>> 3.579

SELECT 10 * 5
FROM DUAL;
--==>> 50

SELECT 1000/3
FROM DUAL;
--==>> 333.333333333333333333333333333333333333

SELECT 100-23
FROM DUAL;
--==>> 77

SELECT "테스트"
FROM DUAL;
--==>>
/*
ORA-00904: "테스트": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
68행, 8열에서 오류 발생
*/

SELECT '김정규' + '윤희진'
FROM DUAL;
--==>> 
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

 
 --○ 현재 오라클 서버에 존재하는 사용자 계정 상태 정보 조회
 
 SELECT *
 FROM DBA_USERS;
 --==>>
 /*
SYS	0		OPEN		19/09/21	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
SYSTEM	5		OPEN		19/09/21	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
ANONYMOUS	35		OPEN		14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP			N	PASSWORD
HR	43		OPEN		19/09/21	USERS	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_PUBLIC_USER	45		LOCKED	14/05/29	14/11/25	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
FLOWS_FILES	44		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_040000	47		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
OUTLN	9		EXPIRED & LOCKED	19/03/25	19/03/25	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DIP	14		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
ORACLE_OCM	21		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XS$NULL	2147483638		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
MDSYS	42		EXPIRED & LOCKED	14/05/29	19/03/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
CTXSYS	32		EXPIRED & LOCKED	19/03/25	19/03/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DBSNMP	29		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XDB	34		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APPQOSSYS	30		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
 */
 
 --> 『DBA_』로 시작하는 Oracle Data Dictionary View 는
 --  오로지 관리자 권한으로 접속했을 경우에만 조회가 가능하다.
 --  아직은 데이터 딕셔너리 개념을 잡지 못해도 상관없다.
 
 --○ 『HR』 사용자 계정을 잠금 상태로 설정
 ALTER USER HR ACCOUNT LOCK;
 --==>> User HR이(가) 변경되었습니다.
 
--○ 다시 사용자 계정 정보 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
    :
HR	LOCKED
    :
*/

--○ 『HR』 사용자 계정 잠금 해체
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR이(가) 변경되었습니다
 
--○ 다시 사용자 계정 정보 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS; 
--==>>
/*
    :
HR	OPEN
    :
*/
 
---------------------------------------------------------------------------

--○ TABLESPACE 생성

--※ TABLESPACE 란?
--   세그먼트(테이블, 인덱스, ...)를 담아두는(저장해두는)
--   오라클의 논리적인 저장 구조를 의미한다.

CREATE TABLESPACE TBS_EDUA                      -- CREATE 유형 개체명 → 생성 
DATAFILE 'C:\TESTORADATA\TBS_EDUA01.DBF'        -- 물리적으로 연결되는 데이터 파일
SIZE 4M                                         -- 물리적 데이터 파일의 용량
EXTENT MANAGEMENT LOCAL                         -- 오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO;                  -- 세그먼트 공간 관리도 사동으로 오라클 서버가
--==>> TABLESPACE TBS_EDUA이(가) 생성되었습니다.

--※ 테이블스페이스 생성 구문을 실행하기 전에
--   물리적인 경로에 디렉터리(TESTORADATA) 생성할 것.

--○ 생성된 테이블 스페이스(TBS_EDUA) 조회
SELECT *
FROM DBA_TABLESPACES;
/*
    :
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
    :
*/


--○ 물리적인 파일 이름 조회
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
    :
C:\TESTORADATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
    :
*/


--○ 오라클 사용자 계정 생성
CREATE USER yhj IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--> yhj 라는 사용자 계정을 만들겠다. (생성하겠다.)
--  이 계정을 통해 생성하는 오라클 객체는(세크먼트들은)
--  기본적으로 TBS_EDUA 라는 테이블스페이스에 생성할 수 있도록 설정하겠다.
--==>> User YHJ이(가) 생성되었습니다.


--※ 생성된 오라클 사용자 계정(yhj)을 통해
--   접속을 시도해 보았으나 접속 불가.
--   → 『create session』 권한이 없기 때문
 

--○ 생성된 오라클 사용자 계정(yhj)에
--   서버 접속이 가능할 수 있도록 create session 권한 부여 → sys 가
GRANT CREATE SESSION TO YHJ;
--==>> Grant을(를) 성공했습니다.


--○ 생성된 오라클 사용자 계정(YHJ)의
--   DEFAULT TABLESPACE 조회
SELECT USERNAME, DEFAULT_TABLESPACE
FROM DBA_USERS;
--==>>
/*
        :
HR	                USERS
YHJ	                TBS_EDUA
        :
*/


--○ 생성된 오라클 사용자 계정(YHJ)의
--   시스템 관련 권한 조회
SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
    :
YHJ	CREATE SESSION	NO
    :
*/


--○ 생성된 오라클 사용자 계정(YHJ)에
--   테이블 생성이 가능할 수 있도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO YHJ;
--==>> Grant을(를) 성공했습니다.


--○ 생성된 오라클 사용자 계정(YHJ)에
--   테이블스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량)
--   의 크기를 무제한으로 지정.
ALTER USER YHJ
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User YHJ이(가) 변경되었습니다.







 