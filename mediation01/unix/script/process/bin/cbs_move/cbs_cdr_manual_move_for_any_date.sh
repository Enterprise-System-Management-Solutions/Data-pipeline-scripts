#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
source=$1
dt=$2
#dt2=`date -"2 day ago" '+%Y%m%d'`


lock=/data02/script/process/bin/cbs_cdr_transfer_backlog  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


#dt=`date -d yesterday '+%Y%m%d'`

cd /data02/cbs

sshpass -p "root335" scp cbs_cdr_${source}_${dt}00*.add  root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}00*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}01*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}01*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}02*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}02*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}03*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}03*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}04*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}04*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}05*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}05*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}06*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}06*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}07*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}07*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}08*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}08*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}09*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}09*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}10*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}10*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}11*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}11*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}12*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}12*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}13*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}13*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}14*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}14*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}15*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}15*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}16*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}16*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}17*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}17*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}18*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}18*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}19*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}19*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}20*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}20*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}21*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}21*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}22*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}22*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}23*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}23*.add  /data02/cbs_dump

rm -f $lock

fi


