#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

#Author :       Tareq
#Date   :       24-06-2020
#cbs file move 253~240

export SSHPASS='root123'
echo $SSHPASS



lock=/data02/script/process/bin/cbs_transfer_253_240  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data02/cbs

xdir=/data02/cbs_dump
zdir=/data01/cbs

FILES=`ls -ltr *.add | awk -F" " {'print $9'}`
for i in $FILES
do
#f=${i}
sshpass -p "root123" scp "$i" root@192.168.61.240:$zdir
mv $i $xdir
done

rm -f $lock

fi
