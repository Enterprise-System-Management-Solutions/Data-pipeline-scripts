#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

#dt1=`date -d yesterday '+%Y%m%d'`
#dt2=`date -d yesterday '+%d.%m.%Y'`
dt2='28.12.2020'

ip=10.25.131.1
name='n1_2021228'


ftp -dni $ip <<eof
user BILLUS BILLING#1
prompt
dir *.DAT .list
quit
eof

echo “Remote files :”
cat .list |grep ${dt2}| awk -F" " {'print $2,$6'} > /data02/script/process/bin/test/$name.txt
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni 10.25.131.1

echo “Done”
bye


HOST=10.25.131.1
USER=BILLUS
PASSWORD=BILLING#1

for i in `cat /data02/script/process/bin/test/$name.txt| awk -F" " {'print $2'}`
do
ftp -inv $HOST <<EOF
user $USER $PASSWORD
get "$i" /data02/script/process/bin/test/n1_20201230_dir/$i
bye
EOF
done
exit
