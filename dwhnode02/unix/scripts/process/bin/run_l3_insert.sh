#!/bin/bash
##Auther: Tareq 
## date :29-Jan-2020
## purpose : to run the jobs for L3 Insert from L3

#dt=`date '+%Y%m%d'`
dt=`date -d yesterday '+%Y%m%d'`

cd /data02/scripts/process/bin/

./l3_adj_insert.sh $dt
./l3_content_insert.sh $dt
./l3_data_insert.sh $dt
./l3_evcrec_insert.sh $dt
./l3_evctra_insert.sh $dt
./l3_management_insert.sh $dt
./l3_mon_insert.sh $dt
./l3_sms_insert.sh $dt
./l3_transfer_insert.sh $dt
./l3_voice_insert.sh $dt
./l3_vou_insert.sh $dt
