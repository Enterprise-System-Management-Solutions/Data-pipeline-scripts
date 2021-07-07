cd /data02/cbs_reload/voice_test
d=$1
dt=`date '+%Y%m%d%H%M%S'`

FILES=`ls -ltr cbs_cdr_voice_*$d*.add | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i}
cat $i >> cbs_cdr_voice_$dt.add
rm -rf "$i"
done
mv cbs_cdr_voice_$dt.add /data02/cbs_reload/voice_test/merge_dir
