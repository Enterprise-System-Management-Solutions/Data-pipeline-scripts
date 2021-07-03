#!/bin/bash
##Auther: Tareq 
## date :21 -Jan-2020
## purpose : to run the jobs for L2 Insert from L1

#dt=`date '+%Y%m%d'`
dt=`date -d yesterday '+%Y%m%d'`

cd /data02/scripts/process/bin/tareq/

./l2_adj_insert.sh $dt
./l2_content_insert.sh $dt
./l2_data_insert.sh $dt
#./l2_management_insert.sh $dt
./l2_mon_insert.sh $dt
./l2_sms_insert.sh $dt
./l2_transfer_insert.sh $dt
./l2_voice_insert.sh $dt
./l2_vou_insert.sh $dt
./l2_management_insert.sh $dt
