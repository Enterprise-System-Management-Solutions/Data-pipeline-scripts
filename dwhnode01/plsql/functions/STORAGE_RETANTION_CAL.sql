--
-- STORAGE_RETANTION_CAL  (Function) 
--
CREATE OR REPLACE FUNCTION DWH_USER.STORAGE_RETANTION_CAL (TABLE_NAME IN VARCHAR2) RETURN VARCHAR2 IS

OUTPUT VARCHAR2(30);
BEGIN

SELECT SEGMENT_NAME||'|'||GB INTO OUTPUT
FROM
(
select
    SEGMENT_NAME,
    sum(BYTES)/1024/1024/1024/5 GB
from
    SYS.dba_segments
    where SEGMENT_NAME =TABLE_NAME
    and PARTITION_NAME in (SELECT TABLE_NAME||'_'||DATE_KEY FROM DATE_DIM WHERE TRUNC(DATE_VALUE)BETWEEN TRUNC(SYSDATE-6) AND TRUNC(SYSDATE-1))
    group by SEGMENT_NAME
    );
    
RETURN OUTPUT;
END;
/
