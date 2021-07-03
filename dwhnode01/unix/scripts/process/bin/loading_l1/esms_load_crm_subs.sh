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
SELECT '/data02/crm_dump_dir/inf_subscriber_all/process_dir'||','||'/data02/crm_dump_dir/inf_subscriber_all/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='crm_subs'
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
 WHERE source='crm_subs'
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
INSERT INTO L1_CRM_SUBSCRIBER(PROCESSED_DATE,FILE_NAME,CS1_SUB_ID,CS2_CUST_ID,CS3_ACTUAL_CUST_ID,CS4_SUB_TYPE,CS5_SUBGROUP_TYPE,CS6_SUBGROUP_NAME,CS7_TELE_TYPE,CS8_PREPAID_FLAG,CS9_MSISDN,CS10_IMSI,CS11_ICCID,CS12_SUB_PASSWORD,CS13_SUB_LAN,CS14_SUB_LEVEL,CS15_SUB_GROUP,CS16_SUB_SEGMENT,CS17_DUN_FLAG,CS18_DUN_START_DATE,CS19_DUN_EXPIRY_DATE,CS20_SUB_INIT_CREDIT,CS21_SUB_CREDIT,CS22_SUB_STATE,CS23_SUB_STATE_REASON,CS24_AGREEMENT_NO,CS25_CREATE_DATE,CS26_AGREEMENT_DATE,CS27_FIRST_EFF_DATE,CS28_EFF_DATE,CS29_EXP_DATE,CS30_MOD_DATE,CS31_ACTIVE_DATE,CS32_LATEST_ACTIVE_DATE,CS33_CREATE_OPER_ID,CS34_CREATE_LOCAL_ID,CS35_BUSI_SEQ,CS36_REMARK,CS37_PARTITION_ID,CS38_SUB_INIT_CREDIT_ID,CS39_VIRTUAL_SUB_ID,CS40_CPE_MAC,CS41_RESERVE_RECONN_TIME,CS42_DEALER_ID,CS43_INFO1,CS44_INFO2,CS45_INFO3,CS46_INFO4,CS47_INFO5,CS48_INFO6,CS49_INFO7,CS50_INFO8,CS51_INFO9,CS52_INFO10,CS53_INFO11,CS54_INFO12,CS55_RELA_MSISDN,CS56_USERNAME,CS57_BRAND_ID,CS58_DISPLAY_TYPE,CS59_MVNO_ID,CS60_HLR_FLAG,CS61_SENDER)
(SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',SUB_ID,CUST_ID,ACTUAL_CUST_ID,SUB_TYPE,SUBGROUP_TYPE,SUBGROUP_NAME,TELE_TYPE,PREPAID_FLAG,MSISDN,IMSI,ICCID,SUB_PASSWORD,SUB_LAN,SUB_LEVEL,SUB_GROUP,SUB_SEGMENT,DUN_FLAG,DUN_START_DATE,DUN_EXPIRY_DATE,SUB_INIT_CREDIT,SUB_CREDIT,SUB_STATE,SUB_STATE_REASON,AGREEMENT_NO,CREATE_DATE,AGREEMENT_DATE,FIRST_EFF_DATE,EFF_DATE,EXP_DATE,MOD_DATE,ACTIVE_DATE,LATEST_ACTIVE_DATE,CREATE_OPER_ID,CREATE_LOCAL_ID,BUSI_SEQ,REMARK,PARTITION_ID,SUB_INIT_CREDIT_ID,VIRTUAL_SUB_ID,CPE_MAC,RESERVE_RECONN_TIME,DEALER_ID,INFO1,INFO2,INFO3,INFO4,INFO5,INFO6,INFO7,INFO8,INFO9,INFO10,INFO11,INFO12,RELA_MSISDN,USERNAME,BRAND_ID,DISPLAY_TYPE,MVNO_ID,HLR_FLAG,SENDER
FROM CRM_SUBS_EXT)
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_subs'
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
sh esms_crm_subs_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

