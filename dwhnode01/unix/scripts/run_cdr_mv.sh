#!/bin/bash


##Auther: khairul
## date : 21-Dec-2019
## purpose : to run the jobs for coping all files from source to target dir

cd /data02/scripts/

dt=`date -d today '+%Y%m%d'`

echo $dt

sh ./all_cdr_mv.sh $dt
