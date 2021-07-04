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



FILE_NAME="ALARM_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="ALARM01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
LOG_SERIAL_NUMBER           VARCHAR2(56 BYTE),
OBJECT_IDENTITY_NAME        VARCHAR2(256 BYTE),
OBJECT_IDENTITY             VARCHAR2(100 BYTE),
PRODUCTNAME                 VARCHAR2(56 BYTE),
NETYPE                      VARCHAR2(56 BYTE),
NE_OBJECT_IDENTITY          VARCHAR2(56 BYTE),
ALARM_SOURCE                VARCHAR2(56 byte),
EQUIPMENTALARMSERIALNUMBER  VARCHAR2(56 BYTE),
ALARMNAME                   VARCHAR2(256 BYTE),
TYPE                        VARCHAR2(56 BYTE),
sEVERITY                     VARCHAR2(56 BYTE),
STATUS                      VARCHAR2(56 BYTE),
OCCURRENCETIME              VARCHAR2(56 BYTE),
ACKNOWLEDGEMENTTIME         VARCHAR2(56 BYTE),
CLEARANCETIME               VARCHAR2(56 BYTE),
UN_ACKNOWLEDGEMENTOPERATOR  VARCHAR2(56 BYTE),
CLEARANCEOPERATOR           VARCHAR2(56 BYTE),
LOCATIONINFORMATION         VARCHAR2(1000 BYTE),
LINKFDN                     VARCHAR2(256 BYTE),
LINKNAME                    VARCHAR2(256 BYTE),
LINKTYPE                    VARCHAR2(256 BYTE),
ALARM_IDENTIFIER            VARCHAR2(56 BYTE),
ALARM_ID                    VARCHAR2(56 BYTE),
OBJECT_INSTANCE_TYPE        VARCHAR2(256 BYTE),
AUTO_CLEAR                  VARCHAR2(256 BYTE),
ALARM_CLEAR_TYPE            VARCHAR2(56 BYTE),
BUSINESS_AFFECTED           VARCHAR2(256 BYTE),
ADDTIONAL_TEXT              VARCHAR2(256 BYTE),
ARRIVEDUTCTIME              VARCHAR2(256 BYTE),
LIST_ID                     VARCHAR2(56 BYTE),
RELATED_LOGID               VARCHAR2(56 BYTE),
AGENT_ID                    VARCHAR2(56 BYTE),
ROOT_ID                      VARCHAR2(56 BYTE),
SHOW_FLAG                   VARCHAR2(256 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ALARM_NBI_FM_DIR
     ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
	skip 1
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
 )
     LOCATION (ALARM_NBI_FM_DIR:'$1.csv')
  )
REJECT LIMIT UNLIMITED
NOPARALLEL
NOMONITORING
/
DROP SYNONYM  $SYN_TYPE
/
CREATE SYNONYM  $SYN_TYPE FOR $FILE_NAME
/
EXIT
EOF

echo "External table created"


