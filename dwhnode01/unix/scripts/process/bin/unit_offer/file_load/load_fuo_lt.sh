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


# This function changes the status of files where errors where encountered to 34
updateOnError()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
UPDATE cdr_head
   SET process_status=34
 WHERE file_name='$1'
   AND process_status=30
/
COMMIT
/
EXIT
EOF
}

# This function lists files (SMSC) after mediation and status is =30

get_smsc_files()
{

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET head off
SET feedback off
SET pagesize 0
SET verify off
SET linesize 400
SELECT '/data02/unit_offer/log_trx/process_dir'||','||'/data02/unit_offer/log_trx/process_dir'||file_name||','||file_name||','||file_id
  FROM cdr_head
  WHERE source='fuo_lt'
   AND process_status=30
   and rownum < 100
/
EOF
}


createSMSCUpdate()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE

UPDATE cdr_head
   SET process_status=32
 WHERE source='fuo_lt'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

insertSMSCUpdate()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
INSERT INTO L1_FUO_LOG_TRX(PROCESSED_DATE, FILE_NAME, LOG_ID, CUST_ID, ACCT_ID, SUB_ID, MSISDN, TELE_TYPE, TRANS_ID, TRANS_TYPE, BATCH_NO, CHANNEL_ID, BSNO, BUSI_TYPE, INVOICE_TYPE, INVOICE_NO, CRDR, TRX_AMT, ADV_AMT, DEP_AMT, BLL_AMT, OS_AMT, OP_CUST_ID, OP_ACCT_ID, OP_SUB_ID, OP_MSISDN, DEPT_ID, OPER_ID, ENTRY_DATE, RECEIPT_NO, PRINT_TIMES, PRINT_DATE, SRC_TRANS_ID, SEQ, REASON_CODE, STATUS, REMARK, PAY_ID, MEASURE_ID, DISCOUNT_LOG_ID, DISCOUNT_AMT, DISCOUNT, AREA_ID, IS_CUSTOMER_BILL)
(SELECT TO_DATE(TO_CHAR(SYSDATE, 'MM/DD/YYYY'), 'MM/DD/YYYY'), '$1',LOG_ID, CUST_ID, ACCT_ID, SUB_ID, MSISDN, TELE_TYPE, TRANS_ID, TRANS_TYPE, BATCH_NO, CHANNEL_ID, BSNO, BUSI_TYPE, INVOICE_TYPE, INVOICE_NO, CRDR, TRX_AMT, ADV_AMT, DEP_AMT, BLL_AMT, OS_AMT, OP_CUST_ID, OP_ACCT_ID, OP_SUB_ID, OP_MSISDN, DEPT_ID, OPER_ID, ENTRY_DATE, RECEIPT_NO, PRINT_TIMES, PRINT_DATE, SRC_TRANS_ID, SEQ, REASON_CODE, STATUS, REMARK, PAY_ID, MEASURE_ID, DISCOUNT_LOG_ID, DISCOUNT_AMT, DISCOUNT, AREA_ID, IS_CUSTOMER_BILL FROM FUO_LOG_TRX_EXT)
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='fuo_lt'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_fuo_dic_payment_method_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/process/bin/unit_offer/file_load
sh create_fuo_lt_ext.sh $v3 
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi
