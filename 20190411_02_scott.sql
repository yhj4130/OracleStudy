--○ 실습 테이블 생성(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

--○ 생성된 테이블에 제약조건 추가
--   ID 컬럼에 PK 제약조건 지정
ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==> Table TBL_TEST1이(가) 변경되었습니다.

--○ 실습 테이블 생성(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.

SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회 결과 없음


--○ 날짜 세션 정보 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ TBL_TEST1 테이블에 데이터 입력
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(1, '조수연', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(2, '이지혜', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.

--○ TBL_TEST1 테이블의 데이터 수정
UPDATE TBL_TEST1
SET NAME = '수여니'
WHERE ID = 1;
--==>> 1 행 이(가) 업데이트되었습니다.

--○ TBL_TEST1 테이블의 데이터 삭제
DELETE
FROM TBL_TEST1
WHERE ID=2;
--==>> 1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_TEST1
WHERE ID=1;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT 쿼리문이 수행되었습니다.	2019-04-11 12:18:57
INSERT 쿼리문이 수행되었습니다.	2019-04-11 12:19:22
UPDATE 쿼리문이 수행되었습니다.	2019-04-11 12:20:17
DELETE 쿼리문이 수행되었습니다.	2019-04-11 12:21:01
DELETE 쿼리문이 수행되었습니다.	2019-04-11 12:21:42
*/


--○ 테스트
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(3, '이기승', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(4, '곽한얼', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1
SET NAME = '윤희진'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.  


-- 오라클 서버의 시간을 21시 대로 변경

-- 시간이 변경된 상태에서 데이터 입력
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(5, '이승희', '010-5555-5555');
--==>> 에러 발생
/*
ORA-20003: 작업은 08:00 ~ 18:00 까지 가능합니다.
*/

SELECT *
FROM TBL_TEST1;
--==>> 3	윤희진	010-3333-3333

-- 시간이 변경된 상태에서 데이터 수정
UPDATE TBL_TEST1
SET NAME = '권홍비'
WHERE ID = 3;
--==>> 에러발생
/*
ORA-20003: 작업은 08:00 ~ 18:00 까지 가능합니다.
*/

-- 시간이 변경된 상태에서 데이터 삭제
DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 에러발생
/*
ORA-20003: 작업은 08:00 ~ 18:00 까지 가능합니다.
*/

SELECT *
FROM TBL_TEST1;
--==>> 3	윤희진	010-3333-3333


--○ 실습 테이블 생성(TBL_TEST2) → 부모 테이블
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.

--○ 실습 테이블 생성(TBL_TEST3) → 자식 테이블
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
                REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.


--○ 실습 데이터 입력
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '건조기');
--==>> 1 행 이(가) 삽입되었습니다. * 3

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	냉장고
2	세탁기
3	건조기
*/

COMMIT;
--==>> 커밋 완료.


--○ 실습 데이터 입력
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 1, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 2, 50);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 1, 60);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 2, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 1, 50);
--==>> 1 행 이(가) 삽입되었습니다. * 9

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	20
2	2	30
3	1	40
4	2	50
5	1	60
6	1	20
7	1	30
8	2	40
9	1	50
*/

SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST2 P JOIN TBL_TEST3 C
ON P.CODE = C.CODE;
--==>>
/*
1	1	냉장고	20
2	2	세탁기	30
3	1	냉장고	40
4	2	세탁기	50
5	1	냉장고	60
6	1	냉장고	20
7	1	냉장고	30
8	2	세탁기	40
9	1	냉장고	50
*/

COMMIT;
--==>> 커밋 완료.

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	냉장고
2	세탁기
*/

COMMIT;
--==>> 커밋 완료.

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;
--==>> 1	냉장고

SELECT *
FROM TBL_TEST3;
--==>> 
/*
1	1	20
3	1	40
5	1	60
6	1	20
7	1	30
9	1	50
*/

COMMIT;
--==>> 커밋 완료.


-- 데이터 날림
TRUNCATE TABLE TBL_입고;
--==>> Table TBL_출고이(가) 잘렸습니다.
TRUNCATE TABLE TBL_출고;
--==>> Table TBL_출고이(가) 잘렸습니다.
UPDATE TBL_상품
SET 재고수량 = 0;
--==>> 21개 행 이(가) 업데이트되었습니다.

COMMIT;
--==>> 커밋 완료.


INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가) 
VALUES(1, 'H001', SYSDATE, 100, 1000);
--==>> 1 행 이(가) 삽입되었습니다.


SELECT *
FROM TBL_상품;
SELECT *
FROM TBL_입고;
--==>> 1	H001	19/04/11	100	1000

COMMIT;
--==>> 커밋 완료.


INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가) 
VALUES(2, 'H002', SYSDATE, 100, 1000);


UPDATE TBL_입고
SET 입고수량 = 50
WHERE 상품코드 = 'H002';


DELETE 
FROM TBL_입고
WHERE 상품코드 = 'H002';


INSERT INTO TBL_출고(출고번호, 상품코드, 출고일자, 출고수량, 출고단가)
VALUES(1, 'H001', SYSDATE, 50, 1000);

SELECT *
FROM TBL_출고;

UPDATE TBL_출고
SET 출고수량 = 20
WHERE 출고번호 = 1;

DELETE 
FROM TBL_출고
WHERE 출고번호 = 1;


--※ TRIGGER 의 정보 조회
SELECT *
FROM USER_TRIGGERS;
--==>>
/*
"TRG_TEST2_DELETE
    BEFORE 
    DELETE ON TBL_TEST2
    FOR EACH ROW
"
"BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;
END;"
*/


SELECT INSA_PACK.FN_GENDER('751212-1234567')
FROM DUAL;
--==>> 남자

SELECT INSA_PACK.FN_GENDER('751212-4234567')
FROM DUAL;
--==>> 여자

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN)
FROM TBL_INSA;
--==>>
/*
홍길동	771212-1022432	남자
이순신	801007-1544236	남자
이순애	770922-2312547	여자
            :
            :
김신애	810809-2111111	여자
김선아	901212-2234567	여자
한승원	910101-1234567	남자
*/
