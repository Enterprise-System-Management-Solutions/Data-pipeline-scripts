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


partition()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
SELECT TABLE_NAME||','||MAX(PARTITION_NAME) AS PARTITION_NAME
FROM ALL_TAB_PARTITIONS
WHERE TABLE_NAME='L1_RECHARGE'
AND TRUNC(LAST_ANALYZED)=TRUNC(SYSDATE-1)
GROUP BY TABLE_NAME;
EXIT
EOF
}

insert_smsc()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE
INSERT INTO L1_RECHARGE PARTITION($1)
SELECT * FROM L1_RECHARGE_MANUAL;
COMMIT;
EXIT
EOF
}



lock=/data02/scripts/bin/l1-vou_manual_l1_vou export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

pert=`partition`

for fil in $pert
do

v1=`echo ${fil}|sed s/,/\ /g|awk '{print $2}'`   ### partition name
echo $v1

insert_smsc $v1

done

rm -f $lock

