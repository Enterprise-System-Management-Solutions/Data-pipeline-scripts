PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode05
export ORACLE_UNQNAME=dwhdb05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb05
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib



FILE_NAME="EVCTRA_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="EVCTRA01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  EVAC_01_SERIAL_NUMBER                         VARCHAR2(256 BYTE),
  EVAC_02_REGION_ID                             VARCHAR2(256 BYTE),
  EVAC_03_MSISDN_DEALER                         VARCHAR2(256 BYTE),
  EVAC_04_INITIATOR_ID                          VARCHAR2(256 BYTE),
  EVAC_05_DEALER_NAME                           VARCHAR2(256 BYTE),
  EVAC_06_MSISDN_BENEFICIARY                    VARCHAR2(256 BYTE),
  EVAC_07_RECIPIENT_ID                          VARCHAR2(256 BYTE),
  EVAC_08_DEALER_NAME                           VARCHAR2(256 BYTE),
  EVAC_09_PRICE_TYPE                            VARCHAR2(256 BYTE),
  EVAC_10_AMOUNT_ROLLBACK                       VARCHAR2(256 BYTE),
  EVAC_11_SENDER_TRANSACTION                    VARCHAR2(256 BYTE),
  EVAC_12_TRANSFER_DATE                         VARCHAR2(256 BYTE),
  EVAC_13_STATE                                 VARCHAR2(256 BYTE),
  EVAC_14_ERROR_MESSAGE                         VARCHAR2(256 BYTE),
  EVAC_15_ACCESS_TYPE                           VARCHAR2(256 BYTE),
  EVAC_16_DEALER_ACTUAL_DECREASE_MONEY          VARCHAR2(256 BYTE),
  EVAC_17_ACCEPTOR_ACTUAL_INCREASE_MONEY        VARCHAR2(256 BYTE),
  EVAC_18_TRANSFER_TRANSACTION_COMMISSION_RATE  VARCHAR2(256 BYTE),
  EVAC_19_SENDER_TEMPLATE_ID                    VARCHAR2(256 BYTE),
  EVAC_20_RECEIVER_TEMPLATE_ID                  VARCHAR2(256 BYTE),
  EVAC_21_SENDER_BALANCE_STOCK_ADJUSTOR         VARCHAR2(256 BYTE),
  EVAC_22_TRANSFER_HANDLING_FEE                 VARCHAR2(256 BYTE),
  EVAC_23_TAX                                   VARCHAR2(256 BYTE),
  EVAC_24_RECEIVER_BALANCE_AFTER_ADJUSTOR       VARCHAR2(256 BYTE),
  EVAC_25_RECEIVER_BALANCE_BEFORE_ADJUSTOR      VARCHAR2(256 BYTE),
  EVAC_26_CELL_ID                               VARCHAR2(256 BYTE),
  EVAC_27_SOURCE_MESSAGE                        VARCHAR2(256 BYTE),
  EVAC_28_DESTINATION_MESSAGE                   VARCHAR2(256 BYTE),
  EVAC_29_DENOMINATION_NUMBER                   VARCHAR2(256 BYTE),
  EVAC_30_QUANTITY                              VARCHAR2(256 BYTE),
  EVAC_31_ACCOUNT_INDEX                         VARCHAR2(256 BYTE),
  EVAC_32_ACTUAL_PAYMENT_AMOUNT                 VARCHAR2(256 BYTE),
  EVAC_33_RESERVED                              VARCHAR2(256 BYTE),
  EVAC_34_CELL_ID_TRANSFEREE                    VARCHAR2(256 BYTE),
  EVAC_35_RESERVED                              VARCHAR2(256 BYTE),
  EVAC_36_BRAND_TYPE                            VARCHAR2(256 BYTE),
  EVAC_37_RESERVED                              VARCHAR2(256 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EVCTRA_DIR
     ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (EVCTRA_DIR:'$1.unl')
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

