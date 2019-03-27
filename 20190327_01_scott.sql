--�� ���ӵ� ����� ��ȸ
SELECT USER
FROM DUAL;
--==>> SCOTT

--�� EMP ���̺��� ������ CLERK �� ����� ��
--   20�� �μ����� �ٹ��ϴ� �������
--   �����ȣ, �����, ������, �޿�, �μ���ȣ �׺��� ��ȸ�Ѵ�.
SELECT EMPNO"�����ȣ", ENAME "�����", JOB "������", SAL "�޿�", DEPTNO "�μ���ȣ"
FROM EMP
WHERE JOB='CLERK' AND DEPTNO=20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/


--�� EMP ���̺��� 10�� �μ��� �ٹ��ϴ� ������ ��
--   �޿��� 2500 �̻��� �������
--   �����, ������, �޿�, �μ���ȣ �׺��� ��ȸ�Ѵ�,
SELECT ENAME "�����", JOB "������", SAL "�޿�", DEPTNO "�μ���ȣ"
FROM EMP
WHERE DEPTNO=10 AND SAL >= 2500;
--==>> KING	PRESIDENT	5000	10


--�� ���̺� ����
--> ���������� ��� ���̺� �ȿ� �ִ� ������ ���븸 �����ϴ� ����

--�� EMP ���̺��� ������ Ȯ���Ͽ�
--   �̿� �Ȱ��� �����Ͱ� ����ִ� EMPCOPY ���̺��� �����Ѵ�.(������)
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
--==>> Table EMP2��(��) �����Ǿ����ϴ�.

--�� ������ ���̺� Ȯ��
SELECT *
FROM EMP2;


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ���̺� ����
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

CREATE TABLE TBL_DEPT
AS 
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT��(��) �����Ǿ����ϴ�.


--�� ������ ���̺� Ȯ��
SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;


--�� ���̺��� Ŀ��Ʈ ���� Ȯ��
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


--�� ���̺��� Ŀ��Ʈ ���� �Է�
COMMENT ON TABLE TBL_EMP IS '�������';
--==>> Comment��(��) �����Ǿ����ϴ�.

--�� Ŀ��Ʈ ���� �Է� ���� �ٽ� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE   �������
EMP2	        TABLE	
EMPCOPY	        TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--�� ���̺� ������ Ŀ��Ʈ ���� �Է� (TBL_DEPT �� �μ�����)
COMMENT ON TABLE TBL_DEPT IS '�μ�����';
--==>> Comment��(��) �����Ǿ����ϴ�.

--�� Ŀ��Ʈ ���� �Է� �� �ٽ� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	�μ�����
TBL_EMP	        TABLE	�������
EMP2	        TABLE	
EMPCOPY	        TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--�� ������ ����
PURGE RECYCLEBIN;
--==>> RECYCLEBIN��(��) ��������ϴ�.


--�� �÷� ������ Ŀ��Ʈ ���� Ȯ��
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


--�� ���̺� �Ҽӵ�(���Ե�) �÷� ������ Ŀ��Ʈ ���� �Է�(����)
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '�μ���ȣ';
--==>> Comment��(��) �����Ǿ����ϴ�.
COMMENT ON COLUMN TBL_DEPT.DNAME IS '�μ���';
--==>> Comment��(��) �����Ǿ����ϴ�.
COMMENT ON COLUMN TBL_DEPT.LOC IS '�μ���ġ';
--==>> Comment��(��) �����Ǿ����ϴ�.


--�� Ŀ��Ʈ ������ �Էµ� ���̺��� �÷� ������ ���� Ȯ�� 
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	�μ���ȣ
TBL_DEPT	DNAME	�μ���
TBL_DEPT	LOC	    �μ���ġ
*/


DESC EMP;
--==>>
/*
EMPNO    NOT NULL NUMBER(4)    -- �����ȣ
ENAME             VARCHAR2(10) -- �����
JOB               VARCHAR2(9)  -- ������
MGR               NUMBER(4)    -- �����ڻ����ȣ
HIREDATE          DATE         -- �Ի���
SAL               NUMBER(7,2)  -- �޿�
COMM              NUMBER(7,2)  -- ����
DEPTNO            NUMBER(2)    -- �μ���ȣ
*/


--�� TBL_EMP ���̺� �Ҽӵ�(���Ե�)
--   �÷��� ���� Ŀ��Ʈ ������ �Է�(����)�Ѵ�.
COMMENT ON COLUMN TBL_EMP.EMPNO IS '�����ȣ';
COMMENT ON COLUMN TBL_EMP.ENAME IS '�����';
COMMENT ON COLUMN TBL_EMP.JOB IS '������';
COMMENT ON COLUMN TBL_EMP.MGR IS '�����ڻ����ȣ';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '�Ի���';
COMMENT ON COLUMN TBL_EMP.SAL IS '�޿�';
COMMENT ON COLUMN TBL_EMP.COMM IS '����';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '�μ���ȣ';
--==>> Comment��(��) �����Ǿ����ϴ�. * 8


--�� Ŀ��Ʈ ������ �Էµ� ���̺��� �÷� ������ ���� Ȯ�� 
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    �����ȣ
TBL_EMP	ENAME	    �����
TBL_EMP	JOB	        ������
TBL_EMP	MGR	        �����ڻ����ȣ
TBL_EMP	HIREDATE	�Ի���
TBL_EMP	SAL	        �޿�
TBL_EMP	COMM	    ����
TBL_EMP	DEPTNO	    �μ���ȣ
*/


--���� �÷��� ������ �߰� �� ���� ����--
SELECT *
FROM TBL_EMP;

--�� TBL_EMP ���̺� �ֹε�Ϲ�ȣ ������ ���� �� �ִ� �÷� �߰�
ALTER TABLE TBL_EMP
ADD SSN CHAR(13);
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.
-- �� �տ� 0�� ���� ���ɼ��� �ִ� ���ڰ� ���յ� �����Ͷ��
-- �������� �ƴ� ���������� ������Ÿ���� ó���ؾ� �Ѵ�.

SELECT 0012121234567
FROM DUAL;
--==>> 12121234567

SELECT '0012121234567'
FROM DUAL;
--==>> 0012121234567


--�� Ȯ��
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

14�� ���� ���õǾ����ϴ�. 
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
      
14�� ���� ���õǾ����ϴ�. 
*/
--> ���̺� ������ �÷��� ������ ���������� �ǹ� ����


--�� TBL_EMP ���̺��� �߰��� SSN(�ֹε�Ϲ�ȣ) �÷� ����
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.


--�� Ȯ��
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
      
14�� ���� ���õǾ����ϴ�. 
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

--> SSN(�ֹε�Ϲ�ȣ) �÷��� ���������� ���ŵǾ����� Ȯ��


DELETE
FROM TBL_EMP
WHERE ENAME='SMITH';
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
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

13�� ���� ���õǾ����ϴ�. 
*/


DELETE TBL_EMP;     -- �������� ����

DELETE
FROM TBL_EMP;       -- ����

--==>> 13�� �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EMP;
--> ���̺��� ������ �״�� �����ִ� ���¿���
--  ������ ��� �ҽ�(����)�� ��Ȳ���� Ȯ��


DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EMP;
--==>>
/*
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
498��, 6������ ���� �߻�
*/


--�� ���̺� �ٽ� ����(����)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


-------------------------------------------------------------------------------------------------------

--�� NULL �� ó��

SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2	12	8	20	5

SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2, 10+NULL, 10-NULL, 10*NULL, 10/NULL
FROM DUAL;
--==>> (NULL) (NULL) (NULL) (NULL) (NULL) (NULL) (NULL) (NULL)(NULL) (NULL)

--�� ���� ���
--   NULL �� ������ ���� �ǹ��ϸ� ���� �������� �ʴ� ���̱� ������
--   �� NULL �� ���꿡 ���Ե� ��� �� ����� ������ NULL �̴�.


--�� TBL_EMP ���̺��� Ŀ�̼�(COMM, ����)�� NULL �� ������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE COMM = NULL;
--==>> ��ȸ ��� ����

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE COMM = (null);
--==>> ��ȸ ��� ����

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> ���� �߻�
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

DESC TBL_EMP;
--> COMM Į���� ������ ������ Ÿ���� ���ϰ� ������ Ȯ��

--�� NULL �� ���� �������� �ʴ� ���̱� ������ �Ϲ����� �����ڸ� Ȱ���Ͽ� ���� �� ����.
--   ��, ������� �� ������ ������ �� ���ٴ� �ǹ��̴�.
--   NULL �� ������� ����� �� ���� �����ڵ�
--   >=, <=, >, <, !=, ^=, <>


SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
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


--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ����� �ʴ� ��������
--   �����, ������, �μ���ȣ �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
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

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO ^= 20;

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO = 10 OR DEPTNO = 30;

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO IN(10, 30);


--�� TBL_EMP ���̺��� Ŀ�̼��� NULL �� �ƴ� ��������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE COMM IS NOT NULL;
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/
SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE NOT COMM IS NULL;


--�� TBL_EMP ���̺��� ��� �������
--   �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸��� ��ȸ�Ѵ�.
--   ��, �޿�(SAL)�� �ſ� �����Ѵ�,
--   ����, ����(COMM)�� �ų� �����Ѵ�.
ALTER TABLE TBL_EMP
ADD ALLS NUMBER(4);

COMMENT ON COLUMN TBL_EMP.ALLS IS '����';

ALTER TABLE TBL_EMP DROP COLUMN ALLS;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", SAL*12 + COMM "����"
FROM TBL_EMP;

SELECT 1600*12+300
FROM DUAL;
--==>> 19500


-- NVL()
SELECT NULL"��", NVL(NULL, 10)"��", NVL(10, 20)"��"
FROM DUAL;
--==>> (null)   10  10
--> ù ��° �Ķ���� ���� NULL �̸�, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
--  ù ��° �Ķ���� ���� NULL �� �ƴϸ�, �� ���� �״�� ��ȯ�Ѵ�.

-- ����
SELECT *
FROM TBL_EMP
WHERE EMPNO=7369;
--==>> 7369	SMITH	CLERK	7902	80/12/17	800	  (null)	20	

SELECT ENAME, COMM
FROM TBL_EMP
WHERE EMPNO=7369;
--==>> SMITH    (null)

SELECT ENAME, NVL(COMM, 0)"Ȯ�ο���"
FROM TBL_EMP
WHERE EMPNO=7369;
--==>> SMITH	0


SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", NVL(COMM, 0) "Ŀ�̼�", SAL*12 + NVL(COMM, 0) "����"
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






















