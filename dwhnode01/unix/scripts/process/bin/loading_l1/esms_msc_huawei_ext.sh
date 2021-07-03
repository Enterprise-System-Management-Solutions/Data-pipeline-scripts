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



FILE_NAME="MSC_HUAWEI_EXI"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="MSC_HUAWEI" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
DROP TABLE $FILE_NAME
/
CREATE TABLE $FILE_NAME
(
  MH01_CALLTYPE          VARCHAR2(264),
  MH02_SERVEDIMSI        VARCHAR2(264),
  MH03_SERVEDIMEI        VARCHAR2(264),
  MH04_APARTYMSISDN      VARCHAR2(264),
  MH05_BPARTYMSISDN      VARCHAR2(264),
  MH06_FORWARDINGMSISDN  VARCHAR2(264),
  MH07_ORIGINATIONTIME   VARCHAR2(264),
  MH08_CALLDURATION      VARCHAR2(264),
  MH09_CAUSEFORTERM      VARCHAR2(150),
  MH10_GLOBAAREAID       VARCHAR2(264)
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

