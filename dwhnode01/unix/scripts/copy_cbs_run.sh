#!/usr/bin/env bash

##if ps -ef | grep -v grep | grep copy_cbs_run.sh ; then
  ##      exit 0
##else

cd /data01/cbs/
touch -d "5 minutes ago" touchfile


`find -maxdepth 1 -name 'cbs_cdr_adj*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/adj/ \;`
find -maxdepth 1 -name 'cbs_cdr_clr*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/clr/ \;
find -maxdepth 1 -name 'cbs_cdr_cm*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/cm/ \;
find -maxdepth 1 -name 'cbs_cdr_com*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/com/ \;
find -maxdepth 1 -name 'cbs_cdr_data*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/data/ \;
find -maxdepth 1 -name 'cbs_cdr_mon*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/mon/ \;
find -maxdepth 1 -name 'cbs_cdr_recharge*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/recharge/ \;
find -maxdepth 1 -name 'cbs_cdr_sms*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/sms/ \;
find -maxdepth 1 -name 'cbs_cdr_transfer*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/transfer/ \;
find -maxdepth 1 -name 'cbs_cdr_voice*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/voice/ \;
find -maxdepth 1 -name 'cbs_cdr_vou*.add' -newer touchfile -exec mv "{}" /data02/cbs_cdrs/vou/ \;

##exit 0
##fi

