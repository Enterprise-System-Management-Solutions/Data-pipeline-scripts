
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
WHERE TABLE_NAME='L1_MANAGEMENT'
AND TRUNC(LAST_ANALYZED)=TRUNC(SYSDATE)
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
DROP TABLE L1_MANAGEMENT_MANUAL PURGE;
CREATE TABLE L1_MANAGEMENT_MANUAL AS
SELECT * FROM L1_MANAGEMENT PARTITION($1);
COMMIT;
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
ALTER TABLE L1_MANAGEMENT DROP PARTITION $1;
EXIT
EOF
}


lock=/data02/scripts/bin/insert_l1_com_manual  export lock

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

	RESULT=$?
	if [ $RESULT -eq 0 ]; then
		drop_partition $v1
	else
	  exit 2
	fi
done

rm -f $lock


