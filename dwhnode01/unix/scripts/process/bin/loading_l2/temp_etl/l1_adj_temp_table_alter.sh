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

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
------------------------------------------------------------
DROP TABLE L1_ADJUSTMENT_TEMP_FULL PURGE;
ALTER TABLE L1_ADJUSTMENT_TEMP RENAME TO L1_ADJUSTMENT_TEMP_FULL;
CREATE TABLE L1_ADJUSTMENT_TEMP AS SELECT * FROM L1_ADJUSTMENT WHERE 1=0;
------------------------------------------------------------
EXIT
EOF


echo "table alter completed"


