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


cd /data04/udn/process_dir
FILES=`ls -ltr *.csv.gz | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i::-7}
sts_code=`sqlplus -s dwh_user/dwh_user_123 <<EOF
SET echo off
SET head off
SET feedback off
select process_status from cdr_head
 where source='HuaweiUDN' 
and file_name='$f'
and trunc(process_date) != trunc(sysdate);
EOF`

if [ $sts_code -eq 32 ]; then rm -f $i; echo "Deleted File: $i"; fi
#if [ $sts_code -eq 96 ]; then mv $i /data04/udn/dump_dir ; echo "Deleted File: $i"; fi

done

