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
 WHERE source='crm_res_msisdn'
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
 WHERE source='crm_res_msisdn'
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

INSERT INTO L1_CRM_RES_MSISDN(PROCESSED_DATE,FILE_NAME,CM1_RES_ID,CM2_RES_CODE,CM3_VENDER_ID,CM4_MODEL_ID,CM5_CATEGORY_ID,CM6_DNSEQ,CM7_CREATE_DATE,CM8_VALID_DATE,CM9_INVALID_DATE,CM10_DEPT_ID,CM11_PERSON,CM12_LEVEL_ID,CM13_IS_BIND,CM14_PACKAGE_MODE,CM15_PACKAGE_ID,CM16_RES_STATUS_ID,CM17_IS_LOCKED,CM18_IS_RECYCLED,CM19_OPER_DATE,CM20_OPER_ID,CM21_ORDER_STATUS,CM22_MSISDN,CM23_HLR_CODE,CM24_PROD_ID,CM25_SIM_CARD_NO,CM26_MNP_STATUS,CM27_LOCAL_LAN,CM28_LAN_HLR,CM29_PAYMENT_MODE,CM30_BATCH_ID,CM31_TELE_TYPE,CM32_LOTID,CM33_WARRANTY_PERIOD,CM34_MDN_TYPE,CM35_PREFIX,CM36_PRICE,CM37_ISSHEDULED,CM38_OUTSCHEDULE_DATE,CM39_CITY,CM40_HLR_NEW,CM41_INFO1,CM42_INFO2,CM43_INFO3,CM44_INFO4,CM45_INFO5,CM46_INFO6,CM47_INFO7,CM48_INFO8,CM49_RNO,CM50_DNO,CM51_PORTOUT_OPTION,CM52_MVNO_ID)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',RES_ID,RES_CODE,VENDER_ID,MODEL_ID,CATEGORY_ID,DNSEQ,CREATE_DATE,VALID_DATE,INVALID_DATE,DEPT_ID,PERSON,LEVEL_ID,IS_BIND,PACKAGE_MODE,PACKAGE_ID,RES_STATUS_ID,IS_LOCKED,IS_RECYCLED,OPER_DATE,OPER_ID,ORDER_STATUS,MSISDN,HLR_CODE,PROD_ID,SIM_CARD_NO,MNP_STATUS,LOCAL_LAN,LAN_HLR,PAYMENT_MODE,BATCH_ID,TELE_TYPE,LOTID,WARRANTY_PERIOD,MDN_TYPE,PREFIX,PRICE,ISSHEDULED,OUTSCHEDULE_DATE,CITY,HLR_NEW,INFO1,INFO2,INFO3,INFO4,INFO5,INFO6,INFO7,INFO8,RNO,DNO,PORTOUT_OPTION,MVNO_ID
FROM CRM_RS_MSISDN_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_res_msisdn'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_crm_res_msisdn  export lock

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
sh esms_crm_rse_msisdn_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

