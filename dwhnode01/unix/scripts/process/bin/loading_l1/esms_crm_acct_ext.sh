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



FILE_NAME="CRM_ACCCT_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_ACCCT" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  acct_id             varchar2(24),
  cust_id             varchar2(24),
  tele_type           VARCHAR2(6),
  acct_code           VARCHAR2(64),
  acct_type           varchar2(1),
  payment_no          VARCHAR2(64),
  payment_mode        VARCHAR2(6),
  bill_cycle_type     VARCHAR2(2),
  converge_flag       varchar2(1),
  title               VARCHAR2(10),
  name1               VARCHAR2(192),
  name2               VARCHAR2(192),
  name3               VARCHAR2(192),
  name4               VARCHAR2(192),
  address_seq         VARCHAR2(16),
  currency_id         varchar2(24),
  lang                VARCHAR2(6),
  password            VARCHAR2(20),
  init_balance        varchar2(36),
  orign_credit        varchar2(36),
  credit_limit        varchar2(36),
  suppress_bill       VARCHAR2(16),
  suppress_exp_date   varchar2(36),
  divert_bill         VARCHAR2(16),
  divert_exp_date     varchar2(36),
  create_date         varchar2(36),
  eff_date            varchar2(36),
  exp_date            varchar2(36),
  mod_date            varchar2(36),
  create_oper_id      VARCHAR2(20),
  create_local_id     VARCHAR2(6),
  busi_seq            VARCHAR2(16),
  lbc_date            varchar2(36),
  status              varchar2(1),
  remark              VARCHAR2(256),
  acct_init_credit_id VARCHAR2(10),
  partition_id        varchar2(8),
  credit_type         VARCHAR2(16),
  bill_tmpl_id        VARCHAR2(32),
  sync_ocs            VARCHAR2(5),
  ownership_tax_flag  VARCHAR2(1),
  billing_group       VARCHAR2(32),
  acct_category       VARCHAR2(32),
  pan                 VARCHAR2(128),
  mvno_id             VARCHAR2(32),
  show_tax_flag       VARCHAR2(1),
  payment_method      VARCHAR2(16),
  warning_level       VARCHAR2(6),
  dealer_machine_id   VARCHAR2(64),
  info1               VARCHAR2(20),
  info2               VARCHAR2(20),
  info3               VARCHAR2(20),
  info4               VARCHAR2(20),
  info5               VARCHAR2(20),
  info6               VARCHAR2(20),
  info7               VARCHAR2(20),
  info8               VARCHAR2(20),
  info9               varchar2(36),
  info10              varchar2(36)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_ACCCT_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_ACCCT_DIR:'$1.unl')
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

