#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

dt=`date -d yesterday '+%Y%m%d'`
cd /data01/unit_offer

sshpass -p "C14#e4TM" sftp -oBatchMode=no -b - sysomc@10.20.134.182 << !
   cd /home/mep/cdr/BDI/backup
   get ${dt}*.list
   bye
!

sshpass -p "C14#e4TM" sftp -oBatchMode=no -b - sysomc@10.20.134.187 << !
   cd /home/mep/cdr/BDI/backup
   get ${dt}*.list
   bye
!

exit

