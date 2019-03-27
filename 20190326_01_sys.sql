
--1�� �ּ��� ó��(������ �ּ��� ó��)

/*
������
(���� ��)
�ּ���
ó��
*/

--�� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ
show user;
--==>> USER��(��) "SYS"�Դϴ�.
--> sqlplus ������ �� ����ϴ� ��ɾ�


SELECT USER
FROM DUAL;
--==>> 

SELECT 1+2
FROM DUAL;
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

SELECT '�ֿ밭��F������'
FROM DUAL;
--==>> �ֿ밭��F������


SELECT '������ ������ ����Ŭ ����';
--==>>
/*
ORA-00923: FROM keyword not found where expected
00923. 00000 -  "FROM keyword not found where expected"
*Cause:    
*Action:
34��, 23������ ���� �߻�
*/

SELECT '������ ������ ����Ŭ ����'
FROM DUAL;
--==>> ������ ������ ����Ŭ ����

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

SELECT "�׽�Ʈ"
FROM DUAL;
--==>>
/*
ORA-00904: "�׽�Ʈ": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
68��, 8������ ���� �߻�
*/

SELECT '������' + '������'
FROM DUAL;
--==>> 
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

 
 --�� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ���� ��ȸ
 
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
 
 --> ��DBA_���� �����ϴ� Oracle Data Dictionary View ��
 --  ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
 --  ������ ������ ��ųʸ� ������ ���� ���ص� �������.
 
 --�� ��HR�� ����� ������ ��� ���·� ����
 ALTER USER HR ACCOUNT LOCK;
 --==>> User HR��(��) ����Ǿ����ϴ�.
 
--�� �ٽ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
    :
HR	LOCKED
    :
*/

--�� ��HR�� ����� ���� ��� ��ü
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�
 
--�� �ٽ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS; 
--==>>
/*
    :
HR	OPEN
    :
*/
 
---------------------------------------------------------------------------

--�� TABLESPACE ����

--�� TABLESPACE ��?
--   ���׸�Ʈ(���̺�, �ε���, ...)�� ��Ƶδ�(�����صδ�)
--   ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

CREATE TABLESPACE TBS_EDUA                      -- CREATE ���� ��ü�� �� ���� 
DATAFILE 'C:\TESTORADATA\TBS_EDUA01.DBF'        -- ���������� ����Ǵ� ������ ����
SIZE 4M                                         -- ������ ������ ������ �뷮
EXTENT MANAGEMENT LOCAL                         -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;                  -- ���׸�Ʈ ���� ������ �絿���� ����Ŭ ������
--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.

--�� ���̺����̽� ���� ������ �����ϱ� ����
--   �������� ��ο� ���͸�(TESTORADATA) ������ ��.

--�� ������ ���̺� �����̽�(TBS_EDUA) ��ȸ
SELECT *
FROM DBA_TABLESPACES;
/*
    :
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
    :
*/


--�� �������� ���� �̸� ��ȸ
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
    :
C:\TESTORADATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
    :
*/


--�� ����Ŭ ����� ���� ����
CREATE USER yhj IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--> yhj ��� ����� ������ ����ڴ�. (�����ϰڴ�.)
--  �� ������ ���� �����ϴ� ����Ŭ ��ü��(��ũ��Ʈ����)
--  �⺻������ TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ��� �����ϰڴ�.
--==>> User YHJ��(��) �����Ǿ����ϴ�.


--�� ������ ����Ŭ ����� ����(yhj)�� ����
--   ������ �õ��� �������� ���� �Ұ�.
--   �� ��create session�� ������ ���� ����
 

--�� ������ ����Ŭ ����� ����(yhj)��
--   ���� ������ ������ �� �ֵ��� create session ���� �ο� �� sys ��
GRANT CREATE SESSION TO YHJ;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(YHJ)��
--   DEFAULT TABLESPACE ��ȸ
SELECT USERNAME, DEFAULT_TABLESPACE
FROM DBA_USERS;
--==>>
/*
        :
HR	                USERS
YHJ	                TBS_EDUA
        :
*/


--�� ������ ����Ŭ ����� ����(YHJ)��
--   �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
    :
YHJ	CREATE SESSION	NO
    :
*/


--�� ������ ����Ŭ ����� ����(YHJ)��
--   ���̺� ������ ������ �� �ֵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO YHJ;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(YHJ)��
--   ���̺����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮)
--   �� ũ�⸦ ���������� ����.
ALTER USER YHJ
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User YHJ��(��) ����Ǿ����ϴ�.







 