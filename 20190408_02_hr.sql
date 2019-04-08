SELECT USER 
FROM DUAL;
--==>> HR


--○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다.
--   단, 부서명이 'IT' 인 경우로 한정한다.
--   (결과 확인 후 ROLLBACK)
SELECT *
FROM EMPLOYEES;
--==>>
/*
100	Steven	    King	    SKING	    515.123.4567	    03/06/17	AD_PRES	    24000			    90
101	Neena	    Kochhar	    NKOCHHAR	515.123.4568	    05/09/21	AD_VP	    17000		    100	90
102	Lex	        De Haan	    LDEHAAN	    515.123.4569	    01/01/13	AD_VP	    17000		    100	90
103	Alexander	Hunold	    AHUNOLD	    590.423.4567	    06/01/03	IT_PROG	     9900	    	102	60
104	Bruce	    Ernst	    BERNST	    590.423.4568	    07/05/21	IT_PROG	     6600	    	103	60
105	David	    Austin	    DAUSTIN 	590.423.4569	    05/06/25	IT_PROG	     5280	    	103	60
106	Valli	    Pataballa	VPATABAL	590.423.4560	    06/02/05	IT_PROG	     5280	    	103	60
107	Diana	    Lorentz	    DLORENTZ	590.423.5567	    07/02/07	IT_PROG	     4620	    	103	60
108	Nancy	    Greenberg	NGREENBE	515.124.4569	    02/08/17	FI_MGR	    12008	    	101	100
109	Daniel	    Faviet	    DFAVIET	    515.124.4169	    02/08/16	FI_ACCOUNT	 9000	    	108	100
110	John	    Chen	    JCHEN	    515.124.4269	    05/09/28	FI_ACCOUNT	 8200	    	108	100
111	Ismael	    Sciarra	    ISCIARRA	515.124.4369	    05/09/30	FI_ACCOUNT	 7700	    	108	100
112	Jose Manuel	Urman	    JMURMAN	    515.124.4469	    06/03/07	FI_ACCOUNT	 7800	    	108	100
113	Luis	    Popp	    LPOPP	    515.124.4567	    07/12/07	FI_ACCOUNT	 6900	    	108	100
114	Den	        Raphaely	DRAPHEAL	515.127.4561	    02/12/07	PU_MAN	    11000	    	100	30
115	Alexander	Khoo	    AKHOO	    515.127.4562	    03/05/18	PU_CLERK	 3100	    	114	30
116	Shelli	    Baida	    SBAIDA	    515.127.4563	    05/12/24	PU_CLERK	 2900	    	114	30
117	Sigal	    Tobias	    STOBIAS	    515.127.4564	    05/07/24	PU_CLERK	 2800	    	114	30
118	Guy	        Himuro	    GHIMURO	    515.127.4565	    06/11/15	PU_CLERK	 2600	    	114	30
119	Karen	    Colmenares	KCOLMENA	515.127.4566	    07/08/10	PU_CLERK	 2500	    	114	30
120	Matthew	    Weiss	    MWEISS	    650.123.1234	    04/07/18	ST_MAN	     8000	    	100	50
121	Adam	    Fripp	    AFRIPP	    650.123.2234	    05/04/10	ST_MAN	     8200	    	100	50
122	Payam	    Kaufling	PKAUFLIN	650.123.3234	    03/05/01	ST_MAN	     7900	    	100	50
123	Shanta	    Vollman	    SVOLLMAN	650.123.4234	    05/10/10	ST_MAN	     6500	    	100	50
124	Kevin	    Mourgos	    KMOURGOS	650.123.5234	    07/11/16	ST_MAN	     5800	    	100	50
125	Julia	    Nayer	    JNAYER	    650.124.1214	    05/07/16	ST_CLERK	 3200	    	120	50
126	Irene	    Mikkilineni	IMIKKILI	650.124.1224	    06/09/28	ST_CLERK	 2700	    	120	50
127	James	    Landry	    JLANDRY	    650.124.1334	    07/01/14	ST_CLERK	 2400	    	120	50
128	Steven	    Markle	    SMARKLE	    650.124.1434	    08/03/08	ST_CLERK	 2200	    	120	50
129	Laura	    Bissot	    LBISSOT	    650.124.5234	    05/08/20	ST_CLERK	 3300	    	121	50
130	Mozhe	    Atkinson	MATKINSO	650.124.6234	    05/10/30	ST_CLERK	 2800	    	121	50
131	James	    Marlow	    JAMRLOW	    650.124.7234	    05/02/16	ST_CLERK	 2500	    	121	50
132	TJ	        Olson	    TJOLSON	    650.124.8234	    07/04/10	ST_CLERK	 2100	    	121	50
133	Jason	    Mallin	    JMALLIN	    650.127.1934	    04/06/14	ST_CLERK	 3300	    	122	50
134	Michael	    Rogers	    MROGERS	    650.127.1834	    06/08/26	ST_CLERK	 2900	    	122	50
135	Ki	        Gee	        KGEE	    650.127.1734	    07/12/12	ST_CLERK	 2400	    	122	50
136	Hazel	    Philtanker	HPHILTAN	650.127.1634	    08/02/06	ST_CLERK	 2200	    	122	50
137	Renske	    Ladwig	    RLADWIG	    650.121.1234	    03/07/14	ST_CLERK	 3600	    	123	50
138	Stephen	    Stiles	    SSTILES	    650.121.2034	    05/10/26	ST_CLERK	 3200	    	123	50
139	John	    Seo	        JSEO	    650.121.2019	    06/02/12	ST_CLERK	 2700	    	123	50
140	Joshua	    Patel	    JPATEL	    650.121.1834	    06/04/06	ST_CLERK	 2500	    	123	50
141	Trenna	    Rajs	    TRAJS	    650.121.8009	    03/10/17	ST_CLERK	 3500	    	124	50
142	Curtis	    Davies	    CDAVIES	    650.121.2994	    05/01/29	ST_CLERK	 3100	    	124	50
143	Randall	    Matos	    RMATOS	    650.121.2874	    06/03/15	ST_CLERK	 2600	    	124	50
144	Peter	    Vargas	    PVARGAS	    650.121.2004	    06/07/09	ST_CLERK	 2500	    	124	50
145	John	    Russell	    JRUSSEL	    011.44.1344.429268	04/10/01	SA_MAN	    14000	 0.4	100	80
146	Karen	    Partners	KPARTNER	011.44.1344.467268	05/01/05	SA_MAN	    13500	 0.3	100	80
147	Alberto	    Errazuriz	AERRAZUR	011.44.1344.429278	05/03/10	SA_MAN	    12000	 0.3    100	80
148	Gerald	    Cambrault	GCAMBRAU	011.44.1344.619268	07/10/15	SA_MAN	    11000	 0.3    100	80
149	Eleni	    Zlotkey	    EZLOTKEY	011.44.1344.429018	08/01/29	SA_MAN	    10500	 0.2    100	80
150	Peter	    Tucker	    PTUCKER	    011.44.1344.129268	05/01/30	SA_REP	    10000	 0.3    145	80
151	David	    Bernstein	DBERNSTE	011.44.1344.345268	05/03/24	SA_REP 	     9500	0.25	145	80
152	Peter	    Hall	    PHALL	    011.44.1344.478968	05/08/20	SA_REP  	 9000	0.25	145	80
153	Christopher	Olsen	    COLSEN	    011.44.1344.498718	06/03/30	SA_REP	     8000	 0.2 	145	80
154	Nanette	    Cambrault	NCAMBRAU	011.44.1344.987668	06/12/09	SA_REP	     7500	 0.2 	145	80
155	Oliver	    Tuvault	    OTUVAULT	011.44.1344.486508	07/11/23	SA_REP	     7000	0.15	145	80
156	Janette	    King	    JKING	    011.44.1345.429268	04/01/30	SA_REP	    10000	0.35	146	80
157	Patrick	    Sully	    PSULLY	    011.44.1345.929268	04/03/04	SA_REP	     9500	0.35	146	80
158	Allan	    McEwen	    AMCEWEN	    011.44.1345.829268	04/08/01	SA_REP	     9000	0.35	146	80
159	Lindsey	    Smith	    LSMITH	    011.44.1345.729268	05/03/10	SA_REP	     8000	 0.3    146	80
160	Louise	    Doran	    LDORAN	    011.44.1345.629268	05/12/15	SA_REP	     7500	 0.3    146	80
161	Sarath	    Sewall	    SSEWALL	    011.44.1345.529268	06/11/03	SA_REP	     7000	0.25	146	80
162	Clara	    Vishney	    CVISHNEY	011.44.1346.129268	05/11/11	SA_REP	    10500	0.25	147	80
163	Danielle	Greene	    DGREENE	    011.44.1346.229268	07/03/19	SA_REP	     9500	0.15	147	80
164	Mattea	    Marvins	    MMARVINS	011.44.1346.329268	08/01/24	SA_REP	     7200	 0.1    147	80
165	David	    Lee     	DLEE	    011.44.1346.529268	08/02/23	SA_REP	     6800	 0.1    147	80
166	Sundar	    Ande	    SANDE	    011.44.1346.629268	08/03/24	SA_REP	     6400	 0.1	147	80
167	Amit	    Banda	    ABANDA	    011.44.1346.729268	08/04/21	SA_REP	     6200	 0.1	147	80
168	Lisa	    Ozer	    LOZER	    011.44.1343.929268	05/03/11	SA_REP	    11500	0.25	148	80
169	Harrison	Bloom	    HBLOOM	    011.44.1343.829268	06/03/23	SA_REP	    10000	 0.2	148	80
170	Tayler	    Fox	        TFOX	    011.44.1343.729268	06/01/24	SA_REP	     9600	 0.2	148	80
171	William	    Smith	    WSMITH	    011.44.1343.629268	07/02/23	SA_REP	     7400	0.15	148	80
172	Elizabeth	Bates	    EBATES	    011.44.1343.529268	07/03/24	SA_REP	     7300	0.15	148	80
173	Sundita	    Kumar	    SKUMAR	    011.44.1343.329268	08/04/21	SA_REP	     6100	 0.1	148	80
174	Ellen	    Abel	    EABEL	    011.44.1644.429267	04/05/11	SA_REP	    11000	 0.3	149	80
175	Alyssa	    Hutton	    AHUTTON	    011.44.1644.429266	05/03/19	SA_REP	     8800	0.25	149	80
176	Jonathon	Taylor	    JTAYLOR	    011.44.1644.429265	06/03/24	SA_REP	     8600	 0.2	149	80
177	Jack	    Livingston	JLIVINGS	011.44.1644.429264	06/04/23	SA_REP	     8400	 0.2	149	80
178	Kimberely	Grant	    KGRANT	    011.44.1644.429263	07/05/24	SA_REP	     7000	0.15	149	
179	Charles	    Johnson 	CJOHNSON	011.44.1644.429262	08/01/04	SA_REP	     6200	 0.1	149	80
180	Winston	    Taylor	    WTAYLOR	    650.507.9876	    06/01/24	SH_CLERK	 3200		    120	50
181	Jean	    Fleaur	    JFLEAUR	    650.507.9877	    06/02/23	SH_CLERK	 3100	    	120	50
182	Martha	    Sullivan	MSULLIVA	650.507.9878	    07/06/21	SH_CLERK	 2500	    	120	50
183	Girard	    Geoni	    GGEONI	    650.507.9879	    08/02/03	SH_CLERK	 2800	    	120	50
184	Nandita	    Sarchand	NSARCHAN	650.509.1876	    04/01/27	SH_CLERK	 4200	    	121	50
185	Alexis	    Bull	    ABULL	    650.509.2876	    05/02/20	SH_CLERK	 4100	    	121	50
186	Julia	    Dellinger	JDELLING	650.509.3876	    06/06/24	SH_CLERK 	 3400	    	121	50
187	Anthony	    Cabrio	    ACABRIO	    650.509.4876	    07/02/07	SH_CLERK	 3000	    	121	50
188	Kelly	    Chung	    KCHUNG	    650.505.1876	    05/06/14	SH_CLERK 	 3800	    	122	50
189	Jennifer	Dilly	    JDILLY	    650.505.2876	    05/08/13	SH_CLERK	 3600	    	122	50
190	Timothy	    Gates	    TGATES	    650.505.3876	    06/07/11	SH_CLERK	 2900	    	122	50
191	Randall	    Perkins	    RPERKINS	650.505.4876	    07/12/19	SH_CLERK	 2500	    	122	50
192	Sarah	    Bell	    SBELL	    650.501.1876	    04/02/04	SH_CLERK	 4000	    	123	50
193	Britney	    Everett	    BEVERETT	650.501.2876    	05/03/03	SH_CLERK	 3900	    	123	50
194	Samuel	    McCain	    SMCCAIN	    650.501.3876    	06/07/01	SH_CLERK	 3200	    	123	50
195	Vance	    Jones	    VJONES	    650.501.4876	    07/03/17	SH_CLERK	 2800	    	123	50
196	Alana	    Walsh	    AWALSH	    650.507.9811	    06/04/24	SH_CLERK	 3100	    	124	50
197	Kevin	    Feeney	    KFEENEY	    650.507.9822	    06/05/23	SH_CLERK	 3000	    	124	50
198	Donald	    OConnell	DOCONNEL	650.507.9833	    07/06/21	SH_CLERK	 2600	    	124	50
199	Douglas	    Grant	    DGRANT	    650.507.9844    	08/01/13	SH_CLERK	 2600	    	124	50
200	Jennifer	Whalen	    JWHALEN	    515.123.4444    	03/09/17	AD_ASST	     4400 	    	101	10
201	Michael	    Hartstein	MHARTSTE	515.123.5555    	04/02/17	MK_MAN	    13000	    	100	20
202	Pat	        Fay 	    PFAY	    603.123.6666    	05/08/17	MK_REP	     6000	    	201	20
203	Susan	    Mavris	    SMAVRIS	    515.123.7777    	02/06/07	HR_REP	     6500	    	101	40
204	Hermann	    Baer	    HBAER	    515.123.8888    	02/06/07	PR_REP	    10000	    	101	70
205	Shelley	    Higgins	    SHIGGINS	515.123.8080    	02/06/07	AC_MGR	    12008	    	101	110
206	William	    Gietz	    WGIETZ	    515.123.8181    	02/06/07	AC_ACCOUNT	 8300	    	205	110
*/

SELECT *
FROM DEPARTMENTS;

UPDATE EMPLOYEES
SET SALARY = SALARY*1.1
WHERE SUBSTR(JOB_ID, 1, 2) IN ( SELECT DEPARTMENT_NAME 
                                FROM DEPARTMENTS 
                                WHERE DEPARTMENT_NAME = 'IT');
                                
-- UPDATE
UPDATE EMPLOYEES
SET SALARY = SALARY *1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
--==>> 5개 행 이(가) 업데이트되었습니다.

ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 JOB_TITLE 이 『Sasle Manager』 인 사원들의
--   SALARY 를 해당 직무(직종)의 최고 급여(MAX_SALARY)로 수정한다.
--   단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한하여
--   적용할 수 있도록 처리한다.,
--   (결과 확인 후 ROLLBACK)

SELECT *
FROM JOBS;

UPDATE EMPLOYEES
SET SALARY = ( SELECT MAX_SALARY
               FROM JOBS
               WHERE JOB_TITLE = 'Sales Manager')
WHERE EXTRACT(YEAR FROM HIRE_DATE) < 2006
      AND JOB_ID = ( SELECT JOB_ID
                     FROM JOBS
                     WHERE JOB_TITLE = 'Sales Manager');
                     
UPDATE EMPLOYEES
SET SALARY = ( SELECT MAX_SALARY
               FROM JOBS
               WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = ( SELECT JOB_ID
                     FROM JOBS
                     WHERE JOB_TITLE = 'Sales Manager')
     AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')<=2005;

SELECT *
FROM EMPLOYEES;

ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 SALARY 를
--   각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다,
--   Finance → 10%
--   Executive → 15%
--   Accounting → 20%
--   나머지 → 0%
--   (결과 확인 후 ROLLBACK)

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID
                                WHEN ( SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY*1.1
                                WHEN ( SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY*1.15
                                WHEN ( SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY*1.2
                                ELSE SALARY
            END;
--==>> 107개 행 이(가) 업데이트되었습니다.

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID
                                WHEN ( SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME='Finance')
                                THEN SALARY*1.1
                                WHEN ( SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME='Executive')
                                THEN SALARY*1.15
                                WHEN ( SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME='Accounting')
                                THEN SALARY*1.2
                                ELSE SALARY
            END
WHERE DEPARTMENT_ID IN ( SELECT DEPARTMENT_ID
                         FROM DEPARTMENTS
                         WHERE DEPARTMENT_NAME IN ('Finance','Executive','Accounting'));
--==>> 11개 행 이(가) 업데이트되었습니다.

ROLLBACK;
--==>> 롤백 완료.




--■■■ DELETE ■■■--

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는 데 사용하는 구문

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 직원들의 정보를 삭제한다.
--   단, 부서명이 'IT' 인 경우로 한정한다.

--※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상)
--   다른 테이블(혹은 자기 자신 테이블)에 의해 참조당하는 경우
--   삭제되지 않을 수 있다는 사실을 염두해야 하며
--   그에 대한 이유도 알아야 한다.
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/




--■■■ 뷰(VIEW) ■■■--

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻디 원하는 데이터들만을
--    정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼둘만 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.

--    가상의 테이블이란 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이며
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
-- CREATE [OR REPLACE] VIEW 뷰이름
-- [(ALIAS,[, ALIAS, ...])]
-- AS
-- 서브쿼리(SUBQUERY)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY];


--○ 뷰 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.

--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;

--○ 뷰(VIEW) 구조 확인
DESC VIEW_EMPLOYEES;
--==>>
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY                     VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


--○ 뷰(VIEW) 소스 확인 -- CHECK!!
SELECT VIEW_NAME, TEXT              -- TEXT
FROM USER_VIEWS                     -- USER_VIEWS
WHERE VIEW_NAME='VIEW_EMPLOYEES';
--==>>
/*
VIEW_EMPLOYEES	"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
                 FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
                 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
                   AND D.LOCATION_ID = L.LOCATION_ID(+)
                   AND L.COUNTRY_ID = C.COUNTRY_ID(+)
                   AND C.REGION_ID = R.REGION_ID(+)"
*/
























