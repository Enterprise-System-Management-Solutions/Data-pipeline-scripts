--
-- SP_FAILOUR_UPDATE  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.SP_FAILOUR_UPDATE IS
   VCOUNT   NUMBER;
BEGIN
   SELECT COUNT (*)
     INTO VCOUNT
     FROM CDR_HEAD
    WHERE     PROCESS_STATUS IN ('32', '34')
          AND TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 2)
                                       AND TRUNC (SYSDATE - 1);


   IF VCOUNT != 0
   THEN
   
        INSERT INTO CDR_HEAD_UPDATE_LOG
        SELECT * 
        FROM CDR_HEAD
        WHERE     PROCESS_STATUS IN ('32', '34')
        AND TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 2) AND TRUNC (SYSDATE - 1);
        COMMIT;
   
      -------if find any failour cdr then execute this script;------------
      UPDATE CDR_HEAD
         SET PROCESS_STATUS = 30
       WHERE     PROCESS_STATUS IN ('32', '34')
             AND TRUNC (PROCESS_DATE) BETWEEN TRUNC (SYSDATE - 2)
                                          AND TRUNC (SYSDATE - 1);

      COMMIT;
   END IF;
END;
/

