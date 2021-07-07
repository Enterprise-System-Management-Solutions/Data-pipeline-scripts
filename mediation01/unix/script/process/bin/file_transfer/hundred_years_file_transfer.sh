#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       23-12-2020
#hundred_year file transfer 253~240 server



lock=/data02/script/process/bin/hundred_year_transfer_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data01/hundred_year

dt2=`date '+%H%S'`
xdir=/data01/hundred_year/in
zdir=/data02/hundred_year/

FILES=`ls -ltr *.csv | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i::-4}
mv ${i} ${f}_${dt2}.csv
sshpass -p "dwhadmin" scp ${f}_${dt2}.csv dwhadmin@192.168.61.202:$zdir
mv ${f}_${dt2}.csv $xdir
done

rm -f $lock

fi

