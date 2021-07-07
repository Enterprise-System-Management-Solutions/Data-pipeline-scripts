#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
source=$1
#dt=`date  '+%Y%m%d'`
#dt2=`date -d yesterday '+%Y%m%d'`

dt='20200715'

lock=/data02/script/process/bin/cbs_cdr_transfer_manual3  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock



cd /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}18*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}18*.add  /data02/cbs_dump_20200715
sshpass -p "root335" scp cbs_cdr_${source}_${dt}19*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}19*.add  /data02/cbs_dump_20200715
sshpass -p "root335" scp cbs_cdr_${source}_${dt}20*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}20*.add  /data02/cbs_dump_20200715
sshpass -p "root335" scp cbs_cdr_${source}_${dt}21*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}21*.add  /data02/cbs_dump_20200715
sshpass -p "root335" scp cbs_cdr_${source}_${dt}22*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}22*.add  /data02/cbs_dump_20200715
sshpass -p "root335" scp cbs_cdr_${source}_${dt}23*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}23*.add  /data02/cbs_dump_20200715

rm -f $lock

fi

