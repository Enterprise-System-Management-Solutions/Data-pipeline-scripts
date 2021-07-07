#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
source=$1
dtx=`date  '+%Y%m%d%M%S'`
#dt2=`date -d yesterday '+%Y%m%d'`

dt=$2
dt2=$3

lock=/data02/script/process/bin/cbs_cdr_transfer_manual_date_$dtx  export lock

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

mv cbs_cdr_clr_${dt}*.add  /data02/cbs_dump
mv cbs_cdr_clr_${dt2}*.add  /data02/cbs_dump

rm -f $lock

fi

