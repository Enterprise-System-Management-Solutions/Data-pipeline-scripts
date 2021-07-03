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



FILE_NAME="CRM_PRODUCTS_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_PRODUCTS" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
PRODUCT_SEQ         VARCHAR2(16),
SUB_ID              VARCHAR2(24),
PRODUCT_TYPE        VARCHAR2(1),
PRODUCT_ID          VARCHAR2(10),
MONTHLY_FEE         VARCHAR2(36),
RATEPLAN_TYPE       VARCHAR2(1),
BOUNDLE_FLAG        VARCHAR2(1),
BOUNDLE_ID          VARCHAR2(10),
STATUS              VARCHAR2(5),
CREATE_DATE         VARCHAR2(36),
AMOUNT              VARCHAR2(3),
VALID_FLAG          VARCHAR2(1),
EFF_DATE            VARCHAR2(36),
EXP_DATE            VARCHAR2(36),
REASON              VARCHAR2(4),
BUSI_TYPE           VARCHAR2(5),
BUSI_SEQ            VARCHAR2(16),
REMARK              VARCHAR2(256),
ISVALIDINBILLCYCLE  VARCHAR2(1),
BILL_CYCLE_ID       VARCHAR2(8),
PARTITION_ID        VARCHAR2(8),
PROD_BUNDLE_SEQ     VARCHAR2(16),
SUBSCRIBE_CHANNEL   VARCHAR2(10),
UNSUBSCRIBE_CHANNEL VARCHAR2(10),
SUB_STATUS          VARCHAR2(1),
MVNO_ID             VARCHAR2(32),
PARELLEL_STATUS     VARCHAR2(1)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_PRODUCTS_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_PRODUCTS_DIR:'$1.unl')
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

