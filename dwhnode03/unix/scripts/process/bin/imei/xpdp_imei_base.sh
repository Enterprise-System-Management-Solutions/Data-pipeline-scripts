#!/bin/bash

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp

export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode03
export ORACLE_UNQNAME=dwhdb03
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb03
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


dt=`date --date=' 1 days ago' '+%Y%m%d'`

expdp dwh_user03/dwh_user_123 tables=LD_IMEI_FCT directory=backup_dir dumpfile=imei_fct_$dt.dmp logfile=expdpimei_fct_$dt.log

cd /data05/backup

sshpass -p 'LandRND@@BI' scp *fct_${dt}* root@192.168.61.253:/data01/imei
