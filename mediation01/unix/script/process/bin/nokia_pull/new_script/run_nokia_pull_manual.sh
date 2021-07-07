#d1=`date -d yesterday '+%Y%m%d'`
#d2=`date -d yesterday '+%d.%m.%Y'`

d1=$1
d2=$2
cd /data02/script/process/bin/nokia_pull/new_script

./nokia_msc_new_01_manual.sh $d1 $d2
./nokia_msc_new_02_manual.sh $d1 $d2
./nokia_msc_old_20_manual.sh $d1 $d2
./nokia_msc_old_21_manual.sh $d1 $d2
./nokia_msc_old_22_manual.sh $d1 $d2
./nokia_msc_old_23_manual.sh $d1 $d2
