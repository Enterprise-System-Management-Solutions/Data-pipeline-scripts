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
SELECT '/data02/crm_dump_dir/res_msisdn/process_dir'||','||'/data02/crm_dump_dir/res_msisdn/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='crm_products'
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
 WHERE source='crm_products'
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

INSERT INTO L1_CRM_PRODUCTS(PROCESSED_DATE,FILE_NAME,CP1_PRODUCT_SEQ,CP2_SUB_ID,CP3_PRODUCT_TYPE,CP4_PRODUCT_ID,CP5_MONTHLY_FEE,CP6_RATEPLAN_TYPE,CP7_BOUNDLE_FLAG,CP8_BOUNDLE_ID,CP9_STATUS,CP10_CREATE_DATE,CP11_AMOUNT,CP12_VALID_FLAG,CP13_EFF_DATE,CP14_EXP_DATE,CP15_REASON,CP16_BUSI_TYPE,CP17_BUSI_SEQ,CP18_REMARK,CP19_ISVALIDINBILLCYCLE,CP20_BILL_CYCLE_ID,CP21_PARTITION_ID,CP22_PROD_BUNDLE_SEQ,CP23_SUBSCRIBE_CHANNEL,CP24_UNSUBSCRIBE_CHANNEL,CP25_SUB_STATUS,CP26_MVNO_ID,CP27_PARELLEL_STATUS)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',PRODUCT_SEQ,SUB_ID,PRODUCT_TYPE,PRODUCT_ID,MONTHLY_FEE,RATEPLAN_TYPE,BOUNDLE_FLAG,BOUNDLE_ID,STATUS,CREATE_DATE,AMOUNT,VALID_FLAG,EFF_DATE,EXP_DATE,REASON,BUSI_TYPE,BUSI_SEQ,REMARK,ISVALIDINBILLCYCLE,BILL_CYCLE_ID,PARTITION_ID,PROD_BUNDLE_SEQ,SUBSCRIBE_CHANNEL,UNSUBSCRIBE_CHANNEL,SUB_STATUS,MVNO_ID,PARELLEL_STATUS
FROM CRM_PRODUCTS_EXT 
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_products'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_crm_products  export lock

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
sh esms_crm_products_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

