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


sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
INSERT INTO PARTITION_LOG
SELECT TABLE_NAME,PARTITION_NAME,SYSDATE,'N' AS STSTUS
FROM ALL_TAB_PARTITIONS
WHERE TABLE_NAME='L1_HUAWEIUDN'
AND PARTITION_NAME NOT IN (SELECT PARTITION_NAME FROM PARTITION_LOG);
COMMIT;
EXIT
EOF


partition()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
SELECT F_PARTITION_UDN FROM DUAL;
EXIT
EOF
}

drop_partition()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
ALTER TABLE L1_HUAWEIUDN DROP PARTITION $1 
/
UPDATE DWH_USER.PARTITION_LOG SET STATUS='Y'
WHERE PARTITION_NAME='$1'
/
COMMIT
/
EXIT
EOF
}


lock=/data02/scripts/dwh/lock/drop_partition  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

pert=`partition`

for fil in $pert
do

v1=`echo ${fil}|sed s/,/\ /g|awk '{print $1}'`   ### partition name
echo $v1
drop_partition $v1

done

rm -f $lock

fi
    
