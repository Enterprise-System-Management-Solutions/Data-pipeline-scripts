#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

dt1=`date -d yesterday '+%Y%m%d'`
dt2=`date -d yesterday '+%d.%m.%Y'`
#dt2='30.12.2020'

ip=192.168.50.21
name=o_21_${dt1}


ftp -dni $ip <<eof
user BILLUS BILLING#1
prompt
dir *.DAT .list
quit
eof

echo “Remote files :”
cat .list |grep ${dt2}| awk -F" " {'print $2,$6'} > /data02/script/process/bin/nokia_pull/log/$name.txt
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni $ip

echo “Done”



HOST=$ip
USER=BILLUS
PASSWORD=BILLING#1

for i in `cat /data02/script/process/bin/nokia_pull/log/$name.txt| awk -F" " {'print $2'}`
do
ftp -inv $HOST <<EOF
user $USER $PASSWORD
get "$i" /data01/nokia/msc_21/o_21_${dt1}_$i
bye
EOF
done
exit
