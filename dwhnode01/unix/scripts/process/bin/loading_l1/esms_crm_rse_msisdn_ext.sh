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



FILE_NAME="CRM_RS_MSISDN_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_RS_MSISDN" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  res_id           varchar2(12),
  res_code         VARCHAR2(64),
  vender_id        VARCHAR2(8),
  model_id         VARCHAR2(15),
  category_id      varchar2(8),
  dnseq            VARCHAR2(20),
  create_date      varchar2(36),
  valid_date       varchar2(36),
  invalid_date     varchar2(36),
  dept_id          VARCHAR2(20),
  person           VARCHAR2(10),
  level_id         VARCHAR2(5),
  is_bind          varchar2(1),
  package_mode     VARCHAR2(15),
  package_id       varchar2(12),
  res_status_id    varchar2(4),
  is_locked        varchar2(1),
  is_recycled      varchar2(1),
  oper_date        varchar2(36),
  oper_id          VARCHAR2(20),
  order_status     varchar2(1),
  msisdn           VARCHAR2(20),
  hlr_code         VARCHAR2(5),
  prod_id          VARCHAR2(10),
  sim_card_no      VARCHAR2(20),
  mnp_status       varchar2(1),
  local_lan        VARCHAR2(6),
  lan_hlr          VARCHAR2(15),
  payment_mode     varchar2(1),
  batch_id         VARCHAR2(20),
  tele_type        VARCHAR2(8),
  lotid            VARCHAR2(8),
  warranty_period  varchar2(36),
  mdn_type         VARCHAR2(8),
  prefix           VARCHAR2(20),
  price            varchar2(36),
  issheduled       varchar2(1),
  outschedule_date varchar2(36),
  city             VARCHAR2(20),
  hlr_new          VARCHAR2(5),
  info1            VARCHAR2(256),
  info2            VARCHAR2(256),
  info3            VARCHAR2(256),
  info4            VARCHAR2(256),
  info5            VARCHAR2(256),
  info6            VARCHAR2(256),
  info7            varchar2(36),
  info8            varchar2(36),
  rno              VARCHAR2(10),
  dno              VARCHAR2(10),
  portout_option   CHAR(1),
  mvno_id          VARCHAR2(32)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_RSE_MSISDN_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_RSE_MSISDN_DIR:'$1.unl')
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

