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



FILE_NAME="MSC_HUAWEI_EXI"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="MSC_HUAWEI01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user03/dwh_user_123
set feedback off
DROP TABLE $FILE_NAME
/
CREATE TABLE $FILE_NAME
(
  MH01_CALLTYPE          VARCHAR2(64 BYTE),
  MH02_SERVEDIMSI        VARCHAR2(64 BYTE),
  MH03_SERVEDIMEI        VARCHAR2(64 BYTE),
  MH04_APARTYMSISDN      VARCHAR2(64 BYTE),
  MH05_BPARTYMSISDN      VARCHAR2(64 BYTE),
  MH06_FORWARDINGMSISDN  VARCHAR2(64 BYTE),
  MH07_ORIGINATIONTIME   VARCHAR2(64 BYTE),
  MH08_CALLDURATION      VARCHAR2(64 BYTE),
  MH09_CAUSEFORTERM      VARCHAR2(150 BYTE),
  MH10_GLOBAAREAID       VARCHAR2(64 BYTE),
  MH11_LAST_LOCATION     VARCHAR2(64 BYTE),
  FILE_FLAG              VARCHAR2(64 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY MSC_HUAWEI_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
        MISSING FIELD VALUES ARE NULL
 )
     LOCATION (MSC_HUAWEI_DIR:'$1.csv')
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
