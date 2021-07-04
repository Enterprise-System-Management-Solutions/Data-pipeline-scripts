lock=/data02/scripts/dwh/lock/HuaweiUDN_cron_reg_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

cd /data04/udn

vc=`ls -l|wc -l`

mood_vc=$((${vc}/2))
echo $mood_vc

cd /data02/scripts/dwh/ipdr_load

./file_reg_HuaweiUDN.sh $mood_vc
sleep 5
./file_reg_HuaweiUDN_2.sh $mood_vc

fi

rm -f $lock

