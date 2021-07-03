#!/bin/bash
## merger file and detete file:

cd /data02/scripts/process/bin/file_merge/backlog

./merge_all_cdr_files_backlog.sh $1 $2
./merge_all_cdr_files_count_backlog.sh $1 $2
./merge_all_merge_file_count_backlog.sh $1 $2
./merge_all_cdr_files_delete_backlog.sh $1 $2


