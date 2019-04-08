SELECT USER
FROM DUAL;
--==>> SCOTT

--���� UPDATE ����--

-- 1. ���̺��� ���� �����͸� �����ϴ� ����

-- 2. ���� �� ����
-- UPDATE ���̺��
-- SET �÷��� = ������ ��[, �÷��� = ������ ��, �÷��� = ������ ��[
-- [WHERE ������]

SELECT *
FROM TBL_SAWON;

--�� TBL_SAWON ���̺��� �����ȣ 1003�� �����
--   �ֹι�ȣ�� ��8710012234567��

UPDATE TBL_SAWON
SET JUBUN = '8710012234567'
WHERE SANO = 1003;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;

-- ���� �� COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_SAWON ���̺��� 1005�� ����� �Ի��ϰ� �޿���
--   ���� 2018-02-22, 1200 ���� �����Ѵ�.
UPDATE TBL_SAWON
SET HIREDATE = TO_DATE('2018-02-22', 'YYYY-MM-DD'), SAL = 1200
WHERE SANO = 1005;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;

-- ���� �� COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_INSA ���̺� ����(�����͸�)
CREATE TABLE TBL_INSABACKUP
AS
SELECT *
FROM TBL_INSA;
--==>> Table TBL_INSABACKUP��(��) �����Ǿ����ϴ�.


--�� TBL_INSABACKUP ���̺���
--   ������ ����� ���常 ���� 10% �λ�
UPDATE TBL_INSABACKUP
SET SUDANG = SUDANG*1.1
WHERE JIKWI IN ('����', '����');
--==>> 15�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_INSABACKUP;

-- ���� �� COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_INSABACKUP ���̺��� ��ȭ��ȣ�� 016, 017, 018, 019 �� �����ϴ�
--   ��ȭ��ȣ�� ��� �̸� ��� 010 ���� �����Ѵ�.
UPDATE TBL_INSABACKUP
SET TEL = '010'||SUBSTR(TEL, 4)
WHERE SUBSTR(TEL, 1, 3) IN ('016', '017', '018', '019');
--==>> 24�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_INSABACKUP;

-- ���� �� COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_SAWON ���̺� ���
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT * 
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.
--> TBL_SAWON ���̺��� �����͸� ����� ����
--  ��, �ٸ� �̸��� ���̺� ���·� ������ �� ��Ȳ


--�� Ȯ��
SELECT *
FROM TBL_SAWONBACKUP;
SELECT *
FROM TBL_SAWON;


-- ���� ���� UPDATE ó�� ���Ŀ� COMMIT �� �����Ͽ��� ������
-- ROLLBACK �� �Ұ����� ��Ȳ�̴�.
-- ������, TBL_SAWONBACKUP ���̺� �����͸� ����� �ξ���.
-- SANAME �÷��� ���븸 �����Ͽ� ��� �־��ټ� �ִٴ� ���̴�.

UPDATE TBL_SAWON
SET SANAME = ( SELECT SANAME
               FROM TBL_SAWONBACKUP
               WHERE SANO = TBL_SAWON.SANO);


-- ���� �� COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� �Ϸ�.

























