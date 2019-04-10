SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   ������ ���� �ִ� ��� ���̺� ������ �Է� ��
--   NUM �÷�(�����ȣ)�� ����
--   ���� �ο��� �����ȣ ������ ��ȣ�� �� ���� ��ȣ�� �ڵ�����
--   �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_INSA_INSERT(NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
/*
���� ��)
EXEC PRC_INSA_INSERT('�輱��','901212-2234567',SYSDATE,'����','010-5555-5555','������','�븮',1000000,200000);

���ν��� ȣ��� ó���� ���)
1061 �輱�� 901212-2234567 SYSDATE ���� 010-5555-5555 ������ �븮 1000000,200000
*/
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE    
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS 
    -- INSERT ������ ���࿡ �ʿ��� ���� �߰� ����
    V_NUM   NUMBER;
BEGIN
    -- ������ ������ �� ��Ƴ���
    SELECT MAX(NUM)+1 INTO V_NUM FROM TBL_INSA;
    
    -- INSERT ������ ����
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��ǰ, TBL_�԰� ���̺��� ������� 
--   TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ����
--   ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�. (������ ��� X)
--   TBL_�԰� ���̺� ���� �÷�
--   �� �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--   ���ν��� �� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����,  �԰�ܰ�)

--�� TBL_�԰� ���̺� �԰� �̺�Ʈ �߻� ��
--   ���� ���̺��� ����Ǿ�� �ϴ� ����
--   �� INSERT �� TBL_�԰�
--      INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
--      VALUES(1, 'HOO1', SYSDATE, 20, 900);
--   �� UPDATE �� TBL_��ǰ
--      UPDATE TBL_��ǰ
--      SET ������ = ���������� + 20(���԰����)
--      WHERE ��ǰ�ڵ� = 'H001';

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ  NUMBER;
BEGIN
    SELECT MAX(�԰��ȣ) INTO V_�԰��ȣ FROM TBL_�԰�;
    
    IF V_�԰��ȣ IS NULL
        THEN V_�԰��ȣ := 0;
    END IF;
    
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�) VALUES(V_�԰��ȣ+1, V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó��
    EXCEPTION 
        WHEN OTHERS THEN ROLLBACK;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.

-- Ǯ��
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    -- �Ʒ��� �������� �����ϱ� ���� �ʿ��� ������ ������ ����
    V_�԰��ȣ  TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(�԰��ȣ), 0) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    -- ������ ����
    -- �� INSERT �� TBL_�԰�
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�) 
    VALUES((V_�԰��ȣ+1), V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    
    -- �� UPDATE �� TBL_��ǰ
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó��
    EXCEPTION 
        WHEN OTHERS THEN ROLLBACK;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


--���� ���ν��� �������� ���� ó�� ����--

--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� ����
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����', '��õ', '���' �� �Է��� �����ϵ��� �����Ѵ�.
--   �� ���� ���� ������ ���ν��� ȣ���� ���� �Է��Ϸ��� �ϴ� ���
--   ���� ó���� �Ϸ��� �Ѵ�.
--   ���ν��� �� : PRC_MEMBER_INSERT(�̸�, ��ȭ��ȣ, ����)

-- ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    -- ���� ������ ������ ������ ���� �ʿ��� ������ ���� ����
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ���� CHECK!!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    
    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ����������
    -- �ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF (V_CITY NOT IN ('����','��õ','���'))
        -- ���� �߻�!! CHECK!!!
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM), 0) INTO V_NUM
    FROM TBL_MEMBER;
    
    -- ������ ����(INSERT)
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó�� ����
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����, ��õ, ��⸸ �Է� �����մϴ�.');     -- ���̳ʽ��� �ƴ϶� ����Ǭ����
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�.
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����.
--   ����, ��� ������ ��� �������� ���� ���
--   ��� �׼��� ����� �� �ֵ��� ó���Ѵ�. (��� �̷������ �ʵ���)
--   ���ν��� �� : PRC_���_INSERT(��ǰ�ڵ�, ������, ���ܰ�);
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS
    -- �ֿ� ���� ����
    V_����ȣ  TBL_���.����ȣ%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ���� CHECK!!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN

    -- ������ ���� ������ ���� ���� Ȯ�� �� ���� ��� Ȯ�� �� �������� ��
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ��� ���������� ������ �� �������� ���� ���� Ȯ��
    -- (�ľ��� ���������� �������� ������ ���ܹ߻�)
    IF V_������<V_������
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ), 0) INTO V_����ȣ
    FROM TBL_���;
    
    -- ������ ����
    -- �� INSERT �� TBL_���
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�) 
    VALUES((V_����ȣ+1), V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- �� UPDATE �� TBL_��ǰ
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó��
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '�������� �����մϴ�.');     -- ���̳ʽ��� �ƴ϶� ����Ǭ����
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺��� ��� ������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_UPDATE(����ȣ, ������ ����);
CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ    IN TBL_���.����ȣ%TYPE
, V_�������    IN TBL_���.������%TYPE
)
IS
    V_������      TBL_��ǰ.������%TYPE;
    V_������      TBL_���.������%TYPE;
    V_��ǰ�ڵ�      TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ���� CHECK!!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    
    -- ������ ���� ������ ���� ���� Ȯ�� �� ���� ��� Ȯ�� �� �������� ��
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ� FROM TBL_��� WHERE ����ȣ = V_����ȣ;
    SELECT ������ INTO V_������ FROM TBL_��ǰ WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    SELECT ������ INTO V_������ FROM TBL_��� WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    IF V_�������>(V_������+V_������)
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;
    
    -- ������ ����
    -- �� UPDATE �� TBL_���
    UPDATE TBL_���
    SET ������ = V_�������
    WHERE ����ȣ = V_����ȣ;
    
    -- �� UPDATE �� TBL_��ǰ
    UPDATE TBL_��ǰ
    SET ������ = V_������� - V_������ - ������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó��
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '�������� �����մϴ�.');     -- ���̳ʽ��� �ƴ϶� ����Ǭ����
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.

-- Ǯ��
CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( 
  --�� �Ű����� ����
  V_����ȣ   IN TBL_���.����ȣ%TYPE
, V_������   IN TBL_���.������%TYPE
)
IS
    --�� �ֿ� ���� �߰� ����
    V_��ǰ�ڵ�      TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    --�� �ֿ� ���� �߰� ����
    V_����������  TBL_���.������%TYPE;
    
    --�� �ֿ� ���� �߰� ����
    V_������      TBL_��ǰ.������%TYPE;
    
    --�� �ֿ� ����(����� ���� ����) �߰� ����
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    
    --�� ��ǰ�ڵ�� ���������� �ľ��� ���� ���� ������ ��� ���� Ȯ��
    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_����������
    FROM TBL_��� 
    WHERE ����ȣ = V_����ȣ;
    
    --�� ��� ���������� �����ؾ� �ϴ����� ���� �Ǵ� �ʿ�
    --   ���� ���� ������ �� ������ ������ Ȯ��
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� �ľ��� �������� ���� ������ ���� �ǽ� ���� �Ǵ�
    --   (��������+���������� < �������������� ��Ȳ�̶�� ����� ���� ���� �߻�)
    IF V_������>(V_������+V_����������)
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;
    
    --�� ����� ������ üũ(UPDATE��TBL_��� / UPDATE��TBL_��ǰ)
    UPDATE TBL_���
    SET ������ = V_������
    WHERE ����ȣ = V_����ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_���������� - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� Ŀ��
    COMMIT;
    
    --�� ���� ó��
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '�������� �����մϴ�.');     -- ���̳ʽ��� �ƴ϶� ����Ǭ����
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.










