#Author :       Tareq
#Date   :       25-06-2020
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
dwh_user03/dwh_user_123
SET head off
SET feedback off
SET pagesize 0
SET verify off
SET linesize 400
SELECT '/data02/sftp_msc/nokia/process_dir'||','||'/data02/sftp_msc/nokia/process_dir/'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='msc_nokia'
   AND process_status=30
   and rownum  < 5001
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
UPDATE cdr_head
   SET process_status=32
 WHERE source='msc_nokia'
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
INSERT INTO L1_MSC_NOKIA_TEMP(PROCESSED_DATE, FILE_NAME, MN01_SERVEDMSISDN, MN02_CALLINGNUMBER, MN03_ANSWERTIME, MN04_CALLDURATION, MN05_RECORDTYPE, MN06_CALLTYPE, MN07_FSTLAC, MN08_FSTCI, MN09_LASTLAC, MN10_LASTCI, MN11_IMEI, MN12_IMSI, MN13_CAUSEFORTERM)
(SELECT TRUNC(SYSDATE),'$1', SERVEDMSISDN, CALLINGNUMBER, ANSWERTIME, CALLDURATION, RECORDTYPE, CALLTYPE, FSTLAC, FSTCI, LASTLAC, LASTCI, IMEI, IMSI, CAUSEFORTERM FROM MSC_NOKIA_EXI)
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='msc_nokia'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_msc_nokia_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id
cd /data02/scripts/process/bin/loading_l1/msc_nokia
sh esms_msc_nokia_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

