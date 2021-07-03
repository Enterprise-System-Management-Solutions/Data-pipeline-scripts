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

v2='v$containers vc'
get_space()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
SET UNDERLINE OFF
SET LINESIZE 32000;
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
select tbspce||',ALLOCATED_'||allocated_gb||'GB,USED_'||used_gb||'GB,FREE_'||free_gb||'GB,USED_PCT_'||used_pct||',DB_'||upper(db)||'~'||free_gb
from
(
select substr(f.tablespace_name,1,30) tbspce,
     round(f.tsbytes/(1024*1024*1024),0) allocated_gb,
     round(nvl(s.segbytes,0)/(1024*1024*1024),0) used_gb,
     round((f.tsbytes-s.segbytes)/(1024*1024*1024)) free_gb,
     round((nvl(s.segbytes,0)/f.tsbytes)*100,2) used_pct,
     lower(vc.name) as db
from
   (select con_id,tablespace_name,sum(bytes) tsbytes from sys.cdb_data_files group by con_id,tablespace_name) f,
   (select con_id,tablespace_name,sum(bytes) segbytes from sys.cdb_segments group by con_id,tablespace_name) s,
   $v2
where f.con_id=s.con_id(+)
  and f.tablespace_name=s.tablespace_name(+)
  and f.con_id=vc.con_id
  and substr(f.tablespace_name,1,30)='DWH_USER_TBS'
  );
EXIT
EOF
}

space=`get_space`

for i in $space
do
free=`echo ${i}|sed s/~/\ /g|awk '{print $2}'` 
echo "$free"
if [ ${free} -lt 60 ]; then
DADDR=sender number
#DADDR2=sender number
text=`echo ${i}|sed s/~/\ /g|awk '{print $1}'`   ### file name
TEXT2=$(echo $text | tr -d ' ')
curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR&text=$TEXT2"
#curl -I "http://192.168.9.85:13015/cgi-bin/sendsms?username=test&password=test&from=TBL_240&to=$DADDR2&text=$TEXT2"
fi
done

