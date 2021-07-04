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
SELECT '/data01/udn/process_dir/'||','||'/data01/udn/process_dir/'||file_name||','||file_name||','||file_id  
FROM cdr_head
 WHERE source='HuaweiUDN'
   AND process_status=30
   and rownum < 101 
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
 WHERE source='HuaweiUDN'
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

INSERT INTO L1_HUAWEIUDN_NEW(PROCESSED_DATE,FILE_NAME,IP1_STARTTIME,IP2_ENDTIME,IP3_ASSOCIATIONFLAG,IP4_IMSI,IP5_MSISDN,IP6_IMEISV,IP7_MS_IP,IP8_SERVER_IP,IP9_MS_PORT,IP10_SERVER_PORT,IP11_IP_PROTOCOL,IP12_APN,IP13_CHARGING_CHARACTERISTICS,IP14_RAT_TYPE,IP15_SERVING_NODE_IP,IP16_GATEWAY_NODE_IP,IP17_CGI,IP18_SAI,IP19_RAI,IP20_TAI,IP21_ECGI,IP22_LAI,IP23_UPLINK_TRAFFIC,IP24_DOWNLINK_TRAFFIC,IP25_UPLINK_PACKETS,IP26_DOWNLINK_PACKETS,IP27_PROTOCOL_CATEGORY,IP28_APPLICATION,IP29_SUB_APPLICATION,IP30_EGN_SUB_PROTOCOL,IP31_URL,IP32_USER_AGENT,IP33_CHARGING_ID,IP34_ONLINE_RG_ID,IP35_OFFLINE_RG_ID,IP36_STATUS,IP37_SAC,IP38_LAC)
(SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',STARTTIME,ENDTIME,ASSOCIATIONFLAG,IMSI,MSISDN,IMEISV,MS_IP,SERVER_IP,MS_PORT,SERVER_PORT,IP_PROTOCOL,APN,CHARGING_CHARACTERISTICS,RAT_TYPE,SERVING_NODE_IP,GATEWAY_NODE_IP,CGI,SAI,RAI,TAI,ECGI,LAI,UPLINK_TRAFFIC,DOWNLINK_TRAFFIC,UPLINK_PACKETS,DOWNLINK_PACKETS,PROTOCOL_CATEGORY,APPLICATION,SUB_APPLICATION,EGN_SUB_PROTOCOL,URL,USER_AGENT,CHARGING_ID,ONLINE_RG_ID,OFFLINE_RG_ID,STATUS,SAC,LAC FROM EXT_HUAWEIUDN)
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='HuaweiUDN'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/dwh/lock/HuaweiUDN_lock  export lock

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
sh HuaweiUDN_ext_tab.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi




