PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode02
export ORACLE_UNQNAME=dwhdb02
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb02
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


dt=`date -d yesterday  '+%d%m%Y'`
xdir=/tmp/corona_16263_ivr_$dt.csv

corona_ivr_16263()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head on
SET feedback off  
set trimspool on 
set headsep on  
set termout off
set underline off
SET LINESIZE 32000;
SET PAGESIZE 40000;
SET LONG 50000; 
--set numw 20000       
spool $1 
SELECT MSISDN||'|'||TIMESTAMP||'|'||LATITUDE||'|'||LONGITUDE||'|'||UPAZILA||'|'||DISTRICT||'|'||NVL(NAME,'NULL')||'|'||DURATION||'|'||LAST3_DAY 
AS "MSISDN|TIMESTAMP|LATITUDE|LONGITUDE|UPAZILA|DISTRICT|NAME|DURATION|LAST3_DAY" FROM COVID_19_16263
/
EXIT
EOF
}

corona_ivr_16263 $xdir
echo "$xdir"
