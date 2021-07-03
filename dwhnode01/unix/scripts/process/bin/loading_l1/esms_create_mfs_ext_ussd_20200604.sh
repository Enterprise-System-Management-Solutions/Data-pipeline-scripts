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



FILE_NAME="NEW_USSD_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="NEW_USSD" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
RecType			 varchar2(56),
Billid                   varchar2(256), 
CallerType               varchar2(2),   
ISPPSUser                varchar2(1),   
MSISDN                   varchar2(15),   
ServiceCode              varchar2(15),   
ServiceType              varchar2(2),   
USSDCID                  varchar2(2),   
BillType                 varchar2(1),   
CallBeginTime            varchar2(30),   
CallEndTime              varchar2(30),   
CallInfoSize             varchar2(6),   
CallTime                 varchar2(6),   
CallFee                  varchar2(6),   
CallInteractiveCount     varchar2(4),   
CallMSRequestCount       varchar2(4),   
CallServiceRequestCount  varchar2(4),   
CallServiceNotifyCount   varchar2(4),   
CallReleaseStatus        varchar2(2),   
ChargeIndex              varchar2(4),   
ChargeInfoFee            varchar2(6),   
ChargeType               varchar2(2),   
ChargeSpCode             varchar2(6),   
ChargeOperCode           varchar2(10),   
IMSI                     varchar2(15),   
IMEI                     varchar2(15),   
Reserved                 varchar2(31),   
AccountName              varchar2(10),   
ErrorCode                varchar2(4),   
MVNOID                   varchar2(33),   
LAC                      varchar2(4),   
CellID                   varchar2(20),   
MSC                      varchar2(56),   
UserInputFlow            varchar2(265),   
SessionInitType          varchar2(1),   
SessionInitTypeDesc      varchar2(4),   
PSSRContent              varchar2(21),   
LastUserInput            varchar2(21),   
LastSPContent            varchar2(700)   
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY NEW_USSD_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
	CHARACTERSET AL32UTF8
	STRING SIZES ARE IN CHARACTERS
	PREPROCESSOR execdir:'cat'
	BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY ','
 )
     LOCATION (NEW_USSD_DIR:'$1.unl')
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
