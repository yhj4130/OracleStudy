SELECT USER
FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ 문제
-- TBL_SAWON 테이블을 활용하여 다음과 같은 항목들을 조회한다.
-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
-- 정년퇴직일, 근무일수, 남은일수, 급여, 보너스

-- 단, 현재 나이는 한국나이 계산법에 따라 연산을 수행한다.
-- 또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해(년도)의 
-- 그 직원의 입사, 월, 일로 연산을 수행한다.
-- 그리고 보너스는 1000일 이상 2000일 미만 근무한 사원은
-- 그 사원의 원래 급여 기준 30% 지급,
-- 2000일 이상 근무한 사원은 그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여
SELECT SANO"사원번호", SANAME"사원명", JUBUN"주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
            ELSE '성별확인불가'
       END"성별"
       
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0
       END"현재나이"
     , HIREDATE"입사일"
     , SAL"급여"
FROM TBL_SAWON;
--==>>
/*
1001	이원영	    8706241234567	남자	33	01/01/03	3000
1002	나주영	    9405022234567	여자	26	01/11/05	2000
1003	진윤비	    9710012234567	여자	23	99/08/16	5000
1004	권홍비	    9504102234567	여자	25	97/11/05	4000
1005	이비승	    7210101234567	남자	48	98/02/02	2000
1006	조영우	    8004271234567	남자	40	98/02/02	2000
1007	이하이	    0405064234567	여자	16	10/07/15	1000
1008	소이현	    0506074234567	여자	15	10/07/15	1000
1009	선동열	    0505053234567	남자	15	11/07/15	3000
1010	선우선	    9505052234567	여자	25	99/11/11	4000
1011	선우용녀	7512122234567	여자	45	99/11/11	5000
1012	남상현	    9302131234567	남자	27	10/11/11	3000
1013	남궁선	    7202021234567	남자	48	92/10/10	2000
1014	남이	    6912121234567	남자	51	87/10/10	4000
1015	이이경	    8410141234567	남자	36	97/10/10	5000
*/


SELECT SANAME"사원명", SAL*12"연봉", SAL*12*2"두배연봉"
FROM TBL_SAWON;

SELECT 사원명, 연봉*2"두배연봉"
FROM
(
    SELECT SANAME"사원명", SAL*12"연봉"      -- 하나의 가상테이블 취급(서브 쿼리)
    FROM TBL_SAWON
);


SELECT T.사원명, T.연봉*2"두배연봉"
FROM
(
    SELECT SANAME"사원명", SAL*12"연봉"     
    FROM TBL_SAWON
) T;                                         -- IN LINE VIEW


-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
-- 정년퇴직일, 근무일수, 남은일수, 급여, 보너스
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     -- 정년퇴직일
     -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
     -- 현재나이가 58세  2년 후 → 2019 2021
     -- 현재나이가 35세 25년 후 → 2019 2044
     -- ADD_MONTHS(SYSDATE, 남은년수*12)
     --                     --------
     --                     60 - 현재나이
     -- ADD_MONTHS(SYSDATE, (60-현재나이)*12)
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60-현재나이)*12), 'YYYY') → 정년퇴직 년도만 추출
     -- TO_CHAR(HIREDATE, 'MM-DD')                             → 입사일   월일만 추출
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60-현재나이)*12), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD')"정년퇴직일"
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD')"정년퇴직일"
     
     -- 근무일수
     -- = 현재일 - 입사일
     , TRUNC(SYSDATE - T.입사일)"근무일수"
     
     -- 남은일수
     -- = 정년퇴직일 - 현재일
     -- TO_DATE(정년퇴직문자열, 'YYYY-MM-DD')
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE)"남은일수"
     
     , T.급여
     
     -- 보너스
     -- 근무일수가 1000일 이상 2000일 미만 → 원래 급여 기준 30% 지급, 근무일수가 2000일 이상 → 원래 급여 기준 50% 지급, 나머지 0
     , CASE WHEN TRUNC(SYSDATE - T.입사일)>=2000
            THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일)>=1000
            THEN T.급여 * 0.3
            ELSE 0
        END"보너스"
     
FROM 
(
    SELECT SANO"사원번호", SANAME"사원명", JUBUN"주민번호"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
                ELSE '성별확인불가'
           END"성별"
           
        -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 생 / 2000년대 생)
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE 0
           END"현재나이"
         , HIREDATE"입사일"
         , SAL"급여"
    FROM TBL_SAWON
) T;
--==>>
/*
1001	이원영	    8706241234567	남자	33	2001-01-03	2046-01-03	 6662	 9773	3000	1500
1002	나주영	    9405022234567	여자	26	2001-11-05	2053-11-05	 6356	12636	2000	1000
1003	진윤비	    9710012234567	여자	23	1999-08-16	2056-08-16	 7168	13651	5000	2500
1004	권홍비	    9504102234567	여자	25	1997-11-05	2054-11-05	 7817	13001	4000	2000
1005	이비승	    7210101234567	남자	48	1998-02-02	2031-02-02	 7728	 4324	2000	1000
1006	조영우	    8004271234567	남자	40	1998-02-02	2039-02-02	 7728	 7246	2000	1000
1007	이하이	    0405064234567	여자	16	2010-07-15	2063-07-15	 3182	16175	1000	 500
1008	소이현	    0506074234567	여자	15	2010-07-15	2064-07-15	 3182	16541	1000	 500
1009	선동열	    0505053234567	남자	15	2011-07-15	2064-07-15	 2817	16541	3000	1500
1010	선우선	    9505052234567	여자	25	1999-11-11	2054-11-11	 7081	13007	4000	2000
1011	선우용녀	7512122234567	여자	45	1999-11-11	2034-11-11	 7081	 5702	5000	2500
1012	남상현	    9302131234567	남자	27	2010-11-11	2052-11-11	 3063	12277	3000	1500
1013	남궁선	    7202021234567	남자	48	1992-10-10	2031-10-10	 9669	 4574	2000	1000
1014	남이	    6912121234567	남자	51	1987-10-10	2028-10-10	11496	 3479	4000	2000
1015	이이경	    8410141234567	남자	36	1997-10-10	2043-10-10	 7843	 8957	5000	2500
*/

-- 상기 내용에서 특정 근무일수의 사원을 확인해야 한다거나,
-- 특정 보너스 금액을 받는 사원을 확인해야 할 경우가 생길 수 있다.
-- 이와 같은 경우 해당 쿼리문을 다시 구성하는 번거로움을 줄일 수 있도록
-- 뷰(VIEW)를 만들어 저장해 둘 수 있다.


CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD')"정년퇴직일"
     
     , TRUNC(SYSDATE - T.입사일)"근무일수"
     
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이)*12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE)"남은일수"
     
     , T.급여

     , CASE WHEN TRUNC(SYSDATE - T.입사일)>=2000
            THEN T.급여 * 0.5
            WHEN TRUNC(SYSDATE - T.입사일)>=1000
            THEN T.급여 * 0.3
            ELSE 0
        END"보너스"
     
FROM 
(
    SELECT SANO"사원번호", SANAME"사원명", JUBUN"주민번호"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남자'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여자'
                ELSE '성별확인불가'
           END"성별"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE 0
           END"현재나이"
         , HIREDATE"입사일"
         , SAL"급여"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON이(가) 생성되었습니다.


--○ TBL_SAWON 테이블의 이원영 입사일 및 급여 데이터 변경
-- 현재 : 1001	이원영	8706241234567	남자	33	2001-01-03	2046-01-03	6662	9773	3000	1500

UPDATE TBL_SAWON
SET HIREDATE=SYSDATE, SAL=100
WHERE SANO=1001;
--==>> 1 행 이(가) 업데이트되었습니다.

COMMIT;
-- 커밋 완료

SELECT *
FROM TBL_SAWON;
--==>> 1001	이원영	8706241234567	2019-04-01	100

SELECT *
FROM VIEW_SAWON;
--==>> 1001	이원영	8706241234567	남자	33	2019-04-01	2046-04-01	0	9861	100	0

INSERT INTO TBL_SAWON(SANO, SANAME, SAL, HIREDATE)
VALUES(2000, '김선아', 5000, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

COMMIT;
-- 커밋 완료


--○ 문제
-- 서브 쿼리를 활용하여 TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 한다.
/*
------------------------------------------
  사원명 성별 현재나이 급여 나이보너스
  
단, 나이보너스는 현재 나이가 40세 이상이면 급여의 70%
    30세 이상 40세 미만이면 급여의 50%
    20세 이상 30세 미만이면 급여의 30%

또한, 완성된 조회 구문을 기반으로
VIEW_SAWON2 라는 이름의 뷰(VIEW)를 생성한다. 
*/


CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.*
    
     -- 나이보너스
     , CASE WHEN T.현재나이 >=40 THEN T.급여 * 0.7
            WHEN T.현재나이 >=30 THEN T.급여 * 0.5
            WHEN T.현재나이 >=20 THEN T.급여 * 0.3
            ELSE 0
        END"나이보너스"
     
FROM 
(
    SELECT SANAME"사원명"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가'
           END"성별"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE 0
           END"현재나이"
           
         , SAL"급여"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON2이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON2;
--==>> 
/*
이원영	    남성	        33	 100	  50
나주영	    여성	        26	2000	 600
진윤비	    여성	        23	5000	1500
권홍비	    여성	        25	4000	1200
이비승	    남성	        48	2000	1400
조영우	    남성	        40	2000	1400
이하이	    여성	        16	1000	   0
소이현	    여성	        15	1000	   0
선동열	    남성	        15	3000	   0
선우선	    여성	        25	4000	1200
선우용녀	여성	        45	5000	3500
남상현	    남성	        27	3000	 900
남궁선	    남성	        48	2000	1400
남이	    남성	        51	4000	2800
이이경	    남성	        36	5000	2500
김선아	    성별확인불가	 0	5000	   0
*/


--------------------------------------------------------------------------------------------------------------

--○ RANK() → 등수(순위)를 반환하는 함수
SELECT EMPNO"사원번호", ENAME"사원명", DEPTNO"부서번호", SAL"급여"
     , RANK() OVER(ORDER BY SAL DESC)"전체급여순위"
FROM EMP;
--==>>
/*
7839	KING	10	5000	 1
7902	FORD	20	3000	 2
7788	SCOTT	20	3000	 2
7566	JONES	20	2975	 4
7698	BLAKE	30	2850	 5
7782	CLARK	10	2450	 6
7499	ALLEN	30	1600	 7
7844	TURNER	30	1500	 8
7934	MILLER	10	1300	 9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	 950	13
7369	SMITH	20	 800	14
*/


SELECT EMPNO"사원번호", ENAME"사원명", DEPTNO"부서번호", SAL"급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)"부서내 급여순위"
     , RANK() OVER(ORDER BY SAL DESC)"전체급여순위"
FROM EMP;
--==>>
/*
7839	KING	10	5000	1	 1
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7698	BLAKE	30	2850	1	 5
7782	CLARK	10	2450	2	 6
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7934	MILLER	10	1300	3	 9
7521	WARD	30	1250	4	10
7654	MARTIN	30	1250	4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	 950	6	13
7369	SMITH	20	 800	5	14
*/


SELECT EMPNO"사원번호", ENAME"사원명", DEPTNO"부서번호", SAL"급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)"부서내 급여순위"
     , RANK() OVER(ORDER BY SAL DESC)"전체급여순위"
FROM EMP
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 6
7934	MILLER	10	1300	3	 9
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	 800	5	14
7698	BLAKE	30	2850	1	 5
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	 950	6	13
*/


--○ DENSE_RANK() → 서열을 반환하는 함수
SELECT EMPNO"사원번호", ENAME"사원명", DEPTNO"부서번호", SAL"급여"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)"부서내 급여순위"
     , DENSE_RANK() OVER(ORDER BY SAL DESC)"전체 급여서열"
FROM EMP
ORDER BY 3, 4 DESC;
--==>> 
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 5
7934	MILLER	10	1300	3	 8
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	2	 3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	 800	4	12
7698	BLAKE	30	2850	1	 4
7499	ALLEN	30	1600	2	 6
7844	TURNER	30	1500	3	 7
7654	MARTIN	30	1250	4	 9
7521	WARD	30	1250	4	 9
7900	JAMES	30	 950	5	11
*/


--○ EMP 테이블의 사원 정보를
--   사원명, 부서번호, 연봉, 부서내 연봉순위, 전체 연봉순위 항목으로 조회한다.
SELECT ENAME"사원명", DEPTNO"부서번호", SAL*12+NVL(COMM,0)"연봉"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC)"부서내 연봉순위"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC)"전체 연봉순위"
FROM TBL_EMP
ORDER BY 2 ASC;
--==>>
/*
KING	10	60000	1	 1
CLARK	10	29400	2	 6
MILLER	10	15600	3	 9
FORD	20	36000	1	 2
SCOTT	20	36000	1	 2
JONES	20	35700	2	 4
ADAMS	20	13200	3	12
SMITH	20	 9600	4	14
BLAKE	30	34200	1	 5
ALLEN	30	19200	2	 7
TURNER	30	18000	3	 8 
MARTIN	30	15000	4	10
WARD	30	15000	4	10
JAMES	30	11400	5	13
*/


SELECT T.*
     , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC)"부서내 연봉순위"
     , RANK() OVER(ORDER BY T.연봉 DESC)"전체 연봉순위"
FROM
(
    SELECT ENAME"사원명", DEPTNO"부서번호"
         , SAL*12+NVL(COMM,0)"연봉"
    FROM EMP
)T
ORDER BY 2, 3 DESC;

--==>>
/*
KING	10	60000	1	 1
CLARK	10	29400	2	 6
MILLER	10	15600	3	10
FORD	20	36000	1	 2
SCOTT	20	36000	1	 2
JONES	20	35700	3	 4
ADAMS	20	13200	4	12
SMITH	20	 9600	5	14
BLAKE	30	34200	1	 5
ALLEN	30	19500	2	 7
TURNER	30	18000	3	 8
MARTIN	30	16400	4	 9
WARD	30	15500	5	11
JAMES	30	11400	6	13
*/


--○ EMP 테이블에서 전체 연봉 순위가 1등부터 5등 까지만
--   사원명, 부서번호 , 연봉, 전체연봉순위 항목으로 조회한다.
SELECT T.*
FROM
(
    SELECT ENAME"사원명", DEPTNO"부서번호"
         , SAL*12+NVL(COMM,0)"연봉"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC)"전체연봉순위"
    FROM EMP
)T
WHERE T.전체연봉순위 <= 5;


SELECT ENAME"사원명", DEPTNO"부서번호"
      , SAL*12+NVL(COMM,0)"연봉"
      , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC)"전체연봉순위"
FROM RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) <= 5;
--==>>
/*
ORA-00933: SQL command not properly ended
00933. 00000 -  "SQL command not properly ended"
*Cause:    
*Action:
463행, 40열에서 오류 발생
*/

--※ 위의 내용은 RANK() OVER() 함수를 WHERE 조건절에서 사용한 경우이며
--   이 함수는 WHERE 조건절에서 사용할 수 없기 때문에 발생하는 에러이다.
--   이 경우, 우리는 INLINE VIEW 를 활용하여 풀이해야 한다.


--○ EMP 테이블에서 각 부서별로 연봉 등수가 1등 부터 2등 까지만 조회한다.
--   사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수
SELECT T.*
FROM
(
    SELECT ENAME"사원명", DEPTNO"부서번호"
         , SAL*12+NVL(COMM,0)"연봉"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC)"부서내연봉등수"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC)"전체연봉등수"
    FROM EMP
)T
WHERE T.부서내연봉등수 <= 2;


------------------------------------------------------------------------------------------------------------------

--■■■ 그룹 함수 ■■■--

-- SUM() 합, AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최소값
-- VARIANCE() 분산, STDDEV() 표준편차

--※ 그룹 함수의 가장 큰 특징은
--   처리해야 할 데이터들 중 NULL 이 존재하면
--   이 NULL 은 제외하고 연산을 수행한다는 것이다.

-- SUM()
-- EMP 테이블을 대상으로 전체 사원들의 급여 총합을 조회한다.
SELECT SUM(SAL)     -- 800+1600+1250+2975+1250+...+1300
FROM EMP;   
--==>> 29025

SELECT SUM(COMM)    -- 300+500+1400+0
FROM EMP;
--==>> 2200


-- COUNT()
-- 행의 갯수 조회하여 결과값 반환
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(SAL)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)  -- COMM 컬럼의 행의 갯수 조회 → NULL 은 제외!!
FROM EMP;
--==>> 4

SELECT COUNT(*)     -- 전체 행의 갯수 조회
FROM EMP;
--==>> 14


-- AVG()
-- 평균 반환
SELECT SUM(SAL) / COUNT(SAL), AVG(SAL)
FROM EMP;
--==>> 
/*
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286
*/

SELECT AVG(COMM)
FROM EMP;
--==>> 550

SELECT SUM(COMM) / COUNT(*)
FROM EMP;
--==>> 157.142857142857142857142857142857142857

SELECT SUM(COMM) / COUNT(COMM), AVG(COMM)
FROM EMP;
--==>>
/*
550	
550
*/


--※ 표준편차의 제곱이 분산
--   분산의 제곱근이 표준편차
SELECT AVG(SAL), VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2), VARIANCE(SAL)
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)), STDDEV(SAL)
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


-- MAX() / MIN()
-- 최대값 / 최소값 반환
SELECT MAX(SAL), MIN(SAL)
FROM EMP;
--==>> 5000	800


--※ 주의
SELECT ENAME, SUM(SAL)  -- 레코드값 14개 1개
FROM EMP;
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
593행, 8열에서 오류 발생
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>> 에러 발생
/*
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
604행, 8열에서 오류 발생
*/


--○ 부서별 급여합 조회
SELECT DEPTNO"부서번호", SUM(SAL)"급여합"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	 8750
20	10875
30	 9400
*/

SELECT DEPTNO"부서번호", SUM(SAL)"급여함"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==> 
/*
10	 8750
20	10875
30	 9400
	29025
*/

--○ 데이터 입력
INSERT INTO TBL_EMP VALUES (8001, '조인성', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
INSERT INTO TBL_EMP VALUES (8002, '강동원', 'CLERK', 7566, SYSDATE, 1000, 0, NULL);
INSERT INTO TBL_EMP VALUES (8003, '공유', 'SALESMAN', 7698, SYSDATE, 2000, NULL, NULL);
INSERT INTO TBL_EMP VALUES (8004, '장동건', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
INSERT INTO TBL_EMP VALUES (8005, '원빈', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다. * 5


--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	 800		    20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	 300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500	30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0	30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	 950		    30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
8001	조인성	CLERK	    7566	2019-04-01	1500	  10	
8002	강동원	CLERK	    7566	2019-04-01	1000	   0	
8003	공유	SALESMAN	7698	2019-04-01	2000		
8004	장동건	SALESMAN	7698	2019-04-01	2500		
8005	원빈	SALESMAN	7698	2019-04-01	1000		
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT DEPTNO"부서번호", SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	     8750
20	    10875
30	     9400
(null)	 8000   → 부서번호가 NULL 인 데이터들끼리의 급여 합
(null)	37025   → 모든 부서의 급여 총 합계
*/

-- 위에서 조회한 내용을
/*
10	         8750
20	        10875
30	         9400
인턴	     8000   → 부서번호가 NULL 인 데이터들끼리의 급여 합
모든부서	37025   → 모든 부서의 급여 총 합계
*/


SELECT CASE DEPTNO WHEN NULL
            THEN '인턴'
            ELSE DEPTNO
       END"부서번호"
FROM TBL_EMP;
--==>> 에러 발생
/*
ORA-00932: inconsistent datatypes: expected CHAR got NUMBER
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
704행, 22열에서 오류 발생
*/

SELECT CASE DEPTNO WHEN NULL
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END"부서번호"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
(null)
(null)
(null)
(null)
(null)
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END"부서번호"
FROM TBL_EMP;
--==>>
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
인턴
인턴
인턴
인턴
인턴
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END"부서번호"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	     8750
20	    10875
30	     9400
인턴	 8000
인턴	37025
*/

SELECT CASE WHEN DEPTNO IS NULL
            THEN '인턴'
            ELSE TO_CHAR(DEPTNO)
       END"부서번호"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	     8750
20	    10875
30	     9400
인턴	 8000
*/

SELECT T.*
FROM
(
    SELECT CASE WHEN DEPTNO IS NULL
                THEN '인턴'
                ELSE TO_CHAR(DEPTNO)
           END"부서번호"
         , SUM(SAL)"급여합"
    FROM TBL_EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO
)T
GROUP BY ROLLUP(T.부서번호);
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
804행, 10열에서 오류 발생
*/


--※ GROUPING()
SELECT DEPTNO"부서번호", SUM(SAL)"급여합", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	     8750	0
20	    10875	0
30	     9400	0
(null)	 8000	0
(null)	37025	1
*/



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서' END"부서번호"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8000
모든부서	37025
*/


--○ TBL_SAWON 테이블을 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
------------------------
    성별      급여합
------------------------
    남         XXXXX
    여         XXXXX
    확인불가
    모든사원 XXXXXXX
*/

SELECT * 
FROM TBL_SAWON;

SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
           ELSE '모든사원' 
       END"성별"
     , SUM(T.급여)"급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '확인불가'
        END"성별"
        , SAL"급여"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        21100
여	        22000
확인불가	 5000
모든사원	48100
*/


--○ TBL_SAWON 테이블을 다음과 같이 연령대별 인원수 형태로
--   조회할 수 있도록 쿼리문을 구성한다.
/*
------------------------------
    연령대     인원수
------------------------------
    0           X
    10          X
    20          X
    30          X
    40          X          
    50          X
    전체        X
------------------------------
*/

SELECT *
FROM TBL_SAWON;

SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN TO_CHAR(T2.연령대)
           ELSE '전체' 
       END"연령대"
    , COUNT(*)"인원수"
FROM(
    SELECT
        CASE WHEN T.현재나이<10 THEN 0
             WHEN T.현재나이<20 THEN 10
             WHEN T.현재나이<30 THEN 20
             WHEN T.현재나이<40 THEN 30
             WHEN T.현재나이<50 THEN 40
             WHEN T.현재나이<60 THEN 50
             ELSE NULL
          END "연령대"
        
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1999)
                    ELSE NULL
                END"현재나이"
        FROM TBL_SAWON
    )T
)T2
GROUP BY ROLLUP(T2.연령대);
--==>>
/*
연령대        인원수
----------- ----------
10              3
20              5
30              2
40              4
50              1
(null)          1
전체           16
*/


-- 방법1. (INLINE VIEW 를 두 번 중첩)
SELECT CASE GROUPING(Q.연령대) WHEN 0 THEN TO_CHAR(Q.연령대)
           ELSE '전체' 
       END"연령대"
    , COUNT(Q.연령대)"인원수"
FROM
(   
    SELECT CASE WHEN T.나이>=50 THEN 50
                WHEN T.나이>=40 THEN 40
                WHEN T.나이>=30 THEN 30
                WHEN T.나이>=20 THEN 20
                WHEN T.나이>=10 THEN 10
                ELSE 0
            END "연령대"
    FROM
    (
        -- 나이
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1999)
                    ELSE 0
                END"나이"
        FROM TBL_SAWON
    )T
)Q
GROUP BY ROLLUP(Q.연령대);
--==>>
/*
연령대       인원수
---------- ----------
0              1
10             3
20             5
30             2
40             4
50             1
전체          16
*/


-- 방법2. (INLINE VIEW 를 한 번만 사용)
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
           ELSE '전체' 
       END"연령대"
    , COUNT(T.연령대)"인원수"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1899) 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1999)
            ELSE 0
       END, -1)"연령대"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
연령대            인원수
--------------- ----------
0                   1
10                  3
20                  5
30                  2
40                  4
50                  1
전체               16
*/

SELECT TRUNC(23, -1)"확인"
FROM DUAL;


--○ ROLLUP 활용 및 CUBE
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10	    (null)       8750       -- 10번 부서 모든 직종의 급여합
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875       -- 20번 부서 모든 직종의 급여합
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400       -- 30번 부서 모든 직종의 급여합
(null)  (null)      29025       -- 모든 부서 모든 직종의 급여합
*/


--○ CUBE() → ROLLUP() 보다 좀 더 자세한 결과를 반환받을 수 있다.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10	    (null)	     8750       -- 10번 부서 모든 직종의 급여합
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875       -- 20번 부서 모든 직종의 급여합
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN  	 5600
30	    (null)	     9400       -- 30번 부서 모든 직종의 급여합
(null)	ANALYST	     6000       -- 모든 부서 ANALYST 직종의 급여합
(null)	CLERK	     4150       -- 모든 부서 CLERK 직종의 급여합
(null)	MANAGER	     8275       -- 모든 부서 MANAGER 직종의 급여합
(null)	PRESIDENT	 5000       -- 모든 부서 PRESIDENT 직종의 급여합
(null)	SALESMAN	 5600       -- 모든 부서 SALESMAN 직종의 급여합
(null)	(null)	    29025       -- 모든 부서 모든 직종의 급여합
*/

--※ ROLLUP() 과 CUBE() 는
--   그룹을 묶어주는 방식이 다르다. (차이)

-- ROLLUP(A, B, C)
-- → (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- → (A, B, C) / (A, B)/ (A, C) / (B / C) / (A) / (B) / (C) / ()

--==>> 위의 처리 내용은 너무 많은 결과물이 출력되기 때문에
--     다음의 쿼리 형태를 더 많이 사용한다.
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만 『GROUPING SETS』를
--     이용하여 묶어주는 방법이다.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END"부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
            ELSE '전체직종'
       END"직종"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종	 8750
20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	10875
30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종	 9400
인턴	    CLERK	     2500
인턴	    SALESMAN	 5500
인턴	    전체직종	 8000
전체부서	전체직종	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END"부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
            ELSE '전체직종'
       END"직종"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종	 8750
20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	10875
30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종	 9400
인턴	    CLERK	     2500
인턴	    SALESMAN	 5500
인턴	    전체직종	 8000
전체부서	ANALYST	     6000
전체부서	CLERK	     6650
전체부서	MANAGER	     8275
전체부서	PRESIDENT	 5000
전체부서	SALESMAN	11100
전체부서	전체직종	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END"부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
            ELSE '전체직종'
       END"직종"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO,JOB), (DEPTNO), ())      -- ROLLUP() 과 같은 결과
ORDER BY 1, 2;


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END"부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
            ELSE '전체직종'
       END"직종"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO,JOB), (DEPTNO), (JOB), ())      -- CUBE() 과 같은 결과
ORDER BY 1, 2;


--○ TBL_EMP 테이블에서 입사년도별 인원수를 조회한다,
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

/*
----------------------------
    입사년도       인원수
----------------------------
     1980           1
     1981          10
     1982           1
     1987           2
     2019           5
     전체          19
----------------------------
*/
SELECT CASE GROUPING(T.입사년도) WHEN 0 THEN TO_CHAR(T.입사년도)
           ELSE '전체' 
       END"입사년도"
    , COUNT(T.입사년도)"인원수"
FROM(
    SELECT  EXTRACT(YEAR FROM HIREDATE)"입사년도"
    FROM TBL_EMP
    ORDER BY HIREDATE
)T
GROUP BY ROLLUP(T.입사년도)
ORDER BY 1, 2;


SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS(EXTRACT(YEAR FROM HIREDATE), ())
ORDER BY 1;

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
1,231행, 26열에서 오류 발생
*/

SELECT TO_CHAR(HIREDATE, 'YYYY')"입사년도"
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
1,245행, 16열에서 오류 발생
*/
