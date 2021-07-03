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



FILE_NAME="PROVISION_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="PROVISION01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
serial          VARCHAR2(32),
id              VARCHAR2(32),
requestid       VARCHAR2(32),
parentid        VARCHAR2(32),
retcode         VARCHAR2(64),
retdesc         VARCHAR2(256),
createtime      varchar2(36),
opertime        varchar2(36),
bizcode         VARCHAR2(64),
packagename     VARCHAR2(64),
reqparamlist    VARCHAR2(4000),
rspparamlist    VARCHAR2(4000),
prorparamlist   VARCHAR2(4000),
netype          VARCHAR2(64),
processduration varchar2(256),
reqparamblob    BLOB,
rspparamblob    BLOB
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY PROVISION_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (PROVISION_DIR:'$1.unl')
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

