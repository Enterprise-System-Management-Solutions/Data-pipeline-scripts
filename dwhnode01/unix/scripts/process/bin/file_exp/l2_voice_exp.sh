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

xdate=`sqlplus -s dwh_user/dwh_user_123 <<EOF
SET echo off
SET head off
SET feedback off
select date_key from date_dim where trunc(date_value)=trunc(sysdate-1);
EOF`


dt=`date -d yesterday '+%Y%m%d'`
xdir=/data02/l2_csv_export_dump/l2_voice_$dt.csv

C_hadoop_OUT()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
set echo off
set head off
set feedback off
set trimspool on
set headsep off
set termout off
set underline off
set linesize 32000;
set pages 0;
spool $1
select /*+ PARALLEL (A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||V24_SERVICE_CATEGORY||'~'||V25_USAGE_SERVICE_TYPE||'~'||V35_RATE_USAGE||'~'||V36_SERVICE_UNIT_TYPE||'~'||V41_DEBIT_AMOUNT
||'~'||V44_DEBIT_FROM_ADVANCE_PRE||'~'||V49_PAY_FREE_UNIT_TIMES||'~'||V50_PAY_FREE_UNIT_DURATION||'~'||V55_CUR_BALANCE||'~'||V372_CALLINGPARTYNUMBER||'~'||V373_CALLEDPARTYNUMBER
||'~'||V378_SERVICEFLOW||'~'||V380_CALLINGROAMINFO||'~'||V381_CALLINGCELLID||'~'||V383_CALLEDCELLID||'~'||V386_BEARERCAPABILITY||'~'||V387_CHARGINGTIME_HOUR
||'~'||V389_TERMINATIONREASON||'~'||V391_IMEI||'~'||V394_REDIRECTINGPARTYID||'~'||V395_MSCADDRESS||'~'||V397_MAINOFFERINGID||'~'||V400_PAYTYPE||'~'||V403_ROAMSTATE
||'~'||V405_CALLINGHOMEAREANUMBER||'~'||V417_HOTLINEINDICATOR||'~'||V425_CALLINGNETWORKTYPE||'~'||V434_ONLINECHARGINGFLAG||'~'||V457_PREPAID_BALANCE||'~'||V476_ONNETINDICATOR
||'~'||V402_CALLTYPE||'~'||V436_LASTEFFECTOFFERING||'~'||V387_CHARGINGTIME_KEY as querys
from L2_VOICE A
WHERE ETL_DATE_KEY=$2
/
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $xdate
echo "$xdir"

