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



FILE_NAME="CRM_CUSTOM_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_CUSTOM" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
CUST_ID              varchar2(24),
PARENT_CUST_ID       varchar2(24),
CUST_TYPE            VARCHAR2(10),
CUST_CLASS           VARCHAR2(10),
CUST_CODE            VARCHAR2(64),
ID_TYPE              VARCHAR2(10),
ID_NUMBER            VARCHAR2(96),
CUST_TITLE           VARCHAR2(10),
NAME1                VARCHAR2(192),
NAME2                VARCHAR2(192),
NAME3                VARCHAR2(192),
CUST_PWD             VARCHAR2(16),
NATION               VARCHAR2(10),
CUST_LANG            VARCHAR2(10),
CUST_LEVEL           VARCHAR2(10),
CUST_SEGMENT         VARCHAR2(10),
CUST_STATUS          VARCHAR2(5),
CUST_DEFAULT_ACCT    varchar2(24),
CREATE_DATE          varchar2(36),
EFF_DATE             varchar2(36),
EXP_DATE             varchar2(36),
MOD_DATE             varchar2(36),
CREATE_OPER_ID       VARCHAR2(20),
CREATE_LOCAL_ID      VARCHAR2(6),
BUSI_SEQ             VARCHAR2(16),
REMARK               VARCHAR2(256),
SYNC_OCS             VARCHAR2(5),
PARTITION_ID         varchar2(8),
DEALER               VARCHAR2(8),
MEMO_DATE_TYPE       VARCHAR2(1),
MEMO_DATE            varchar2(36),
AUDIT_STATUS         VARCHAR2(1),
AUDIT_DATE           varchar2(36),
SERVICE_CATEGORY     VARCHAR2(32),
SERVICE_LIMIT_FLAG   VARCHAR2(1),
DOCUMENT_STATUS      VARCHAR2(1),
DOCUMENT_STATUS_TIME varchar2(36),
CUST_DEPT            VARCHAR2(32),
DISTRICT             VARCHAR2(32),
DESIGNATION          VARCHAR2(32),
MVNO_ID              VARCHAR2(32)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_CUS_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_CUS_DIR:'$1.unl')
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

