#Author :       Tareq
#Date   :       27-06-2020
#cbs_cdr_vou file_name column add and merge
date=$1

lock=/data02/scripts/process/bin/cbs_vou_file_merge_manual  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


cd /data02/cbs_cdrs/vou/process_dir


FILES=`ls -ltr *${date}*.add | awk -F" " {'print $9'}`
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



dt=`date '+%Y%m%d%H%M%S'`

nFILES=`ls -ltr new*.add | awk -F" " {'print $9'}`
for i in $nFILES
do
cat $i >> cbs_cdr_vou_$dt.add

RESULT=$?
if [ $RESULT -eq 0 ]; then
  rm -rf "$i"
else
  exit 2
fi
done

mv cbs_cdr_vou_$dt.add /data02/cbs_cdrs/vou/merge_dir

rm -f $lock

fi

