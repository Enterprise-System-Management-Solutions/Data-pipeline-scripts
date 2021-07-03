#Author :       Tareq
#Date   :       25-06-2020
#huawei_msc file_name column add and merge


lock=/data02/scripts/process/bin/huawei_msc_file_name_merge  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


cd /data02/sftp_msc/huawei_csv


FILES=`ls -ltr b*.csv | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i}
awk 'BEGIN {OFS="|"} {print $0,FILENAME}' $i > new_$i
rm -rf "$i"
done


d=$1
dt=`date '+%Y%m%d%H%M%S'`

FILES=`ls -ltr new*.csv | awk -F" " {'print $9'}`
for i in $FILES ;
do cat "$i" >> huawei_msc_$dt.csv && rm -rf "$i" || break;
done

mv huawei_msc*.csv /data02/sftp_msc/huawei

rm -f $lock

fi
