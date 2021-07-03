#!/bin/bash
cd /data02/scripts/process/bin/file_merge/backlog/

#d=`date ' +%Y%m%d'`
#d=`date '+%Y%m%d'`
#d="20200201"
d=`date -d yesterday '+%Y%m%d'`
#d=`date -d '-3 days' '+%Y%m%d'`

./merge_run_all_backlog.sh $d adj
./merge_run_all_backlog.sh $d cm
./merge_run_all_backlog.sh $d com
./merge_run_all_backlog.sh $d data
./merge_run_all_backlog.sh $d mon
./merge_run_all_backlog.sh $d sms
./merge_run_all_backlog.sh $d transfer
./merge_run_all_backlog.sh $d voice
./merge_run_all_backlog.sh $d vou


