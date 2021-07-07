#file get from mediation
#file reg and load to node01
#L1 to l3 transformation
#L3 to condition calculation
#export yes and not list
#Send sms to not list



dt=`date -d yesterday '+%Y%m%d'`
sshpass -p "LandRND@@BI" ssh root@192.168.61.253 sh -x /data02/script/process/bin/file_transfer/hundred_years_file_transfer.sh

sshpass -p "dwhadmin" ssh dwhadmin@192.168.61.202 sh -x /data02/scripts/process/bin/hundred_year/file_reg.sh

sshpass -p "dwhadmin" ssh dwhadmin@192.168.61.202 sh -x /data02/scripts/process/bin/hundred_year/s100_load.sh 
sleep 3
cd /data02/scripts/process/bin/file_exp
./sp_l3_migration_base.sh $dt
sleep 3
./sp_migration_condition.sh $dt
sleep 3
./s100_yes_no_list_exp.sh $dt
sleep 3
./s100_no_list_sms_send.sh $dt
