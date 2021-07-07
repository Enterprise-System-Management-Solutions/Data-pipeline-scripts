dt=`date --date="1 day ago" '+%Y%m%d'`
dt2=`date --date="1 day ago" '+%d/%m/%Y'`

cd /data02/cbs_dump/
v01=`ls -p|grep adj_${dt} |wc -l`
v02=`ls -p|grep cm_${dt}|wc -l`
v03=`ls -p|grep com_${dt} |wc -l`
v04=`ls -p|grep data_${dt} |wc -l`
v05=`ls -p|grep mon_${dt} |wc -l`
v06=`ls -p|grep transfer_${dt} |wc -l`
v07=`ls -p|grep sms_${dt} |wc -l`
v08=`ls -p|grep voice_${dt} |wc -l`
v09=`ls -p|grep vou_${dt}|wc -l`

##=============MSC CSV==============##
cd /data01/msc/alu_csv_msc_cdr_dump
v10=`ls -p|grep ${dt} |wc -l`
cd /data01/msc/huawei_csv_msc_cdr_backup
v11=`ls -p|grep ${dt} |wc -l`
cd /data01/msc/nokia_csv_msc_cdr_dump
v12=`ls -p|grep ${dt} |wc -l`

##======MFS============##
dtm=`date --date="3 days ago" '+%Y%m%d'`
cd /data02/mfs/cgw_dump
v13=`ls -p|grep ${dtm} |wc -l`
cd /data02/mfs/smsc_dump
v14=`ls -p|grep ${dtm} |wc -l`
cd /data02/mfs/ussd_dump
v15=`ls -p|grep ${dtm} |wc -l`

echo "${dt2}|adj|${v01}"
echo "${dt2}|cm|${v02}"
echo "${dt2}|com|${v03}"
echo "${dt2}|data|${v04}"
echo "${dt2}|mon|${v05}"
echo "${dt2}|transfer|${v06}"
echo "${dt2}|sms|${v07}"
echo "${dt2}|voice|${v08}"
echo "${dt2}|vou|${v09}"

##=======MSC CSV======##
echo "${dt2}|msc_alu|${v10}"
echo "${dt2}|msc_huawei|${v11}"
echo "${dt2}|msc_nokia|${v12}"

##======MFS===========##
echo "${dt2}|cgw|${v13}"
echo "${dt2}|smsc|${v14}"
echo "${dt2}|ussd|${v15}"

