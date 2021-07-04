PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode05
export ORACLE_UNQNAME=dwhdb05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb05
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
SELECT '/data04/ipdr_u2000/alarm/process_dir'||','||'/data04/ipdr_u2000/alarm/process_dir'||file_name||','||file_name||','||file_id
  FROM cdr_head
 WHERE source='alarm'
   AND process_status=30
   and rownum <101 
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
 WHERE source='alarm'
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

INSERT INTO L1_ALARM(PROCESSED_DATE, FILE_NAME, FA01_OBJECT_IDENTITY_NAME, FA02_OBJECT_IDENTITY, FA03_PRODUCT_NAME, FA04_NE_TYPE, FA05_NE_OBJECT_IDENTITY, FA06_ALARM_SOURCE, FA07_ALARM_NAME, FA08_TYPE, FA09_OCCURRENCE_TIME, FA10_CLEARANCE_TIME, FA11_LOCATION_INFORMATION, FA12_ALARM_ID, FA13_OBJECT, FA14_INSTANCE_TYPE, FA15_ADDTIONAL_TEXT)
(SELECT TO_DATE(TO_CHAR(SYSDATE, 'MM/DD/YYYY'), 'MM/DD/YYYY'),'$1',OBJECT_IDENTITY_NAME, OBJECT_IDENTITY, PRODUCT_NAME, NE_TYPE, NE_OBJECT_IDENTITY, ALARM_SOURCE, ALARM_NAME, TYPE, OCCURRENCE_TIME, CLEARANCE_TIME, LOCATION_INFORMATION, ALARM_ID, OBJECT, INSTANCE_TYPE, ADDTIONAL_TEXT FROM ALARM_EXT)
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='alarm'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/dwh/lock/alarm_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/dwh/file_loader/
sh create_fm_alarm_ext_tab.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi


