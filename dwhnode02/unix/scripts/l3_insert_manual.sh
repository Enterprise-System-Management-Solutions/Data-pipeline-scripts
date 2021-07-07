#Auther: Tareq
## date :29-Jan-2020
## purpose : to run the jobs for L3 Insert from L3

#dt=`date '+%Y%m%d'`
#dt=`date -d yesterday '+%Y%m%d'`
dt=$1

cd /data02/scripts/

./l3_adj_insert_manual.sh $dt
#./l3_content_insert_manual.sh $dt
./l3_data_insert_manual.sh $dt
./l3_management_insert_manual.sh $dt
./l3_recharge_insert_manual.sh $dt
./l3_recurring_insert_manual.sh $dt
./l3_sms_insert_manual.sh $dt
./l3_voice_insert_manual.sh $dt
