--
-- F_PARTITION_VOU  (Function) 
--
CREATE OR REPLACE FUNCTION DWH_USER.F_PARTITION_VOU RETURN VARCHAR2 IS
    VPRE_COUNT  NUMBER;
    VPARTITION_NAME VARCHAR2(100);
BEGIN
    --Function created Tareq-10/05/2020 fro drop old partition---
    SELECT COUNT(*) INTO VPRE_COUNT
    FROM ALL_TAB_PARTITIONS
    WHERE TABLE_NAME='L1_RECHARGE';
    
    IF VPRE_COUNT > 60 THEN
        SELECT PARTITION_NAME into VPARTITION_NAME
        from
        (SELECT PARTITION_NAME,PARTITION_POSITION,ROW_NUMBER () OVER (ORDER BY PARTITION_POSITION ASC) LS
        FROM ALL_TAB_PARTITIONS
        WHERE TABLE_NAME='L1_RECHARGE')
        where ls =1;
    END IF;
    
    RETURN VPARTITION_NAME;
   
END;
/

