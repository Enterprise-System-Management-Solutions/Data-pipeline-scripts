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



FILE_NAME="CRM_ORDER_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_ORDER" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
TRACE_ID           VARCHAR2(64),
ORDER_NO           VARCHAR2(16),
WF_TPL_ID          VARCHAR2(6),
PARENT_ORDER_NO    VARCHAR2(16),
ORDER_TYPE         VARCHAR2(5),
ORDER_SUB_TYPE     VARCHAR2(2),
TELE_TYPE          VARCHAR2(8),
PREPAID_FLAG       VARCHAR2(1),
BUSI_SEQ           VARCHAR2(16),
CUST_ID            VARCHAR2(24),
SUB_ID             VARCHAR2(24),
GROUP_SUB_ID       VARCHAR2(24),
ACCT_ID            VARCHAR2(24),
MSISDN             VARCHAR2(20),
ICCID              VARCHAR2(20),
IMSI               VARCHAR2(20),
ORDER_PRI          VARCHAR2(2),
ORDER_SOURCE       VARCHAR2(6),
DISPATCH_DATE      VARCHAR2(36),
COMPLETE_DATE      VARCHAR2(36),
WANTED_FINISH_DATE VARCHAR2(36),
START_DATE         VARCHAR2(36),
IS_VALID_BILLCYCLE VARCHAR2(1),
VALID_BILLCYCLE_ID VARCHAR2(8),
UNDO_DATE          VARCHAR2(36),
IS_PAID            VARCHAR2(1),
IS_CHECKED         VARCHAR2(1),
ORDER_RUN_STATE    VARCHAR2(1),
ORDER_STATE        VARCHAR2(1),
ABNORMAL_REASON    VARCHAR2(512),
ORDER_CREATE_DATE  VARCHAR2(36),
ORDER_OPER         VARCHAR2(20),
ORDER_DEPT         VARCHAR2(20),
ORDER_LOCAL_ID     VARCHAR2(6),
REMARK             VARCHAR2(256),
PARTITION_ID       VARCHAR2(8),
PROCESS_ID         VARCHAR2(16),
WORK_ITEM          VARCHAR2(256),
CLIENT_IP          VARCHAR2(20),
ISAP_ERR_FLAG      VARCHAR2(32),
CO_LOCK            VARCHAR2(100),
RELA_ORDER_NO      VARCHAR2(32),
CANCEL_ORDER_NO    VARCHAR2(32),
MVNO_ID            VARCHAR2(32)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_ORDER_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_ORDER_DIR:'$1.unl')
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
