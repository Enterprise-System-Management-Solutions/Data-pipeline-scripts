cd /data01/nokia/msc_new_1

HOST=10.25.131.1
USER=BILLUS
PASSWORD=BILLING#1

for i in `cat /data02/script/process/bin/test/20200912.txt`
do
ftp -inv $HOST <<EOF
user $USER $PASSWORD
get "$i"
bye
EOF
done

