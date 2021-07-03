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



FILE_NAME="MSC_NOKIA_EXI"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="MSC_NOKIA01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user03/dwh_user_123
set feedback off
DROP TABLE $FILE_NAME
/
CREATE TABLE $FILE_NAME
(
  SERVEDMSISDN   VARCHAR2(264 BYTE),
  CALLINGNUMBER  VARCHAR2(264 BYTE),
  ANSWERTIME     VARCHAR2(264 BYTE),
  CALLDURATION   VARCHAR2(264 BYTE),
  RECORDTYPE     VARCHAR2(264 BYTE),
  CALLTYPE       VARCHAR2(264 BYTE),
  FSTLAC         VARCHAR2(264 BYTE),
  FSTCI          VARCHAR2(264 BYTE),
  LASTLAC        VARCHAR2(264 BYTE),
  LASTCI         VARCHAR2(264 BYTE),
  IMEI           VARCHAR2(264 BYTE),
  IMSI           VARCHAR2(160 BYTE),
  CAUSEFORTERM   VARCHAR2(264 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY MSC_NOKIA_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
 )
     LOCATION (MSC_NOKIA_DIR:'$1.csv')
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
