SELECT USER
FROM DUAL;
--==>> SCOTT

--���� HAVING ����--

--�� EMP ���̺��� �μ���ȣ�� 20, 30�� �μ��� �������
--   �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> ���� �߻�
/*
ORA-00934: group function is not allowed here
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
17��, 7������ ���� �߻�
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
HAVING DEPTNO IN (20, 30)           -- �Ϲ� ���ǹ��� WHERE�� ����� ���� ����
   AND SUM(SAL) < 10000;
--==>> 30	9400


----------------------------------------------------------------------------------------------------------------

--���� ��ø �׷��Լ� / �м��Լ� ����--

-- �׷� �Լ� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�.
-- �̸����� MSSQL �� �Ұ����ϴ�.
SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875

-- RANK()
-- DENSE_RANK()
--> ORACLE 9i ���� ���� MSSQL 2005 ���� ����

-- ���� ���������� RANK() �� DENSE_RANK() �� ����� �� ���� ������
-- �̸� ��ü�Ͽ� ������ ������ �� �ִ� ����� �����ؾ� �Ѵ�.

-- ���� ���, �޿��� ������ ���ϰ��� �Ѵٸ�
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- Ȯ���� ���ڿ� +1 �� �߰� �������ָ� �װ��� �� ����� �ȴ�.

SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
--==>> 14 �� SMITH �� �޿� ���

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;
--==>> 7 �� ALLEN �� �޿� ���


--�� ���� ��� ���� (��� ���� ����)
--   ���� ������ �ִ� ���̺��� �÷���
--   ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���
--   �츮�� �� �������� ���� ��� ���� ��� �θ���.

SELECT ENAME"�����", SAL"�޿�", 1"�޿����"
FROM EMP;

SELECT ENAME"�����", SAL"�޿�"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E1.SAL)"�޿����"
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


SELECT ENAME"�����", SAL"�޿�"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E1.SAL)"�޿����"
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


--�� EMP ���̺��� ������� 
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--   ��, RANK() �Լ��� ������� �ʰ�, ��� ���� ������ Ȱ���� �� �ֵ��� �Ѵ�.



SELECT ENAME"�����", SAL"�޿�"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE DEPTNO = E1.DEPTNO AND SAL > E1.SAL)"�μ����޿����"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E1.SAL)"��ü�޿����"
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
--==>> Session��(��) ����Ǿ����ϴ�.

--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
----------------------------------------------------------------------------
  �����   �μ���ȣ    �Ի���       �޿�      �μ����Ի纰�޿�����
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

SELECT ENAME"�����", DEPTNO"�μ���ȣ", HIREDATE"�Ի���", SAL"�޿�"
     , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E1.DEPTNO AND HIREDATE <= E1.HIREDATE)"�μ����Ի纰�޿�����"
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


--�� TBL_EMP�� ������� �Ի��� ������� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ִ� �������� �����Ѵ�.
/*
-------------------------------------
    �Ի���        �ο���
-------------------------------------
    2019-04           5 
-------------------------------------
*/
SELECT *
FROM(
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���", COUNT(*)"�ο���"
    FROM TBL_EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
)T
WHERE T.�ο��� = (SELECT MAX(COUNT(*))
                  FROM TBL_EMP
                  GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
--==>>
/*
�Ի���  �ο���
------- ----------
2019-04     5
*/


SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���", COUNT(*)"�ο���"
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

--���� ROW_NUMBER() ����--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
     , ENAME"�����", SAL"�޿�", HIREDATE"�Ի���"
FROM EMP
ORDER BY ENAME;


--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴� ���� ���鿡���� �̰��� �ٶ������� ���� ��Ȳ�� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����غ� �� �ִ�.
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY �� ���������
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� ����.

CREATE TABLE TBL_AAA
( NO        NUMBER
, NAME      VARCHAR2(30)
, GRADE     CHAR(10)
);
--==>> Table TBL_AAA��(��) �����Ǿ����ϴ�.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '������', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '�̱��', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '������', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '��ȫ��', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '��ȫ��', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '�̱��', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '�̱��', 'A');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 7

COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_AAA;
--==>>
/*
1	������	A         
2	�̱��	B         
3	������	A         
4	��ȫ��	C         
5	��ȫ��	A         
6	�̱��	A         
7	�̱��	A         
*/

UPDATE TBL_AAA
SET GRADE = 'C'
WHERE NO=6;


SELECT *
FROM TBL_AAA
WHERE NO=6;
--==>> 6	�̱��	A         


--�� SEQUENCE (������ : �ֹ���ȣ) ����
--   �� �������� �ǹ� : 1.(�Ϸ���) �������� ��ǵ�  2.(���, �ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD   -- ������ ���� �⺻ ����(MSSQL �� IDENTITY �� ������ ����)
START WITH 1                -- ���۰�
INCREMENT BY 1              -- ������
NOMAXVALUE                  -- �ִ밪 ���� ����
NOCACHE;                    -- ĳ�� ��� ����(����)
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� ���̺� ����(TBL_BOARD)
CREATE TABLE TBL_BOARD              -- TBL_BOARD �̸��� ���̺� ���� �� �Խ���
( NO        NUMBER                  -- �Խù� ��ȣ       ��
, TITLE     VARCHAR2(50)            -- �Խù� ����       ��
, CONTENTS  VARCHAR2(2000)          -- �Խù� ����       ��
, NAME      VARCHAR2(20)            -- �Խù� �ۼ���     ��
, PW        VARCHAR2(20)            -- �Խù� �н�����   ��
, CREATED   DATE DEFAULT SYSDATE    -- �Խù� �ۼ���     ��
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� ������ �Է� �� �Խ��ǿ� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '�ѽ�~1��', '���� 1��������', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '�ǰ�����', '�ٵ� �ǰ� ì��ô�', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '������', '���� ������...', '�ֺ���', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '������', '�̼����� ����?', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '�������������', '�ڿ��� �� �Ⱥ�����', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '�����ֽ��ϴ�', '������ �Ѹ� �ȵǳ���', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES(SEQ_BOARD.NEXTVAL, '�����ֽ��ϴ�', '�������� �ٽ� �����Ҳ���', '�ѽ¿�', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES (SEQ_BOARD.NEXTVAL, '������', '�� �׳� �߷���', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_BOARD;

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES (SEQ_BOARD.NEXTVAL, '���¿�', '�� ������ �ֽ��ϴ�.', '�̿���', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1��	    ���� 1��������	            ������	JAVA006$	2019-04-02
3	������	        ���� ������...	            �ֺ���	JAVA006$	2019-04-02
5	�������������	�ڿ��� �� �Ⱥ�����	        ������	JAVA006$	2019-04-02
6	�����ֽ��ϴ�	������ �Ѹ� �ȵǳ���	    ������	JAVA006$	2019-04-02
7	�����ֽ��ϴ�	�������� �ٽ� �����Ҳ���	�ѽ¿�	JAVA006$	2019-04-02
9	���¿�	        �� ������ �ֽ��ϴ�.	        �̿���	JAVA006$	2019-04-02
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	���¿�	        �̿���	2019-04-02
5	�����ֽ��ϴ�	�ѽ¿�	2019-04-02
4	�����ֽ��ϴ�	������	2019-04-02
3	�������������	������	2019-04-02
2	������	        �ֺ���	2019-04-02
1	�ѽ�~1��	    ������	2019-04-02
*/

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES (SEQ_BOARD.NEXTVAL, '����', '�� ���� �ȵ���', '�輱��', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=7;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	����	        �輱��	2019-04-02
5	���¿�	        �̿���	2019-04-02
4	�����ֽ��ϴ�	������	2019-04-02
3	�������������	������	2019-04-02
2	������	        �ֺ���	2019-04-02
1	�ѽ�~1��	    ������	2019-04-02
*/


------------------------------------------------------------------------------------------------------

--���� JOIN(����) ����--        �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�

-- 1. SQL 1992 CODE
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(Catersian Product)
--  �� ���̺��� ��ģ(������) ��� ����� ��

-- Equi join : ���� ��Ȯ�� ��ġ�ϴ� �����͵鳢�� �����Ű�� ����
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


-- Non Equi join : ���� �ȿ� ������ �����͵鳢�� �����Ű�� ����
SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- Equi Join �� ��(+)�� �� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5)�� ��� ����!!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);       
--> �� 19 ���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� ����鵵 ��� ��ȸ�� ��Ȳ

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO; 
--> �� 16 ���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ��� �Ҽӵ� ����� �ƹ��� ���� �μ��� ��� ��ȸ�� ��Ȳ

--�� (+)�� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��
--   (+)�� �ִ� �� ���̺��� �����͸� �ϳ��� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN �� �̷������.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--> ���� ���� ������ �̷��� ������ JOIN ������ �������� �ʴ´�.


-- 2. SQL 1999 CODE �� ��JOIN�� Ű���� ���� �� JOIN ���� ���
--                     ���� ������ ��WHERE�� ��� ��ON�� ���

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

--�� INNER JOIN �� INNER �� ���� ����
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

--�� ������ ������ �� ���̺�(�� LEFT) �� �����͸� ��� �޸𸮿� ������ ��
--   ������ �������� ���� �� ���̺���� �����͸� ���� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN �� �̷������.

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

--�� OUTER JOIN ���� OUTER �� ���� ����

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
-- �� ������� ������ CLERK �� ����鸸 ��ȸ

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- �̷��� �������� �����ص� ��ȸ�ϴ� ���� ������ ����.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- ������, �̿� ���� �����Ͽ� ��ȸ�� �� �ֵ��� �����Ѵ�.
-------------------------------------------------------------------------------------------------------

--�� EMP ���̺�� DEPT ���̺���
--   ������ MANAGER �� CLERK �� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.

SELECT D.DEPTNO"�μ���ȣ", D.DNAME"�μ���", E.ENAME"�����", E.JOB"������", E.SAL"�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'MANAGER' OR JOB = 'CLERK'
ORDER BY 4;
-- DEPTNO �� EMP, DEPT �� �� �ش������ �θ��ڽ��� �����Ͽ� �ۼ� (�� �� �ټ�)
-->
SELECT DEPTNO           -- �� EMP ���̺��� DEPTNO(�ټ�)
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

SELECT DEPTNO           -- �� DEPT ���̺��� DEPTNO
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
--==>> ���� �߻�
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
649��, 8������ ���� �߻�
*/
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺���
--  �������(����� ���)�Ѵ�.

SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��Ǵ� �÷��� �������� �ʴ� ��ȸ ������
--  ���� �߻����� �ʴ´�.
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
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--  �μ�(DEPT), ���(EMP) �� � ���̺��� �����ص�
--  ������ ���࿡ ���� ��� ��ȯ�� ������ ����.

--�� ������ �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--   �θ� ���̺��� �÷��� ������ �� �ֵ��� �ؾ� �Ѵ�.

SELECT *
FROM DEPT;      -- �θ� ���̺�
SELECT *
FROM EMP;       -- �ڽ� ���̺�

--�� �θ� �ڽ� ���̺� ���踦 ��Ȯ�� ������ �� �ֵ��� �Ѵ�. �ڡڡڡڡڡ�

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��� �÷��� �ƴϴ���
--  �Ҽ� ���̺��� ����� �� �ֵ��� �����Ѵ�.

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


--�� SELF JOIN (�ڱ� ����)

-- EMP ���̺��� ������ ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
E         E       E       E           E         E
EMPNO     ENAME   JOB     MGR, EMPNO  ENAME     JOB
------------------------------------------------------------
�����ȣ  �����  ������  �����ڹ�ȣ  �����ڸ�  ������������
------------------------------------------------------------
7369      SMITH   CLERK   7902        FORD      ANALYST

EMP       EMP     EMP     EMP                                       --> ��
                          EMP         EMP       EMP                 --> ��
------------------------------------------------------------
*/

SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����", E1.JOB"������", E2.EMPNO"�����ڹ�ȣ", E2.ENAME"�����ڸ�", E2.JOB"������������"
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


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.
















