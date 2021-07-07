#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       07-08-2020
#nokia_msc file transfer 253~239 server and move dump directory



lock=/data02/script/process/bin/smsc_file_pull_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock
#dt=`date -d yesterday '+%Y%m%d'`
dt='20200601'
sdir=/home/tblbi/smsc/
xdir=/data02/mfs/smsc


#FILES=`ls -ltr *.csv |head -n 10 | awk -F" " {'print $9'}`

FILES=`sshpass -p 'tfvbhg71!$' ssh tblbi@192.168.61.141 ls -ltr ${sdir}*${dt}*.txt | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i}
sshpass -p 'tfvbhg71!$' scp tblbi@192.168.61.141:$i $xdir

done

rm -f $lock

fi

