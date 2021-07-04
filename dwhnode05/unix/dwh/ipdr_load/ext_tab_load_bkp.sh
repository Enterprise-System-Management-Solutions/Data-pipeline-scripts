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
drop table EXT_HuaweiUDN purge;

CREATE TABLE EXT_HuaweiUDN (
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
URL  VARCHAR2(256 BYTE),
User_Agent  VARCHAR2(256 BYTE),
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
FIELDS TERMINATED BY ','
MISSING FIELD VALUES ARE NULL
(
StartTime  CHAR(64),
EndTime  CHAR(64),
AssociationFlag  CHAR(64),
IMSI  CHAR(64),
MSISDN  CHAR(64),
IMEISV  CHAR(64),
MS_IP  CHAR(64),
Server_IP  CHAR(64),
MS_Port  CHAR(64),
Server_Port  CHAR(64),
IP_Protocol  CHAR(64),
APN  CHAR(64),
Charging_Characteristics  CHAR(64),
RAT_Type  CHAR(64),
Serving_Node_IP  CHAR(64),
Gateway_Node_IP  CHAR(64),
CGI  CHAR(64),
SAI  CHAR(64),
RAI  CHAR(64),
TAI  CHAR(64),
ECGI  CHAR(64),
LAI  CHAR(64),
Uplink_Traffic  CHAR(64),
Downlink_Traffic  CHAR(64),
Uplink_Packets  CHAR(64),
Downlink_Packets  CHAR(64),
Protocol_Category  CHAR(64),
Application  CHAR(64),
Sub_Application  CHAR(64),
EGN_Sub_Protocol  CHAR(64),
URL  CHAR(256),
User_Agent  CHAR(256),
Charging_ID  CHAR(64),
Online_RG_ID  CHAR(64),
Offline_RG_ID  CHAR(64),
Status  CHAR(64),
SAC  CHAR(64),
LAC CHAR(64)
)
)
LOCATION ('$file'))
REJECT LIMIT UNLIMITED
PARALLEL 2;

insert into L1_HuaweiUDN select TO_DATE('2020-04-06','yyyy-mm-dd'),'HuaweiUDN-NON-ASSOC01_20200405184559_000000.csv.gz',
StartTime,EndTime,AssociationFlag,IMSI,MSISDN,IMEISV,MS_IP,Server_IP,MS_Port,Server_Port,IP_Protocol,
APN,Charging_Characteristics,RAT_Type,Serving_Node_IP,Gateway_Node_IP,CGI,SAI,RAI,TAI,ECGI,LAI,Uplink_Traffic,
Downlink_Traffic,Uplink_Packets,Downlink_Packets,Protocol_Category,Application,Sub_Application,EGN_Sub_Protocol,
URL,User_Agent,Charging_ID,Online_RG_ID,Offline_RG_ID,Status,SAC,LAC from EXT_HuaweiUDN;

EXIT
EOF







