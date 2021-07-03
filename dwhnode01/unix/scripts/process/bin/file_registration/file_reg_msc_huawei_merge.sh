#Author :       Tareq
#Date   :       16-05-2020
#!/bin/bash

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


#DATE=$1
#DATE=`date '+%Y%m%d'`
#file_name='bRMNMSSH'
file_name='MSC'
type='msc_huawei'
LIMIT=1000
MINCOUNT=0
LDIR=/data02/sftp_msc/huawei

getFileList()
{

cd $LDIR
filecount=`ls *$file_name.csv | wc -l`
if [ "$filecount" -gt "$MINCOUNT" ] ; then
        ls  *$file_name.csv | head -$LIMIT
fi

}
#getFileList $DATE
getFileList $file_name


data_pre()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE

INSERT INTO CDR_HEAD
(file_id,file_name,process_status,process_date,source,pre_count)
values(FILE_ID.nextval,'$1',30,SYSDATE,'$type',$2)
/
COMMIT
/
EXIT
EOF
}


f1=`ps -ef|grep 'file_reg_smsc.sh'|grep -v grep|wc -l`
echo $f1
if [ $f1 -lt 2 ]
then
fileList=`getFileList`

for fil in $fileList
do
echo "moving from $LDIR  to $LDIR/process_dir for ${fil}"
##pre_count for every files
pc1=`cat $LDIR/$fil | wc -l`

mv $LDIR/$fil $LDIR/process_dir/$fil
v1=`echo ${fil}|sed s/.csv/\ /g|awk '{print $1}'`
data_pre $v1 $pc1
echo "File registration end for ${v1} `date`"
done
fi

