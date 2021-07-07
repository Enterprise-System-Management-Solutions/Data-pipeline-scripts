cd /data02/cbs_reload/20200622_voice

FILES=`ls -ltr cbs_cdr_voice_*$1*.add | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i}
awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i
mv new_$i /data02/cbs_reload/voice_test
rm -rf "$i"
done
