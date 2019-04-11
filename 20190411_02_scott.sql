--�� �ǽ� ���̺� ����(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.

--�� ������ ���̺� �������� �߰�
--   ID �÷��� PK �������� ����
ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==> Table TBL_TEST1��(��) ����Ǿ����ϴ�.

--�� �ǽ� ���̺� ����(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_EVENTLOG;
--==>> ��ȸ ��� ����


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� TBL_TEST1 ���̺� ������ �Է�
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(1, '������', '010-1111-1111');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(2, '������', '010-2222-2222');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� TBL_TEST1 ���̺��� ������ ����
UPDATE TBL_TEST1
SET NAME = '������'
WHERE ID = 1;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--�� TBL_TEST1 ���̺��� ������ ����
DELETE
FROM TBL_TEST1
WHERE ID=2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_TEST1
WHERE ID=1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT �������� ����Ǿ����ϴ�.	2019-04-11 12:18:57
INSERT �������� ����Ǿ����ϴ�.	2019-04-11 12:19:22
UPDATE �������� ����Ǿ����ϴ�.	2019-04-11 12:20:17
DELETE �������� ����Ǿ����ϴ�.	2019-04-11 12:21:01
DELETE �������� ����Ǿ����ϴ�.	2019-04-11 12:21:42
*/


--�� �׽�Ʈ
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(3, '�̱��', '010-3333-3333');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(4, '���Ѿ�', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '������'
WHERE ID = 3;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.  


-- ����Ŭ ������ �ð��� 21�� ��� ����

-- �ð��� ����� ���¿��� ������ �Է�
INSERT INTO TBL_TEST1(ID, NAME, TEL) VALUES(5, '�̽���', '010-5555-5555');
--==>> ���� �߻�
/*
ORA-20003: �۾��� 08:00 ~ 18:00 ���� �����մϴ�.
*/

SELECT *
FROM TBL_TEST1;
--==>> 3	������	010-3333-3333

-- �ð��� ����� ���¿��� ������ ����
UPDATE TBL_TEST1
SET NAME = '��ȫ��'
WHERE ID = 3;
--==>> �����߻�
/*
ORA-20003: �۾��� 08:00 ~ 18:00 ���� �����մϴ�.
*/

-- �ð��� ����� ���¿��� ������ ����
DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> �����߻�
/*
ORA-20003: �۾��� 08:00 ~ 18:00 ���� �����մϴ�.
*/

SELECT *
FROM TBL_TEST1;
--==>> 3	������	010-3333-3333


--�� �ǽ� ���̺� ����(TBL_TEST2) �� �θ� ���̺�
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.

--�� �ǽ� ���̺� ����(TBL_TEST3) �� �ڽ� ���̺�
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
                REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.


--�� �ǽ� ������ �Է�
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '��Ź��');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '������');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 3

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�����
2	��Ź��
3	������
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �ǽ� ������ �Է�
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 1, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 2, 50);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 1, 60);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 2, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 1, 50);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 9

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
1	1	�����	20
2	2	��Ź��	30
3	1	�����	40
4	2	��Ź��	50
5	1	�����	60
6	1	�����	20
7	1	�����	30
8	2	��Ź��	40
9	1	�����	50
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�����
2	��Ź��
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST2;
--==>> 1	�����

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
--==>> Ŀ�� �Ϸ�.


-- ������ ����
TRUNCATE TABLE TBL_�԰�;
--==>> Table TBL_�����(��) �߷Ƚ��ϴ�.
TRUNCATE TABLE TBL_���;
--==>> Table TBL_�����(��) �߷Ƚ��ϴ�.
UPDATE TBL_��ǰ
SET ������ = 0;
--==>> 21�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.


INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�) 
VALUES(1, 'H001', SYSDATE, 100, 1000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


SELECT *
FROM TBL_��ǰ;
SELECT *
FROM TBL_�԰�;
--==>> 1	H001	19/04/11	100	1000

COMMIT;
--==>> Ŀ�� �Ϸ�.


INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�) 
VALUES(2, 'H002', SYSDATE, 100, 1000);


UPDATE TBL_�԰�
SET �԰���� = 50
WHERE ��ǰ�ڵ� = 'H002';


DELETE 
FROM TBL_�԰�
WHERE ��ǰ�ڵ� = 'H002';


INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(1, 'H001', SYSDATE, 50, 1000);

SELECT *
FROM TBL_���;

UPDATE TBL_���
SET ������ = 20
WHERE ����ȣ = 1;

DELETE 
FROM TBL_���
WHERE ����ȣ = 1;


--�� TRIGGER �� ���� ��ȸ
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
--==>> ����

SELECT INSA_PACK.FN_GENDER('751212-4234567')
FROM DUAL;
--==>> ����

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN)
FROM TBL_INSA;
--==>>
/*
ȫ�浿	771212-1022432	����
�̼���	801007-1544236	����
�̼���	770922-2312547	����
            :
            :
��ž�	810809-2111111	����
�輱��	901212-2234567	����
�ѽ¿�	910101-1234567	����
*/
