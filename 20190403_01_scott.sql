SELECT USER
FROM DUAL;
--==>> SCOTT

--���� UNION / UNION ALL ����--

--�� �ǽ� ���̺� ���� (TBL_JUMUN)
CREATE TABLE TBL_JUMUN              -- �ֹ� ���̺� ����
( JUNO      NUMBER                  -- �ֹ� ��ȣ
, JECODE    VARCHAR2(30)            -- �ֹ��� ��ǰ �ڵ�
, JUSU      NUMBER                  -- �ֹ� ����
, JUDAY     DATE DEFAULT SYSDATE    -- �ֹ� ����
);
--==>> Table TBL_JUMUN��(��) �����Ǿ����ϴ�.
--> ���� �ֹ��� �߻����� ��� �ֹ� ���뿡 ���� �����Ͱ�
--  �Էµ� �� �ִ� ���̺�

--�� ������ �Է� �� ���� �ֹ� �߻� / ����
INSERT INTO TBL_JUMUN VALUES (1, 'Ȩ����', 20, TO_DATE('2001-11-01 09:00:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (2, '������', 10, TO_DATE('2001-11-01 09:23:24', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (3, '����', 30, TO_DATE('2001-11-02 12:00:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (4, '��īĨ', 10, TO_DATE('2001-11-02 15:16:17', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (5, '���Ͻ�', 10, TO_DATE('2001-11-03 10:22:33', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (6, '���Ͻ�', 12, TO_DATE('2001-11-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (7, 'Ȩ����', 50, TO_DATE('2001-11-06 11:11:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (8, '��īĨ', 40, TO_DATE('2001-11-10 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (9, '������', 10, TO_DATE('2001-11-13 09:14:03', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES (10, '�ܲϹ��', 20, TO_DATE('2001-11-13 14:20:00', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 10

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	Ȩ����	    20	2001-11-01 09:00:10
2	��Į��	    10	2001-11-01 09:23:24
3	����	    30	2001-11-02 12:00:11
4	��īĨ	    10	2001-11-02 15:16:17
5	���Ͻ�	    10	2001-11-03 10:22:33
6	���Ͻ�	    12	2001-11-04 16:00:00
7	Ȩ����	    50	2001-11-06 11:11:11
8	��īĨ	    40	2001-11-10 19:00:00
9	��Į��	    10	2001-11-13 09:14:03
10	�ܲϹ��	20	2001-11-13 14:20:00
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ������ �߰� �Է� �� 2001�� ���� ���۵� �ֹ��� ����(2019��)���� ��� �߻�
INSERT INTO TBL_JUMUN VALUES (98765, 'Ȩ����', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98766, '�Ǻ���', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98767, '������Ĩ', 30, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98768, '���Ͻ�', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98769, '���Ͻ�', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98770, '������', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98771, 'Ȩ����', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98772, '���ڼ���', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98773, 'Ȩ����', 30, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_JUMUN VALUES (98774, '����Ĩ', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    Ȩ����	    20	2001-11-01 09:00:10
2	    ��Į��	    10	2001-11-01 09:23:24
3	    ����	    30	2001-11-02 12:00:11
4	    ��īĨ	    10	2001-11-02 15:16:17
5	    ���Ͻ�	    10	2001-11-03 10:22:33
6	    ���Ͻ�	    12	2001-11-04 16:00:00
7	    Ȩ����	    50	2001-11-06 11:11:11
8	    ��īĨ	    40	2001-11-10 19:00:00
9	    ��Į��	    10	2001-11-13 09:14:03
10	    �ܲϹ��	20	2001-11-13 14:20:00
                    :
                    :
98765	Ȩ����	    10	2019-04-03 09:25:09
98766	�Ǻ���	    20	2019-04-03 09:25:47
98767	������Ĩ	30	2019-04-03 09:26:45
98768	���Ͻ�	    10	2019-04-03 09:27:02
98769	���Ͻ�	    20	2019-04-03 09:27:47
98770	������	    20	2019-04-03 09:28:22
98771	Ȩ����	    20	2019-04-03 09:29:14
98772	���ڼ���	10	2019-04-03 09:29:44
98773	Ȩ����	    30	2019-04-03 09:30:29
98774	����Ĩ	    20	2019-04-03 09:31:19
*/

--�� ���� ���θ� ���
--   TBL_JUMUN ���̺��� �ʹ� ���ſ��� ��Ȳ
--   ���ø����̼ǰ��� �������� ���� �ֹ� ������ �ٸ� ���̺�
--   ����� �� �ֵ��� ����� ���� �Ұ����� ��Ȳ
--   ������ ��� �����͸� ������� ����� �͵� �Ұ����� ��Ȳ
--   �� ��������� ������� ������ �ֹ� ������ ��
--      ���� �߻��� �ֹ� ������ �����ϰ� �������� �ٸ� ���̺�(TBL_JUMUNBACKUP)��
--      ������ �̰��� ������ ��ȹ


SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>>
/*
1	Ȩ����	20	2001-11-01 09:00:10
2	��Į��	10	2001-11-01 09:23:24
3	����	30	2001-11-02 12:00:11
4	��īĨ	10	2001-11-02 15:16:17
5	���Ͻ�	10	2001-11-03 10:22:33
6	���Ͻ�	12	2001-11-04 16:00:00
7	Ȩ����	50	2001-11-06 11:11:11
8	��īĨ	40	2001-11-10 19:00:00
9	��Į��	10	2001-11-13 09:14:03
10	�ܲϹ��	20	2001-11-13 14:20:00
*/


--�� ���� ��ȸ ����� TBL_JUMUNBACKUP ���̺� ����
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==> Table TBL_JUMUNBACKUP��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
1	Ȩ����	    20	2001-11-01 09:00:10
2	��Į��	    10	2001-11-01 09:23:24
3	����	    30	2001-11-02 12:00:11
4	��īĨ	    10	2001-11-02 15:16:17
5	���Ͻ�	    10	2001-11-03 10:22:33
6	���Ͻ�	    12	2001-11-04 16:00:00
7	Ȩ����	    50	2001-11-06 11:11:11
8	��īĨ	    40	2001-11-10 19:00:00
9	��Į��	    10	2001-11-13 09:14:03
10	�ܲϹ��	20	2001-11-13 14:20:00
*/
--> TBL_JUMUN ���̺��� �����͵� ��
--  ���� �ֹ����� �̿��� �����ʹ� ��� TBL_JUMUNBACKUPP �� ����� ��ģ ����


--�� TBL_JUMUN ���̺��� �����͵� ��
--   ����� ��ģ �����͵� ���� �� ���� �ֹ��� �ƴ� �����͵� ����
DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> 10�� �� ��(��) �����Ǿ����ϴ�.

-- ���� ��ǰ �߼��� �Ϸ���� ���� ���� �ֹ� �����͸� �����ϰ�
-- ������ ��� �ֹ� �����͵��� ������ ��Ȳ�̹Ƿ�
-- ���̺��� ��(���ڵ�)�� ������ �پ��� ��� �������� ��Ȳ

--�� Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98765	Ȩ����	    10	2019-04-03 09:25:09
98766	�Ǻ���	    20	2019-04-03 09:25:47
98767	������Ĩ	30	2019-04-03 09:26:45
98768	���Ͻ�	    10	2019-04-03 09:27:02
98769	���Ͻ�	    20	2019-04-03 09:27:47
98770	������	    20	2019-04-03 09:28:22
98771	Ȩ����	    20	2019-04-03 09:29:14
98772	���ڼ���	10	2019-04-03 09:29:44
98773	Ȩ����	    30	2019-04-03 09:30:29
98774	����Ĩ	    20	2019-04-03 09:31:19
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �׷���, ���ݱ��� �ֹ����� ������ ���� ������
-- ��ǰ�� �� �ֹ������� ��Ÿ���� �� ��Ȳ�� �߻��ϰ� �Ǿ���.
-- �׷��ٸ� TBL_JUMUNBACKUP ���̺��� ���ڵ�(��)��
-- TBL_JUMUN ���̺��� ���ڵ�(��)�� ���ļ� �ϳ��� ���̺���
-- ��ȸ�ϴ� �Ͱ� ���� ����� Ȯ���� �� �ֵ��� ��ȸ�ؾ� �Ѵ�.

-- �÷��� �÷��� ���踦 ����Ͽ� ���̺��� �����ϰ��� �ϴ� ��� JOIN �� ���������
-- ���ڵ�(��)�� ���ڵ�(��)�� �����ϰ��� �ϴ� ��� UNION / UNION ALL �� ����� �� �ִ�.

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;


SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;
--==>> 
/*
1	    Ȩ����	    20	2001-11-01 09:00:10
2	    ��Į��	    10	2001-11-01 09:23:24
3	    ����	    30	2001-11-02 12:00:11
4	    ��īĨ	    10	2001-11-02 15:16:17
5	    ���Ͻ�	    10	2001-11-03 10:22:33
6	    ���Ͻ�	    12	2001-11-04 16:00:00
7	    Ȩ����	    50	2001-11-06 11:11:11
8	    ��īĨ	    40	2001-11-10 19:00:00
9	    ��Į��	    10	2001-11-13 09:14:03
10	    �ܲϹ��	20	2001-11-13 14:20:00
98765	Ȩ����	    10	2019-04-03 09:25:09
98766	�Ǻ���	    20	2019-04-03 09:25:47
98767	������Ĩ	30	2019-04-03 09:26:45
98768	���Ͻ�	    10	2019-04-03 09:27:02
98769	���Ͻ�	    20	2019-04-03 09:27:47
98770	������	    20	2019-04-03 09:28:22
98771	Ȩ����	    20	2019-04-03 09:29:14
98772	���ڼ���	10	2019-04-03 09:29:44
98773	Ȩ����	    30	2019-04-03 09:30:29
98774	����Ĩ	    20	2019-04-03 09:31:19
*/

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
98765	Ȩ����	    10	2019-04-03 09:25:09
98766	�Ǻ���	    20	2019-04-03 09:25:47
98767	������Ĩ	30	2019-04-03 09:26:45
98768	���Ͻ�	    10	2019-04-03 09:27:02
98769	���Ͻ�	    20	2019-04-03 09:27:47
98770	������	    20	2019-04-03 09:28:22
98771	Ȩ����	    20	2019-04-03 09:29:14
98772	���ڼ���	10	2019-04-03 09:29:44
98773	Ȩ����	    30	2019-04-03 09:30:29
98774	����Ĩ	    20	2019-04-03 09:31:19
1	    Ȩ����	    20	2001-11-01 09:00:10
2	    ��Į��	    10	2001-11-01 09:23:24
3	    ����	    30	2001-11-02 12:00:11
4	    ��īĨ	    10	2001-11-02 15:16:17
5	    ���Ͻ�	    10	2001-11-03 10:22:33
6	    ���Ͻ�	    12	2001-11-04 16:00:00
7	    Ȩ����	    50	2001-11-06 11:11:11
8	    ��īĨ	    40	2001-11-10 19:00:00
9	    ��Į��	    10	2001-11-13 09:14:03
10	    �ܲϹ��	20	2001-11-13 14:20:00
*/

--�� UNION �� �׻� ������� ù ��° �÷��� ��������
--   �������� ������ �����Ѵ�.
--   UNION ALL �� ���յ� ������� ��ȸ�� ����� ��ȯ�Ѵ�. (���� ����)
--   �̷� ���� UNION �� ���ϰ� �� ũ��.
--   ����, UNION �� ��������� �ߺ��� ���� ������ ���
--   �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�Ѵ�.


--�� ���ݱ��� �ֹ����� ��� �����͸� ���� 
--   ��ǰ�� �� �ֹ����� ��ȸ�ϴ� �������� �����Ѵ�.
/*
----------------------------------------------------
    ��ǰ�ڵ�        �� �ֹ���
----------------------------------------------------
*/

SELECT T.��ǰ�ڵ�, SUM(T.�ֹ���)
FROM
(
    SELECT JECODE"��ǰ�ڵ�", JUSU"�ֹ���"
    FROM TBL_JUMUN
    UNION ALL
    SELECT JECODE"��ǰ�ڵ�", JUSU"�ֹ���"
    FROM TBL_JUMUNBACKUP
)T
GROUP BY T.��ǰ�ڵ�;
--==>>
/*
������	    40
������Ĩ	30
���Ͻ�	    52
����Ĩ	    20
�Ǻ���	    20
����	    30
���ڼ���	10
��īĨ	    50
�ܲϹ��	20
Ȩ����	   130
*/
--> �� ������ �ذ��ϴ� ���������� UNION �� ����ؼ��� �ȵȴ�.
--  �� JECODE �� JUSU �� ��ȸ�ϴ� �������� �ߺ��� ���� �����ϴ� ��Ȳ �߻�!!


--�� INTERSECT / MINUS (�� ������ / ������)

-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
-- ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� �ุ �����ϰ��� �Ѵ�.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
���Ͻ�	10
Ȩ����	20
*/


--�� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ�����, �ֹ����� �׸����� ��ȸ�Ѵ�.

-- ���1.
SELECT T2.JUNO"�ֹ���ȣ", T1.JECODE"��ǰ�ڵ�", T1.JUSU"�ֹ�����", T2.JUDAY"�ֹ�����"
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
)T2
JOIN
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
)T1
ON T1.JECODE = T2.JECODE
AND T1.JUSU = T2.JUSU;

-- ���2
SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
)T
--WHERE JECODE||JUSU IN ('Ȩ����20','���Ͻ�10');
--WHERE CONCAT(JECODE, JUSU) IN ('Ȩ����20','���Ͻ�10');
WHERE CONCAT(JECODE, JUSU) = ANY ('Ȩ����20', '���Ͻ�10');

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--> ('���Ͻ�','10','Ȩ����','20')

SELECT CONCAT(JECODE, JUSU)
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT CONCAT(JECODE, JUSU)
FROM TBL_JUMUN;

SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
)T
WHERE CONCAT(T.JECODE, T.JUSU) = ANY (SELECT CONCAT(JECODE, JUSU)
                                  FROM TBL_JUMUNBACKUP
                                  INTERSECT
                                  SELECT CONCAT(JECODE, JUSU)
                                  FROM TBL_JUMUN);
--==>>
/*
1	    Ȩ����	20	2001-11-01 09:00:10
5	    ���Ͻ�	10	2001-11-03 10:22:33
98768	���Ͻ�	10	2019-04-03 10:46:16
98771	Ȩ����	20	2019-04-03 10:46:16
*/

SELECT *
FROM 
(
    SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
)T,
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
)Q
WHERE(T.JECODE = Q.JECODE AND T.JUSU = Q.JUSU);


--MINUS : ������

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
���Ͻ�	10
Ȩ����	20
*/

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
������	    10
�ܲϹ��	20
����	    30
���Ͻ�	    12
��īĨ	    10
��īĨ	    40
Ȩ����	    50
*/

/*
    A = {10, 20, 30, 40, 50}
    B = {10, 20, 30}
    
    A - B = {40, 50}
*/


SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- CHECK!
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
-- ������������













