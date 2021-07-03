#!/bin/bash
##Auther: Tareq 
## date :21 -Jan-2020
## purpose : to run the jobs for L2 Insert from L1

dt=`date '+%Y%m%d'`


cd /data02/scripts/process/bin/tareq/

./l3_adj_insert.sh $dt
./l3_content_insert.sh $dt
./l3_data_insert.sh $dt
./l3_management_insert.sh $dt
./l3_mon_insert.sh $dt
./l3_sms_insert.sh $dt
./l3_transfer_insert.sh $dt
./l3_voice_insert.sh $dt
./l3_vou_insert.sh $dt
