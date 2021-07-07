#!/bin/bash
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

#Author :       Tareq
#Date   :       07-08-2020
#45 days older .tar file remove from /data02/cbs_dump directory



lock=/data02/script/process/bin/rm_cbs_dump export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data02/cbs_dump

wc=`ls *.tar|wc -l`

	if [ $wc -gt 45 ] ; then
		FILES=`ls -ltr *.tar |head -1 | awk -F" " {'print $9'}`
		for i in $FILES
		do
		rm -f $FILES
		#echo $FILES
		done
	fi

rm -f $lock

fi

