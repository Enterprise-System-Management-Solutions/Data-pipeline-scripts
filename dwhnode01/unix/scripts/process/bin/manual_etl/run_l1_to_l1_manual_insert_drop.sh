#!/bin/bash
##Auther: Tareq
## date :06 -July-2020
## purpose : to run this jobs for l1_manual Insert from L1 orginal table and drop currint partition from original table(MANUAL ETL)

cd /data02/scripts/process/bin/manual_etl

./l1_adj_to_l1_adj_manual.sh
./l1_cm_to_l1_cm_manual.sh
./l1_com_to_l1_com_manual.sh
./l1_data_to_l1_data_manual.sh
./l1_mon_to_l1_mon_manual.sh
./l1_sms_to_l1_sms_manual.sh
./l1_transfer_to_l1_transfer_manual.sh
./l1_voice_to_l1_voice_manual.sh
./l1_vou_to_l1_vou_manual.sh
