--
-- DATEDIFFERENCE  (View) 
--
CREATE OR REPLACE FORCE VIEW DWH_USER.DATEDIFFERENCE
(MSISDIN_NO, DATE_DIFF)
BEQUEATH DEFINER
AS 
SELECT A.MSISDIN_NO, LAST_ACTIVITY_DATE_KEY - FIRST_ACTIVE_DATE Date_Diff
     FROM ( (SELECT LAST_ACTIVITY_DATE_KEY, MSISDIN_NO
               FROM ACTIVEBASE
              WHERE ETL_DATE_KEY =
                       (SELECT DATE_KEY
                          FROM DATE_DIM
                         WHERE DATE_VALUE =
                                  TO_DATE (SYSDATE - 27, 'DD/MM/RRRR'))) A
           INNER JOIN
           (SELECT FIRST_ACTIVE_DATE, MSISDIN_NO
              FROM AGEONNETWROK
             WHERE ETL_DATE_KEY =
                      (SELECT DATE_KEY
                         FROM DATE_DIM
                        WHERE DATE_VALUE =
                                 TO_DATE (SYSDATE - 27, 'DD/MM/RRRR'))) B
              ON B.MSISDIN_NO = A.MSISDIN_NO);


