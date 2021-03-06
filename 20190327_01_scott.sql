--○ 접속된 사용자 조회
SELECT USER
FROM DUAL;
--==>> SCOTT

--○ EMP 테이블에서 직종이 CLERK 인 사원들 중
--   20번 부서에서 근무하는 사원들의
--   사원번호, 사원명, 직종명, 급여, 부서번호 항복을 조회한다.
SELECT EMPNO"사원번호", ENAME "사원명", JOB "직종명", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE JOB='CLERK' AND DEPTNO=20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/


--○ EMP 테이블에서 10번 부서에 근무하는 직원들 중
--   급여가 2500 이상인 사원들의
--   사원명, 직종명, 급여, 부서번호 항복을 조회한다,
SELECT ENAME "사원명", JOB "직종명", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO=10 AND SAL >= 2500;
--==>> KING	PRESIDENT	5000	10


--○ 테이블 복사
--> 내부적으로 대상 테이블 안에 있는 데이터 내용만 복사하는 과정

--※ EMP 테이블의 정보를 확인하여
--   이와 똑같은 데이터가 들어있는 EMPCOPY 테이블을 생성한다.(팀별로)
SELECT *
FROM EMP;

DESCRIBE EMP;

CREATE TABLE EMPCOPY
(EMPNO NUMBER(4)  
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2) 
);

ALTER TABLE EMPCOPY MODIFY(EMPNO NUMBER(4) CONSTRAINT PK_EMPCOPY PRIMARY KEY);

INSERT INTO EMPCOPY VALUES
(7369, 'SMITH', 'CLERK', 7902, to_date('17-12-1980','dd-mm-yyyy'), 800, NULL, 20);
INSERT INTO EMPCOPY VALUES
(7499, 'ALLEN', 'SALESMAN', 7698, to_date('20-02-1980','dd-mm-yyyy'), 1600, 300, 30);
INSERT INTO EMPCOPY VALUES
(7521, 'WARD', 'SALESMAN', 7698, to_date('22-02-1981','dd-mm-yyyy'), 1250, 500, 30);
INSERT INTO EMPCOPY VALUES
(7566, 'JONES', 'MANAGER', 7839, to_date('02-04-1981','dd-mm-yyyy'), 2975, NULL, 20);
INSERT INTO EMPCOPY VALUES
(7654, 'MARTIN', 'SALESMAN', 7698, to_date('28-09-1981','dd-mm-yyyy'), 1250, 1400, 30);
INSERT INTO EMPCOPY VALUES
(7698, 'BLAKE', 'MANAGER', 7839, to_date('01-05-1981','dd-mm-yyyy'), 2850, NULL, 30);
INSERT INTO EMPCOPY VALUES
(7782, 'CLARK', 'MANAGER', 7839, to_date('09-06-1981','dd-mm-yyyy'), 2450, NULL, 10);
INSERT INTO EMPCOPY VALUES
(7788, 'SCOTT', 'ANALYST', 7566, to_date('13-07-1987','dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO EMPCOPY VALUES
(7839, 'KING', 'PRESIDENT', NULL, to_date('17-11-1981','dd-mm-yyyy'), 5000, NULL, 10);
INSERT INTO EMPCOPY VALUES
(7844, 'TURNER', 'SALESMAN', 7698, to_date('08-09-1981','dd-mm-yyyy'), 1500, 0, 30);
INSERT INTO EMPCOPY VALUES
(7876, 'ADAMS', 'CLERK', 7788, to_date('13-07-1987','dd-mm-yyyy'), 1100, NULL, 20);
INSERT INTO EMPCOPY VALUES
(7900, 'JAMES', 'CLERK', 7698, to_date('03-12-1981','dd-mm-yyyy'), 950, NULL, 30);
INSERT INTO EMPCOPY VALUES
(7902, 'FORD', 'ANALYST', 7566, to_date('03-12-1981','dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO EMPCOPY VALUES
(7934, 'MILLER', 'CLERK', 7782, to_date('23-01-1982','dd-mm-yyyy'), 1300, NULL, 10);

DESC EMPCOPY;

SELECT * 
FROM EMPCOPY;

CREATE TABLE EMP2
AS
SELECT *
FROM EMP;
--==>> Table EMP2이(가) 생성되었습니다.

--○ 복사한 테이블 확인
SELECT *
FROM EMP2;


--※ 날짜 관련 세션 정보 설정
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ 테이블 복사
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

CREATE TABLE TBL_DEPT
AS 
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT이(가) 생성되었습니다.


--○ 복사한 테이블 확인
SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;


--○ 테이블의 커멘트 정보 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
DEPT	        TABLE	
EMP	            TABLE	
BONUS	        TABLE	
SALGRADE	    TABLE	
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
EMPCOPY	        TABLE	
EMP2	        TABLE	
TBL_EMP	        TABLE	
TBL_DEPT	    TABLE	
*/


--○ 테이블의 커멘트 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원정보';
--==>> Comment이(가) 생성되었습니다.

--○ 커멘트 정보 입력 이후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE   사원정보
EMP2	        TABLE	
EMPCOPY	        TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--○ 테이블 레벨의 커멘트 정보 입력 (TBL_DEPT → 부서정보)
COMMENT ON TABLE TBL_DEPT IS '부서정보'
--==>> Comment이(가) 생성되었습니다.

--○ 커멘트 정보 입력 후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	부서정보
TBL_EMP	        TABLE	사원정보
EMP2	        TABLE	
EMPCOPY	        TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--※ 휴지통 비우기
PURGE RECYCLEBIN;
--==>> RECYCLEBIN이(가) 비워졌습니다.


--○ 컬럼 레벨의 커멘트 정보 확인
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
EMPCOPY	        MGR	
DEPT	        LOC	
BONUS	        COMM	
TBL_EMP	        EMPNO	
EMPCOPY	        DEPTNO	
SALGRADE	    LOSAL	
EMP2	        DEPTNO	
TBL_DEPT	    DNAME	
TBL_EMP	        COMM	
EMPCOPY	        COMM	
EMPCOPY	        EMPNO	
EMP 	        DEPTNO	
SALGRADE	    HISAL	
EMP	            EMPNO	
DEPT	        DEPTNO	
DEPT	        DNAME	
TBL_EMP	        JOB	
EMP2	        JOB	
EMP2	        HIREDATE	
EMP2	        COMM	
EMPCOPY	        JOB	
TBL_EXAMPLE2	NO	
BONUS	        JOB	
TBL_EXAMPLE1	NO	
TBL_EMP	        HIREDATE	
EMP	            ENAME	
EMP2	        SAL	
EMPCOPY	        HIREDATE	
EMPCOPY	        ENAME	
EMP	            JOB	
TBL_EXAMPLE2	NAME	
BONUS	        SAL	
EMP	            SAL	
TBL_EMP	        SAL	
TBL_EXAMPLE1	NAME	
EMP2	        ENAME	
EMP	            COMM	
SALGRADE	    GRADE	
TBL_EXAMPLE1	ADDR	
TBL_EXAMPLE2	ADDR	
EMP	            HIREDATE	
EMPCOPY	        SAL	
TBL_EMP	        DEPTNO	
TBL_EMP	        ENAME	
TBL_DEPT	    DEPTNO	
EMP2	        EMPNO	
EMP	            MGR	
TBL_EMP	        MGR	
TBL_DEPT	    LOC	
BONUS	        ENAME	
EMP2	        MGR	
*/


SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/


--○ 테이블에 소속된(포함된) 컬럼 레벨의 커멘트 정보 입력(설정)
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서명';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.LOC IS '부서위치';
--==>> Comment이(가) 생성되었습니다.


--○ 커멘트 정보가 입력된 테이블의 컬럼 레벨의 정보 확인 
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	부서번호
TBL_DEPT	DNAME	부서명
TBL_DEPT	LOC	    부서위치
*/


DESC EMP;
--==>>
/*
EMPNO    NOT NULL NUMBER(4)    -- 사원번호
ENAME             VARCHAR2(10) -- 사원명
JOB               VARCHAR2(9)  -- 직종명
MGR               NUMBER(4)    -- 관리자사원번호
HIREDATE          DATE         -- 입사일
SAL               NUMBER(7,2)  -- 급여
COMM              NUMBER(7,2)  -- 수당
DEPTNO            NUMBER(2)    -- 부서번호
*/


--○ TBL_EMP 테이블에 소속된(포함된)
--   컬럼에 대한 커멘트 정보를 입력(설정)한다.
COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원번호';
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원명';
COMMENT ON COLUMN TBL_EMP.JOB IS '직종명';
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자사원번호';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사일';
COMMENT ON COLUMN TBL_EMP.SAL IS '급여';
COMMENT ON COLUMN TBL_EMP.COMM IS '수당';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다. * 8


--○ 커멘트 정보가 입력된 테이블의 컬럼 레벨의 정보 확인 
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    사원번호
TBL_EMP	ENAME	    사원명
TBL_EMP	JOB	        직종명
TBL_EMP	MGR	        관리자사원번호
TBL_EMP	HIREDATE	입사일
TBL_EMP	SAL	        급여
TBL_EMP	COMM	    수당
TBL_EMP	DEPTNO	    부서번호
*/


--■■■ 컬럼의 구조의 추가 및 제거 ■■■--
SELECT *
FROM TBL_EMP;

--○ TBL_EMP 테이블에 주민등록번호 정보를 담을 수 있는 컬럼 추가
ALTER TABLE TBL_EMP
ADD SSN CHAR(13);
--==>> Table TBL_EMP이(가) 변경되었습니다.
-- 맨 앞에 0이 들어올 가능성이 있는 숫자가 조합된 데이터라면
-- 숫자형이 아닌 문자형으로 데이터타입을 처리해야 한다.

SELECT 0012121234567
FROM DUAL;
--==>> 12121234567

SELECT '0012121234567'
FROM DUAL;
--==>> 0012121234567


--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO SSN          
---------- ---------- --------- ---------- ---------- ---------- ---------- ---------- -------------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20              
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30              
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30              
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20              
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30              
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30              
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10              
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20              
      7839 KING       PRESIDENT            1981-11-17       5000                    10              
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30              
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20              
      7900 JAMES      CLERK           7698 1981-12-03        950                    30              
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20              
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10 

14개 행이 선택되었습니다. 
*/

DESC TBL_EMP;
--==>>
/*
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
SSN         CHAR(13) 
*/


SELECT EMPNO, ENAME, SSN, HIREDATE, SAL, COMM
FROM TBL_EMP;
--==>>
/*
     EMPNO ENAME      SSN           HIREDATE          SAL       COMM
---------- ---------- ------------- ---------- ---------- ----------
      7369 SMITH                    1980-12-17        800           
      7499 ALLEN                    1981-02-20       1600        300
      7521 WARD                     1981-02-22       1250        500
      7566 JONES                    1981-04-02       2975           
      7654 MARTIN                   1981-09-28       1250       1400
      7698 BLAKE                    1981-05-01       2850           
      7782 CLARK                    1981-06-09       2450           
      7788 SCOTT                    1987-07-13       3000           
      7839 KING                     1981-11-17       5000           
      7844 TURNER                   1981-09-08       1500          0
      7876 ADAMS                    1987-07-13       1100           
      7900 JAMES                    1981-12-03        950           
      7902 FORD                     1981-12-03       3000           
      7934 MILLER                   1982-01-23       1300   
      
14개 행이 선택되었습니다. 
*/
--> 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음


--○ TBL_EMP 테이블에서 추가한 SSN(주민등록번호) 컬럼 제거
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP이(가) 변경되었습니다.


--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO
---------- ---------- --------- ---------- ---------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 1980-12-17        800                    20
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20
      7839 KING       PRESIDENT            1981-11-17       5000                    10
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20
      7900 JAMES      CLERK           7698 1981-12-03        950                    30
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10
      
14개 행이 선택되었습니다. 
*/

DESC TBL_EMP;
--==>>
/*
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)
*/

--> SSN(주민등록번호) 컬럼이 정상적으로 제거되었음을 확이


DELETE
FROM TBL_EMP
WHERE ENAME='SMITH';
--==>> 1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
     EMPNO ENAME      JOB              MGR HIREDATE          SAL       COMM     DEPTNO
---------- ---------- --------- ---------- ---------- ---------- ---------- ----------
      7499 ALLEN      SALESMAN        7698 1981-02-20       1600        300         30
      7521 WARD       SALESMAN        7698 1981-02-22       1250        500         30
      7566 JONES      MANAGER         7839 1981-04-02       2975                    20
      7654 MARTIN     SALESMAN        7698 1981-09-28       1250       1400         30
      7698 BLAKE      MANAGER         7839 1981-05-01       2850                    30
      7782 CLARK      MANAGER         7839 1981-06-09       2450                    10
      7788 SCOTT      ANALYST         7566 1987-07-13       3000                    20
      7839 KING       PRESIDENT            1981-11-17       5000                    10
      7844 TURNER     SALESMAN        7698 1981-09-08       1500          0         30
      7876 ADAMS      CLERK           7788 1987-07-13       1100                    20
      7900 JAMES      CLERK           7698 1981-12-03        950                    30
      7902 FORD       ANALYST         7566 1981-12-03       3000                    20
      7934 MILLER     CLERK           7782 1982-01-23       1300                    10

13개 행이 선택되었습니다. 
*/


DELETE TBL_EMP;     -- 권장하지 않음

DELETE
FROM TBL_EMP;       -- 권장

--==>> 13개 행 이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_EMP;
--> 테이블의 구조는 그대로 남아있는 상태에서
--  데이터 모두 소실(삭제)된 상황임을 확인


DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
498행, 6열에서 오류 발생
*/


--○ 테이블 다시 생성(복사)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.


-------------------------------------------------------------------------------------------------------

--○ NULL 의 처리

SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2	12	8	20	5

SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2, 10+NULL, 10-NULL, 10*NULL, 10/NULL
FROM DUAL;
--==>> (NULL) (NULL) (NULL) (NULL) (NULL) (NULL) (NULL) (NULL)(NULL) (NULL)

--※ 관찰 결과
--   NULL 은 상태의 값을 의미하며 실제 존재하지 않는 값이기 때문에
--   이 NULL 이 연산에 포함될 경우 그 결과는 무조건 NULL 이다.


--○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL 인 직원의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM = NULL;
--==>> 조회 결과 없음

SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM = (null);
--==>> 조회 결과 없음

SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> 에러 발생
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

DESC TBL_EMP;
--> COMM 칼럼은 숫자형 데이터 타입을 취하고 있음을 확인

--※ NULL 은 실제 존재하지 않는 값이기 때문에 일반적인 연산자를 활용하여 비교할 수 없다.
--   즉, 산술적인 비교 연산을 수행할 수 없다는 의미이다.
--   NULL 을 대상으로 사용할 수 없는 연산자들
--   >=, <=, >, <, !=, ^=, <>


SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
SMITH	CLERK	    800	
JONES	MANAGER	    2975	
BLAKE	MANAGER	    2850	
CLARK	MANAGER	    2450	
SCOTT	ANALYST	    3000	
KING	PRESIDENT	5000	
ADAMS	CLERK	    1100	
JAMES	CLERK	    950	
FORD	ANALYST	    3000	
MILLER	CLERK	    1300	
*/


--○ TBL_EMP 테이블에서 20번 부서에 근무하지 않는 직원들의
--   사원명, 직족명, 부서번호 항목을 조회한다.
SELECT ENAME "사원명", JOB "직종명", DEPTNO "부서번호"
FROM TBL_EMP
WHERE DEPTNO != 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	    30
CLARK	MANAGER	    10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	    30
MILLER	CLERK	    10
*/

SELECT ENAME "사원명", JOB "직종명", DEPTNO "부서번호"
FROM TBL_EMP
WHERE DEPTNO ^= 20;

SELECT ENAME "사원명", JOB "직종명", DEPTNO "부서번호"
FROM TBL_EMP
WHERE DEPTNO = 10 OR DEPTNO = 30;

SELECT ENAME "사원명", JOB "직종명", DEPTNO "부서번호"
FROM TBL_EMP
WHERE DEPTNO IN(10, 30);


--○ TBL_EMP 테이블에서 커미션이 NULL 이 아닌 직원들의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM IS NOT NULL;
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/
SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE NOT COMM IS NULL;


--○ TBL_EMP 테이블에서 모든 사원들의
--   사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--   단, 급여(SAL)는 매월 지급한다,
--   또한, 수당(COMM)은 매년 지급한다.
ALTER TABLE TBL_EMP
ADD ALLS NUMBER(4);

COMMENT ON COLUMN TBL_EMP.ALLS IS '연봉';

ALTER TABLE TBL_EMP DROP COLUMN ALLS;

SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", SAL*12 + COMM "연봉"
FROM TBL_EMP;

SELECT 1600*12+300
FROM DUAL;
--==>> 19500


-- NVL()
SELECT NULL"ⓐ", NVL(NULL, 10)"ⓑ", NVL(10, 20)"ⓒ"
FROM DUAL;
--==>> (null)   10  10
--> 첫 번째 파라미터 값이 NULL 이면, 두 번째 파라미터 값을 반환한다.
--  첫 번째 파라미터 값이 NULL 이 아니면, 그 값을 그대로 반환한다.

-- 관찰
SELECT *
FROM TBL_EMP
WHERE EMPNO=7369;
--==>> 7369	SMITH	CLERK	7902	80/12/17	800	  (null)	20	

SELECT ENAME, COMM
FROM TBL_EMP
WHERE EMPNO=7369;
--==>> SMITH    (null)

SELECT ENAME, NVL(COMM, 0)"확인여부"
FROM TBL_EMP
WHERE EMPNO=7369;
--==>> SMITH	0


SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", NVL(COMM, 0) "커미션", SAL*12 + NVL(COMM, 0) "연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800	    0	    9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975	0	    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850	0	    34200
7782	CLARK	2450	0	    29400
7788	SCOTT	3000	0	    36000
7839	KING	5000	0	    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100	0	    13200
7900	JAMES	950	    0	    11400
7902	FORD	3000	0	    36000
7934	MILLER	1300	0	    15600
*/


--○ NVL2()
--> 첫 번째 파라미터 값이 NULL 이 아닌 경우, 두 번째 파라미터 값을 반환하고
--  첫 번째 파라미터 값이 NULL 인 경우, 세 번째 파라미터 값을 반환한다.
SELECT ENAME, COMM, NVL2(COMM, '청기올려', '백기올려')"확인여부"
FROM TBL_EMP;
--==>> 
/*
SMITH		    백기올려 --
ALLEN	300	    청기올려
WARD	500	    청기올려
JONES		    백기올려 --
MARTIN	1400	청기올려
BLAKE		    백기올려 --
CLARK		    백기올려 --
SCOTT		    백기올려 --
KING		    백기올려 --
TURNER	0	    청기올려
ADAMS		    백기올려 --
JAMES		    백기올려 --
FORD		    백기올려 --
MILLER		    백기올려 --
*/

SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", NVL2(COMM, COMM, 0) "커미션", NVL2(COMM, SAL*12+COMM, SAL*12) "연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800	    0	     9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975	0	    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850	0	    34200
7782	CLARK	2450	0	    29400
7788	SCOTT	3000	0	    36000
7839	KING	5000	0	    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100	0	    13200
7900	JAMES	950 	0	    11400
7902	FORD	3000	0	    36000
7934	MILLER	1300	0	    15600
*/


--○ COALESCE()
--> 매개변수 제한이 없는 형태로 인지하고 활용한다.
--  맨 앞에 있는 매개변수부터 차례로 NULL 인지 아닌지 확인하여
--  NULL 이 아닐경우 적용(반환, 처리)하고,
--  NULL 인 경우에는 그 다음 매개변수의 값으로 적용(반환, 처리)한다.
--  NVL() 나 NVL2() 에 비해 모든 경우의 수를 고려할 수 있는 특징을 갖고 있다.
SELECT NULL "기본확인"
    , COALESCE(NULL, NULL, NULL, 30) "함수 확인1"
    , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, 100) "함수 확인2"
    , COALESCE(10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100) "함수 확인3"
    , COALESCE(NULL, NULL, 80, NULL, NULL, NULL, NULL, NULL, 100) "함수 확인4"
FROM DUAL;


--○ 실습을 위한 데이터 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '승워니', 'SALEMAN', 7839, SYSDATE, 10);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, COMM, DEPTNO)
VALUES(8001, '희지니', 'SALESMAN', 7839, SYSDATE, 100, 10);
--==>> 1 행 이(가) 삽입되었습니다.

ROLLBACK;   -- 데이터 수정하기 위해...

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '승워니', 'SALESMAN', 7839, SYSDATE, 10);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, COMM, DEPTNO)
VALUES(8001, '희지니', 'SALESMAN', 7839, SYSDATE, 100, 10);
--==>> 1 행 이(가) 삽입되었습니다.

ALTER TABLE TBL_EMP
DROP COLUMN YEAR;       --YEAR 컬럼 삭제

SELECT *
FROM TBL_EMP;

COMMIT;
--==>> 커밋 완료.

SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", SAL*12 + NVL(COMM, 0) "연봉"
FROM TBL_EMP;

SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", COALESCE((SAL*12 +COMM), (COMM), (SAL*12), 0) "연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	 800	         9600
7499	ALLEN	1600	 300	19500
7521	WARD	1250	 500    15500
7566	JONES	2975		    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		    34200
7782	CLARK	2450		    29400
7788	SCOTT	3000		    36000
7839	KING	5000		    60000
7844	TURNER	1500	   0    18000
7876	ADAMS	1100		    13200
7900	JAMES	 950	        11400
7902	FORD	3000		    36000
7934	MILLER	1300		    15600
8000	승워니			            0
8001	희지니		      100	  100
*/


-----------------------------------------------------------------------------------------------------------

--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 현재 날짜 및 시간을 반환하는 함수
SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP
FROM DUAL;
--==>>
/*
2019-03-27 15:45:55	
2019-03-27 15:45:55	
19/03/27 15:45:55.000000000
*/


--※ 날짜에 대한 세션 설정 정보 다시 변경하기
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ 컬럼과 컬럼의 연결(결합)
--   문자타입과 문자타입의 연결
--   『+』 연산자를 통한 결합 수행은 불가능 → 『||』
SELECT 1+1
FROM DUAL;
--==>> 2

SELECT '이원영' + '전훈의'
FROM DUAL;
--==>> 에러 발생
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

SELECT '이원영', '전훈의'
FROM DUAL;
--==>> 이원영	전훈의

SELECT '이원영' || '전훈의'
FROM DUAL;
--==>> 이원영전훈의

SELECT EMPNO, ENAME
FROM TBL_EMP;
--==>>
/*
7369	SMITH
7499	ALLEN
7521	WARD
7566	JONES
7654	MARTIN
7698	BLAKE
7782	CLARK
7788	SCOTT
7839	KING
7844	TURNER
7876	ADAMS
7900	JAMES
7902	FORD
7934	MILLER
8000	승워니
8001	희지니
*/

SELECT EMPNO || ENAME
FROM TBL_EMP;
/*
7369SMITH
7499ALLEN
7521WARD
7566JONES
7654MARTIN
7698BLAKE
7782CLARK
7788SCOTT
7839KING
7844TURNER
7876ADAMS
7900JAMES
7902FORD
7934MILLER
8000승워니
8001희지니
*/

--      문자타입   날짜타입  문자타입 숫자타입 문자타입
--     ----------  -------  ----------  ---  --------------
SELECT '원영이는', SYSDATE, '에 연봉 ', 500, '억을 원한다.'
FROM DUAL;
--==>> 원영이는	2019-03-27	에 연봉 	500	억을 원한다.

--      문자타입    날짜타입     문자타입   숫자타입   문자타입
--     ----------    -------    ----------    ---    --------------
SELECT '원영이는' || SYSDATE || '에 연봉 ' || 500 || '억을 원한다.'
FROM DUAL;
--==>> 원영이는2019-03-27에 연봉 500억을 원한다.

--※ 오라클에서 문자 타입의 형태로 형 변환하는 별도의 과정 없이
--   위에서 처리한 내용 처럼 『||』만 삽입해주면 간단히 컬럼과 컬럼을
--   (서로 다른 종류의 데이터) 결합하는 것이 가능하다.
--   MYSQL 에서는 모든 데이터를 문자타입으로 CONVERT 해야 한다.


--○ TBL_EMP 테이블의 정보를 활용하여
--   모든 직원들의 데이터에 대하여
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다.

--   SMITH 의 현재 연봉은 9600인데 희망 연봉은 19200이다.
--   ALLEN 의 현재 연봉은 19500인데 희망 연봉은 39000이다.
--                         :


SELECT *
FROM TBL_EMP
WHERE EMPNO IN (8000, 8001);

DELETE
FROM TBL_EMP
WHERE EMPNO IN (8000, 8001);
--==>> 2개 행 이(가) 삭제되었습니다.

COMMIT;
--==>> 커밋 완료.

--방식1
SELECT ENAME || ' 의 현재 연봉은 ' || NVL(SAL*12 +COMM, SAL*12) || '인데 희망 연봉은 ' || NVL((SAL*12 +COMM), SAL*12)*2 || '이다.'
FROM TBL_EMP;

--방식2
SELECT ENAME || ' 의 현재 연봉은 ' || NVL2(COMM, SAL*12 +COMM, SAL*12) || '인데 희망 연봉은 ' || NVL2(COMM, (SAL*12 +COMM), SAL*12)*2 || '이다.'
FROM TBL_EMP;

--방식3
SELECT ENAME || ' 의 현재 연봉은 ' || COALESCE((SAL*12 +COMM), (COMM), (SAL*12), 0) || '인데 희망 연봉은 ' || COALESCE((SAL*12 +COMM), (COMM), (SAL*12), 0)*2 || '이다.'
FROM TBL_EMP;


-- SMITH's 입사일은 1980-12-17 이다. 그리고 급여는 800이다.
-- ALLEN's 입사일은 1981-02-20 이다. 그리고 급여는 1600이다.
--                      :

SELECT ENAME || '''s 입사일은 ' || HIREDATE || ' 이다. 그리고 급여는 ' || SAL || '이다.'
FROM TBL_EMP;

--※ 문자열을 나타내는 홑따옴표 사이에서(시작과 끝)
--   홑따옴표 두 개가 홑따옴표 하나(어퍼스트로피)를 의미한다.
--   홑따옴표 『'』하나는 문자열의 시작을 나타내고
--   홑따옴표 『''』두 개는 문자열 영역 안에서 어퍼스트로피를 나타내며
--   다시 등장하는 홑따옴표 『'』하나가 문자열 영역의 종료를 의미하게 되는 것이다.













