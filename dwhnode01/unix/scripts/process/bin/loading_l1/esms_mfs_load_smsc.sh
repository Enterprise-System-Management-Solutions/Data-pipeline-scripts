#Author :       Tareq
#Date   :       16-05-2020
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
SELECT '/data02/mfs/smsc/process_dir'||','||'/data02/mfs/smsc/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='smsc'
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
 WHERE source='smsc'
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
INSERT INTO L1_SMSC(PROCESSED_DATE,FILE_NAME,SMC1_TIME_SERIAL_NUMBER,SMC2_SM_ID,SMC3_ORIGINAL_DELIVERY_ADDR,SMC4_TON_OF_ORIGINAL_DELIVE,SMC5_NPI_OF_ORIGINAL_DELIVE,SMC6_DESTINATION_DELIVERY_A,SMC7_TON_DESTINATION_DELIVE,SMC8_NPI_DESTINATION_DELIVE,SMC9_ORG_SUBMISSION_TIME,SMC10_FINAL_TIME,SMC11_SRR,SMC12_PID,SMC13_DCS,SMC14_SM_LENGTH,SMC15_SMSTATUS,SMC16_ERROR_CODE,SMC17_DESCRIPTION_PPS_USER,SMC18_CHARGEBILLPOINT,SMC19_MESSAGETYPE,SMC20_DELIVERCOUNT,SMC21_LASTERR,SMC22_UDHI,SMC23_RN,SMC24_MN,SMC25_SN,SMC26_MOMSCADDR,SMC27_MTMSCADDR,SMC28_ORGIMSI,SMC29_DESTIMSI,SMC30_ORGACCOUNT,SMC31_DESTACCOUNT,SMC32_MOSCADDRESS,SMC33_CELLID)
(SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',SMC1_TIME_SERIAL_NUMBER,SMC2_SM_ID,SMC3_ORIGINAL_DELIVERY_ADDR,SMC4_TON_OF_ORIGINAL_DELIVE,SMC5_NPI_OF_ORIGINAL_DELIVE,SMC6_DESTINATION_DELIVERY_A,SMC7_TON_DESTINATION_DELIVE,SMC8_NPI_DESTINATION_DELIVE,SMC9_ORG_SUBMISSION_TIME,SMC10_FINAL_TIME,SMC11_SRR,SMC12_PID,SMC13_DCS,SMC14_SM_LENGTH,SMC15_SMSTATUS,SMC16_ERROR_CODE,SMC17_DESCRIPTION_PPS_USER,SMC18_CHARGEBILLPOINT,SMC19_MESSAGETYPE,SMC20_DELIVERCOUNT,SMC21_LASTERR,SMC22_UDHI,SMC23_RN,SMC24_MN,SMC25_SN,SMC26_MOMSCADDR,SMC27_MTMSCADDR,SMC28_ORGIMSI,SMC29_DESTIMSI,SMC30_ORGACCOUNT,SMC31_DESTACCOUNT,SMC32_MOSCADDRESS,SMC33_CELLID
FROM SMSC_EXT)
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='smsc'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_smsc  export lock

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
sh esms_create_mfs_ext_smsc.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi
