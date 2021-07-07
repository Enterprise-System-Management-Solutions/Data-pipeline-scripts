PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'
#!/bin/bash


lock=/data02/script/process/bin/etsaf_transfer_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data01/dwh_biomatric

xdir=/data01/dwh_biomatric_dump
zdir=/data02/dwh_biomatric/excel_csv

FILES=`ls -ltr *.xlsx | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i}
sshpass -p "dwhadmin" scp "$i" dwhadmin@192.168.61.240:$zdir
mv $i $xdir
done

rm -f $lock

fi

