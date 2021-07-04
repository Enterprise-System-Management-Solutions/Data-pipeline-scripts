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
drop table EVENT_EXT purge;

CREATE TABLE EVENT_EXT (
  LOG_SERIAL_NUMBER           VARCHAR2(56 BYTE),
  OBJECT_IDENTITY_NAME        VARCHAR2(256 BYTE),
  OBJECT_IDENTITY             VARCHAR2(256 BYTE),
  PRODUCTNAME                 VARCHAR2(56 BYTE),
  NETYPE                      VARCHAR2(56 BYTE),
  NE_OBJECT_IDENTITY          VARCHAR2(56 BYTE),
  ALARM_SOURCE                VARCHAR2(256 BYTE),
  EQUIPMENTALARMSERIALNUMBER  VARCHAR2(256 BYTE),
  ALARMNAME                   VARCHAR2(256 BYTE),
  TYPE                        VARCHAR2(56 BYTE),
  SEVERITY                    VARCHAR2(56 BYTE),
  OCCURRENCETIME              VARCHAR2(256 BYTE),
  LOCATIONINFORMATION         VARCHAR2(56 BYTE),
  LINKFDN                     VARCHAR2(56 BYTE),
  LINKNAME                    VARCHAR2(56 BYTE),
  LINKTYPE                    VARCHAR2(56 BYTE),
  ALARM_IDENTIFIER            VARCHAR2(56 BYTE),
  ALARM_ID                    VARCHAR2(56 BYTE),
  OBJECT_INSTANCE_TYPE        VARCHAR2(56 BYTE),
  BUSINESS_AFFECTED           VARCHAR2(56 BYTE),
  ADDTIONAL_TEXT              VARCHAR2(56 BYTE),
  ARRIVEDUTCTIME              VARCHAR2(56 BYTE),
  AGENT_ID                    VARCHAR2(56 BYTE),
  ROOT_ID                     VARCHAR2(56 BYTE),
  SHOW_FLAG                   VARCHAR2(56 BYTE)
)
ORGANIZATION EXTERNAL (
TYPE ORACLE_LOADER
DEFAULT DIRECTORY event
ACCESS PARAMETERS (
RECORDS DELIMITED BY NEWLINE
skip 1
PREPROCESSOR execdir:'zcat'
FIELDS TERMINATED BY ','
MISSING FIELD VALUES ARE NULL
)
LOCATION ('$file.csv.gz'))
REJECT LIMIT UNLIMITED;


EXIT
EOF



