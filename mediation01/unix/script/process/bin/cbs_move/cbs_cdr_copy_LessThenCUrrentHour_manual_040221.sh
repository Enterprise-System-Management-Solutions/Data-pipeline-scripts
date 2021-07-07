#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
source=$1
#dt=`date  '+%Y%m%d'`
#dt2=`date -d yesterday '+%Y%m%d'`

hour=`date  '+%Y%m%d%H'`

dt=$1
dt2=$2

lock=/data02/script/process/bin/cbs_cdr_transfer_LessThenCurrentHour_manual_${1}  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


#dt=`date -d yesterday '+%Y%m%d'`

cd /data02/cbs

if [ ${dt}00 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}00*.add  root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}00*.add  /data02/cbs_dump
fi

if [ ${dt}01 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}01*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}01*.add  /data02/cbs_dump
fi

if [ ${dt}02 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}02*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}02*.add  /data02/cbs_dump
fi

if [ ${dt}03 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}03*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}03*.add  /data02/cbs_dump
fi

if [ ${dt}04 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}04*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}04*.add  /data02/cbs_dump
fi

if [ ${dt}05 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}05*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}05*.add  /data02/cbs_dump
fi

if [ ${dt}06 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}06*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}06*.add  /data02/cbs_dump
fi
if [ ${dt}07 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}07*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}07*.add  /data02/cbs_dump
fi

if [ ${dt}08 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}08*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}08*.add  /data02/cbs_dump
fi

if [ ${dt}09 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}09*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}09*.add  /data02/cbs_dump
fi
if [ ${dt}10 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}10*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}10*.add  /data02/cbs_dump
fi

if [ ${dt}11 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}11*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}11*.add  /data02/cbs_dump
fi

if [ ${dt}12 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}12*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}12*.add  /data02/cbs_dump
fi

if [ ${dt}13 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}13*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}13*.add  /data02/cbs_dump
fi

if [ ${dt}14 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}14*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}14*.add  /data02/cbs_dump
fi

if [ ${dt}15 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}15*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}15*.add  /data02/cbs_dump
fi

if [ ${dt}16 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}16*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}16*.add  /data02/cbs_dump
fi

if [ ${dt}17 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}17*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}17*.add  /data02/cbs_dump
fi

if [ ${dt}18 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}18*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}18*.add  /data02/cbs_dump
fi

if [ ${dt}19 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}19*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}19*.add  /data02/cbs_dump
fi

if [ ${dt}20 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}20*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}20*.add  /data02/cbs_dump
fi

if [ ${dt}21 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}21*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}21*.add  /data02/cbs_dump
fi

if [ ${dt}22 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}22*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}22*.add  /data02/cbs_dump
fi

if [ ${dt}23 -lt $hour ];  then
sshpass -p "root335" scp cbs_cdr_${source}_${dt}23*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt}23*.add  /data02/cbs_dump
fi



sshpass -p "root335" scp cbs_cdr_${source}_${dt2}00*.add  root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}00*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}01*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}01*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}02*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}02*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}03*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}03*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}04*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}04*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}05*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}05*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}06*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}06*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}07*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}07*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}08*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}08*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}09*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}09*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}10*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}10*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}11*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}11*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}12*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}12*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}13*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}13*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}14*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}14*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}15*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}15*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}16*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}16*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}17*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}17*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}18*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}18*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}19*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}19*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}20*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}20*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}21*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}21*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}22*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}22*.add  /data02/cbs_dump
sshpass -p "root335" scp cbs_cdr_${source}_${dt2}23*.add   root@192.168.61.202:/data05/cbs
mv cbs_cdr_${source}_${dt2}23*.add  /data02/cbs_dump

mv cbs_cdr_clr_${dt}*.add  /data02/cbs_dump
mv cbs_cdr_clr_${dt2}*.add  /data02/cbs_dump

rm -f $lock

fi

