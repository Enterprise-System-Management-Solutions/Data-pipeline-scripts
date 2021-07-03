#Author :       Tareq
#Date   :       28-05-2020
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
SELECT '/data02/crm_dump_dir/Sql_IPCC/process_dir'||','||'/data02/crm_dump_dir/Sql_IPCC/process_dir'||file_name||','||file_name||','||file_id
FROM cdr_head
 WHERE source='cct_contactdetail'
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
 WHERE source='cct_contactdetail'
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
INSERT INTO L1_T_CCT_CONTACTDETAIL(PROCESSED_DATE,FILE_NAME,SERIALNO,CONTACTID,CONTACTCHANNELID,CONTACTCHANNELNAME,CONTACTMODEID,CONTACTMODENAME,SUBCCNO,VDNID,HOSTEDCCID,CALLID,CALLTYPE,LANGUAGETYPEID,LANGUAGETYPENAME,CALLSKILLID,CALLSKILLDESC,CALLERNO,CALLEDNO,SUBSNUMBER,ORGCALLERNO,ORGCALLEDNO,MEDIATYPEID,MEDIATYPENAME,CALLSTARTTIME,CALLDURATION,STAFFID,CUSTCITYID,SERVICECITYID,STAFFCITYID,SUBSCITYID,SUBSNAME,SUBSLEVELID,SUBSLEVELNAME,SUBSBRANDID,SUBSBRANDNAME,SUBSPHONE1,SUBSPHONE2,SUBSFAXNO,SUBSEMAIL,SUBSADDRESS,CUSTID,CUSTNAME,CUSTLEVELID,CUSTLEVELNAME,CUSTBRANDID,CUSTBRANDNAME,CUSTPHONE1,CUSTPHONE2,CUSTFAXNO,CUSTEMAIL,CUSTADDRESS,LINKMODE,LINKMAN,LINKINFO,LINKADDRESS,REMARK,CONTACTSTARTTIME,CONTACTDURATION,PLAYRECORDFLAG,QCFLAG,EVTERID,HAVESERVICEFLAG,INTERCEPTFLAG,STAFFHANGUP,SURVEYTYPEID,USERSATISFY,SATISFYFILEPATH,LISTENFLAG,INNERHELPFLAG,PICKUPSTAFFID,MAINCONTACTFLAG,CALLTRACK,DIGITCODE,EXPFLAG,HASRECORDFILE,ISPROCESSED,TENANTID,DYFIELD1,DYFIELD2,DYFIELD3,DYFIELD4,DYFIELD5,DYFIELD6,DYFIELD7,DYFIELD8,DYFIELD9,DYFIELD10,DYFIELD11,DYFIELD12,DYFIELD13,DYFIELD14,DYFIELD15,DYFIELD16,DYFIELD17,DYFIELD18,DYFIELD19,DYFIELD20)
SELECT TO_DATE(TO_CHAR(SYSDATE,'MM/DD/YYYY'),'MM/DD/YYYY'),'$1',SERIALNO,CONTACTID,CONTACTCHANNELID,CONTACTCHANNELNAME,CONTACTMODEID,CONTACTMODENAME,SUBCCNO,VDNID,HOSTEDCCID,CALLID,CALLTYPE,LANGUAGETYPEID,LANGUAGETYPENAME,CALLSKILLID,CALLSKILLDESC,CALLERNO,CALLEDNO,SUBSNUMBER,ORGCALLERNO,ORGCALLEDNO,MEDIATYPEID,MEDIATYPENAME,CALLSTARTTIME,CALLDURATION,STAFFID,CUSTCITYID,SERVICECITYID,STAFFCITYID,SUBSCITYID,SUBSNAME,SUBSLEVELID,SUBSLEVELNAME,SUBSBRANDID,SUBSBRANDNAME,SUBSPHONE1,SUBSPHONE2,SUBSFAXNO,SUBSEMAIL,SUBSADDRESS,CUSTID,CUSTNAME,CUSTLEVELID,CUSTLEVELNAME,CUSTBRANDID,CUSTBRANDNAME,CUSTPHONE1,CUSTPHONE2,CUSTFAXNO,CUSTEMAIL,CUSTADDRESS,LINKMODE,LINKMAN,LINKINFO,LINKADDRESS,REMARK,CONTACTSTARTTIME,CONTACTDURATION,PLAYRECORDFLAG,QCFLAG,EVTERID,HAVESERVICEFLAG,INTERCEPTFLAG,STAFFHANGUP,SURVEYTYPEID,USERSATISFY,SATISFYFILEPATH,LISTENFLAG,INNERHELPFLAG,PICKUPSTAFFID,MAINCONTACTFLAG,CALLTRACK,DIGITCODE,EXPFLAG,HASRECORDFILE,ISPROCESSED,TENANTID,DYFIELD1,DYFIELD2,DYFIELD3,DYFIELD4,DYFIELD5,DYFIELD6,DYFIELD7,DYFIELD8,DYFIELD9,DYFIELD10,DYFIELD11,DYFIELD12,DYFIELD13,DYFIELD14,DYFIELD15,DYFIELD16,DYFIELD17,DYFIELD18,DYFIELD19,DYFIELD20
FROM CCT_CONTACTDETAIL_EXT
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='cct_contactdetail'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/ipcc_contact_detail  export lock

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
sh esms_creat_extt_t_cct_contactdetail.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi
/process_dir