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



FILE_NAME="CRM_SUBS_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_SUBS" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
SUB_ID              VARCHAR2(24),
CUST_ID             VARCHAR2(24),
ACTUAL_CUST_ID      VARCHAR2(24),
SUB_TYPE            VARCHAR2(1),
SUBGROUP_TYPE       VARCHAR2(10),
SUBGROUP_NAME       VARCHAR2(300),
TELE_TYPE           VARCHAR2(8),
PREPAID_FLAG        VARCHAR2(1),
MSISDN              VARCHAR2(64),
IMSI                VARCHAR2(20),
ICCID               VARCHAR2(20),
SUB_PASSWORD        VARCHAR2(200),
SUB_LAN             VARCHAR2(10),
SUB_LEVEL           VARCHAR2(10),
SUB_GROUP           VARCHAR2(10),
SUB_SEGMENT         VARCHAR2(10),
DUN_FLAG            VARCHAR2(1),
DUN_START_DATE      VARCHAR2(36),
DUN_EXPIRY_DATE     VARCHAR2(36),
SUB_INIT_CREDIT     VARCHAR2(56),
SUB_CREDIT          VARCHAR2(56),
SUB_STATE           VARCHAR2(5),
SUB_STATE_REASON    VARCHAR2(24),
AGREEMENT_NO        VARCHAR2(45),
CREATE_DATE         VARCHAR2(36),
AGREEMENT_DATE      VARCHAR2(36),
FIRST_EFF_DATE      VARCHAR2(36),
EFF_DATE            VARCHAR2(36),
EXP_DATE            VARCHAR2(36),
MOD_DATE            VARCHAR2(36),
ACTIVE_DATE         VARCHAR2(36),
LATEST_ACTIVE_DATE  VARCHAR2(36),
CREATE_OPER_ID      VARCHAR2(20),
CREATE_LOCAL_ID     VARCHAR2(6),
BUSI_SEQ            VARCHAR2(16),
REMARK              VARCHAR2(256),
PARTITION_ID        VARCHAR2(8),
SUB_INIT_CREDIT_ID  VARCHAR2(10),
VIRTUAL_SUB_ID      VARCHAR2(24),
CPE_MAC             VARCHAR2(30),
RESERVE_RECONN_TIME VARCHAR2(36),
DEALER_ID           VARCHAR2(20),
INFO1               VARCHAR2(256),
INFO2               VARCHAR2(256),
INFO3               VARCHAR2(256),
INFO4               VARCHAR2(256),
INFO5               VARCHAR2(256),
INFO6               VARCHAR2(256),
INFO7               VARCHAR2(256),
INFO8               VARCHAR2(256),
INFO9               VARCHAR2(8),
INFO10              VARCHAR2(8),
INFO11              VARCHAR2(36),
INFO12              VARCHAR2(36),
RELA_MSISDN         VARCHAR2(64),
USERNAME            VARCHAR2(64),
BRAND_ID            VARCHAR2(32),
DISPLAY_TYPE        VARCHAR2(10),
MVNO_ID             VARCHAR2(32),
HLR_FLAG            VARCHAR2(10),
SENDER              VARCHAR2(20)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_SUBS_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_SUBS_DIR:'$1.unl')
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

