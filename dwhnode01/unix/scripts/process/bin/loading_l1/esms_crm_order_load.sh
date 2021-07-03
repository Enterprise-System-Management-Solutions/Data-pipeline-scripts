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
SELECT '/data02/crm_dump_dir/his_orderinfo/process_dir'||','||'/data02/crm_dump_dir/his_orderinfo/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='crm_order'
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
 WHERE source='crm_order'
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

INSERT INTO L1_CRM_ORDERINFO(PROCESSED_DATE,FILE_NAME,CO1_TRACE_ID,CO2_ORDER_NO,CO3_WF_TPL_ID,CO4_PARENT_ORDER_NO,CO5_ORDER_TYPE,CO6_ORDER_SUB_TYPE,CO7_TELE_TYPE,CO8_PREPAID_FLAG,CO9_BUSI_SEQ,CO10_CUST_ID,CO11_SUB_ID,CO12_GROUP_SUB_ID,CO13_ACCT_ID,CO14_MSISDN,CO15_ICCID,CO16_IMSI,CO17_ORDER_PRI,CO18_ORDER_SOURCE,CO19_DISPATCH_DATE,CO20_COMPLETE_DATE,CO21_WANTED_FINISH_DATE,CO22_START_DATE,CO23_IS_VALID_BILLCYCLE,CO24_VALID_BILLCYCLE_ID,CO25_UNDO_DATE,CO26_IS_PAID,CO27_IS_CHECKED,CO28_ORDER_RUN_STATE,CO29_ORDER_STATE,CO30_ABNORMAL_REASON,CO31_ORDER_CREATE_DATE,CO32_ORDER_OPER,CO33_ORDER_DEPT,CO34_ORDER_LOCAL_ID,CO35_REMARK,CO36_PARTITION_ID,CO37_PROCESS_ID,CO38_WORK_ITEM,CO39_CLIENT_IP,CO40_ISAP_ERR_FLAG,CO41_CO_LOCK,CO42_RELA_ORDER_NO,CO43_CANCEL_ORDER_NO,CO44_MVNO_ID)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',TRACE_ID,ORDER_NO,WF_TPL_ID,PARENT_ORDER_NO,ORDER_TYPE,ORDER_SUB_TYPE,TELE_TYPE,PREPAID_FLAG,BUSI_SEQ,CUST_ID,SUB_ID,GROUP_SUB_ID,ACCT_ID,MSISDN,ICCID,IMSI,ORDER_PRI,ORDER_SOURCE,DISPATCH_DATE,COMPLETE_DATE,WANTED_FINISH_DATE,START_DATE,IS_VALID_BILLCYCLE,VALID_BILLCYCLE_ID,UNDO_DATE,IS_PAID,IS_CHECKED,ORDER_RUN_STATE,ORDER_STATE,ABNORMAL_REASON,ORDER_CREATE_DATE,ORDER_OPER,ORDER_DEPT,ORDER_LOCAL_ID,REMARK,PARTITION_ID,PROCESS_ID,WORK_ITEM,CLIENT_IP,ISAP_ERR_FLAG,CO_LOCK,RELA_ORDER_NO,CANCEL_ORDER_NO,MVNO_ID
FROM CRM_ORDER_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_order'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_crm_subs  export lock

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
sh esms_crm_order_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

