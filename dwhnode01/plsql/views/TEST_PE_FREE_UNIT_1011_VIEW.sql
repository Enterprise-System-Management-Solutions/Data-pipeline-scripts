--
-- TEST_PE_FREE_UNIT_1011_VIEW  (View) 
--
CREATE OR REPLACE FORCE VIEW DWH_USER.TEST_PE_FREE_UNIT_1011_VIEW
(PROCESSED_DATE, SUB_ID, FREEUNIT_TYPE, EFF_DATE, EXP_DATE, 
 INIT_BALANCE, CURRENT_BALANCE, EVENT_DATE)
BEQUEATH DEFINER
AS 
SELECT "PROCESSED_DATE","SUB_ID","FREEUNIT_TYPE","EFF_DATE","EXP_DATE","INIT_BALANCE","CURRENT_BALANCE","EVENT_DATE" FROM TEST_PE_FREE_UNIT_101 A
WHERE TRUNC(A.PROCESSED_DATE)=TRUNC(TO_DATE('24082020','ddmmrrrr'))
AND ROWNUM <100;


