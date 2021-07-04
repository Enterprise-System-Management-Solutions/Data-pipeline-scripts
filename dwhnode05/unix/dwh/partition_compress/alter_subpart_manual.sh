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

sqlplus  -s <<EOF
conn / as sysdba
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
EXECUTE DWH_USER.P_SUBPARTITION_LOG
EXIT
EOF



alter_sub_part()
{
sqlplus  -s <<EOF
conn / as sysdba
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
ALTER TABLE DWH_USER.L1_HUAWEIUDN MOVE SUBPARTITION $1 TABLESPACE DWH_USER_TBS NOLOGGING COMPRESS PARALLEL 8
/
UPDATE DWH_USER.SUBPARTITION_LOG SET STATUS='Y'
WHERE SUBPARTITION_NAME='$1'
/
COMMIT
/
EXIT
EOF
}

alter_sub_part $1
