#Author :       Tareq
#Date   :       16-05-2020
#!/bin/bash

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode03
export ORACLE_UNQNAME=dwhdb03
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb03
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


# This function changes the status of files where errors where encountered to 34
updateOnError()
{
sqlplus  -s <<EOF
dwh_user03/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
UPDATE cdr_head_merge
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
dwh_user03/dwh_user_123
SET head off
SET feedback off
SET pagesize 0
SET verify off
SET linesize 400
SELECT '/data02/sftp_msc/huawei/dump_dir'||','||'/data02/sftp_msc/huawei/dump_dir'||file_name||','||file_name||','||file_id
FROM cdr_head_merge
 WHERE source='msc_huawei'
   AND process_status=30
   and rownum  < 201
/
EOF
}


createSMSCUpdate()
{
sqlplus  -s <<EOF
dwh_user03/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
UPDATE cdr_head_merge
   SET process_status=32
 WHERE source='msc_huawei'
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
dwh_user03/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
INSERT INTO L1_MSC_HUAWEI_TEMP(PROCESSED_DATE, FILE_NAME, MH01_CALLTYPE, MH02_SERVEDIMSI, MH03_SERVEDIMEI, MH04_APARTYMSISDN, MH05_BPARTYMSISDN, MH06_FORWARDINGMSISDN, MH07_ORIGINATIONTIME, MH08_CALLDURATION, MH09_CAUSEFORTERM, MH10_GLOBAAREAID,MH11_LAST_LOCATION)
(SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'), FILE_FLAG, MH01_CALLTYPE, MH02_SERVEDIMSI, MH03_SERVEDIMEI, MH04_APARTYMSISDN, MH05_BPARTYMSISDN, MH06_FORWARDINGMSISDN, MH07_ORIGINATIONTIME, MH08_CALLDURATION, MH09_CAUSEFORTERM, MH10_GLOBAAREAID, MH11_LAST_LOCATION FROM MSC_HUAWEI_EXI)
/
COMMIT
/
UPDATE cdr_head_merge
   SET process_status=96
 WHERE source='msc_huawei'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_msc_huawei  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id
cd /data02/scripts/process/bin/loading_l1/msc_huawei
sh esms_msc_huawei_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi
