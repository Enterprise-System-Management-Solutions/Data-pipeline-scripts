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
SELECT '/data04/udn/process_dir/'||','||'/data04/udn/process_dir/'||file_name||','||file_name||','||file_id  
FROM cdr_head
 WHERE source in ('HuaweiUDN','HuaweiUDN2')
   AND process_status=30
   and trunc(PROCESS_DATE)between trunc(sysdate-4) and trunc(sysdate-1)
   and rownum < 300 
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
 WHERE source in ('HuaweiUDN','HuaweiUDN2')
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

INSERT INTO L1_HUAWEIUDN2(PROCESSED_DATE, PROCESSED_HOUR, FILE_ID, IP1_STARTTIME, IP2_ENDTIME, IP3_MS_IP, IP4_MS_PORT, IP5_SERVER_IP, IP6_SERVER_PORT, IP7_MSISDN, IP8_IMSI, IP9_IMEI, IP10_CGI, IP11_SAI, IP12_ECGI, IP23_UPLINK_TRAFFIC, IP24_DOWNLINK_TRAFFIC, IP14_RAT_TYPE, IP19_RAI, IP20_TAI, IP22_LAI, IP37_SAC, IP38_LAC)
(SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'), TO_CHAR(SYSDATE, 'HH24') AS PROCESSED_HOUR, '$2', STARTTIME, ENDTIME, MS_IP, MS_PORT, SERVER_IP, SERVER_PORT, MSISDN, IMSI, IMEISV, CGI, SAI, ECGI, UPLINK_TRAFFIC, DOWNLINK_TRAFFIC,RAT_TYPE,RAI,TAI,LAI,SAC,LAC FROM EXT_HUAWEIUDN3 )
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source in ('HuaweiUDN','HuaweiUDN2')
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/dwh/lock/HuaweiUDN_backlog_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/dwh/ipdr_load/
sh HuaweiUDN_ext_tab_3.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3 $v4


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi





