#Author :       Tareq
#Date   :       16-05-2020
#!/bin/bash


PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode03
export ORACLE_UNQNAME=dwhdb03
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb03
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


sqlplus  -s <<EOF
dwh_user03/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
insert into RECHARGE_LOCATION_FCT
SELECT (SELECT DATE_KEY FROM DATE_DIM WHERE TRUNC(DATE_VALUE)=TRUNC(SYSDATE-1)) as DATE_KEY, MSISDN,M09_LOCATION,CHARGINGTIME
FROM
(
SELECT MSISDN,M09_LOCATION,CHARGINGTIME,RANK ()OVER(PARTITION BY MSISDN ORDER BY CHARGINGTIME ASC )FS
FROM
(select MSISDN,M09_LOCATION,TO_NUMBER(TRIM(LEADING '-' FROM CHARGINGTIME)) as CHARGINGTIME
from
(
SELECT A.MSISDN,A.M09_LOCATION,A.M07_ANSWER_HOUR-B.RE30_ENTRY_HOUR AS CHARGINGTIME
FROM
(SELECT /*+ parallel (A.16)*/ M04_MSISDNAPARTY AS MSISDN,M09_LOCATION ,SUBSTR((M07_ANSWERTIMESTAMP),1,8) AS M07_ANSWERTIMESTAMP ,SUBSTR(M07_ANSWERTIMESTAMP,9,4) AS M07_ANSWER_HOUR
FROM L1_MSC A
WHERE SUBSTR((M07_ANSWERTIMESTAMP),1,8)=(SELECT TO_CHAR(DATE_VALUE,'RRRRMMDD') AS DATE_VALUE FROM DATE_DIM WHERE TO_CHAR(DATE_VALUE,'RRRRMMDD')=TO_CHAR(SYSDATE-1,'RRRRMMDD'))
)A,
(SELECT RE6_PRI_IDENTITY AS MSISDN,RE30_ENTRY_HOUR
FROM L3_RECHARGE@DWH03TODWH05 A
WHERE RE30_ENTRY_DATE_KEY=(SELECT DATE_KEY FROM DATE_DIM WHERE TO_CHAR(DATE_VALUE,'RRRRMMDD')=TO_CHAR(SYSDATE-1,'RRRRMMDD'))
)B
WHERE A.MSISDN=B.MSISDN
)a
union all
select MSISDN,M09_LOCATION,TO_NUMBER(TRIM(LEADING '-' FROM CHARGINGTIME)) as CHARGINGTIME
from
(
SELECT A.MSISDN,A.M09_LOCATION,B.RE30_ENTRY_HOUR-A.M07_ANSWER_HOUR AS CHARGINGTIME
FROM
(SELECT /*+ parallel (A.16)*/ M04_MSISDNAPARTY AS MSISDN,M09_LOCATION ,SUBSTR((M07_ANSWERTIMESTAMP),1,8) AS M07_ANSWERTIMESTAMP ,SUBSTR(M07_ANSWERTIMESTAMP,9,4) AS M07_ANSWER_HOUR
FROM L1_MSC A
WHERE SUBSTR((M07_ANSWERTIMESTAMP),1,8)=(SELECT TO_CHAR(DATE_VALUE,'RRRRMMDD') AS DATE_VALUE FROM DATE_DIM WHERE TO_CHAR(DATE_VALUE,'RRRRMMDD')=TO_CHAR(SYSDATE-1,'RRRRMMDD'))
)A,
(SELECT RE6_PRI_IDENTITY AS MSISDN,RE30_ENTRY_HOUR
FROM L3_RECHARGE@DWH03TODWH05 A
WHERE RE30_ENTRY_DATE_KEY=(SELECT DATE_KEY FROM DATE_DIM WHERE TO_CHAR(DATE_VALUE,'RRRRMMDD')=TO_CHAR(SYSDATE-1,'RRRRMMDD'))
)B
WHERE A.MSISDN=B.MSISDN
)b
)
GROUP BY MSISDN,M09_LOCATION,CHARGINGTIME
)
WHERE FS=1
GROUP BY MSISDN,M09_LOCATION,CHARGINGTIME
/
COMMIT
/
EXIT
EOF
