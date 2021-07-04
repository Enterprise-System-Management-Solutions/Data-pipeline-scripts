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

XDIR=/data02/card
XDATA=$2
type=$1
VGET="$1$2"
LIMIT=10000
MINCOUNT=1
LDIR=$XDIR/$1



getFileList()
{

cd $LDIR
filecount=`ls $VGET*.unl | wc -l`
if [ "$filecount" -gt "$MINCOUNT" ] ; then
        ls  $VGET*.unl | head -$LIMIT
fi

}
getFileList $VGET


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
values(FILE_ID.nextval,'$1',30,SYSDATE,'$type')
/
COMMIT
/
EXIT
EOF
}


f1=`ps -ef|grep 'file_registration.sh'|grep -v grep|wc -l`
echo $f1
if [ $f1 -lt 3 ]
then
fileList=`getFileList`

for fil in $fileList
do
echo "moving from $LDIR  to $LDIR/process for ${fil}"
mv $LDIR/$fil $LDIR/process/$fil
v1=`echo ${fil}|sed s/.unl/\ /g|awk '{print $1}'`
data_pre $v1
echo "File registration end for ${v1} `date`"
done
fi

