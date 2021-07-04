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


dt=`date +%Y-%m-%d`
file=$1

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
drop table EXT_HuaweiUDN3 purge;

CREATE TABLE EXT_HuaweiUDN3 (
StartTime  VARCHAR2(64 BYTE),
EndTime  VARCHAR2(64 BYTE),
AssociationFlag  VARCHAR2(64 BYTE),
IMSI  VARCHAR2(64 BYTE),
MSISDN  VARCHAR2(64 BYTE),
IMEISV  VARCHAR2(64 BYTE),
MS_IP  VARCHAR2(64 BYTE),
Server_IP  VARCHAR2(64 BYTE),
MS_Port  VARCHAR2(64 BYTE),
Server_Port  VARCHAR2(64 BYTE),
IP_Protocol  VARCHAR2(64 BYTE),
APN  VARCHAR2(64 BYTE),
Charging_Characteristics  VARCHAR2(64 BYTE),
RAT_Type  VARCHAR2(64 BYTE),
Serving_Node_IP  VARCHAR2(64 BYTE),
Gateway_Node_IP  VARCHAR2(64 BYTE),
CGI  VARCHAR2(64 BYTE),
SAI  VARCHAR2(64 BYTE),
RAI  VARCHAR2(64 BYTE),
TAI  VARCHAR2(64 BYTE),
ECGI  VARCHAR2(64 BYTE),
LAI  VARCHAR2(64 BYTE),
Uplink_Traffic  VARCHAR2(64 BYTE),
Downlink_Traffic  VARCHAR2(64 BYTE),
Uplink_Packets  VARCHAR2(64 BYTE),
Downlink_Packets  VARCHAR2(64 BYTE),
Protocol_Category  VARCHAR2(64 BYTE),
Application  VARCHAR2(64 BYTE),
Sub_Application  VARCHAR2(64 BYTE),
EGN_Sub_Protocol  VARCHAR2(64 BYTE),
URL  VARCHAR2(1200 BYTE),
User_Agent  VARCHAR2(640 BYTE),
Charging_ID  VARCHAR2(64 BYTE),
Online_RG_ID  VARCHAR2(64 BYTE),
Offline_RG_ID  VARCHAR2(64 BYTE),
Status  VARCHAR2(64 BYTE),
SAC  VARCHAR2(64 BYTE),
LAC VARCHAR2(64 BYTE)
)
ORGANIZATION EXTERNAL (
TYPE ORACLE_LOADER
DEFAULT DIRECTORY HuaweiUDN
ACCESS PARAMETERS (
RECORDS DELIMITED BY NEWLINE
skip 1
PREPROCESSOR execdir:'zcat'
BADFILE     '$1.bad'
DISCARDFILE '$1.dis'
FIELDS TERMINATED BY ','
MISSING FIELD VALUES ARE NULL
)
LOCATION ('$file.csv.gz')
)
REJECT LIMIT UNLIMITED
NOMONITORING;
EXIT
EOF




