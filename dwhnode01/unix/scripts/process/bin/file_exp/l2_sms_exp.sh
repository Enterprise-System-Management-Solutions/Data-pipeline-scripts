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
xdir=/data02/l2_csv_export_dump/l2_sms_$dt.csv

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
SELECT /*+ PARALLEL (A,16)*/ ETL_DATE_KEY||'~'||FILE_NAME||'~'||S4_SPLIT_CDR_REASON||'~'||S9_STATUS||'~'||S18_OBJ_TYPE||'~'||S22_PRI_IDENTITY||'~'||S24_SERVICE_CATEGORY||'~'||S41_DEBIT_AMOUNT||'~'||S372_CALLINGPARTYNUMBER||'~'||S373_CALLEDPARTYNUMBER||'~'||S374_CALLINGPARTYIMSI||'~'||S378_SERVICEFLOW||'~'||S379_CALLFORWARDINDICATOR||'~'||S381_CALLINGCELLID||'~'||S387_CHARGINGTIME_HOUR||'~'||S388_SENDRESULT||'~'||S391_SMLENGTH||'~'||S393_REFUNDINDICATOR||'~'||S395_MAINOFFERINGID||'~'||S397_CHARGEPARTYINDICATOR||'~'||S398_PAYTYPE||'~'||S400_SMSTYPE||'~'||S401_ONNETINDICATOR||'~'||S416_SPECIALNUMBERINDICATOR||'~'||S417_NPFLAG||'~'||S418_NPPREFIX||'~'||S434_LASTEFFECTOFFERING||'~'||S438_SPECIALZONEID||'~'||S445_PRIMARYOFFERCHGAMT||'~'||S448_TAXINFO||'~'||S456_DISCOUNTOFLASTEFFOFFERING||'~'||S457_UNROUND||'~'||S459_PREPAID_BALANCE||'~'||S460_POSTPAID_BALANCE||'~'||S479_RATED_OFFER_ID||'~'||S25_USAGE_SERVICE_TYPE||'~'||S402_ROAMSTATE||'~'||S387_CHARGINGTIME_KEY as my_query
FROM L2_SMS
WHERE ETL_DATE_KEY=$2
/
spool off;
EXIT
EOF
}

C_hadoop_OUT $xdir $xdate
echo "$xdir"