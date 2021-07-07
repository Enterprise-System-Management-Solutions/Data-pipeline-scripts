#!/bin/bash
PATH='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin'

dt=`date -d yesterday '+%Y%m%d'`
cd /data01/unit_offer

sshpass -p "dwhadmin" scp ${dt}* dwhadmin@192.168.61.202:/data02/unit_offer/unit_offer_pull

mv ${dt}* /data01/unit_offer_dump
