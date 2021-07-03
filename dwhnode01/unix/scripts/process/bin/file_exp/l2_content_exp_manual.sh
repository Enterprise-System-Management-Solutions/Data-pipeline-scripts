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

#dt=`date -d yesterday '+%Y%m%d'`

dt=$1

xdir=/data02/l2_csv_export_dump/l2_content_$dt.csv

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
SELECT /*+ PARALLEL (A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||CO4_SPLIT_CDR_REASON||'~'||CO9_STATUS||'~'||CO18_OBJ_TYPE||'~'||CO22_PRI_IDENTITY||'~'||CO24_SERVICE_CATEGORY||'~'||CO25_USAGE_SERVICE_TYPE||'~'||CO41_DEBIT_AMOUNT||'~'||CO372_CALLINGPARTYNUMBER||'~'||CO373_CALLINGPARTYIMSI||'~'||CO374_CHARGINGTYPE||'~'||CO375_CHARGINGUSAGETYPE||'~'||CO382_SERVICETYPE||'~'||CO383_CONTENTTYPE||'~'||CO384_SERVICECAPABILITY||'~'||CO385_PROVISIONTYPE||'~'||CO386_CATEGORYTYPE||'~'||CO388_TIMES||'~'||CO389_DURATION||'~'||CO396_MAINOFFERINGID||'~'||CO402_STARTTIMEOFBILLCYL_HOUR||'~'||CO405_MAINBALANCEINFO||'~'||CO406_CHGBALANCEINFO||'~'||CO407_CHGFREEUNITINFO||'~'||CO410_PAYTYPE||'~'||CO431_PREPAID_BALANCE||'~'||CO432_POSTPAID_BALANCE||'~'||CO402_STARTTIMEOFBILLCYL_KEY 
as my_query
FROM L2_CONTENT A
WHERE ETL_DATE_KEY=(select date_key from date_dim where to_char(date_value,'rrrrmmdd')=$2);
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $dt
echo "$xdir"
