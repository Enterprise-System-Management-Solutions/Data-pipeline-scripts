cd /data02/scripts/process/bin/file_exp

./l2_adjustment_exp.sh
sleep 10
./l2_content_exp.sh
sleep 10
./l2_data_exp.sh
sleep 10
./l2_management_exp.sh
sleep 10
./l2_recharge_exp.sh
sleep 10
./l2_recurring_exp.sh
sleep 10
./l2_sms_exp.sh
sleep 10
./l2_transfer_exp.sh
sleep 10
./l2_voice_exp.sh
sleep 3
/data02/scripts/process/bin/file_move_hadoop/layer2_move_to_hadoop.sh
