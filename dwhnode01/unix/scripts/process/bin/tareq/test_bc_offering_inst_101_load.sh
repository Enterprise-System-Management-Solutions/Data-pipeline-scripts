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
INSERT INTO TEST_BC_OFFERING_INST_101(SUB_ID, TYPE, OFFERID, EFF_DATE, EXP_DATE,date_key)
SELECT COLUMN1, COLUMN2, COLUMN3, COLUMN4, COLUMN5,(SELECT DATE_KEY FROM DATE_DIM WHERE TO_CHAR(DATE_VALUE,'RRRRMMDD')=TO_CHAR(SYSDATE-3,'RRRRMMDD'))DATE_KEY
FROM TEST_BC_OFFERING_INST_101_EXT
/
COMMIT
/
EXIT
EOF
