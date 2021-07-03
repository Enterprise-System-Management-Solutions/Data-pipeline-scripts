#Author :       Tareq
#Date   :       09-08-2020
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

alter_table()
{
sqlplus  -s <<EOF
dwh_user03/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"

DROP TABLE L1_MSC_HUAWEI PURGE;
ALTER TABLE L1_MSC_HUAWEI_TEMP RENAME TO L1_MSC_HUAWEI;
CREATE TABLE L1_MSC_HUAWEI_TEMP AS SELECT * FROM L1_MSC_HUAWEI WHERE 1=0;

INSERT INTO TEMP_TABLE_ALTER_LOG(TABLE_NAME,STATUS,ALTER_DATE)
VALUES('L1_MSC_HUAWEI',96,SYSDATE);
COMMIT;
EXIT
EOF
}



not_alter_table()
{
sqlplus  -s <<EOF
dwh_user03/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"

INSERT INTO TEMP_TABLE_ALTER_LOG(TABLE_NAME,STATUS,ALTER_DATE)
VALUES('L1_MSC_HUAWEI',34,SYSDATE);
COMMIT;
EXIT
EOF
}

lock=/data02/scripts/process/bin/l1_msc_huawei  export lock

if [ -f $lock ] ; then
echo "huawei loading1"
sleep 3m
lock2=/data02/scripts/process/bin/l1_msc_huawei  export lock
        if [ -f $lock2 ] ; then
        echo "huawei loading2"
                sleep 3m
                lock3=/data02/scripts/process/bin/l1_msc_huawei  export lock
                        if [ -f $lock3 ] ; then
                        echo "huawei loading3"
                                sleep 4m
                                lock4=/data02/scripts/process/bin/l1_msc_huawei  export lock
                                        if [ -f $lock4 ] ; then
                                        echo "huawei loading4"
                                                sleep 5m
                                                lock5=/data02/scripts/process/bin/l1_msc_huawei  export lock
                                                        if [ -f $lock5 ] ; then
                                                        echo "huawei loading system exit"
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

