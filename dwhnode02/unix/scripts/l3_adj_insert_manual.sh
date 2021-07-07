

export ORACLE_UNQNAME=DWH05
export ORACLE_SID=DWH05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=/data01/app/oracle/product/12.2.0/db_1

PATH=/usr/sbin:$PATH:$ORACLE_HOME/bin

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib;
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib;




DATA_INSERT_L3_ADJ()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
EXECUTE P_L2_TO_L3_ADJUSTMENT_MANUAL($1)
EXIT
EOF
}

DATA_INSERT_L3_ADJ $1
echo "$1"


