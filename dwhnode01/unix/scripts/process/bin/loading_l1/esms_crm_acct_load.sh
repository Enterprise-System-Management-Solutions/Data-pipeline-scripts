#Author :       Tareq
#Date   :       28-05-2020
#!/bin/bash

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

# This function lists files after mediation and status is =30

get_smsc_files()
{

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET head off
SET feedback off
SET pagesize 0
SET verify off
SET linesize 400
SELECT '/data02/crm_dump_dir/inf_customer_all/process_dir'||','||'/data02/crm_dump_dir/inf_customer_all/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='crm_acct'
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
 WHERE source='crm_acct'
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

INSERT INTO L1_CRM_INF_ACCT (PROCESSED_DATE,FILE_NAME,CA1_ACCT_ID,CA2_CUST_ID,CA3_TELE_TYPE,CA4_ACCT_CODE,CA5_ACCT_TYPE,CA6_PAYMENT_NO,CA7_PAYMENT_MODE,CA8_BILL_CYCLE_TYPE,CA9_CONVERGE_FLAG,CA10_TITLE,CA11_NAME1,CA12_NAME2,CA13_NAME3,CA14_NAME4,CA15_ADDRESS_SEQ,CA16_CURRENCY_ID,CA17_LANG,CA18_PASSWORD,CA19_INIT_BALANCE,CA20_ORIGN_CREDIT,CA21_CREDIT_LIMIT,CA22_SUPPRESS_BILL,CA23_SUPPRESS_EXP_DATE,CA24_DIVERT_BILL,CA25_DIVERT_EXP_DATE,CA26_CREATE_DATE,CA27_EFF_DATE,CA28_EXP_DATE,CA29_MOD_DATE,CA30_CREATE_OPER_ID,CA31_CREATE_LOCAL_ID,CA32_BUSI_SEQ,CA33_LBC_DATE,CA34_STATUS,CA35_REMARK,CA36_ACCT_INIT_CREDIT_ID,CA37_PARTITION_ID,CA38_CREDIT_TYPE,CA39_BILL_TMPL_ID,CA40_SYNC_OCS,CA41_OWNERSHIP_TAX_FLAG,CA42_BILLING_GROUP,CA43_ACCT_CATEGORY,CA44_PAN,CA45_MVNO_ID,CA46_SHOW_TAX_FLAG,CA47_PAYMENT_METHOD,CA48_WARNING_LEVEL,CA49_DEALER_MACHINE_ID,CA50_INFO1,CA51_INFO2,CA52_INFO3,CA53_INFO4,CA54_INFO5,CA55_INFO6,CA56_INFO7,CA57_INFO8,CA58_INFO9,CA59_INFO10)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',ACCT_ID,CUST_ID,TELE_TYPE,ACCT_CODE,ACCT_TYPE,PAYMENT_NO,PAYMENT_MODE,BILL_CYCLE_TYPE,CONVERGE_FLAG,TITLE,NAME1,NAME2,NAME3,NAME4,ADDRESS_SEQ,CURRENCY_ID,LANG,PASSWORD,INIT_BALANCE,ORIGN_CREDIT,CREDIT_LIMIT,SUPPRESS_BILL,SUPPRESS_EXP_DATE,DIVERT_BILL,DIVERT_EXP_DATE,CREATE_DATE,EFF_DATE,EXP_DATE,MOD_DATE,CREATE_OPER_ID,CREATE_LOCAL_ID,BUSI_SEQ,LBC_DATE,STATUS,REMARK,ACCT_INIT_CREDIT_ID,PARTITION_ID,CREDIT_TYPE,BILL_TMPL_ID,SYNC_OCS,OWNERSHIP_TAX_FLAG,BILLING_GROUP,ACCT_CATEGORY,PAN,MVNO_ID,SHOW_TAX_FLAG,PAYMENT_METHOD,WARNING_LEVEL,DEALER_MACHINE_ID,INFO1,INFO2,INFO3,INFO4,INFO5,INFO6,INFO7,INFO8,INFO9,INFO10
FROM CRM_ACCCT_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_acct'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_crm_inf_acct  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/process/bin/loading_l1
sh esms_crm_acct_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

