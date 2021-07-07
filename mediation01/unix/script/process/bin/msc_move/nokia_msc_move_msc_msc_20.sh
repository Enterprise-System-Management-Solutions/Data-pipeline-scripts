#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       07-08-2020
#nokia_msc file transfer 253~239 server and move dump directory



lock=/data02/script/process/bin/nokia_msc_20_transfer_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data01/msc/nokia_csv_msc_cdr/msc_20

xdir=/data01/msc/nokia_csv_msc_cdr_dump
zdir=/data02/sftp_msc/nokia

FILES=`ls -ltr *.csv | awk -F" " {'print $9'}`
for i in $FILES
do
#f=${i}
#sshpass -p "dwhadmin" scp "$i" dwhadmin@192.168.61.239:$zdir
sshpass -p "dwhadmin" scp "$i" dwhadmin@192.168.61.204:$zdir
mv $i $xdir
done

rm -f $lock

fi

