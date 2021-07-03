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



FILE_NAME="MS_REC_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="MS_REC" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  MSGID               VARCHAR2(40 BYTE),
  PARTDAY             VARCHAR2(2 BYTE),
  MSGTYPE             VARCHAR2(20 BYTE),
  SERVICETYPE         VARCHAR2(50 BYTE),
  SENDNO              VARCHAR2(50 BYTE),
  RECEIVERINFO        VARCHAR2(50 BYTE),
  CONTENT             VARCHAR2(4000 BYTE),
  ASSARYINFO          VARCHAR2(2000 BYTE),
  PRORITY             VARCHAR2(20 BYTE),
  SENDTIME            VARCHAR2(160 BYTE),
  ACCEPTTIME          VARCHAR2(160 BYTE),
  PICKTIME            VARCHAR2(160 BYTE),
  PICKSTATUS          VARCHAR2(20 BYTE),
  PICKMSPID           VARCHAR2(40 BYTE),
  MSPID               VARCHAR2(40 BYTE),
  SCANID              VARCHAR2(20 BYTE),
  LINKID              VARCHAR2(60 BYTE),
  SENDERCB            VARCHAR2(50 BYTE),
  RECEIVERCB          VARCHAR2(50 BYTE),
  COMMANDID           VARCHAR2(10 BYTE),
  DESTSERVICECODE     VARCHAR2(20 BYTE),
  APPNAME             VARCHAR2(20 BYTE),
  MSGFMT              VARCHAR2(10 BYTE),
  TPPID               VARCHAR2(10 BYTE),
  TPUDHI              VARCHAR2(10 BYTE),
  REPORTSUBMITTIME    VARCHAR2(20 BYTE),
  REPORTSTAT          VARCHAR2(40 BYTE),
  REPORTMSGID         VARCHAR2(40 BYTE),
  REGISTEREDDELIVERY  VARCHAR2(10 BYTE),
  ERRCODE             VARCHAR2(40 BYTE),
  MATCHFLAG           VARCHAR2(10 BYTE),
  REPORTDONETIME      VARCHAR2(40 BYTE),
  EXT1                VARCHAR2(100 BYTE),
  EXT2                VARCHAR2(500 BYTE),
  EXT3                VARCHAR2(500 BYTE),
  EXT4                VARCHAR2(500 BYTE),
  EXT5                VARCHAR2(500 BYTE) 
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY CRM_REC_MSG
        ACCESS PARAMETERS
       ( RECORDS DELIMITED by NEWLINE
        CHARACTERSET UTF8
	PREPROCESSOR execdir:'cat'
	BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (CRM_REC_MSG:'$1.unl')
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
