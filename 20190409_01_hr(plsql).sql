SELECT USER
FROM DUAL;
--==>> HR

--�� %TYPE

-- 1. Ư�� ���̺� ���ԵǾ� �ִ� �÷��� �ڷ����� �����ϴ� ������Ÿ��

-- 2. ���� �� ����
-- ������ ���̺��.�÷���%TYPE [ := �ʱⰪ ];

DESC EMPLOYEES;
SET SERVEROUTPUT ON;


--�� HR.EMPLOYEES ���̺��� Ư�� �����͸� ������ ����
DECLARE
    -- VNAME    VARCHAR2(20);
    VNAME   EMPLOYEES.FIRST_NAME%TYPE;  -- VARCHAR2(20)
BEGIN
    SELECT FIRST_NAME INTO VNAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=103;
    
    DBMS_OUTPUT.PUT_LINE(VNAME);
END;
--==>> Alexander


--�� %ROWTYPE

-- 1. ���̺��� ���ڵ�� ���� ������ ����ü ������ ����(���� ���� �÷�)

-- 2. ���� �� ����
-- ������ ���̺��%ROWTYPE

--�� HR.EMPLOYEES ���̺��� �����͸� ������ ������ ����
DECLARE
    --VNAME   VARCHAR2(20);
    --VPHONE  VARCHAR2(20);
    --VEMAIL  VARCHAR2(25);
    
    --VNAME   EMPLOYEES.FIRST_NAME%TYPE;
    --VPHONE  EMPLOYEES.PHONE_NUMBER%TYPE;
    --VEMAIL  EMPLOYEES.EMAIL%TYPE
    
    VEMP    EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
        INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=103;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME||' - '||VEMP.PHONE_NUMBER||' - '||VEMP.EMAIL);
END;
--==>> Alexander - 590.423.4567 - AHUNOLD


--�� HR.EMPLOYEES ���̺��� ������ ������ �������� ������ ����
DECLARE
    VEMP EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
        INTO VEMP.FIRST_NAME, VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME||' - '||VEMP.PHONE_NUMBER||' - '||VEMP.EMAIL);
END;
--==>> ���� �߻�
/*
ORA-01422: exact fetch returns more than requested number of rows
*/
--> ���� ���� ��(ROWS) ������ ���� �������� �ϸ�
--  ������ �����ϴ� �� ��ü�� �Ұ����� ��Ȳ

-- �Ұ���!!
























