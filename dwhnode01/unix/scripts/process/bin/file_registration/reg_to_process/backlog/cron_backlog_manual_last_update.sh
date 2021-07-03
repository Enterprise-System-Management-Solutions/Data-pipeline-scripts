cd /data02/scripts/process/bin/file_registration/reg_to_process/backlog/
dt='20210503'
./run_registration_adj_manual.sh $dt
./run_registration_cm_manual.sh $dt
./run_registration_com_manual.sh $dt
./run_registration_data_manual.sh $dt
./run_registration_mon_manual.sh $dt
./run_registration_sms_manual.sh $dt
./run_registration_transfer_manual.sh $dt
./run_registration_voice_manual.sh $dt
./run_registration_vou_manual.sh $dt

