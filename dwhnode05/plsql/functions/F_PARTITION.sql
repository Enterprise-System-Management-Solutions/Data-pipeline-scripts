--
-- F_PARTITION  (Function) 
--
CREATE OR REPLACE FUNCTION DWH_USER.F_PARTITION RETURN VARCHAR2 IS
    VPRE_COUNT  NUMBER;
    VPARTITION_NAME VARCHAR2(100);
BEGIN
    --Function created Tareq-10/05/2020 fro drop old partition---
    SELECT COUNT(*) INTO VPRE_COUNT
    FROM ALL_TAB_PARTITIONS
    WHERE TABLE_NAME='L1_HUAWEIUDN';
    
    IF VPRE_COUNT > 1 THEN
        SELECT MIN(PARTITION_NAME) INTO VPARTITION_NAME
        FROM ALL_TAB_PARTITIONS
        WHERE TABLE_NAME='L1_HUAWEIUDN';
    END IF;
    
    RETURN VPARTITION_NAME;
   
END;
/
