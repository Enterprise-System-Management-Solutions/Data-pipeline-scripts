
cd /data02/scripts/process/bin

d=`date '+%Y%m%d'`

sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d adj
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d clr
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d cm
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d com
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d data
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d mon
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d recharge
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d sms
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d transfer
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d voice
sh /data02/scripts/process/bin/file_merge/merge_all_cdr_files.sh $d vou


