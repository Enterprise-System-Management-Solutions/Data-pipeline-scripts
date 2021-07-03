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


dt=`date  '+%Y%m%d'`

xdir=/tmp/msisdn_wise_$dt.csv

sqlplus  -s <<EOF
dwh_user03/dwh_user_123
SET ECHO OFF
SET WRAP OFF
SET HEAD on
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET HEADSEP ON
SET TERMOUT OFF
SET UNDERLINE OFF
SET LINESIZE 200
SET PAGESIZE 0
SPOOL $xdir
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
SELECT MSISDN||','||IMEI as "MSISDN,IMEI"
FROM IMEI_FCT
WHERE IMEI != '10'
AND  IMEI IS NOT NULL
GROUP BY MSISDN||','||IMEI
/
EXIT
EOF


