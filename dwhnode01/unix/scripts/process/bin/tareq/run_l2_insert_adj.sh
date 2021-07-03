#!/bin/bash
##Auther: Tareq 
## date :21 -Jan-2020
## purpose : to run the jobs for L2 Insert from L1

#dt=`date '+%Y%m%d'`
dt=`date -d yesterday '+%Y%m%d'`

cd /data02/scripts/process/bin/tareq/

./l2_adj_insert.sh $dt
