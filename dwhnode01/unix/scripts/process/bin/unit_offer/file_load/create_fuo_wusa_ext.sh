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


FILE_NAME="FUO_W_UVS_SERVICEAREA_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"


sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  NATIVEMSCADDRESS  VARCHAR2(255 BYTE),
  PROVINCECODE      VARCHAR2(255 BYTE),
  PROVINCENAME      VARCHAR2(255 BYTE),
  AREACODE          VARCHAR2(255 BYTE),
  AREANAME          VARCHAR2(255 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY FUO_WUSA_DIR
     ACCESS PARAMETERS 
       ( RECORDS DELIMITED by NEWLINE
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
   )
     LOCATION (FUO_WUSA_DIR:'$1.list')
  )
REJECT LIMIT UNLIMITED
NOPARALLEL
NOMONITORING;
exit
EOF

echo "External table created"


