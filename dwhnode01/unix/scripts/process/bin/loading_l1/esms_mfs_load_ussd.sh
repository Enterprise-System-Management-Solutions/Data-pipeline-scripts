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
SELECT '/data02/mfs/ussd/process_dir'||','||'/data02/mfs/ussd/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='ussd'
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
 WHERE source='ussd'
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

INSERT INTO L1_USSD(PROCESSED_DATE,FILE_NAME,USSD1_RECTYPE,USSD2_BILLID,USSD3_CALLERTYPE,USSD4_ISPPSUSER,USSD5_MSISDN,USSD6_SERVICECODE,USSD7_SERVICETYPE,USSD8_USSDCID,USSD9_BILLTYPE,USSD10_CALLBEGINTIME,USSD11_CALLENDTIME,USSD12_CALLINFOSIZE,USSD13_CALLTIME,USSD14_CALLFEE,USSD15_CALLINTERACTIVECOUNT,USSD16_CALLMSREQUESTCOUNT,USSD17_CALLSERVICEREQUESTCOUNT,USSD18_CALLSERVICENOTIFYCOUNT,USSD19_CALLRELEASESTATUS,USSD20_CHARGEINDEX,USSD21_CHARGEINFOFEE,USSD22_CHARGETYPE,USSD23_CHARGESPCODE,USSD24_CHARGEOPERCODE,USSD25_IMSI,USSD26_IMEI,USSD27_RESERVED,USSD28_ACCOUNTNAME,USSD29_ERRORCODE,USSD30_MVNOID,USSD31_LAC,USSD32_CELLID,USSD33_MSC,USSD34_USERINPUTFLOW,USSD35_SESSIONINITTYPE,USSD36_SESSIONINITTYPEDESC,USSD37_PSSRCONTENT,USSD38_LASTUSERINPUT,USSD39_LASTSPCONTENT)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',RECTYPE,BILLID,CALLERTYPE,ISPPSUSER,MSISDN,SERVICECODE,SERVICETYPE,USSDCID,BILLTYPE,CALLBEGINTIME,CALLENDTIME,CALLINFOSIZE,CALLTIME,CALLFEE,CALLINTERACTIVECOUNT,CALLMSREQUESTCOUNT,CALLSERVICEREQUESTCOUNT,CALLSERVICENOTIFYCOUNT,CALLRELEASESTATUS,CHARGEINDEX,CHARGEINFOFEE,CHARGETYPE,CHARGESPCODE,CHARGEOPERCODE,IMSI,IMEI,RESERVED,ACCOUNTNAME,ERRORCODE,MVNOID,LAC,CELLID,MSC,USERINPUTFLOW,SESSIONINITTYPE,SESSIONINITTYPEDESC,PSSRCONTENT,LASTUSERINPUT,LASTSPCONTENT
FROM USSD_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='ussd'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_ussd  export lock

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
sh esms_create_mfs_ext_ussd.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

