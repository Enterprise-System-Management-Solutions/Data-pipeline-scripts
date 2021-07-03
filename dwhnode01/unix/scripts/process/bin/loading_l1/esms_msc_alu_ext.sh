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



FILE_NAME="MSC_ALU_EXI"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="MSC_ALU" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
DROP TABLE $FILE_NAME
/
CREATE TABLE $FILE_NAME
(
  CALLTYPE            VARCHAR2(264 BYTE),
  IMSI                VARCHAR2(264 BYTE),
  IMEI                VARCHAR2(264 BYTE),
  MSISDNAPARTY        VARCHAR2(264 BYTE),
  MSISDNBPARTY        VARCHAR2(264 BYTE),
  FORWARDEDMSISDN     VARCHAR2(264 BYTE),
  ANSWERTIMESTAMP     VARCHAR2(264 BYTE),
  CALLDUR             VARCHAR2(264 BYTE),
  AREACODE            VARCHAR2(264 BYTE),
  CELLID              VARCHAR2(160 BYTE),
  CAUSEOFTERMINATION  VARCHAR2(264 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY MSC_ALU_DIR
	ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
	PREPROCESSOR execdir:'cat'
	BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
)
     LOCATION (MSC_ALU_DIR:'$1.csv')
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

