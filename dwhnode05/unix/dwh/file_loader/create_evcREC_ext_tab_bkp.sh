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



FILE_NAME="EVCREC_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="EVCREC01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  EVAC_01_SERIAL_NUMBER                    VARCHAR2(256 BYTE),
  EVAC_02_REGION_ID                        VARCHAR2(256 BYTE),
  EVAC_03_MSISDN_DEALER                    VARCHAR2(256 BYTE),
  EVAC_04_INITIATOR_DEALER_ID              VARCHAR2(256 BYTE),
  EVAC_05_INITIATOR_TEMPLATE_ID            VARCHAR2(256 BYTE),
  EVAC_06_DEALER_NAME                      VARCHAR2(256 BYTE),
  EVAC_07_BRAND_TYPE                       VARCHAR2(256 BYTE),
  EVAC_08_USER_BRAND_TYPE                  VARCHAR2(256 BYTE),
  EVAC_09_PRICE                            VARCHAR2(256 BYTE),
  EVAC_10_MSISDN                           VARCHAR2(256 BYTE),
  EVAC_11_SUBSCRIBER_TYPE                  VARCHAR2(256 BYTE),
  EVAC_12_RECHARGE_DATE                    VARCHAR2(256 BYTE),
  EVAC_13_SERIAL_NUMBER_RECHARGEABLE_CARD  VARCHAR2(256 BYTE),
  EVAC_14_RESPONSE_STATE                   VARCHAR2(256 BYTE),
  EVAC_15_TRANSACTION_STATUS               VARCHAR2(256 BYTE),
  EVAC_16_ADJUST_STATUS                    VARCHAR2(256 BYTE),
  EVAC_17_ERROR_MESSAGE                    VARCHAR2(256 BYTE),
  EVAC_18_ACCESS_TYPE                      VARCHAR2(256 BYTE),
  EVAC_19_DEALER_ACTUAL_DECREASE_MONEY     VARCHAR2(256 BYTE),
  EVAC_20_ACCEPTOR_ACTUAL_INCREASE_MONEY   VARCHAR2(256 BYTE),
  EVAC_21_COMMISSION_RATE_RECHARGE         VARCHAR2(256 BYTE),
  EVAC_22_SENDER_ID                        VARCHAR2(256 BYTE),
  EVAC_23_ICCID                            VARCHAR2(256 BYTE),
  EVAC_24_BALANCE_STOCK_ADJUSTOR           VARCHAR2(256 BYTE),
  EVAC_25_RECHARGE_HANDLING_FEE            VARCHAR2(256 BYTE),
  EVAC_26_BALANCE_AFTER_RECHARGE           VARCHAR2(256 BYTE),
  EVAC_27_ENCRYPTED_MSISDN                 VARCHAR2(256 BYTE),
  EVAC_28_CELL_ID                          VARCHAR2(256 BYTE),
  EVAC_29_SOURCE_MESSAGE                   VARCHAR2(256 BYTE),
  EVAC_30_DESTINATION_MESSAGE              VARCHAR2(256 BYTE),
  EVAC_31_FUNCTION_ID                      VARCHAR2(256 BYTE),
  EVAC_32_ACCOUNT_INDEX                    VARCHAR2(256 BYTE),
  EVAC_33_OLD_BALANCE                      VARCHAR2(256 BYTE),
  EVAC_34_NEW_BALANCE                      VARCHAR2(256 BYTE),
  EVAC_35_NEW_VALIDITY                     VARCHAR2(256 BYTE),
  EVAC_36_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_37_ERROR_CODE                       VARCHAR2(256 BYTE),
  EVAC_38_RECHARGE_DURATION                VARCHAR2(256 BYTE),
  EVAC_39_IN_RECHARGE_DURATION             VARCHAR2(256 BYTE),
  EVAC_40_UPSTREAM_MSISDN                  VARCHAR2(256 BYTE),
  EVAC_41_UPSTREAM_NAME                    VARCHAR2(256 BYTE),
  EVAC_42_CELL_ID_RECHARGED_PARTY          VARCHAR2(256 BYTE),
  EVAC_43_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_44_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_45_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_46_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_47_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_48_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_49_RESERVED                         VARCHAR2(256 BYTE),
  EVAC_50_RESERVED                         VARCHAR2(256 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EVCREC_DIR
     ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (EVCREC_DIR:'$1.unl')
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

