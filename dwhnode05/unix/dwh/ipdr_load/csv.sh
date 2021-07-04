PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode05
export ORACLE_UNQNAME=dwhdb05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb05
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

dt=`date -d yesterday  '+%d%m%Y'`
xdir=/tmp/ipdr_$dt.csv

ipdr()
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
select /*+PARALLEL(a,8)*/ IP5_MSISDN||'|'||IP14_RAT_TYPE||'|'||IP17_CGI||'|'||IP18_SAI||'|'||IP20_TAI||'|'||IP21_ECGI
as "IP5_MSISDN|IP14_RAT_TYPE|IP17_CGI|IP18_SAI|IP20_TAI|IP21_ECGI"
from L1_HUAWEIUDN  
where IP8_SERVER_IP='104.26.8.93'
and ((IP14_RAT_TYPE=1 and IP24_DOWNLINK_TRAFFIC >=1000)
or (IP14_RAT_TYPE=2 and IP24_DOWNLINK_TRAFFIC >=1000)
or (IP14_RAT_TYPE=3 and IP24_DOWNLINK_TRAFFIC >=1000)
or ((IP14_RAT_TYPE=6 and IP24_DOWNLINK_TRAFFIC >=1000) and IP21_ECGI is not null))
and  PROCESSED_DATE=(SELECT DATE_VALUE FROM DATE_DIM WHERE DATE_VALUE = TO_DATE (SYSDATE-1, 'DD/MM/RRRR'))
group by IP5_MSISDN,IP14_RAT_TYPE,IP17_CGI,IP18_SAI,IP20_TAI,IP21_ECGI
/
EXIT
EOF
}

ipdr $xdir
echo "$xdir"

