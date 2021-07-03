#!/bin/bash
##Auther: Tareq
## date :06 -July-2020
## purpose : to run this jobs for L2 Insert from L1(MANUAL ETL)

dt=`date '+%Y%m%d'`
#dt=`date -d yesterday '+%Y%m%d'`
#dt=$1

cd /data02/scripts/process/bin/manual_etl

./l2_adj_insert_manual_etl.sh $dt
./l2_content_insert_manual_etl.sh $dt
./l2_data_insert_manual_etl.sh $dt
./l2_mon_insert_manual_etl.sh $dt
./l2_sms_insert_manual_etl.sh $dt
./l2_transfer_insert_manual_etl.sh $dt
./l2_voice_insert_manual_etl.sh $dt
./l2_vou_insert_manual_etl.sh $dt
./l2_management_insert_manual_etl.sh $dt

