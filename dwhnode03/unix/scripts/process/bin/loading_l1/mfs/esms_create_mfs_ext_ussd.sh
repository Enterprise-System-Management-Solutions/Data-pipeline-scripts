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


FILE_NAME="USSD_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="USSD" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user03/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  RECTYPE                  VARCHAR2(255 BYTE),
  BILLID                   VARCHAR2(255 BYTE),
  CALLERTYPE               VARCHAR2(255 BYTE),
  ISPPSUSER                VARCHAR2(255 BYTE),
  MSISDN                   VARCHAR2(255 BYTE),
  SERVICECODE              VARCHAR2(255 BYTE),
  SERVICETYPE              VARCHAR2(255 BYTE),
  USSDCID                  VARCHAR2(255 BYTE),
  BILLTYPE                 VARCHAR2(255 BYTE),
  CALLBEGINTIME            VARCHAR2(255 BYTE),
  CALLENDTIME              VARCHAR2(255 BYTE),
  CALLINFOSIZE             VARCHAR2(255 BYTE),
  CALLTIME                 VARCHAR2(255 BYTE),
  CALLFEE                  VARCHAR2(255 BYTE),
  CALLINTERACTIVECOUNT     VARCHAR2(255 BYTE),
  CALLMSREQUESTCOUNT       VARCHAR2(255 BYTE),
  CALLSERVICEREQUESTCOUNT  VARCHAR2(255 BYTE),
  CALLSERVICENOTIFYCOUNT   VARCHAR2(255 BYTE),
  CALLRELEASESTATUS        VARCHAR2(255 BYTE),
  CHARGEINDEX              VARCHAR2(255 BYTE),
  CHARGEINFOFEE            VARCHAR2(255 BYTE),
  CHARGETYPE               VARCHAR2(255 BYTE),
  CHARGESPCODE             VARCHAR2(255 BYTE),
  CHARGEOPERCODE           VARCHAR2(255 BYTE),
  IMSI                     VARCHAR2(255 BYTE),
  IMEI                     VARCHAR2(255 BYTE),
  RESERVED                 VARCHAR2(255 BYTE),
  ACCOUNTNAME              VARCHAR2(255 BYTE),
  ERRORCODE                VARCHAR2(255 BYTE),
  MVNOID                   VARCHAR2(255 BYTE),
  LAC                      VARCHAR2(255 BYTE),
  CELLID                   VARCHAR2(255 BYTE),
  MSC                      VARCHAR2(255 BYTE),
  USERINPUTFLOW            VARCHAR2(255 BYTE),
  SESSIONINITTYPE          VARCHAR2(255 BYTE),
  SESSIONINITTYPEDESC      VARCHAR2(255 BYTE),
  PSSRCONTENT              VARCHAR2(255 BYTE),
  LASTUSERINPUT            VARCHAR2(255 BYTE),
  LASTSPCONTENT            VARCHAR2(700 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY USSD_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
	CHARACTERSET AL32UTF8
	STRING SIZES ARE IN CHARACTERS
	PREPROCESSOR execdir:'cat'
	BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY ','
	MISSING FIELD VALUES ARE NULL
 )
     LOCATION (USSD_DIR:'$1.unl')
  )
REJECT LIMIT UNLIMITED
NOPARALLEL
NOMONITORING
/
drop synonym  $SYN_TYPE
/
create synonym  $SYN_TYPE for $FILE_NAME
/
exit
EOF

echo "External table created"
