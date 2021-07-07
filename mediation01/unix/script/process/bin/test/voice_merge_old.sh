cd /data02/cbs_reload/voice_test


dt=`date '+%Y%m%d%H%M%S'`

sed -i '1d' 000000000000.add

ls -cr *$1*.add

for i in `ls -cr *$1*.add` ; do cat "$i" >> cbs_cdr_voice_$dt.add && rm -rf "$i" || break ; done
mv cbs_cdr_voice_$dt.add /data02/cbs_reload/voice_test/merge_dir
