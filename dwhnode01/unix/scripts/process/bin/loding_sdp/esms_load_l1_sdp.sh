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
SELECT '/data02/dwh_sdp_dir/process_dir'||','||'/data02/dwh_sdp_dir/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='sdp'
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
 WHERE source='sdp'
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
INSERT INTO L1_SDP(PROCESSED_DATE, FILE_NAME, SDP01_TIMESTAMP, SDP02_CLIENTTRANSACTIONID, SDP03_APARTY, SDP04_INTERNALCAUSE, SDP05_BASICCAUSE, SDP06_TRANSACTIONID, SDP07_PRICEPLAN, SDP08_OFFERCODE, SDP09_ORIGCOUNTRYCODE, SDP10_DIAMTRANSTYPE, SDP11_ACCESSFLAG, SDP12_CONTENTPROVIDERID, SDP13_DATA, SDP14_SUBSCRIPTIONDATE, SDP15_SUBSCRIPTIONFLAG, SDP16_CHARGINGTYPE, SDP17_CALLCHARGE, SDP18_CHANNEL, SDP19_CP_NAME, SDP20_BILLINGTYPE, SDP21_DEFAULTCALLCHARGE, SDP22_REASONCODE, SDP23_BILLINGTIME, SDP24_TASKID, SDP25_PRODUCTID, SDP26_TAXABLEAMOUNT, SDP27_CREATE_TIME)
SELECT TRUNC(SYSDATE-1),'$1',SDP01_TIMESTAMP, SDP02_CLIENTTRANSACTIONID, SDP03_APARTY, SDP04_INTERNALCAUSE, SDP05_BASICCAUSE, SDP06_TRANSACTIONID, SDP07_PRICEPLAN, SDP08_OFFERCODE, SDP09_ORIGCOUNTRYCODE, SDP10_DIAMTRANSTYPE, SDP11_ACCESSFLAG, SDP12_CONTENTPROVIDERID, SDP13_DATA, SDP14_SUBSCRIPTIONDATE, SDP15_SUBSCRIPTIONFLAG, SDP16_CHARGINGTYPE, SDP17_CALLCHARGE, SDP18_CHANNEL, SDP19_CP_NAME, SDP20_BILLINGTYPE, SDP21_DEFAULTCALLCHARGE, SDP22_REASONCODE, SDP23_BILLINGTIME, SDP24_TASKID, SDP25_PRODUCTID, SDP26_TAXABLEAMOUNT, SDP27_CREATE_TIME
FROM SDP_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='sdp'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_sdp export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/process/bin/loding_sdp
sh esms_create_sdp_ext.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

