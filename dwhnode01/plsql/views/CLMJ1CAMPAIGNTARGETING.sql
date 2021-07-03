--
-- CLMJ1CAMPAIGNTARGETING  (View) 
--
CREATE OR REPLACE FORCE VIEW DWH_USER.CLMJ1CAMPAIGNTARGETING
(V372_CALLINGPARTYNUMBER, G372_CALLINGPARTYNUMBER, S22_PRI_IDENTITY, TOTAL_REVENUE)
BEQUEATH DEFINER
AS 
SELECT V372_CALLINGPARTYNUMBER,
          
          G372_CALLINGPARTYNUMBER,
          
          S22_PRI_IDENTITY,
          
            COALESCE (A.REVENUE1, 0)
          + COALESCE (B.REVENUE2, 0)
          + COALESCE (C.REVENUE3, 0)
             AS TOTAL_REVENUE
     FROM (  SELECT V372_CALLINGPARTYNUMBER,
                   
                    SUM (V41_DEBIT_AMOUNT) REVENUE1
               FROM L3_VOICE
              WHERE ETL_DATE_KEY IN (SELECT A.DATE_KEY
                                       FROM DATE_DIM A
                                      WHERE A.DATE_VALUE >
                                               TO_DATE (SYSDATE - 15,
                                                        'DD/MM/RRRR'))
           GROUP BY  V372_CALLINGPARTYNUMBER) A
          FULL JOIN
          (  SELECT G372_CALLINGPARTYNUMBER,
                   
                    SUM (G41_DEBIT_AMOUNT) REVENUE2
               FROM L3_DATA
              WHERE ETL_DATE_KEY IN (SELECT A.DATE_KEY
                                       FROM DATE_DIM A
                                      WHERE A.DATE_VALUE >
                                               TO_DATE (SYSDATE - 15,
                                                        'DD/MM/RRRR'))
           GROUP BY  G372_CALLINGPARTYNUMBER) B
             ON  
                B.G372_CALLINGPARTYNUMBER = A.V372_CALLINGPARTYNUMBER
          FULL JOIN
          (  SELECT S22_PRI_IDENTITY,
                   
                    SUM (S41_DEBIT_AMOUNT) REVENUE3
               FROM L3_SMS
              WHERE ETL_DATE_KEY IN (SELECT A.DATE_KEY
                                       FROM DATE_DIM A
                                      WHERE A.DATE_VALUE >
                                               TO_DATE (SYSDATE - 15,
                                                        'DD/MM/RRRR'))
           GROUP BY S22_PRI_IDENTITY) C
             ON     (   C.S22_PRI_IDENTITY = A.V372_CALLINGPARTYNUMBER
                     OR C.S22_PRI_IDENTITY = B.G372_CALLINGPARTYNUMBER);


