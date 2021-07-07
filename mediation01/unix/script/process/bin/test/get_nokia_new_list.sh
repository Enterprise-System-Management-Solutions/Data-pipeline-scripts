#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

#dt1=`date -d yesterday '+%Y%m%d'`
#dt2=`date -d yesterday '+%d.%m.%Y'`
dt1=$1
dt2=$2
source=$3

ip=$4
name=$source$dt1
ftp -dni $ip <<eof
user BILLUS BILLING#1
prompt
dir *.DAT .list
quit
eof

echo “Remote files :”
cat .list > /data02/script/process/bin/test/$name.txt
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni $ip 

echo “Done”
bye

