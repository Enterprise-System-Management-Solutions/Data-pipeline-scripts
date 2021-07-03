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



FILE_NAME="CRM_RSE_SIM_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_RSE_SIM" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
RES_ID          VARCHAR2(12),
RES_CODE        VARCHAR2(64),
VENDER_ID       VARCHAR2(8),
MODEL_ID        VARCHAR2(15),
CATEGORY_ID     VARCHAR2(8),
DNSEQ           VARCHAR2(20),
CREATE_DATE     VARCHAR2(36),
VALID_DATE      VARCHAR2(36),
INVALID_DATE    VARCHAR2(36),
DEPT_ID         VARCHAR2(20),
PERSON          VARCHAR2(10),
LEVEL_ID        VARCHAR2(5),
IS_BIND         VARCHAR2(1),
PACKAGE_MODE    VARCHAR2(15),
PACKAGE_ID      VARCHAR2(12),
RES_STATUS_ID   VARCHAR2(4),
IS_LOCKED       VARCHAR2(1),
IS_RECYCLED     VARCHAR2(1),
OPER_DATE       VARCHAR2(36),
OPER_ID         VARCHAR2(20),
ORDER_STATUS    VARCHAR2(1),
ICCID           VARCHAR2(20),
IMSI            VARCHAR2(15),
K               VARCHAR2(32),
PIN1            VARCHAR2(32),
PUK1            VARCHAR2(128),
PIN2            VARCHAR2(32),
PUK2            VARCHAR2(128),
KLA1            VARCHAR2(16),
KLA2            VARCHAR2(16),
KLA3            VARCHAR2(16),
KIC3            VARCHAR2(32),
KID3            VARCHAR2(32),
KIC8            VARCHAR2(32),
KID8            VARCHAR2(32),
KIC9            VARCHAR2(32),
KID9            VARCHAR2(32),
HLR_CODE        VARCHAR2(5),
LOCAL_LAN       VARCHAR2(6),
LAN_HLR         VARCHAR2(15),
PAYMENT_MODE    VARCHAR2(1),
BATCH_ID        VARCHAR2(20),
LOTID           VARCHAR2(8),
WARRANTY_PERIOD VARCHAR2(36),
TELE_TYPE       VARCHAR2(8),
ESN             VARCHAR2(200),
AKEY            VARCHAR2(200),
MDN_TYPE        VARCHAR2(8),
IMSI2           VARCHAR2(15),
PREFIX          VARCHAR2(20),
PRICE           VARCHAR2(36),
CITY            VARCHAR2(20),
HLR_NEW         VARCHAR2(5),
KI              VARCHAR2(200),
ADM1            VARCHAR2(200),
KOTA            VARCHAR2(200),
INFO1           VARCHAR2(256),
INFO2           VARCHAR2(256),
INFO3           VARCHAR2(256),
INFO4           VARCHAR2(256),
INFO5           VARCHAR2(256),
INFO6           VARCHAR2(256),
INFO7           VARCHAR2(36),
INFO8           VARCHAR2(36),
MVNO_ID         VARCHAR2(32)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_RES_SIM_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_RES_SIM_DIR:'$1.unl')
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

