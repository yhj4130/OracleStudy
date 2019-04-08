SELECT USER
FROM DUAL;
--==>> SCOTT

--���� PL/SQL ����--

-- 1. PL/SQL(Procedural Language extension to SQL) ��
--    ���α׷��� ����� Ư���� ������ SQL �� Ȯ���̸�,
--    ������ ���۰� ���� ������ PL/SQL �� ������ �ڵ� �ȿ� ���Եȴ�.
--    ���� PL/SQL�� ����ϸ� SQL�� �� �� ���� ������ �۾��� �����ϴ�.
--    ���⿡�� �����������̶�� �ܾ ������ �ǹ̴�
--    � ���� � ������ ���� ��� �Ϸ�Ǵ���
--    �� ����� ��Ȯ�ϰ� �ڵ忡 ����Ѵٴ� ���� �ǹ��Ѵ�.

-- 2. PL/SQL �� ���������� ǥ���ϱ� ����
--    ������ ������ �� �ִ� ���,
--    ���� ������ ������ �� �ִ� ���,
--    ����� �帧�� ��Ʈ���� �� �ִ� ��� ���� �����Ѵ�.

-- 3. PL/SQL �� �� ������ �Ǿ� ������
--    ���� ���� �κ�, ���� �κ�, ���� ó�� �κ���
--    �� �κ����� �����Ǿ� �ִ�.
--    ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����.

-- 4. ���� �� ����
/*
[DECLARE]
    -- ����(declarations)
BEGIN
    -- ���๮(statements)
    
    [EXCEPTION]
        -- ���� ó����(exception handlers)
END;
*/

-- 5. ���� ����
/*
DECLARE
    ������ �ڷ���;
    ������ �ڷ��� := �ʱⰪ;
BEGIN
    PL/SQL ����;
END;
*/

SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.
--> ��DBMS_OUTPUT.PUT_LINE()�� �� ����
--  ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    D1 NUMBER := 10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- �����
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    D1 NUMBER := 10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- �����
    D1 := D1 * 10;
    D2 := D2 || ' ����';
    D3 := D3 || ' World';
    
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
100
HELLO ����
Oracle World


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� IF��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    TRUE �̸� THEN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE �� END IF ������ ������ �����ϰ� �ȴ�.

-- 2. ���� �� ����
/*
IF ����
    THEN ó������;
ELSIF
    THEN ó������;
ELSE
    ó������;    
END IF;
*/

--�� ������ ���ִ� ���� ����
--   Excellent, Good, Fail �� �����Ͽ�
--   ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'C';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>> Fail

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>> Good

DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    IF (GRADE = 'A')
        THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    ELSIF (GRADE = 'B')
        THEN DBMS_OUTPUT.PUT_LINE('Good');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fail');
    END IF;
END;
--==>> Excellent


--�� CASE�� (���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1
        THEN ���๮;
    WHEN ��2
        THEN ���๮;
    ELSE
        ���๮;
END CASE;
*/

--�� ������ ���ִ� ���� ����
--   Excellent, Good, Fail �� �����Ͽ�
--   ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, CASE ������ Ȱ���Ͽ� �ۼ��Ѵ�.
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    CASE GRADE
        WHEN 'A'
            THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B'
            THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Fail');
    END CASE;
END;
--==>> Excellent


--�� �ܺ� �Է� ó��

-- 1. ACCEPT ��
-- ACCEPT ������ PROMPT '�޼���';
-- �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
-- ��&�ܺκ����� ���·� �����ϰ� �ȴ�.

--�� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

ACCEPT N1 PROMPT 'ù ��° ������ �Է��ϼ���.';
ACCEPT N2 PROMPT '�� ��° ������ �Է��ϼ���.';

DECLARE
    -- �ֿ� ���� ���� �� �ʱ�ȭ
    NUM1 NUMBER := &N1;
    NUM2 NUMBER := &N2;
    TOTAL NUMBER := 0;
BEGIN
    -- ���� �� ó��
    TOTAL := NUM1 + NUM2;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;
--==>> 25 + 47 = 72


--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ�� ������ ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990 ��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

ACCEPT MONEY PROMPT '�ݾ� �Է�(10�� �̻� 1õ�� �̸�) : ';

DECLARE
    COIN NUMBER := &MONEY;
    C500 NUMBER;
    C100 NUMBER;
    C50 NUMBER;
    C10 NUMBER;
BEGIN
    C500 := TRUNC(COIN/500);
    C100 := TRUNC(MOD(COIN,500)/100);
    C50 := TRUNC(MOD(COIN,100)/50);
    C10 := TRUNC(MOD(COIN,50)/10);
    
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || C500 || ', ��� ' || C100 || ', ���ʿ� ' || C50 || ', �ʿ� ' || C10);
END;

ACCEPT INPUT PROMPT '�ݾ� �Է�';

DECLARE
    --�� �ֿ� ���� ���� �� �ʱ�ȭ
    MONEY  NUMBER := &INPUT;    -- ������ ���� ��Ƶ� ����
    MONEY2 NUMBER := &INPUT;    -- ����� ���� ��Ƶ� ����(���� �������� ���� ���ϱ� ������)
    M500   NUMBER;    -- 500�� ¥�� ������ ��Ƶ� ����
    M100   NUMBER;    -- 100�� ¥�� ������ ��Ƶ� ����
    M50    NUMBER;    --  50�� ¥�� ������ ��Ƶ� ����
    M10    NUMBER;    --  10�� ¥�� ������ ��Ƶ� ����
BEGIN
    --�� ���� �� ó��
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������. �� 500���� ����
    M500 := TRUNC(MONEY/500);
    
    -- MONEY �� 500���� ������ ���� ������ �������� ���Ѵ�.
    -- �� ����� MONEY�� ��Ƴ���.
    MONEY := MOD(MONEY,500);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������. �� 100���� ����
    M100 := TRUNC(MONEY/100);
    
    -- MONEY �� 100���� ������ ���� ������ �������� ���Ѵ�.
    -- �� ����� MONEY�� ��Ƴ���.
    MONEY := MOD(MONEY, 100);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������. �� 50���� ����
    M50 := TRUNC(MONEY/50);
    
    -- MOENY �� 50���� ������ ���� ������ �������� ���Ѵ�.
    MONEY := MOD(MONEY, 50);
    
    -- MONEY �� 10���� ������ ���� ���ϰ� �������� ������. �� 10���� ����
    M10 := TRUNC(MONEY/10);
    
    --�� ��� ���
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || M500 || ', ��� ' || M100 || ', ���ʿ� ' || M50 || ', �ʿ� ' || M10);
END;
--> ���ε� ���� �Է� ��ȭâ�� 970�� �Է�
/*
�Է¹��� �ݾ� �Ѿ� : 970��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 2
*/


--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮;
    EXIT WHEN ����;       -- ������ ���� ��� �ݺ����� ����������.
    
END LOOP;
*/

--�� 1 ���� 10 ������ �� ��� (LOOP Ȱ��)
DECLARE
    N NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N >= 10;
        N := N + 1;     -- N++;, N+=1;
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵� �� üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP   -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/

--�� 1 ���� 10 ������ �� ��� (WHILE LOOP Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. ������ �������� 1�� �����Ͽ�
--    ������ ������ �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� in [REVERSE] ���ۼ� .. ������ LOOP    -- �⺻������ ���� ���
    -- ���๮
END LOOP;
*/

--�� 1 ���� 10 ������ �� ��� (FOR LOOP Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է����ּ��� : 2

2 * 1 = 2
    :
*/

ACCEPT INPUT PROMPT '���� �Է��ϼ��� :';

-- LOOP
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
        EXIT WHEN N >= 9;
        N := N + 1;
    END LOOP;
END;

-- WHILE LOOP
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<9 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
    END LOOP;
END;

-- FOR LOOP
DECLARE
    DAN NUMBER := &INPUT;
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
    END LOOP;
END;










