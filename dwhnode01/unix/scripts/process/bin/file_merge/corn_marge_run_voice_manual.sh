##d=`date ' +%Y%m%d'`
d=$1
sh /data02/scripts/process/bin/file_merge/merge_run_all.sh $d voice
