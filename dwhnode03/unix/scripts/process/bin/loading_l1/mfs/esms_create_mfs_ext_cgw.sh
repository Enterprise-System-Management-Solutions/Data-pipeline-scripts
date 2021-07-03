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




FILE_NAME="CGW_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CGW" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user03/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  ID                VARCHAR2(12 BYTE),
  GLOBAL_ID         VARCHAR2(56 BYTE),
  TID               VARCHAR2(56 BYTE),
  USER_ID           VARCHAR2(12 BYTE),
  USERNAME          VARCHAR2(12 BYTE),
  OPERATION         VARCHAR2(12 BYTE),
  MSISDN            VARCHAR2(56 BYTE),
  PREPAID           CHAR(2 BYTE),
  RESULT_CODE       VARCHAR2(24 BYTE),
  RESULT_DESC       VARCHAR2(100 BYTE),
  CURRENT_BALANCE   CHAR(36 BYTE),
  PREVIOUS_BALANCE  CHAR(36 BYTE),
  AMOUNT            VARCHAR2(24 BYTE),
  TRANSACTION_TIME  VARCHAR2(20 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CGW_DIR
     ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CGW_DIR:'$1.txt')
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
