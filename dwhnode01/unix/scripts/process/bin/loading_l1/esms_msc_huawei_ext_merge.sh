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
CALLTYPE	    VARCHAR2(64),
IMSI                VARCHAR2(64),
IMEI                VARCHAR2(64),
APARTY              VARCHAR2(64),
BPARTY              VARCHAR2(64),
FORWARDING_MSISDN    VARCHAR2(64),
ORIGINATION_TIME     VARCHAR2(64),
CALL_DURATION        VARCHAR2(64),
CAUSE_FOR_TERM        VARCHAR2(150),
GLOBAAREA_ID         VARCHAR2(64)
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

