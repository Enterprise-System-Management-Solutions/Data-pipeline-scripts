#!/bin/sh

echo `date` >>/data02/scripts/crontab_file_mv.log
echo "=======================================" >>/data02/scripts/crontab_file_mv.log

cd /data05/cbs/

cnt=`ls *adj* | wc -l`
chown dwhadmin:dwhadmin *adj*
mv *adj* /data02/cbs_cdrs/adj
echo  "File Moved: adj: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *clr* | wc -l`
chown dwhadmin:dwhadmin *clr*
mv *clr* /data02/cbs_cdrs/clr
echo  "File Moved: clr: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *cm* | wc -l`
chown dwhadmin:dwhadmin *cm*
mv *cm* /data02/cbs_cdrs/cm
echo  "File Moved: cm: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *com* | wc -l`
chown dwhadmin:dwhadmin *com*
mv *com* /data02/cbs_cdrs/com
echo  "File Moved: com: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *data* | wc -l`
chown dwhadmin:dwhadmin *data*
mv *data* /data02/cbs_cdrs/data
echo  "File Moved: data: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *mon* | wc -l`
chown dwhadmin:dwhadmin *mon*
mv *mon* /data02/cbs_cdrs/mon
echo  "File Moved: mon: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *recharge* | wc -l`
chown dwhadmin:dwhadmin *recharge*
mv *recharge* /data02/cbs_cdrs/recharge
echo  "File Moved: recharge: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *sms* | wc -l`
chown dwhadmin:dwhadmin *sms*
mv *sms* /data02/cbs_cdrs/sms
echo  "File Moved: sms: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *transfer* | wc -l`
chown dwhadmin:dwhadmin *transfer*
mv *transfer* /data02/cbs_cdrs/transfer
echo  "File Moved: transfer: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *voice* | wc -l`
chown dwhadmin:dwhadmin *voice*
mv *voice* /data02/cbs_cdrs/voice
echo  "File Moved: voice: $cnt" >>/data02/scripts/crontab_file_mv.log

cnt=`ls *vou* | wc -l`
chown dwhadmin:dwhadmin *vou*
mv *vou* /data02/cbs_cdrs/vou
echo  "File Moved: vou: $cnt" >>/data02/scripts/crontab_file_mv.log

echo "=======================================" >>/data02/scripts/crontab_file_mv.log
