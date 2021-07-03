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



FILE_NAME="CRM_BATCH_DEACTIVE_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="CRM_BATCH_DEACTIVE" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
res_seq         varchar2(24),
line            varchar2(10),
task_id         varchar2(10),
group_no        varchar2(6),
order_no        VARCHAR2(16),
create_date     varchar2(36),
status          CHAR(2),
status_date     varchar2(36),
err_type        VARCHAR2(12),
err_msg         VARCHAR2(512),
original_msg    VARCHAR2(256),
msisdn          VARCHAR2(64),
sub_id          varchar2(24),
exp_time        varchar2(36),
iccid_method    VARCHAR2(20),
msisdn_method   VARCHAR2(64),
iccid_position  VARCHAR2(20),
msisdn_position VARCHAR2(64),
idle_flag       CHAR(1),
orderseq        VARCHAR2(16),
batch_id        varchar2(6),
imsi            VARCHAR2(16),
mvno_id         VARCHAR2(32)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_BATCH_DEACTIVE_DIR
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        PREPROCESSOR execdir:'cat'
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_BATCH_DEACTIVE_DIR:'$1.unl')
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

