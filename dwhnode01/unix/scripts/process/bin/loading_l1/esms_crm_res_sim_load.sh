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
 WHERE source='crm_res_sim'
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
 WHERE source='crm_res_sim'
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

INSERT INTO L1_CRM_RES_SIM(PROCESSED_DATE,FILE_NAME,CS1_RES_ID,CS2_RES_CODE,CS3_VENDER_ID,CS4_MODEL_ID,CS5_CATEGORY_ID,CS6_DNSEQ,CS7_CREATE_DATE,CS8_VALID_DATE,CS9_INVALID_DATE,CS10_DEPT_ID,CS11_PERSON,CS12_LEVEL_ID,CS13_IS_BIND,CS14_PACKAGE_MODE,CS15_PACKAGE_ID,CS16_RES_STATUS_ID,CS17_IS_LOCKED,CS18_IS_RECYCLED,CS19_OPER_DATE,CS20_OPER_ID,CS21_ORDER_STATUS,CS22_ICCID,CS23_IMSI,CS24_K,CS25_PIN1,CS26_PUK1,CS27_PIN2,CS28_PUK2,CS29_KLA1,CS30_KLA2,CS31_KLA3,CS32_KIC3,CS33_KID3,CS34_KIC8,CS35_KID8,CS36_KIC9,CS37_KID9,CS38_HLR_CODE,CS39_LOCAL_LAN,CS40_LAN_HLR,CS41_PAYMENT_MODE,CS42_BATCH_ID,CS43_LOTID,CS44_WARRANTY_PERIOD,CS45_TELE_TYPE,CS46_ESN,CS47_AKEY,CS48_MDN_TYPE,CS49_IMSI2,CS50_PREFIX,CS51_PRICE,CS52_CITY,CS53_HLR_NEW,CS54_KI,CS55_ADM1,CS56_KOTA,CS57_INFO1,CS58_INFO2,CS59_INFO3,CS60INFO4,CS61INFO5,CS62INFO6,CS63INFO7,CS64INFO8,CS65MVNO_ID)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',RES_ID,RES_CODE,VENDER_ID,MODEL_ID,CATEGORY_ID,DNSEQ,CREATE_DATE,VALID_DATE,INVALID_DATE,DEPT_ID,PERSON,LEVEL_ID,IS_BIND,PACKAGE_MODE,PACKAGE_ID,RES_STATUS_ID,IS_LOCKED,IS_RECYCLED,OPER_DATE,OPER_ID,ORDER_STATUS,ICCID,IMSI,K,PIN1,PUK1,PIN2,PUK2,KLA1,KLA2,KLA3,KIC3,KID3,KIC8,KID8,KIC9,KID9,HLR_CODE,LOCAL_LAN,LAN_HLR,PAYMENT_MODE,BATCH_ID,LOTID,WARRANTY_PERIOD,TELE_TYPE,ESN,AKEY,MDN_TYPE,IMSI2,PREFIX,PRICE,CITY,HLR_NEW,KI,ADM1,KOTA,INFO1,INFO2,INFO3,INFO4,INFO5,INFO6,INFO7,INFO8,MVNO_ID
FROM CRM_RSE_SIM_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='crm_res_sim'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_crm_res_sim  export lock

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
sh esms_crm_rse_sim_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

