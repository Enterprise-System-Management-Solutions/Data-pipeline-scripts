

#!/bin/bash
PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode02
export ORACLE_UNQNAME=dwhdb02
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb02
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


dt=`date -d yesterday '+%Y%m%d'`

xdir=/tmp/date_dim.csv

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET ECHO OFF
SET WRAP OFF
SET HEAD OFF 
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET HEADSEP ON
SET TERMOUT OFF
SET UNDERLINE OFF
SET LINESIZE 20000
SET PAGESIZE 0
SPOOL $xdir
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
SELECT /*+ parallel(A,16)*/  DATE_KEY||'|'||DATE_VALUE||'|'||DAYS||'|'||MONTH_SHORT||'|'||MONTH_NUM||'|'||MONTH_LONG||'|'||MONTH_KEY||'|'||YEAR
AS "DATE_KEY|DATE_VALUE|DAYS|MONTH_SHORT|MONTH_NUM|MONTH_LONG|MONTH_KEY|YEAR"
FROM DATE_DIM A
WHERE TO_DATE(DATE_VALUE,'dd/mm/rrrr')> TO_DATE('01/01/2017','dd/mm/rrrr');
EXIT
EOF

