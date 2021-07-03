
## Created by Khairul
## Date: 21-Dec-2019
## Purpose : copy All cdr for CBS source to esms processed dir
## run command : sh -x all_cdr_mv.sh 20191221(Date)


cd /data02/scripts


ydate=$1

echo  adj >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh adj $ydate
echo  clr >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh clr $1

echo  cm >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh cm $1

echo  com >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh com $1

echo  data >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh data $1

echo  mon >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh mon $1 

echo  recharge >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh recharge $1

echo  sms >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh sms $1 

echo  transfer >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh transfer $1

echo  voice >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh voice $1

echo  vou >>/data02/scripts/crontab_file_mv.log
sh ./adhoc_cdr_mv.sh vou $1


