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
OBJECT_IDENTITY_NAME	VARCHAR2(255),
OBJECT_IDENTITY         VARCHAR2(255),
PRODUCT_NAME            VARCHAR2(255),
NE_TYPE                 VARCHAR2(255),
NE_OBJECT_IDENTITY      VARCHAR2(255),
ALARM_SOURCE            VARCHAR2(255),
ALARM_NAME              VARCHAR2(255),
TYPE                    VARCHAR2(255),
OCCURRENCE_TIME         VARCHAR2(255),
CLEARANCE_TIME          VARCHAR2(255),
LOCATION_INFORMATION    VARCHAR2(255),
ALARM_ID                VARCHAR2(255),
OBJECT                  VARCHAR2(255),
INSTANCE_TYPE           VARCHAR2(255),
ADDTIONAL_TEXT          VARCHAR2(255)
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
	MISSING FIELD VALUES ARE NULL
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



