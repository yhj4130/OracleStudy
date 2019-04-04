SELECT USER
FROM DUAL;
--==>> HR


--�� �� �� �̻��� ���̺� ����(JOIN)

-- ����1(SQL 1992 CONE)
SELECT ���̺���1.�÷���, ���̺���2.�÷���, ���̺���3.�÷���
FROM ���̺���1, ���̺���2, ���̺���3
WHERE ���̺���1.�÷���1 = ���̺�2.�÷���1
  AND ���̺���2.�÷���1 = ���̺�3.�÷���2;

-- ����2(SQL 1999 CONE)
SELECT ���̺���1.�÷���, ���̺���2.�÷���, ���̺���3.�÷���
FROM ���̺���1 JOIN ���̺���2
ON ���̺���1.�÷���1 = ���̺���2.�÷���1
        JOIN ���̺���3
        ON ���̺���2.�÷���2 = ���̺�3.�÷���2;


--�� HR ���� ���� ���̺� �Ǵ� �� ��� ��ȸ
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	 VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/


--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� �������
--   �������� ������ FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME     JOBS-JOB_TITLE EM-FI,LA DE-DEPANA
--   �׸��� ��ȸ�Ѵ�.


SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, JOBS.JOB_TITLE, DEPARTMENTS.DEPARTMENT_NAME
FROM JOBS, EMPLOYEES, DEPARTMENTS
WHERE JOBS.JOB_ID(+) = EMPLOYEES.JOB_ID
  AND EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID(+);
  

SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, JOBS.JOB_TITLE, DEPARTMENTS.DEPARTMENT_NAME
FROM JOBS JOIN EMPLOYEES
ON JOBS.JOB_ID = EMPLOYEES.JOB_ID
        LEFT JOIN DEPARTMENTS
        ON EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

SELECT *
FROM JOBS;

SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;


--�� EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS,COUNTRIES, REGIONS ���̺��� �������
--   �������� ������ ������ ���� ��ȸ�Ѵ�.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME
--   , CITY, COUNTRY_NAME, REGION_NAME

SELECT *
FROM REGIONS;

SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, JOBS.JOB_TITLE, DEPARTMENTS.DEPARTMENT_NAME, LOCATIONS.CITY, COUNTRIES.COUNTRY_NAME, REGIONS.REGION_NAME
FROM JOBS, EMPLOYEES, DEPARTMENTS, LOCATIONS,COUNTRIES, REGIONS
WHERE JOBS.JOB_ID(+) = EMPLOYEES.JOB_ID
  AND EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID(+)
  AND DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID(+)
  AND LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID(+)
  AND COUNTRIES.REGION_ID = REGIONS.REGION_ID(+);
  
  
SELECT EMPLOYEES.FIRST_NAME, EMPLOYEES.LAST_NAME, JOBS.JOB_TITLE, DEPARTMENTS.DEPARTMENT_NAME, LOCATIONS.CITY, COUNTRIES.COUNTRY_NAME, REGIONS.REGION_NAME
FROM JOBS JOIN EMPLOYEES
ON JOBS.JOB_ID = EMPLOYEES.JOB_ID
        LEFT JOIN DEPARTMENTS
        ON EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
        LEFT JOIN LOCATIONS
        ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
        LEFT JOIN COUNTRIES
        ON LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
        LEFT JOIN REGIONS
        ON COUNTRIES.REGION_ID = REGIONS.REGION_ID;






























