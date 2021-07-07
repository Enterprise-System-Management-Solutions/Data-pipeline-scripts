#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
source=$1
#dt=`date  '+%Y%m%d'`
#dt2=`date -"2 day ago" '+%Y%m%d'`


dt=`date --date="3 day ago" '+%Y%m%d'`
dt2=`date --date="4 day ago" '+%Y%m%d'`
dt3=`date --date="5 day ago" '+%Y%m%d'`
#dt4=`date --date="6 day ago" '+%Y%m%d'`
dt4=$1


lock=/data02/script/process/bin/cbs_cdr_transfer_backlog  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


#dt=`date -d yesterday '+%Y%m%d'`

cd /data02/cbs

sshpass -p "root335" scp cbs_cdr_${source}_${dt}00*.add  root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}00*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}01*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}01*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}02*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}02*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}03*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}03*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}04*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}04*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}05*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}05*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}06*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}06*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}07*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}07*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}08*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}08*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}09*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}09*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}10*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}10*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}11*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}11*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}12*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}12*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}13*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}13*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}14*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}14*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}15*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}15*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}16*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}16*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}17*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}17*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}18*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}18*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}19*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}19*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}20*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}20*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}21*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}21*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}22*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}22*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt}23*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt}23*.add  /data02/cbs_dump

sshpass -p "root335" scp cbs_cdr_${source}_${dt2}00*.add  root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}00*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}01*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}01*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}02*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}02*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}03*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}03*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}04*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}04*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}05*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}05*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}06*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}06*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}07*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}07*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}08*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}08*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}09*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}09*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}10*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}10*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}11*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}11*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}12*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}12*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}13*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}13*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}14*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}14*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}15*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}15*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}16*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}16*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}17*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}17*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}18*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}18*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}19*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}19*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}20*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}20*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}21*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}21*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}22*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}22*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}23*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt2}23*.add  /data02/cbs_dump


sshpass -p "root335" scp cbs_cdr_${source}_${dt3}00*.add  root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}00*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}01*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}01*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}02*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}02*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}03*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}03*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}04*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}04*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}05*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}05*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}06*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}06*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}07*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}07*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}08*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}08*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}09*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}09*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}10*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}10*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}11*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}11*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}12*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}12*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}13*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}13*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}14*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}14*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}15*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}15*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}16*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}16*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}17*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}17*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}18*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}18*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}19*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}19*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}20*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}20*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}21*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}21*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}22*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}22*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt3}23*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt3}23*.add  /data02/cbs_dump


sshpass -p "root335" scp cbs_cdr_${source}_${dt4}00*.add  root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}00*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}01*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}01*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}02*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}02*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}03*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}03*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}04*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}04*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}05*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}05*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}06*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}06*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}07*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}07*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}08*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}08*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}09*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}09*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}10*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}10*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}11*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}11*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}12*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}12*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}13*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}13*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}14*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}14*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}15*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}15*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}16*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}16*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}17*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}17*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}18*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}18*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}19*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}19*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}20*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}20*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}21*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}21*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}22*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}22*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt4}23*.add   root@192.168.61.240:/data01/cbs
mv cbs_cdr_${source}_${dt4}23*.add  /data02/cbs_dump

rm -f $lock

fi

