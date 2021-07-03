dt=`date -d yesterday '+%Y%m%d'`

cd /data02/scripts/process/bin/file_merge/

./file_merge_vou_manual.sh $dt
