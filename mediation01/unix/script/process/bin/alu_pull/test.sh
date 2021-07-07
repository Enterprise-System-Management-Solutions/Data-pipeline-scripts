#!/bin/ksh


dt1=`date -d yesterday '+%Y%m%d'`
dt2=`date -d yesterday '+%Y.%m.%d'`

ftp -dni 10.25.22.33 <<eof
user ftpuser radisson#1
prompt
dir G*${dt2}* .list
quit
eof

echo “Remote files :”
cat .list |grep ${dt2}| awk -F" " {'print $9'} > /data02/script/process/bin/alu_pull/log/alu_02_{dt1}.txt
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni 10.25.22.33

echo “Done”
