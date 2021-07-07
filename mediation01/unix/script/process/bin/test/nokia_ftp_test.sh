#!/bin/ksh

ftp -dni 10.25.131.1 <<eof
user BILLUS BILLING#1
prompt
dir *.DAT .list
quit
eof

echo “Remote files :”
cat .list
echo “Getting files of current day …”

cat .list|awk '12.09.2020' ‘
BEGIN { print “user BILLUS BILLING#1” }
{ print “get ” $6 }
END { print “quit” } ‘|ftp -dni 10.25.131.1

echo “Done”
