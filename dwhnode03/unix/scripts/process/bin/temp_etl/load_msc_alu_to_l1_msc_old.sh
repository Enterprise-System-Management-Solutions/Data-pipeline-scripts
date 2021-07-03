#Author :       Tareq
#Date   :       06-08-2020
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
set sqlblanklines on
WHENEVER SQLERROR EXIT SQL.SQLCODE

INSERT INTO L1_MSC (PROCESSED_DATE, FILE_NAME, M01_CALLTYPE, M02_IMSI, M03_IMEI, M04_MSISDNAPARTY, M05_MSISDNBPARTY, M06_FORWARDEDMSISDN, M07_ANSWERTIMESTAMP, M08_CALLDUR, M09_LOCATION, M10_LAST_LOCATION, M11_CAUSEOFTERMINATION)
SELECT  PROCESSED_DATE,FILE_NAME, MA01_CALLTYPE, MA02_IMSI, IMEI, MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN,MA07_ANSWERTIMESTAMP, MA08_CALLDUR, LOCATION, MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION
FROM
(SELECT PROCESSED_DATE,FILE_NAME, MA01_CALLTYPE, MA02_IMSI, MA03_IMEI, MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN,MA07_ANSWERTIMESTAMP, MA08_CALLDUR, M09_LOCATION, MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION,
CASE
WHEN LENGTH(MA03_IMEI)>13
THEN MA03_IMEI
WHEN LENGTH(MA03_IMEI)<14
THEN NULL

END IMEI,

CASE
WHEN LENGTH(M09_LOCATION)=15
THEN M09_LOCATION
WHEN LENGTH(M09_LOCATION)!=15
THEN NULL

END LOCATION

FROM
(SELECT /*+ PARALLEL (A,16) */ TO_DATE(TO_CHAR(SYSDATE-1, 'MM/DD/YYYY'), 'MM/DD/YYYY')AS PROCESSED_DATE,FILE_NAME, decode(MA01_CALLTYPE,'MT SMS','SMSMT','MO SMS','SMSMO',MA01_CALLTYPE)MA01_CALLTYPE, MA02_IMSI, MA03_IMEI, LPAD(MA04_MSISDNAPARTY,13,880) AS MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN, '20'||MA07_ANSWERTIMESTAMP AS MA07_ANSWERTIMESTAMP, MA08_CALLDUR, LPAD(MA09_AREACODE||MA10_CELLID,15,47004) AS M09_LOCATION, LPAD(MA12_LAST_LOCATION,15,47004) AS MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION
FROM L1_MSC_ALU A
WHERE MA04_MSISDNAPARTY is not null
and MA05_MSISDNBPARTY is not null
and MA07_ANSWERTIMESTAMP is not null)
)
GROUP BY PROCESSED_DATE,FILE_NAME, MA01_CALLTYPE, MA02_IMSI, IMEI, MA04_MSISDNAPARTY, MA05_MSISDNBPARTY, MA06_FORWARDEDMSISDN,MA07_ANSWERTIMESTAMP, MA08_CALLDUR, LOCATION, MA12_LAST_LOCATION, MA11_CAUSEOFTERMINATION
;
COMMIT;
EXIT
EOF