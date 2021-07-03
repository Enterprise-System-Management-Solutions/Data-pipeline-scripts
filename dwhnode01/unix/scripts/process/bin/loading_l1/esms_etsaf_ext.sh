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



FILE_NAME="ETSAF_EXI"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="ETSAF01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
DROP TABLE $FILE_NAME
/
CREATE TABLE $FILE_NAME
(
  MSISDN        VARCHAR2(256 BYTE),
  TYPE          VARCHAR2(256 BYTE),
  NID           VARCHAR2(256 BYTE),
  DOB           VARCHAR2(256 BYTE),
  TXN_NO        VARCHAR2(256 BYTE),
  ICCID         VARCHAR2(256 BYTE),
  ENTRY_DATE    VARCHAR2(256 BYTE),
  PROCESSED_BY  VARCHAR2(256 BYTE),
  IMEI          VARCHAR2(256 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY ETSAF_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
	skip 1
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
	MISSING FIELD VALUES ARE NULL
 )
     LOCATION (ETSAF_DIR:'$1.csv')
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

