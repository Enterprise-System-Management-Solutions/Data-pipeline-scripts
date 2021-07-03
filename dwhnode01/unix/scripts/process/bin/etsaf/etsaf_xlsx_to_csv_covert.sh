#Author :       Tareq
#Date   :       31-08-2020
#etsaf_xlsx_to_csv_covert


lock=/data02/scripts/process/bin/etsaf_xlsx_to_csv_covert_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock


cd /data02/dwh_biomatric/excel_csv


FILES=`ls -ltr *.xlsx | awk -F" " {'print $9'}`
for i in $FILES
do
f=${i::-5}
xlsx2csv "$i" > new_${f}.csv
sed s/\,/\|/g new_${f}.csv > ${f}.csv

RESULT=$?
if [ $RESULT -eq 0 ]; then
	mv ${f}.csv /data02/dwh_biomatric
	rm -f new_${f}.csv
	rm -f "$i"
else
  exit 2
fi
done

rm -f $lock

fi
