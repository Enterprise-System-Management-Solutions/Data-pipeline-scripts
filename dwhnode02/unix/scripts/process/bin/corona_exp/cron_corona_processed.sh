cd /data02/scripts/process/bin/corona_exp/

./c_new_in.sh
sleep 30
./c_new_out_ld.sh
sleep 30
./c_out_with_idle.sh
sleep 30
./c_new_out.sh
sleep 30
./c_new_idle.sh
sleep 30
./c_new_less_cdr.sh
sleep 30
./c_first_in_last_out_new.sh
sleep 30
./exp_first_in_last_out_new.sh
sleep 5
./exp_inactive_list.sh
sleep 5
./exp_out_list.sh

