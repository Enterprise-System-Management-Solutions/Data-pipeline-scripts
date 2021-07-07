source=$1
#dt=`date  '+%Y%m%d'`
dt2=`date -d yesterday '+%Y%m%d'`

dt='20200707'
#dt2='20200630'

lock=/data02/script/process/bin/cbs_cdr_transfer_manual2  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


#dt=`date -d yesterday '+%Y%m%d'`

cd /data02/cbs_dump_old

sshpass -p "root123" scp cbs_cdr_${source}_${dt}23*.add   root@192.168.61.240:/data01/cbs
#mv cbs_cdr_${source}_${dt}23*.add  /data02/cbs_dump

rm -f $lock

fi

