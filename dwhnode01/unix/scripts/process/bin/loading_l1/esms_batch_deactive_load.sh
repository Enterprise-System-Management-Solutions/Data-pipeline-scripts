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
 WHERE source='crm_batch_deactive'
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
 WHERE source='crm_batch_deactive'
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

INSERT INTO L1_CRM_BATCH_DEACTIVE_DATA (PROCESSED_DATE,FILE_NAME,CB1_RES_SEQ,CB2_LINE,CB3_TASK_ID,CB4_GROUP_NO,CB5_ORDER_NO,CB6_CREATE_DATE,CB7_STATUS,CB8_STATUS_DATE,CB9_ERR_TYPE,CB10_ERR_MSG,CB11_ORIGINAL_MSG,CB12_MSISDN,CB13_SUB_ID,CB14_EXP_TIME,CB15_ICCID_METHOD,CB16_MSISDN_METHOD,CB17_ICCID_POSITION,CB18_MSISDN_POSITION,CB19_IDLE_FLAG,CB20_ORDERSEQ,CB21_BATCH_ID,CB22_IMSI,CB23_MVNO_ID)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',RES_SEQ,LINE,TASK_ID,GROUP_NO,ORDER_NO,CREATE_DATE,STATUS,STATUS_DATE,ERR_TYPE,ERR_MSG,ORIGINAL_MSG,MSISDN,SUB_ID,EXP_TIME,ICCID_METHOD,MSISDN_METHOD,ICCID_POSITION,MSISDN_POSITION,IDLE_FLAG,ORDERSEQ,BATCH_ID,IMSI,MVNO_ID
FROM CRM_BATCH_DEACTIVE_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_batch_deactive'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_crm_batch_deactive  export lock

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
sh esms_batch_deactive_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

