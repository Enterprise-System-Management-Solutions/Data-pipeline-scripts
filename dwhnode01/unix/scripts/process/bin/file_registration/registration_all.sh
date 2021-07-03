##Auther: Tareq
##Purpose : insert file name from source to oracle db
## Date : 2019-12-27

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


XDIR=$1
XDATE_TIME=$2
SDIR=`echo "$XDIR"`
SDATE_TIME=`echo "$XDATE_TIME"`
LIMIT=100
MINCOUNT=1
LDIR='/data02/cbs_cdrs/'$SDIR''


getFileList()
{

cd $LDIR
filecount=`ls cbs_cdr_$SDIR_`$SDATE_TIME`*.add | wc -l`
if [ "$filecount" -gt "$MINCOUNT" ] ; then
        ls  cbs_cdr_$SDIR_`$SDATE_TIME`*.add | head -$LIMIT
fi

}



data_pre()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
INSERT INTO CDR_HEAD
(file_id,file_name,process_status,process_date,source)
values(FILE_ID.nextval,'$1',30,SYSDATE,'$SDIR')
/
COMMIT
/
EXIT
EOF
}



f1=`ps -ef|grep 'registration_all.sh'|grep -v grep|wc -l`
##echo $f1
if [ $f1 -eq 2 ]
then
fileList=`getFileList`

for fil in $fileList
do
echo "moving from /data02/cbs_cdrs/$SDIR/  to /data02/cbs_cdrs/$SDIR/process_dir for ${fil}"
mv $LDIR/$fil /data02/cbs_cdrs/$SDIR/process_dir/$fil
v1=`echo ${fil}|sed s/.add/\ /g|awk '{print $1}'`
data_pre $v1
echo "File registration end for ${v1} `date`"
done
fi

