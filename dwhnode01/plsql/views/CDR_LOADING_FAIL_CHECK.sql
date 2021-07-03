--
-- CDR_LOADING_FAIL_CHECK  (View) 
--
CREATE OR REPLACE FORCE VIEW DWH_USER.CDR_LOADING_FAIL_CHECK
(SOURCE, PROCESS_STATUS, COUNT, MAIN_SOURCE, WHO_IS_DB)
BEQUEATH DEFINER
AS 
SELECT /*+PARALLEL(Q,16)*/
           SOURCE,
            PROCESS_STATUS,
            COUNT (UNIQUE FILE_NAME) AS COUNT,
            'cbs' AS MAIN_SOURCE,
            'Please Check in 202 database' AS who_is_db
       FROM CDR_HEAD_merge Q
      WHERE        TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 1)
                                            AND TRUNC (SYSDATE)
               AND PROCESS_STATUS !=96
               AND FILE_NAME LIKE
                         '%'
                      || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD') AS FILE_NAME
                            FROM DATE_DIM
                           WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 1))
                      || '%'
               AND SOURCE IN ('adj',
                              'cm',
                              'com',
                              'data',
                              'mon',
                              'sms',
                              'transfer',
                              'voice',
                              'vou')
            OR source LIKE '%fou%'
   GROUP BY SOURCE, PROCESS_STATUS
   UNION ALL
     SELECT /*+PARALLEL(Q,16)*/
           SOURCE,
            PROCESS_STATUS,
            COUNT (UNIQUE FILE_NAME) AS COUNT,
            'fuo' AS MAIN_SOURCE,
            'Please Check in 202 database' AS who_is_db
       FROM CDR_HEAD Q
      WHERE     TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 1)
                                         AND TRUNC (SYSDATE)
            AND PROCESS_STATUS !=96
            AND FILE_NAME LIKE
                      '%'
                   || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD') AS FILE_NAME
                         FROM DATE_DIM
                        WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 1))
                   || '%'
            AND SOURCE LIKE '%fuo%'
   GROUP BY SOURCE, PROCESS_STATUS
   UNION ALL
     SELECT SOURCE,
            PROCESS_STATUS,
            COUNT (UNIQUE FILE_NAME) AS COUNT,
            'msc' AS MAIN_SOURCE,
            'Please Check in 204 database' AS who_is_db
       FROM CDR_HEAD@DWH01TODWH03
      WHERE     TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 1)
                                         AND TRUNC (SYSDATE)
            AND PROCESS_STATUS !=96
            AND source = 'msc_nokia'
            AND FILE_NAME LIKE
                      '%'
                   || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD') AS FILE_NAME
                         FROM DATE_DIM
                        WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 1))
                   || '%'
   GROUP BY SOURCE, PROCESS_STATUS
   UNION ALL
     SELECT SOURCE,
            PROCESS_STATUS,
            COUNT (UNIQUE FILE_NAME) AS COUNT,
            'msc' AS MAIN_SOURCE,
            'Please Check in 204 database' AS who_is_db
       FROM CDR_HEAD_merge@DWH01TODWH03
      WHERE     TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 1)
                                         AND TRUNC (SYSDATE)
            AND PROCESS_STATUS !=96
            AND source != 'msc_nokia'
            AND FILE_NAME LIKE
                      '%'
                   || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD') AS FILE_NAME
                         FROM DATE_DIM
                        WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 1))
                   || '%'
   GROUP BY SOURCE, PROCESS_STATUS
   UNION ALL
     SELECT SOURCE,
            PROCESS_STATUS,
            COUNT (UNIQUE FILE_NAME) AS COUNT,
            'mfs' AS MAIN_SOURCE,
            'Please Check in 204 database' AS who_is_db
       FROM CDR_HEAD@DWH01TODWH03
      WHERE     TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 1)
                                         AND TRUNC (SYSDATE)
            AND SOURCE IN ('smsc', 'ussd', 'cgw')
            AND PROCESS_STATUS !=96
            AND FILE_NAME LIKE
                      '%'
                   || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD') AS FILE_NAME
                         FROM DATE_DIM
                        WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 3))
                   || '%'
   GROUP BY SOURCE, PROCESS_STATUS
   UNION ALL
     SELECT SOURCE,
            PROCESS_STATUS,
            COUNT (UNIQUE FILE_NAME) AS COUNT,
            'evc' AS MAIN_SOURCE,
            'Please Check in 20 database' AS who_is_db
       FROM CDR_HEAD@DWH01TODWH02
      WHERE     TRUNC (PROCESS_DATE) = TRUNC (SYSDATE - 1)
            AND SOURCE IN ('evcTRA', 'evcREC')
            AND PROCESS_STATUS !=96
            AND FILE_NAME LIKE
                      '%'
                   || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD') AS FILE_NAME
                         FROM DWH_USER.DATE_DIM
                        WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 2))
                   || '%'
   GROUP BY SOURCE, PROCESS_STATUS
   UNION ALL
     SELECT SOURCE,
            PROCESS_STATUS,
            COUNT (UNIQUE FILE_NAME) AS COUNT,
            'alarm' AS MAIN_SOURCE,
            'Please Check in 20 database' AS who_is_db
       FROM CDR_HEAD@DWH01TODWH02
      WHERE     TRUNC (PROCESS_DATE) = TRUNC (SYSDATE - 1)
            AND SOURCE = 'alarm'
            AND PROCESS_STATUS !=96
            AND FILE_NAME LIKE
                      '%'
                   || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD') AS FILE_NAME
                         FROM DWH_USER.DATE_DIM
                        WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 1))
                   || '%'
   GROUP BY SOURCE, PROCESS_STATUS
   UNION ALL
   SELECT 'HuaweiUDN' AS SOURCE,
          PROCESS_STATUS,
          COUNTS,
          'ipdr' AS MAIN_SOURCE,
          'Please Check in 20 database' AS who_is_db
     FROM (  SELECT PROCESS_STATUS, COUNT (*) AS COUNTS
               FROM CDR_HEAD@DWH01TODWH02
              WHERE     TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 1)
                                                 AND TRUNC (SYSDATE)
                    AND SOURCE IN ('HuaweiUDN', 'HuaweiUDN2')
                    AND PROCESS_STATUS !=96
                    AND FILE_NAME LIKE
                              '%'
                           || (SELECT TO_CHAR (DATE_VALUE, 'RRRRMMDD')
                                         AS FILE_NAME
                                 FROM DATE_DIM
                                WHERE TRUNC (DATE_VALUE) = TRUNC (SYSDATE - 1))
                           || '%'
           GROUP BY PROCESS_STATUS);


