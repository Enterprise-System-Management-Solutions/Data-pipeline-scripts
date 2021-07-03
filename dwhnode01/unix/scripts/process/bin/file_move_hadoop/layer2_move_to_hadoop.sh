#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       26-09-2020
#layer2 export file transfer 240~245

dt=`date -d yesterday '+%Y%m%d'`

lock=/data02/scripts/process/bin/l2_transfer_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data02/l2_csv_export_dump/

zdir=/data02/csv_export_dump/

FILES=`ls -ltr *$dt.csv | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i}
#sshpass -p "dwhadmin" scp "$i" dwhadmin@192.168.61.245:$zdir
sshpass -p "dwhadmin" scp "$i" dwhadmin@192.168.61.207:$zdir

 RESULT=$?
 if [ $RESULT -eq 0 ]; then
   rm -f "$i"
 else
   exit 2
 fi
done

rm -f $lock

fi
