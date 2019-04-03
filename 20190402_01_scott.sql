SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ HAVING ■■■--

--○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회한다.
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> 에러 발생
/*
ORA-00934: group function is not allowed here
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
17행, 7열에서 오류 발생
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (20, 30)           -- 일반 조건문은 WHERE에 사용할 것을 권장
   AND SUM(SAL) < 10000;
--==>> 30	9400


----------------------------------------------------------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- 그룹 함수 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- 이마저도 MSSQL 은 불가능하다.
SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875

-- RANK()
-- DENSE_RANK()
--> ORACLE 9i 부터 적용 MSSQL 2005 부터 적용

-- 하위 버전에서는 RANK() 나 DENSE_RANK() 를 사용할 수 없기 때문에
-- 이를 대체하여 연산을 수행할 수 있는 방법을 강구해야 한다.

-- 예를 들어, 급여의 순위를 구하고자 한다면
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 확인한 숫자에 +1 을 추가 연산해주면 그것이 곧 등수가 된다.

SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--==>> 14 → SMITH 의 급여 등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;
--==>> 7 → ALLEN 의 급여 등수


--※ 서브 상관 쿼리 (상관 서브 쿼리)
--   메인 쿼리에 있는 테이블의 컬럼이
--   서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
--   우리는 이 쿼리문을 서브 상관 쿼리 라고 부른다.

SELECT ENAME"사원명", SAL"급여", 1"급여등수"
FROM EMP;

SELECT ENAME"사원명", SAL"급여"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E1.SAL)"급여등수"
FROM EMP E1;
--==>>
/*
SMITH	 800	14
ALLEN	1600	 7
WARD	1250	10
JONES	2975	 4
MARTIN	1250	10
BLAKE	2850	 5
CLARK	2450	 6
SCOTT	3000	 2
KING	5000	 1
TURNER	1500	 8
ADAMS	1100	12
JAMES	 950	13
FORD	3000	 2
MILLER	1300	 9
*/


SELECT ENAME"사원명", SAL"급여"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E1.SAL)"급여등수"
FROM EMP E1
ORDER BY 3;
--==>>
/*
KING	5000	 1
FORD	3000	 2
SCOTT	3000	 2
JONES	2975	 4
BLAKE	2850	 5
CLARK	2450	 6
ALLEN	1600	 7
TURNER	1500	 8
MILLER	1300	 9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	 950	13
SMITH	 800	14
*/


--○ EMP 테이블을 대상으로 
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK() 함수를 사용하지 않고, 상관 서브 쿼리를 활용할 수 있도록 한다.



SELECT ENAME"사원명", SAL"급여"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE DEPTNO = E1.DEPTNO AND SAL > E1.SAL)"부서내급여등수"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E1.SAL)"전체급여등수"
FROM EMP E1
ORDER BY E1.DEPTNO, SAL DESC;
--==>>
/*
KING	5000	1	 1
CLARK	2450	2	 6
MILLER	1300	3	 9
SCOTT	3000	1	 2
FORD	3000	1	 2
JONES	2975	3	 4
ADAMS	1100	4	12
SMITH	 800	5	14
BLAKE	2850	1	 5
ALLEN	1600	2	 7
TURNER	1500	3	 8
MARTIN	1250	4	10
WARD	1250	4	10
JAMES	 950	6	13
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--○ EMP 테이블을 대상으로 다음과 같이 조회할 수 있도록 한다.
/*
----------------------------------------------------------------------------
  사원명   부서번호    입사일       급여      부서내입사별급여누적
  CLARK	     10	    1981-06-09	    2450            2450
  KING	     10	    1981-11-17	    5000            7450
  MILLER     10	    1982-01-23	    1300            8750
  SMITH	     20	    1980-12-17	     800             800
  JONES	     20	    1981-04-02	    2975            3775
  FORD	     20	    1981-12-03	    3000
  SCOTT	     20	    1987-07-13	    3000
  ADAMS	     20	    1987-07-13	    1100
  ALLEN	     30	    1981-02-20	    1600
  WARD	     30	    1981-02-22	    1250
  BLAKE	     30	    1981-05-01	    2850
  TURNER     30	    1981-09-08	    1500
  MARTIN     30	    1981-09-28	    1250
  JAMES	     30	    1981-12-03	     950
----------------------------------------------------------------------------
*/

SELECT ENAME"사원명", DEPTNO"부서번호", HIREDATE"입사일", SAL"급여"
     , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E1.DEPTNO AND HIREDATE <= E1.HIREDATE)"부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;
--==>>
/*
CLARK	10	1981-06-09	2450	 2450
KING	10	1981-11-17	5000	 7450
MILLER	10	1982-01-23	1300	 8750
SMITH	20	1980-12-17	 800	  800
JONES	20	1981-04-02	2975	 3775
FORD	20	1981-12-03	3000	 6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	 1600
WARD	30	1981-02-22	1250	 2850
BLAKE	30	1981-05-01	2850	 5700
TURNER	30	1981-09-08	1500	 7200
MARTIN	30	1981-09-28	1250	 8450
JAMES	30	1981-12-03	 950	 9400
*/


--○ TBL_EMP를 기반으로 입사한 사원수가 제일 많았을 때의
--   입사년월과 인원수를 조회할 수 있는 쿼리문을 구성한다.
/*
-------------------------------------
    입사년월        인원수
-------------------------------------
    2019-04           5 
-------------------------------------
*/
SELECT *
FROM(
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월", COUNT(*)"인원수"
    FROM TBL_EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
)T
WHERE T.인원수 = (SELECT MAX(COUNT(*))
                  FROM TBL_EMP
                  GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>>
/*
입사년월  인원수
------- ----------
2019-04     5
*/


SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월", COUNT(*)"인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                  FROM EMP
                  GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>>
/*
1981-12	2
1981-09	2
1981-02	2
1987-07	2
*/


-------------------------------------------------------------------------------------------------------

--■■■ ROW_NUMBER() ■■■--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
     , ENAME"사원명", SAL"급여", HIREDATE"입사일"
FROM EMP
ORDER BY ENAME;


--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에 다음 번호를 가진
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는 보안 측면에서나 미관상 바람직하지 않은 상황일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY 를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 좋다.

CREATE TABLE TBL_AAA
( NO        NUMBER
, NAME      VARCHAR2(30)
, GRADE     CHAR(10)
);
--==>> Table TBL_AAA이(가) 생성되었습니다.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '이지혜', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '이기승', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '윤희진', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '권홍비', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '권홍비', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '이기승', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '이기승', 'A');
--==>> 1 행 이(가) 삽입되었습니다. * 7

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_AAA;
--==>>
/*
1	이지혜	A         
2	이기승	B         
3	윤희진	A         
4	권홍비	C         
5	권홍비	A         
6	이기승	A         
7	이기승	A         
*/

UPDATE TBL_AAA
SET GRADE = 'C'
WHERE NO=6;


SELECT *
FROM TBL_AAA
WHERE NO=6;
--==>> 6	이기승	A         


--○ SEQUENCE (시퀀스 : 주문번호) 생성
--   → 사전적인 의미 : 1.(일련의) 연속적인 사건들  2.(사건, 행동 등의) 순서

CREATE SEQUENCE SEQ_BOARD   -- 시퀀스 생성 기본 구문(MSSQL 의 IDENTITY 와 동일한 개념)
START WITH 1                -- 시작값
INCREMENT BY 1              -- 증가값
NOMAXVALUE                  -- 최대값 제한 없음
NOCACHE;                    -- 캐시 사용 안함(없음)
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


--○ 테이블 생성(TBL_BOARD)
CREATE TABLE TBL_BOARD              -- TBL_BOARD 이름의 테이블 생성 → 게시판
( NO        NUMBER                  -- 게시물 번호       Ⅹ
, TITLE     VARCHAR2(50)            -- 게시물 제목       ○
, CONTENTS  VARCHAR2(2000)          -- 게시물 내용       ○
, NAME      VARCHAR2(20)            -- 게시물 작성자     △
, PW        VARCHAR2(20)            -- 게시물 패스워드   △
, CREATED   DATE DEFAULT SYSDATE    -- 게시물 작성일     Ⅹ
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


--○ 데이터 입력 → 게시판에 게시물 작성
INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '앗싸~1등', '내가 1등이지롱', '전훈의', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '건강관리', '다들 건강 챙깁시당', '유진석', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '오늘은', '점심 뭐먹지...', '최보라', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '오늘은', '미세먼지 없나?', '정임혜', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '공부히고싶은데', '뒤에서 잘 안보여요', '조현우', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '질문있습니다', '쉬었다 한면 안되나요', '남상현', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '질문있습니다', '생각나면 다시 질문할께요', '한승원', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES (SEQ_BOARD.NEXTVAL, '졸려요', '전 그냥 잘래요', '윤희진', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_BOARD;

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES (SEQ_BOARD.NEXTVAL, '저는요', '잘 지내고 있습니다.', '이원영', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1등	    내가 1등이지롱	            전훈의	JAVA006$	2019-04-02
3	오늘은	        점심 뭐먹지...	            최보라	JAVA006$	2019-04-02
5	공부히고싶은데	뒤에서 잘 안보여요	        조현우	JAVA006$	2019-04-02
6	질문있습니다	쉬었다 한면 안되나요	    남상현	JAVA006$	2019-04-02
7	질문있습니다	생각나면 다시 질문할께요	한승원	JAVA006$	2019-04-02
9	저는요	        잘 지내고 있습니다.	        이원영	JAVA006$	2019-04-02
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	저는요	        이원영	2019-04-02
5	질문있습니다	한승원	2019-04-02
4	질문있습니다	남상현	2019-04-02
3	공부히고싶은데	조현우	2019-04-02
2	오늘은	        최보라	2019-04-02
1	앗싸~1등	    전훈의	2019-04-02
*/

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES (SEQ_BOARD.NEXTVAL, '오빠', '저 맘에 안들죠', '김선아', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=7;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	오빠	        김선아	2019-04-02
5	저는요	        이원영	2019-04-02
4	질문있습니다	남상현	2019-04-02
3	공부히고싶은데	조현우	2019-04-02
2	오늘은	        최보라	2019-04-02
1	앗싸~1등	    전훈의	2019-04-02
*/


------------------------------------------------------------------------------------------------------

--■■■ JOIN(조인) ■■■--        ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

-- 1. SQL 1992 CODE
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(Catersian Product)
--  두 테이블을 합친(결합한) 모든 경우의 수

-- Equi join : 서로 정확히 일치하는 데이터들끼리 연결시키는 결합
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


-- Non Equi join : 범위 안에 적합한 데이터들끼리 연결시키는 결합
SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- Equi Join 시 『(+)』 를 활용한 결합 방법
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5)은 모두 나락!!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);       
--> 총 19 건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들도 모두 조회된 상황

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO; 
--> 총 16 건의 데이터가 결합되어 조회된 상황
--  즉, 부서에 소속된 사원이 아무도 없는 부서도 모두 조회된 상황

--※ (+)가 없는 쪽 데이블의 데이터를 모두 메모리에 적재한 후
--   (+)가 있는 쪽 테이블의 데이터를 하나한 확인하여 결합시키는 형태로
--   JOIN 이 이루어진다.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--> 위와 같은 이유로 이러한 형식의 JOIN 구문은 존재하지 않는다.


-- 2. SQL 1999 CODE → 『JOIN』 키워드 등장 → JOIN 유형 명시
--                     결합 조건은 『WHERE』 대신 『ON』 사용

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--※ INNER JOIN 시 INNER 는 생략 가능
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- OUTER JOIN 
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

--※ 방향이 지정된 쪽 테이블(→ LEFT) 의 데이터를 모두 메모리에 적재한 후
--   방향이 지정되지 않은 쪽 테이블들의 데이터를 각각 확인하여 결합시키는 형태로
--   JOIN 이 이루어진다.

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

--※ OUTER JOIN 에서 OUTER 는 생략 가능

SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D    -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT            -- INNER JOIN
ON E.DEPTNO = D.DEPTNO;

-------------------------------------------------------------------------------------------------------
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- 이 결과에서 직종이 CLERK 인 사원들만 조회

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- 이렇게 쿼리문을 구성해도 조회하는 데는 문제가 없다.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- 하지만, 이와 같이 구성하여 조회할 수 있도록 권장한다.
-------------------------------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블에서
--   직종이 MANAGER 와 CLERK 인 사원들만
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.

SELECT D.DEPTNO"부서번호", D.DNAME"부서명", E.ENAME"사원명", E.JOB"직종명", E.SAL"급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'MANAGER' OR JOB = 'CLERK'
ORDER BY 4;
-- DEPTNO 는 EMP, DEPT 둘 다 해당되지만 부모자식을 구분하여 작성 (일 대 다수)
-->
SELECT DEPTNO           -- → EMP 테이블의 DEPTNO(다수)
FROM EMP;
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
*/

SELECT DEPTNO           -- → DEPT 테이블의 DEPTNO
FROM DEPT;
--==>>
/*
10
20
30
40
*/

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 에러 발생
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
649행, 8열에서 오류 발생
*/
--> 두 테이블 간 중복되는 컬럼에 대한 소속 테이블을
--  정해줘야(명시해 줘야)한다.

SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복되는 컬럼이 존재하지 않는 조회 구문은
--  에러 발생하지 않는다.
--==>> 
/*
RESEARCH	SMITH	CLERK	     800
SALES	    ALLEN	SALESMAN	1600
SALES	    WARD	SALESMAN	1250
RESEARCH	JONES	MANAGER	    2975
SALES	    MARTIN	SALESMAN	1250
SALES	    BLAKE	MANAGER	    2850
ACCOUNTING	CLARK	MANAGER	    2450
RESEARCH	SCOTT	ANALYST	    3000
ACCOUNTING	KING	PRESIDENT	5000
SALES	    TURNER	SALESMAN	1500
RESEARCH	ADAMS	CLERK	    1100
SALES	    JAMES	CLERK	     950
RESEARCH	FORD	ANALYST	    3000
ACCOUNTING	MILLER	CLERK	    1300
*/


SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
-- SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--  부서(DEPT), 사원(EMP) 중 어떤 테이블을 지정해도
--  쿼리문 수행에 대한 결과 반환에 문제가 없다.

--※ 하지만 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--   부모 테이블의 컬럼을 참조할 수 있도록 해야 한다.

SELECT *
FROM DEPT;      -- 부모 테이블
SELECT *
FROM EMP;       -- 자식 테이블

--※ 부모 자식 테이블 관계를 명확히 정리할 수 있도록 한다. ★★★★★★

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복된 컬럼이 아니더라도
--  소속 테이블을 명시할 수 있도록 권장한다.

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E LEFT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E LEFT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

---

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT E.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


--○ SELF JOIN (자기 조인)

-- EMP 테이블의 정보를 다음과 같이 조회할 수 있도록 한다.
/*
E         E       E       E           E         E
EMPNO     ENAME   JOB     MGR, EMPNO  ENAME     JOB
------------------------------------------------------------
사원번호  사원명  직종명  관리자번호  관리자명  관리자직종명
------------------------------------------------------------
7369      SMITH   CLERK   7902        FORD      ANALYST

EMP       EMP     EMP     EMP                                       --> ①
                          EMP         EMP       EMP                 --> ②
------------------------------------------------------------
*/

SELECT E1.EMPNO"사원번호", E1.ENAME"사원명", E1.JOB"직종명", E2.EMPNO"관리자번호", E2.ENAME"관리자명", E2.JOB"관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO
ORDER BY 1;
/*
7369	SMITH	CLERK	    7902	FORD	ANALYST
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7839	KING	PRESIDENT			
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7902	FORD	ANALYST	    7566	JONES	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
*/

SELECT *
FROM EMP;


--○ 커밋
COMMIT;
--==>> 커밋 완료.
















