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


FILE_NAME="FUO_LOG_TRX_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"


sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  LOG_ID            VARCHAR2(255 BYTE),
  CUST_ID           VARCHAR2(255 BYTE),
  ACCT_ID           VARCHAR2(255 BYTE),
  SUB_ID            VARCHAR2(255 BYTE),
  MSISDN            VARCHAR2(255 BYTE),
  TELE_TYPE         VARCHAR2(255 BYTE),
  TRANS_ID          VARCHAR2(255 BYTE),
  TRANS_TYPE        VARCHAR2(255 BYTE),
  BATCH_NO          VARCHAR2(255 BYTE),
  CHANNEL_ID        VARCHAR2(255 BYTE),
  BSNO              VARCHAR2(255 BYTE),
  BUSI_TYPE         VARCHAR2(255 BYTE),
  INVOICE_TYPE      VARCHAR2(255 BYTE),
  INVOICE_NO        VARCHAR2(255 BYTE),
  CRDR              VARCHAR2(255 BYTE),
  TRX_AMT           VARCHAR2(255 BYTE),
  ADV_AMT           VARCHAR2(255 BYTE),
  DEP_AMT           VARCHAR2(255 BYTE),
  BLL_AMT           VARCHAR2(255 BYTE),
  OS_AMT            VARCHAR2(255 BYTE),
  OP_CUST_ID        VARCHAR2(255 BYTE),
  OP_ACCT_ID        VARCHAR2(255 BYTE),
  OP_SUB_ID         VARCHAR2(255 BYTE),
  OP_MSISDN         VARCHAR2(255 BYTE),
  DEPT_ID           VARCHAR2(255 BYTE),
  OPER_ID           VARCHAR2(255 BYTE),
  ENTRY_DATE        VARCHAR2(255 BYTE),
  RECEIPT_NO        VARCHAR2(255 BYTE),
  PRINT_TIMES       VARCHAR2(255 BYTE),
  PRINT_DATE        VARCHAR2(255 BYTE),
  SRC_TRANS_ID      VARCHAR2(255 BYTE),
  SEQ               VARCHAR2(255 BYTE),
  REASON_CODE       VARCHAR2(255 BYTE),
  STATUS            VARCHAR2(255 BYTE),
  REMARK            VARCHAR2(255 BYTE),
  PAY_ID            VARCHAR2(255 BYTE),
  MEASURE_ID        VARCHAR2(255 BYTE),
  DISCOUNT_LOG_ID   VARCHAR2(255 BYTE),
  DISCOUNT_AMT      VARCHAR2(255 BYTE),
  DISCOUNT          VARCHAR2(255 BYTE),
  AREA_ID           VARCHAR2(255 BYTE),
  IS_CUSTOMER_BILL  VARCHAR2(255 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY FUO_LT_DIR
     ACCESS PARAMETERS 
       ( RECORDS DELIMITED by NEWLINE
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
  )
     LOCATION (FUO_LT_DIR:'$1.list')
  )
REJECT LIMIT UNLIMITED
NOPARALLEL
NOMONITORING;
exit
EOF

echo "External table created"


