

find /data02/cbs_cdrs/adj/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/cm/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/com/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/data/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/mon/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/sms/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/transfer/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/voice/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;
find /data02/cbs_cdrs/vou/process_dir/ -type f -exec chown dwhadmin:dwhadmin  {} \;

find /data02/cbs_cdrs/adj/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/cm/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/com/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/data/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/mon/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/sms/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/transfer/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/voice/process_dir/ -type f -exec chmod 775 {} \;
find /data02/cbs_cdrs/vou/process_dir/ -type f -exec chmod 775 {} \;
