#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       04-08-2020
#alu_msc file transfer 253~240 server and move dump directory

export SSHPASS='dwhadmin'
echo $SSHPASS



lock=/data02/script/process/bin/alu_msc_transfer_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data01/msc/alu_csv_msc_cdr/

xdir=/data01/msc/alu_csv_msc_cdr_dump
zdir=/data02/sftp_msc/alu

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

