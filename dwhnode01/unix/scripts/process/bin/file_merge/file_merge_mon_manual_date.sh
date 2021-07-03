#Author :       Tareq
#Date   :       27-06-2020
#cbs_cdr_mon file_name column add and merge


lock=/data02/scripts/process/bin/cbs_mon_file_merge_manual_$1  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


cd /data02/cbs_cdrs/mon/process_dir


FILES=`ls -ltr *$1*.add | head -n 5000 | awk -F" " {'print $9'}`
for i in $FILES
do
awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i

RESULT=$?
if [ $RESULT -eq 0 ]; then
  rm -rf "$i"
else
  exit 2
fi
done


d=$1
dt=`date '+%Y%m%d%H%M%S'`

FILES=`ls -ltr new*.add | head -n 5000 | awk -F" " {'print $9'}`
for i in $FILES
do
cat $i >> cbs_cdr_mon_$dt.add

RESULT=$?
if [ $RESULT -eq 0 ]; then
  rm -rf "$i"
else
  exit 2
fi
done

mv cbs_cdr_mon_$dt.add /data02/cbs_cdrs/mon/merge_dir

rm -f $lock

fi

