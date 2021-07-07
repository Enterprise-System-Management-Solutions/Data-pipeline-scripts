#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

#dt1=`date -d yesterday '+%Y%m%d'`
#dt2=`date -d yesterday '+%d.%m.%Y'`
dt1=$1
dt2=$2


ip20=192.168.50.20
name20=o_20_${dt1}


ftp -dni $ip20 <<eof
user BILLUS BILLING#1
prompt
dir *.DAT .list
quit
eof

echo “Remote files :”
cat .list |grep ${dt2}| awk -F" " {'print $2,$6'} 
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni $ip20

echo “Done”



HOST=$ip20
USER=BILLUS
PASSWORD=BILLING#1

for i in `cat /data02/script/process/bin/test/o_20_20210109.txt| awk -F" " {'print $2'}`
do
ftp -inv $HOST <<EOF
user $USER $PASSWORD
get "$i" /data02/script/process/bin/test/n1_20201230_dir/o_20_${dt1}_$i
bye
EOF
done

exit
