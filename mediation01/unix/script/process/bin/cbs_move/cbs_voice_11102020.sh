#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       09-10-2020
#cbs cdr transfer 253~240 server and move dump directory



lock=/data02/script/process/bin/voice_cdr_transfer_test_11102020_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

xdir=/data02/cbs_dump
zdir=/data01/cbs

cd /data02/cbs

wc=`ls *voice*|wc -l`
count=$(( $wc - 5 ))


FILES=`ls -lt *voice*.add|tail -$count | awk -F" " {'print $9'}`
for i in $FILES
do
sshpass -p "root335" scp "$i" root@192.168.61.240:$zdir
mv $i $xdir
done

rm -f $lock

fi
