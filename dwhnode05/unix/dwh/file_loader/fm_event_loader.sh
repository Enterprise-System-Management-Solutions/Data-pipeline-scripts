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
SELECT '/data04/ipdr_u2000/event/process_dir'||','||'/data04/ipdr_u2000/event/process_dir'||file_name||','||file_name||','||file_id
  FROM cdr_head
 WHERE source='event'
   AND process_status=30
   and rownum < 1000 
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
 WHERE source='event'
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

INSERT INTO L1_EVENT(PROCESSED_DATE, FILE_NAME, FE_01LOG_SERIAL_NUMBER, FE_02OBJECT_IDENTITY_NAME, FE_03OBJECT_IDENTITY, FE_04PRODUCTNAME, FE_05NETYPE, FE_06NE_OBJECT_IDENTITY, FE_07ALARM_SOURCE, FE_08EQUIPALARMSINUM, FE_09ALARMNAME, FE_10TYPE, FE_11SEVERITY, FE_12OCCURRENCETIME, FE_13LOCATIONINFORMATION, FE_14LINKFDN, FE_15LINKNAME, FE_16LINKTYPE, FE_17ALARM_IDENTIFIER, FE_18ALARM_ID, FE_19OBJECT_INSTANCE_TYPE, FE_20BUSINESS_AFFECTED, FE_21ADDTIONAL_TEXT, FE_22ARRIVEDUTCTIME, FE_23AGENT_ID, FE_24ROOT_ID, FE_25SHOW_FLAG)
(SELECT TO_DATE(TO_CHAR(SYSDATE, 'MM/DD/YYYY'), 'MM/DD/YYYY')as PROCESSED_DATE,'$1',LOG_SERIAL_NUMBER, OBJECT_IDENTITY_NAME, OBJECT_IDENTITY, PRODUCTNAME, NETYPE, NE_OBJECT_IDENTITY, ALARM_SOURCE, EQUIPMENTALARMSERIALNUMBER, ALARMNAME, TYPE, SEVERITY, OCCURRENCETIME, LOCATIONINFORMATION, LINKFDN, LINKNAME, LINKTYPE, ALARM_IDENTIFIER, ALARM_ID, OBJECT_INSTANCE_TYPE, BUSINESS_AFFECTED, ADDTIONAL_TEXT, ARRIVEDUTCTIME, AGENT_ID, ROOT_ID, SHOW_FLAG FROM EVENT_EXT)

/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='event'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/dwh/lock/event_lock  export lock

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
sh create_fm_event_ext_tab.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

