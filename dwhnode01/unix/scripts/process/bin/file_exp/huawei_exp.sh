PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode01
export ORACLE_UNQNAME=dwhdb01
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb01
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


lock=/data02/scripts/process/bin/huawei_msc_exp_log  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

dt=`date  '+%Y%m%d%H%M%S'`

xdir=/data02/sftp_msc/huawei_exp/huawei_msc_$dt.csv

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET ECHO OFF
SET WRAP OFF
SET HEAD ON
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET HEADSEP ON
SET TERMOUT OFF
SET UNDERLINE OFF
SET LINESIZE 32000;
SET PAGESIZE 40000;
SET LONG 50000;
SPOOL $xdir
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
SELECT LPAD(MH04_APARTYMSISDN,13,880) AS MSISDN
FROM L1_MSC_HUAWEI
WHERE TO_CHAR(PROCESSED_DATE,'RRRRMMDDHH24MISS') BETWEEN  TO_CHAR(SYSDATE+ (1/1440*-5),'RRRRMMDDHH24MISS') AND TO_CHAR(SYSDATE,'RRRRMMDDHH24MISS')
GROUP BY LPAD(MH04_APARTYMSISDN,13,880)
/
EXIT
EOF

echo "File Exported for $dt"

rm -f $lock

fi



