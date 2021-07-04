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



FILE_NAME="HISTORY_ALARMS_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="HISTORY_ALARMS_01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
CONSEC_NBR            VARCHAR2(255),
DN                  VARCHAR2(255),
ALARM_TYPE          VARCHAR2(255),
ALARM_STATUS        VARCHAR2(255),
ORIGINAL_SEVERITY   VARCHAR2(255),
ALARM_TIME          VARCHAR2(255),
CANCEL_TIME         VARCHAR2(255),
CANCELLED_BY        VARCHAR2(255),
ACK_STATUS          VARCHAR2(255),
ACK_TIME            VARCHAR2(255),
AC                  VARCHAR2(255)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY TMP_DIR
     ACCESS PARAMETERS 
       ( RECORDS DELIMITED BY NEWLINE
skip 7 
PREPROCESSOR execdir:'zcat'
badfile TMP_DIR:'$1.bad'
logfile TMP_DIR:'$1.log'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
MISSING FIELD VALUES ARE NULL
 )
     LOCATION (TMP_DIR:'$1.zip')
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
