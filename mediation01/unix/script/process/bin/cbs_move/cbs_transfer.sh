#Author :       Tareq
#Date   :       24-06-2020
#cbs_cdr file move 253~240
lock=/data02/script/process/bin/cbs_cdr_transfer_log  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data02/cbs


cdir=/data02/cbs/

ddir=/data02/cbs_dump/
tdir=/data01/cbs/

##FILES=`find . -type f  -mmin +5 -mmin -10 | xargs -r ls -l | awk -F" " {'print $9'}`

FILES=`find . -maxdepth 1 -type f -name "*.add" -mmin +5 -mmin -10 | xargs -r ls -l | awk -F" " {'print $9'}`
for i in $FILES
do
sshpass -p "root123" scp "$i" root@192.168.61.240:$tdir

RESULT=$?
if [ $RESULT -eq 0 ]; then
  mv "$i" $ddir
else
  exit 2
fi

done

rm -f $lock

fi
