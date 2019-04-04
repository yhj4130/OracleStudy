SELECT USER
FROM DUAL;
--==>> HR


------------------------------------------------------------------------------------------------------------

--■■■ 정규화(Nomalization) ■■■--

--○ 정규화란?
--   한 마디로 데이터베이스 서버의 메모리 낭비를 막기 위해
--   어떤 하나의 테이블을 식별자를 가리는 여러 개의 테이블로
--   나누는 과정을 말한다.

-- ex) 진석이가 옥장판을 판매한다.
--     고객리스트 → 거래처직원 명단이 적혀있는 수첩의 정보를
--     데이터베이스화 하려고 한다.

-- 테이블명 : 거래처직원
/* 
   10Byte     10Byte     10Byte          10Byte    10Byte  10Byte     10Byte
---------------------------------------------------------------------------------
거래처회사명 회사주소    회사전화     거래처직원명  직급   이메일     휴대폰
---------------------------------------------------------------------------------
    LG       서울여의도  02-3456-7890    곽한얼     부장   khy@na...  010-...
    LG       서울여의도  02-3456-7890    권홍비     과장   khb@na...  010-...
    LG       서울여의도  02-3456-7890    김경환     대장   kkh@na...  010-...
    LG       서울여의도  02-3456-7890    김선아     부장   ksa@na...  010-...
    SK       서울소공동  02-1234-5678    김성희     대리   ksh@na...  010-...
    LG       부산동래구  051-9999-9999   남상현     대리   nsh@na...  010-...
                                    :
                                    :
---------------------------------------------------------------------------------
*/

/*
가정) 서울 여의도 LG 라는 회사에 근무하는 거래처 직원 명단이
      총 100만 명이라고 한다.
      (한 행(레코드)은 70Byte 이다.)
      
      어느날 『서울 여의도』에 위치한 『LG』 본사가
      『경기 분당』으로 사옥을 이전하게 되었다.
      이로 인해
      회사 주소는 『경기 분당』으로 바뀌고,
      회사 전화는 『031-1111-2222』로 바뀌게 되었다.
      
      그러면 100만 명의 회사주소와 회사전화를 변경해야 한다.
      
      - 이 때 수행되어야 할 쿼리문 → UPDATE 구문
      
        UPDATE 거래처직원
        SET 회사주소='경기분당', 회사전화='031-1111-2222'
        WHERE 거래처회사명='LG'
          AND 회사주소='서울여의도';
          
      --> 100만 개 행을 하드디스크상에서 읽어다가
          메모리에 로드시켜주어야 한다.
          즉, 100만 * 70Byte 를 모두
          하드디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말이다.
          
          --> 이는 테이블의 설계가 잘못되었으므로
              DB서버는 조만간 메모리 고갈로 인해 DOWN 될 것이다.
              
              --> 그러므로 정규화 과정을 수행해야 한다.
*/

--※ 테이블이 분할(분리)되기 이전 상태로 조회
SELECT A.거래처회사명 , A.회사주소, A.회사전화
     , B.거래처직원명, B.직급, B.이메일, B.휴대폰
FORM 회사 A.직원 B
WHERE A.회사ID = B.회사ID;


--○ 제 1 정규화
--> 어떤 하나의 테이블에 반복되어 컬럼 값들이 존재한다면
--  값들이 반복되어 나오는 컬럼을 분리하여
--  새로운 테이블을 만들어준다.

--> 제 1정규화를 수행하는 과정에서 분리된 테이블은
--  반드시 부모 테이블과 자식 테이블의 관계를 갖게 된다. 

--> 부모 테이블 → 참조받는 컬럼 → PRIMARY KEY 
--  자식 테이블 → 참조하는 컬럼 → FOREIGN KEY

--※ 참조받는 컬림이 갖는 특징(부모 테이블)
--   - 반드시 고유한 값(데이터)이 들어와야 한다.
--     즉, 중복된 값(데이터)이 없어야 한다.
--   - NULL 이 있어서는 안된다.(NOT NULL 이어야 한다.)

--> 제 1 정규화를 수행하는 과정에서 부모 테이블의 PRIMARY KEY 는
--  항상 자식 테이블의 FOREIGN KEY 로 전이된다.


/* 

테이블 명 : 회사 → 부모 테이블
10Byte      10Byte     10Byte     10Byte        
-----------------------------------------------
회사ID   거래처회사명 회사주소    회사전화     
------
(참조받는 컬럼 → P.K)
-----------------------------------------------
 10          LG       서울여의도  02-3456-7890      → 여러개 있을 필요 없어서 하나만
 20          SK       서울소공동  02-1234-5678    
 30          LG       부산동래구  051-9999-9999 
-----------------------------------------------

테이블명 : 직원 → 자식 테이블
   10Byte    10Byte  10Byte     10Byte
-------------------------------------------------
거래처직원명  직급   이메일     휴대폰    회사ID
                                          ------
                                          (참조하는 컬럼 → F.K(NULL가능))
-------------------------------------------------
  곽한얼     부장   khy@na...  010-...      10
  권홍비     과장   khb@na...  010-...      10
  김경환     대장   kkh@na...  010-...      10
  김선아     부장   ksa@na...  010-...      10
  김성희     대리   ksh@na...  010-...      20
  남상현     대리   nsh@na...  010-...      30
                     :
                     :
------------------------------------------------
*/

/*
가정) 서울 여의도 LG 라는 회사에 근무하는 거래처 직원 명단이
      총 100만 명이라고 한다.

      어느날 『서울 여의도』에 위치한 『LG』 본사가
      『경기 분당』으로 사옥을 이전하게 되었다.
      이로 인해
      회사 주소는 『경기 분당』으로 바뀌고,
      회사 전화는 『031-1111-2222』로 바뀌게 되었다.
      
      그러면 회사 테이블에서 1건의 회사주소와 회사전화를 변경해야 한다.
      
      - 이 때 수행되어야 할 쿼리문 → UPDATE 구문
      
        UPDATE 회사
        SET 회사주소='경기분당', 회사전화='031-1111-2222'
        WHERE 회사ID=10
        
        --> 1개 행을 하드디스크상에서 읽어다가
          메모리에 로드시켜주어야 한다.
          즉, 1 * 40Byte 를 모두
          하드디스크상에서 읽어다가 메모리에 로드시켜 주면 된다는 말이다.
          
          --> 이는 테이블 설계가 잘 된 상황이다.
              
              --> 정규화를 수행하기 이전에는 100만 건을 처리해야 할 업무에서
                  1건만 처리하면 되는 업무로 바뀐 상황이기 때문에
                  DB서버는 메모리에  고갈없이 아주 빠르게 처리될 것이다.
*/

-- A. 거래처회사명, 회사전화
/*
SELECT 거래처회사명, 회사전화         | SELECT 거래처회사명, 회사전화
FROM 회사                             | FROM 거래처직원
--> 3 * 40Byte                        | --> 200만 * 70Byte
*/

-- B. 거래처직원명, 직급
/*
SELECT 거래처직원명, 직급             | SELECT 거래처직원명, 직급
FROM 직원                             | FROM 거래처직원
--> 200만 * 50Byte                    | --> 200만 * 70Byte
*/

-- C. 거래처회사명, 거래처직원명
/*
SELECT 회사.거래처회사명, 직원.거래처직원명     | SELECT 거래처회사명, 거래처직원명
FROM 회사 JOIN 직원                             | FROM 거래처직원
ON 회사.회사ID = 직원.회사ID                    | --> 200만 * 70Byte
--> (3*40Btye) + (200만*50Byte)                 
*/


/*
-- 테이블명 : 주문
---------------------------------------------------------------------------------
  고객ID              제품코드            주문일자                주문수량
  ++++++++++++++++++++++++++++++++++++++++++++++++
                       (P.K)
---------------------------------------------------------------------------------
  CSY1227(조수연)     SWK9984(새우깡)     2019-04-02 11:11:11        50
  KHE7733(곽한얼)     YPR8866(양파링)     2019-04-02 12:12:12        30
  LJH7755(이지혜)     CPI1100(초파이)     2019-04-03 10:12:00        20
  LJH7755(이지혜)     SWK9984(새우깡)     2019-04-03 17:00:00        20
  KHE7733(곽한얼)     CPI1100(초파이)     2019-04-04 05:12:12        50
                                    :
                                    :
---------------------------------------------------------------------------------
*/

--※ 하나의 테이블에 존재하는 PRIMARY KEY 의 최대 갯수는 1개이다.
--   하지만, PRIMARY KEY 를 이루는(구성하는) 컬럼의 갯수는
--   복수(다수, 여러개)인 것이 가능하다.
--   컬럼 1개로만 (단일 컬럼) 구성된 PRIMARY KEY를
--   Single Primary Key 라고 부른다.
--   (단일 프라이머리 키)
--   두 개 이상의 컬럼으로 구성된 PRIMARY KEY를
--   Composite Primary Key 라고 부른다.
--   (복합 프라이머리 키)


--○ 제 2 정규화
--> 제 1 정규화를 마친 결과물에서 PRIMARY KEY 가 SINGLE COLUMN 이라면
--  제 2 정규화는 수행하지 않는다.
--  하지만, PRIMARY KEY 가 COMPOSITE COLUMN 이라면
--  반.드.시. 제 2정규화를 수행해야 한다.

--> 식별자가 아닌 컬럼은 식별자 전체 컬럼에 대해 의존적이어야 하는데
--  식별자 전체 컬럼이 아닌 일부 식별자 컬럼에 대해서만 의존적이라면
--  이를 분리하여 새로운 테이블 생성해 준다.

/*
테이블명 : 과목 → 부모 테이블
------------------------------------------------------------------------------------
과목번호    과목명       교수자번호  교수자명   강의실코드  강의실설명
++++++++                 ++++++++++
(P              .               K)
------------------------------------------------------------------------------------
JV0101      자바기초     21          슈바이처   A301        전산실습관 3층 30석 규모
JV0102      자바중급     22          테슬라     T502        전자공학관 5층 20석 규모
DB0102      오라클중급   22          테슬라     A201        전산실습관 2층 50석 규모
DB0102      오라클중급   10          장영실     T502        전자공학관 5층 20석 규모
DB0103      오라클고급   22          테슬라     A203        전산실습관 2층 90석 규모
JS0105      JSP심화      10          장영실     K101        인문사회관 1층 80석 규모
                                        :
                                        :
------------------------------------------------------------------------------------

테이블명 : 점수 → 자식 테이블
---------------------------------------------------
과목번호    교수자번호   학번      학생명     점수
======================
       (F.K)
++++++++                 ++++
(P           .             K)
---------------------------------------------------
DB0102      22           1902110   이기승     80
DB0102      22           1902127   윤희진     70
                        :
                        :
---------------------------------------------------
*/


--○ 제 3 정규화
--> 식별자가 아닌 컬럼이 식별자가 아닌 컬럼에 의존적인 상황이라면
--  이를 분리하여 새로운 테이블을 생성해 주어야 한다.


--※ 관계(Relation)의 종류

-- 1 : 1

-- 1 : 다
--> 제 1 정규화를 마친 결과물에서 나타나는 바람직한 관계.
--  관계형 데이터베이스를 활용하는 과정에서 추구해야 하는 관계.

-- 다 : 다
--> 논리적인 모델링에서는 존재할 수 있지만
--  실제 물리적인 모델링에서는 존재할 수 없는 관계.

/*
테이블명 : 고객 (다)                   테이블명 : 제품 (다)
---------------------------           ----------------------------
고객번호 고객명 이메일 ...            제품코드 제품명 제품단가 ...
++++++++                              ++++++++
 (P.K)                                 (P.K)
---------------------------           ----------------------------
  1100   이원영 ....                    swk    새우깡 1500
  1101   김선아 ....                    ggk    감자깡  700
  1102   임나래 ....                    ggc    자갈치  500
           :                                        :
           
           테이블명 : 주문등록 
           -------------------------------------
           고객번호 제품코드 주문일자 주문수량
           -------------------------------------
             1100     swk     ......     30
             1101     swk     ......     50
                            :
*/


--○ 제 4 정규화
-->  위에서 확인한 내용과 같이 『다:다』 관계를 『1:다』 관계로 깨뜨리는 과정이
--   제 4 정규화의 수행 과정이다.
--   → 일반적으로 파생 테이블 생성
--      → 『다:다』 관계를 『1:다』 관계로 깨뜨리는 역할 수행



--○ 역정규화(비정규화)
/*
--A 경우 → 역정규화를 수행하지 않는 것이 바람직한 경우

테이블명 : 부서                           테이블명 : 사원

      10        10       10          10        10     10    10     10       10       10
------------------------------     ----------------------------------------------- ------
부서번호   부서명   주소           사원번호  사원명  직급  급여  입사일  부서번호  부서명
++++++++                           ++++++++                              ========  ------
 (P.K)                              (P/K)                                 (F.K)
------------------------------     ----------------------------------------------- ------
              10개 행                                 1,000,000개 행
------------------------------     ----------------------------------------------- ------

>> 업무 분석 상 조회 결과물
---------------------------
부서명  사원명  직급  급여
---------------------------
 부서   사원    사원  사원
 
→ 『부서』테이블과 『사원』테이블을 JOIN 했을 때의 크기
    (10 * 30Byte) +  (1000000 * 60Byte) = 300 + 60000000 = 60000200Byte
     
→ 『사원』테이블을 역정규화 수행한 수 이 테이블만 읽어올 떄의 크기
    (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
     1000000 * 70Byte = 70000000Byte


--B 경우 → 역정규화를 수행하는 것이 바람직하다.

테이블명 : 부서                           테이블명 : 사원

  10        10       10                     10        10     10    10     10       10       10
-------------------------------------     ----------------------------------------------- ------
부서번호   부서명   주소                  사원번호  사원명  직급  급여  입사일  부서번호  부서명
++++++++                                  ++++++++                              ========  ------
 (P.K)                                     (P/K)                                 (F.K)
-------------------------------------     ----------------------------------------------- ------
        500,000개 행                                    1,000,000개 행
-------------------------------------     ----------------------------------------------- ------

>> 업무 분석 상 조회 결과물
---------------------------
부서명  사원명  직급  급여
---------------------------
 부서   사원    사원  사원
 
→ 『부서』테이블과 『사원』테이블을 JOIN 했을 때의 크기
    (500000 * 30Byte) +  (1000000 * 60Byte) = 15000000 + 60000000 = 75000000Byte
     
→ 『사원』테이블을 역정규화 수행한 수 이 테이블만 읽어올 떄의 크기
    (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
     1000000 * 70Byte = 70000000Byte
*/


/*
테이블명 : 사원 → 부모 테이블
---------------------------------------------------
사원번호   사원명   주민번호  입사일   급여   직급 
++++++++
 (P.K)
---------------------------------------------------
  7369     전훈의   9XXXXXXX  2010-XX  XXXX   부장
  7370     유진석   9XXXXXXX  2011-XX  XXXX   차장
  7371     최보라   9XXXXXXX  2010-XX  XXXX   과장
  7372     정임혜   9XXXXXXX  2010-XX  XXXX   대리 
  7373     조현우   9XXXXXXX  2010-XX  XXXX   사원
                        :
  
  
테이블명 : 사원가족 → 자식 테이블
-----------------------------------
주민번호   사원번호   관계    성명    
++++++++   ========
  (P.K)      (F.K)
-----------------------------------
9XXXXXX     7369      아내   아이유 
0XXXXXX     7369      아들   강동원  
9XXXXXX     7370      아내   이연희  
9XXXXXX     7371      남편   박형식
                :
                        
*/ 


























