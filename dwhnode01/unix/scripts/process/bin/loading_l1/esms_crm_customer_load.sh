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
 WHERE source='crm_custom'
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
 WHERE source='crm_custom'
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

INSERT INTO L1_CRM_CUSTOMER (PROCESSED_DATE,FILE_NAME,CC1_CUST_ID,CC2_PARENT_CUST_ID,CC3_CUST_TYPE,CC4_CUST_CLASS,CC5_CUST_CODE,CC6_ID_TYPE,CC7_ID_NUMBER,CC8_CUST_TITLE,CC9_NAME1,CC10_NAME2,CC11_NAME3,CC12_CUST_PWD,CC13_NATION,CC14_CUST_LANG,CC15_CUST_LEVEL,CC16_CUST_SEGMENT,CC17_CUST_STATUS,CC18_CUST_DEFAULT_ACCT,CC19_CREATE_DATE,CC20_EFF_DATE,CC21_EXP_DATE,CC22_MOD_DATE,CC23_CREATE_OPER_ID,CC24_CREATE_LOCAL_ID,CC25_BUSI_SEQ,CC26_REMARK,CC27_SYNC_OCS,CC28_PARTITION_ID,CC29_DEALER,CC30_MEMO_DATE_TYPE,CC31_MEMO_DATE,CC32_AUDIT_STATUS,CC33_AUDIT_DATE,CC34_SERVICE_CATEGORY,CC35_SERVICE_LIMIT_FLAG,CC36_DOCUMENT_STATUS,CC37_DOCUMENT_STATUS_TIME,CC38_CUST_DEPT,CC39_DISTRICT,CC40_DESIGNATION,CC41_MVNO_ID)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',CUST_ID,PARENT_CUST_ID,CUST_TYPE,CUST_CLASS,CUST_CODE,ID_TYPE,ID_NUMBER,CUST_TITLE,NAME1,NAME2,NAME3,CUST_PWD,NATION,CUST_LANG,CUST_LEVEL,CUST_SEGMENT,CUST_STATUS,CUST_DEFAULT_ACCT,CREATE_DATE,EFF_DATE,EXP_DATE,MOD_DATE,CREATE_OPER_ID,CREATE_LOCAL_ID,BUSI_SEQ,REMARK,SYNC_OCS,PARTITION_ID,DEALER,MEMO_DATE_TYPE,MEMO_DATE,AUDIT_STATUS,AUDIT_DATE,SERVICE_CATEGORY,SERVICE_LIMIT_FLAG,DOCUMENT_STATUS,DOCUMENT_STATUS_TIME,CUST_DEPT,DISTRICT,DESIGNATION,MVNO_ID
FROM CRM_CUSTOM_EXT 
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_custom'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_crm_custom  export lock

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
sh esms_crm_customer_exe.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

