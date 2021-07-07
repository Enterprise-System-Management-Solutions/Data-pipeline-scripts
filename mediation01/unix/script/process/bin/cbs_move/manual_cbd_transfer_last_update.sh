cd /data02/script/process/bin/cbs_move
#dt='20210124'
dt=$1
./cbs_cdr_manual_move_for_any_date.sh adj $dt
./cbs_cdr_manual_move_for_any_date.sh cm $dt
./cbs_cdr_manual_move_for_any_date.sh com $dt
./cbs_cdr_manual_move_for_any_date.sh data $dt
./cbs_cdr_manual_move_for_any_date.sh mon $dt
./cbs_cdr_manual_move_for_any_date.sh transfer $dt
./cbs_cdr_manual_move_for_any_date.sh sms $dt
./cbs_cdr_manual_move_for_any_date.sh vou $dt
./cbs_cdr_manual_move_for_any_date.sh voice $dt
