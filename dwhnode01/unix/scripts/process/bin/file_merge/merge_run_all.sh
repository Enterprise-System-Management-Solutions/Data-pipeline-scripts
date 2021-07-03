#!/bin/bash
## merger file and detete file:

cd /data02/scripts/process/bin/file_merge

./merge_all_cdr_files.sh $1 $2
./merge_all_cdr_files_count.sh $1 $2
./merge_all_merge_file_count.sh $1 $2
./merge_all_cdr_files_delete.sh $1 $2


