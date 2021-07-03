#!/bin/bash
##Auther: Tareq
## date :19 -July-2020
## purpose : to run the jobs for L1 main table Insert from L1 temp table

#dt=`date '+%Y%m%d'`
dt=`date -d yesterday '+%Y%m%d'`

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

L1_FROM_L1_VOICE_TEMP()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
EXECUTE P_L1_FROM_L1_VOICE_TEMP($1)
EXIT
EOF
}

L1_FROM_L1_VOICE_TEMP $dt

echo "$dt"
