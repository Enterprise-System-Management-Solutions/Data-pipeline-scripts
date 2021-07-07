#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

dt1=`date -d yesterday '+%Y%m%d'`
dt2=`date -d yesterday '+%d.%m.%Y'`


ftp -dni 192.168.50.21 <<eof
user BILLUS BILLING#1
prompt
dir *.DAT .list
quit
eof

echo “Remote files :”
cat .list |grep ${dt2}| awk -F" " {'print $6'} > /data02/script/process/bin/nokia_pull/log/o_21_${dt1}.txt
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni 192.168.50.21

echo “Done”


#cd /tmp/nokia

HOST=192.168.50.21
USER=BILLUS
PASSWORD=BILLING#1

for i in `cat /data02/script/process/bin/nokia_pull/log/o_21_${dt1}.txt`
do
ftp -inv $HOST <<EOF
user $USER $PASSWORD
get "$i" /data01/nokia/msc_21/o_21_${dt1}_$i
bye
EOF
done



