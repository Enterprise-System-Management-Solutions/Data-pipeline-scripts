
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'
#!/bin/bash
#PATH=/usr/bin

#Author :       Tareq
#Date   :       24-06-2020
#sdp_dump file move 253~240




lock=/data02/script/process/bin/sdp_dump_transfer_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data01/dwh_vas_dir

chmod 775 SDP*.txt 

xdir=/data01/dwh_sdp_dir_dump
zdir=/data02/dwh_sdp_dir/

FILES=`ls -ltr SDP*.txt | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i}

sshpass -p "dwhadmin" scp "$i" dwhadmin@192.168.61.240:$zdir
mv $i $xdir
done

rm -f $lock

fi

