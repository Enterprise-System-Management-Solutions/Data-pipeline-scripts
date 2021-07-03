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

xdir=/data02/l2_csv_export_dump/l2_data_$dt.csv

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
SELECT /*+ PARALLEL (A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||G41_DEBIT_AMOUNT||'~'||G51_FREE_UNIT_AMOUNT_OF_FLUX||'~'||G372_CALLINGPARTYNUMBER||'~'||G375_CALLINGPARTYIMSI||'~'||G379_CALLINGCELLID||'~'||G383_CHARGINGTIME_HOUR||'~'||G384_TOTALFLUX||'~'||G388_IMEI||'~'||G389_SERVICEID||'~'||G401_MAINOFFERINGID||'~'||G403_PAYTYPE||'~'||G404_CHARGINGTYPE||'~'||G412_SERVICETYPE||'~'||G418_LASTEFFECTOFFERING||'~'||G429_RATTYPE||'~'||G430_CHARGEPARTYINDICATOR||'~'||G432_PRIMARYOFFERCHGAMT||'~'||G435_TAXINFO||'~'||G446_PAY_FREE_UNIT_FLUX||'~'||G447_PAY_FREE_UNIT_DURATION||'~'||G448_PAY_DEBIT_AMOUNT||'~'||G449_PAY_DEBIT_FROM_PREPAID||'~'||G450_PAY_PREPAID_BALANCE||'~'||G453_PAY_POSTPAID_BALANCE||'~'||G455_SUBSCRIBERIDTYPE||'~'||G467_ACCUMLATEDPOINT||'~'||G383_CHARGINGTIME_KEY
as querys
FROM L2_DATA A
WHERE ETL_DATE_KEY=(select date_key from date_dim where to_char(date_value,'rrrrmmdd')=$2);
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $dt
echo "$xdir"
