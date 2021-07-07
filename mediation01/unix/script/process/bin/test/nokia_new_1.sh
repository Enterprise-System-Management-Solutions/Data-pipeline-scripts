#!/bin/ksh

dt1=`date '+%Y%m%d'`

dt2=`date '+%d.%m.%Y'`


ftp -dni 10.25.131.1 <<eof
user BILLUS BILLING#1
prompt
dir *.DAT .list
quit
eof

echo “Remote files :”
cat .list |grep ${dt2}| awk -F" " {'print $6'} > n_1${dt1}.txt
echo “Getting files of current day …”
END { print “quit” } ‘|ftp -dni 10.25.131.1

echo “Done”


cd /tmp/nokia

HOST=10.25.131.1
USER=BILLUS
PASSWORD=BILLING#1

for i in `cat /data02/script/process/bin/test/n_1${dt1}.txt`
do
ftp -inv $HOST <<EOF
user $USER $PASSWORD
get "$i" /tmp/nokia/n_1_${dt1}_$i
bye
EOF
done

