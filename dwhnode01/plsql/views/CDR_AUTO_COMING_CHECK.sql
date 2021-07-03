--
-- CDR_AUTO_COMING_CHECK  (View) 
--
CREATE OR REPLACE FORCE VIEW DWH_USER.CDR_AUTO_COMING_CHECK
(PROCESS_DATE, SOURCE, MAIN_SOURCE, COUNT, CDR_AUTO_COMING)
BEQUEATH DEFINER
AS 
SELECT  PROCESS_DATE, SOURCE, MAIN_SOURCE, COUNT, CDR_AUTO_COMING
     FROM
     (
     SELECT /*+PARALLEL(Q,16)*/
           TRUNC (PROCESS_DATE) AS PROCESS_DATE,
            SOURCE,
            'cbs' AS main_source,
            COUNT (*) AS COUNT,
            'cdr auto coming from 253' AS cdr_auto_coming
       FROM CDR_HEAD Q
      WHERE TO_CHAR (PROCESS_DATE, 'RRRRMMDDHH24MISS') BETWEEN TO_CHAR (
                                                                    SYSDATE
                                                                  + (  1
                                                                     / 1440
                                                                     * -60),
                                                                  'RRRRMMDDHH24MISS')
                                                           AND TO_CHAR (
                                                                  SYSDATE,
                                                                  'RRRRMMDDHH24MISS')
   GROUP BY TRUNC (PROCESS_DATE), SOURCE
   UNION ALL
     SELECT /*+PARALLEL(Q,16)*/
           TRUNC (PROCESS_DATE) AS PROCESS_DATE,
            SOURCE,
            'msc' AS main_source,
            COUNT (*) AS COUNT,
            'Cdr auto coming from 253' AS cdr_auto_coming
       FROM CDR_HEAD@DWH01TODWH03 Q
      WHERE     TO_CHAR (PROCESS_DATE, 'RRRRMMDDHH24MISS') BETWEEN TO_CHAR (
                                                                        SYSDATE
                                                                      + (  1
                                                                         / 1440
                                                                         * -60),
                                                                      'RRRRMMDDHH24MISS')
                                                               AND TO_CHAR (
                                                                      SYSDATE,
                                                                      'RRRRMMDDHH24MISS')
            AND SOURCE IN ('msc_alu', 'msc_nokia', 'msc_huawei')
   GROUP BY TRUNC (PROCESS_DATE), SOURCE
   UNION ALL
     SELECT /*+PARALLEL(Q,16)*/
           TRUNC (PROCESS_DATE) AS PROCESS_DATE,
            SOURCE,
            'mfs' AS main_source,
            COUNT (*) AS COUNT,
            'cdr auto coming from 253' AS cdr_auto_coming
       FROM CDR_HEAD@DWH01TODWH03 Q
      WHERE     TO_CHAR (PROCESS_DATE, 'RRRRMMDDHH24MISS') BETWEEN TO_CHAR (
                                                                        SYSDATE
                                                                      + (  1
                                                                         / 1440
                                                                         * -60),
                                                                      'RRRRMMDDHH24MISS')
                                                               AND TO_CHAR (
                                                                      SYSDATE,
                                                                      'RRRRMMDDHH24MISS')
            AND SOURCE IN ('smsc', 'ussd', 'cgw')
   GROUP BY TRUNC (PROCESS_DATE), SOURCE
   UNION ALL
     SELECT /*+PARALLEL(Q,16)*/
           TRUNC (PROCESS_DATE) AS PROCESS_DATE,
            SOURCE,
            'evc' AS main_source,
            COUNT (*) AS COUNT,
            'Cdr auto coming from source' AS cdr_auto_coming
       FROM CDR_HEAD@DWH01TODWH02 Q
      WHERE     TO_CHAR (PROCESS_DATE, 'RRRRMMDDHH24MISS') BETWEEN TO_CHAR (
                                                                        SYSDATE
                                                                      + (  1
                                                                         / 1440
                                                                         * -600),
                                                                      'RRRRMMDDHH24MISS')
                                                               AND TO_CHAR (
                                                                      SYSDATE,
                                                                      'RRRRMMDDHH24MISS')
            AND SOURCE IN ('evcTRA', 'evcREC')
   GROUP BY TRUNC (PROCESS_DATE), SOURCE
   UNION ALL
     SELECT /*+PARALLEL(Q,16)*/
           TRUNC (PROCESS_DATE) AS PROCESS_DATE,
            SOURCE,
            'alarm' AS main_source,
            COUNT (*) AS COUNT,
            'Cdr auto coming from source' AS cdr_auto_coming
       FROM CDR_HEAD@DWH01TODWH02 Q
      WHERE     TO_CHAR (PROCESS_DATE, 'RRRRMMDDHH24MISS') BETWEEN TO_CHAR (
                                                                        SYSDATE
                                                                      + (  1
                                                                         / 1440
                                                                         * -60),
                                                                      'RRRRMMDDHH24MISS')
                                                               AND TO_CHAR (
                                                                      SYSDATE,
                                                                      'RRRRMMDDHH24MISS')
            AND SOURCE = 'alarm'
   GROUP BY TRUNC (PROCESS_DATE), SOURCE
   UNION ALL
     SELECT /*+PARALLEL(Q,16)*/
           TRUNC (PROCESS_DATE) AS PROCESS_DATE,
            SOURCE,
            'ipdr' AS main_source,
            COUNT (*) AS COUNT,
            'Cdr auto coming from source' AS cdr_auto_coming
       FROM CDR_HEAD@DWH01TODWH02 Q
      WHERE     TO_CHAR (PROCESS_DATE, 'RRRRMMDDHH24MISS') BETWEEN TO_CHAR (
                                                                        SYSDATE
                                                                      + (  1
                                                                         / 1440
                                                                         * -60),
                                                                      'RRRRMMDDHH24MISS')
                                                               AND TO_CHAR (
                                                                      SYSDATE,
                                                                      'RRRRMMDDHH24MISS')
            AND SOURCE IN ('HuaweiUDN', 'HuaweiUDN2')
   GROUP BY TRUNC (PROCESS_DATE), SOURCE)
   ORDER BY MAIN_SOURCE,SOURCE;


