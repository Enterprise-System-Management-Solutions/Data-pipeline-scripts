#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       07-08-2020
#smsc file transfer 253~239 server and move dump directory



lock=/data02/script/process/bin/smsc_transfer_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data02/mfs/smsc

xdir=/data02/mfs/smsc_dump
zdir=/data02/mfs/smsc

FILES=`ls -ltr *.txt | awk -F" " {'print $9'}`
for i in $FILES
do
#f=${i}
sshpass -p "dwhadmin" scp "$i" dwhadmin@192.168.61.204:$zdir
mv $i $xdir
done

rm -f $lock

fi
