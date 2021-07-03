#!/bin/bash
##Auther: Tareq 
## date :21 -Jan-2020
## purpose : to run the jobs for L2 Insert from L1

#dt=`date '+%Y%m%d'`
#dt=`date -d yesterday '+%Y%m%d'`
dt=$1

cd /data02/scripts/process/bin/tareq/

#./l2_adj_insert_manual.sh $dt
./l2_content_insert_manual.sh $dt
./l2_data_insert_manual3.sh $dt
./l2_management_insert_manual.sh $dt
./l2_mon_insert_manual.sh $dt
./l2_sms_insert_manual.sh $dt
./l2_transfer_insert_manual.sh $dt
./l2_voice_insert_manual3.sh $dt
#./l2_vou_insert_manual.sh $dt
