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

alter_table()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"

DROP TABLE L1_SMS_TEMP_FULL PURGE;
ALTER TABLE L1_SMS_TEMP RENAME TO L1_SMS_TEMP_FULL;
CREATE TABLE L1_SMS_TEMP AS SELECT * FROM L1_SMS WHERE 1=0;

INSERT INTO TEMP_TABLE_ALTER_LOG(TABLE_NAME,STATUS,ALTER_DATE)
VALUES('L1_SMS_TEMP',96,SYSDATE);
COMMIT;
EXIT
EOF
}

not_alter_table()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"

INSERT INTO TEMP_TABLE_ALTER_LOG(TABLE_NAME,STATUS,ALTER_DATE)
VALUES('L1_SMS_TEMP',34,SYSDATE);
COMMIT;
EXIT
EOF
}


lock=/data02/scripts/process/bin/l1_sms_temp_loader_lock  export lock

if [ -f $lock ] ; then
echo "sms loading1"
sleep 3m
lock1=/data02/scripts/process/bin/l1_sms_temp_loader_lock  export lock
	if [ -f $lock1 ] ; then
	echo "sms loading2"
		sleep 3m
		lock2=/data02/scripts/process/bin/l1_sms_temp_loader_lock  export lock
			if [ -f $lock2 ] ; then
			echo "sms loading3"
				sleep 4m
				lock3=/data02/scripts/process/bin/l1_sms_temp_loader_lock  export lock
					if [ -f $lock3 ] ; then
					echo "sms loading4"
						sleep 5m
						lock4=/data02/scripts/process/bin/l1_sms_temp_loader_lock  export lock
							if [ -f $lock4 ] ; then
							echo "sms loading system exit"
							   not_alter_table
								exit 2
							else
								alter_table
							fi
					else
						alter_table
					fi
			else
			  alter_table
			fi
	else
		alter_table
	fi
else
	alter_table
fi
