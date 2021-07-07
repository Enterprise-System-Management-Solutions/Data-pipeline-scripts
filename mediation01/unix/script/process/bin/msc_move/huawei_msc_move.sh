PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'
#!/bin/bash
#PATH=/usr/bin

#Author :       Tareq
#Date   :       24-06-2020
#huawei_msc file move 253~240

export SSHPASS='dwhadmin'
echo $SSHPASS



lock=/data02/script/process/bin/huawei_msc_transfer_log  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data01/msc/huawei_csv_msc_cdr

xdir=/data01/msc/huawei_csv_msc_cdr_backup
zdir=/data02/sftp_msc/huawei

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

