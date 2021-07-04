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
SELECT '/data02/card/HuaweiUDN/process_dir/'||','||'/data02/card/HuaweiUDN/process_dir/'||file_name||','||file_name||','||file_id
  FROM cdr_head
 WHERE source='HuaweiUDN'
   AND process_status=30
   and rownum < 10 
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

insert into L1_HuaweiUDN_new select TO_DATE(TO_CHAR(SYSDATE, 'MM/DD/YYYY'), 'MM/DD/YYYY'),'$1',
StartTime,EndTime,AssociationFlag,IMSI,MSISDN,IMEISV,MS_IP,Server_IP,MS_Port,Server_Port,IP_Protocol,
APN,Charging_Characteristics,RAT_Type,Serving_Node_IP,Gateway_Node_IP,CGI,SAI,RAI,TAI,ECGI,LAI,Uplink_Traffic,
Downlink_Traffic,Uplink_Packets,Downlink_Packets,Protocol_Category,Application,Sub_Application,EGN_Sub_Protocol,
URL,User_Agent,Charging_ID,Online_RG_ID,Offline_RG_ID,Status,SAC,LAC from EXT_HuaweiUDN;

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




