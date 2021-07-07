#!/bin/bash
PATH='/usr/sbin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/dwhadmin/.local/bin:/home/dwhadmin/bin:/bin'

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

dt=$1
#dt=`date -d yesterday  '+%d%m%Y'`
xdir=/data02/s100_csv_exp/no_list_$dt.csv
zdir=/data02/s100_csv_exp/yes_list_$dt.csv


#-----file export-------#

s100_no_list_exp()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
set echo off
set head off
set feedback off
set trim on
set trimspool on
set headsep on
set termout off
set underline off
set linesize 32000;
set pagesize 40000;
set long 50000;
spool $1
SELECT MSISDN
FROM MIGRATION_CONDITION
WHERE DATE_KEY=(SELECT DATE_KEY FROM DATE_DIM WHERE TRUNC(DATE_VALUE)=TRUNC(TO_DATE('$2','RRRR/MM/DD')))
AND STATUS='N';

EXIT
EOF
}

s100_no_list_exp $xdir $dt



s100_yes_list_exp()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
set echo off
set head off
set feedback off
set trim on
set trimspool on
set headsep on
set termout off
set underline off
set linesize 32000;
set pagesize 40000;
set long 50000;
spool $1
SELECT MSISDN
FROM MIGRATION_CONDITION
WHERE DATE_KEY=(SELECT DATE_KEY FROM DATE_DIM WHERE TRUNC(DATE_VALUE)=TRUNC(TO_DATE('$2','RRRR/MM/DD')))
AND STATUS='Y';

EXIT
EOF
}

s100_yes_list_exp $zdir $dt


#-----file send-------#

#cd /data02/s100_csv_exp/
#scp *list_$dt.csv dwhadmin@192.168.61.253:/data01/hundred_year/out
cd /data02/s100_csv_exp/
sed -i '/^$/d' *list_$dt.csv
sshpass -p "ftp_in_100" sftp -oBatchMode=no -b - ftp_in_100@192.168.61.253 << !
   cd out
   put *list_$dt.csv
   bye
!
