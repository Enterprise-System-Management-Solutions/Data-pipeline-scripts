#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

dt1=$1
dt2=$2

ftp -dni 10.25.22.33 <<eof
user ftpuser radisson#1
prompt
dir G*${dt2}* .list
quit
eof

echo “Remote files :”
cat .list |grep ${dt2}| awk -F" " {'print $9'} > /data02/script/process/bin/alu_pull/log/alu_02_${dt1}.txt
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni 10.25.22.33

echo “Done”




cd /data01/msc_alu/

HOST=10.25.22.33
USER=ftpuser
PASSWORD=radisson#1

for i in `cat /data02/script/process/bin/alu_pull/log/alu_02_${dt1}.txt`
do
ftp -inv $HOST <<EOF
user $USER $PASSWORD
get "$i"
bye
EOF
done
exit



