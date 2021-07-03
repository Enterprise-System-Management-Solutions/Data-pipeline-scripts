


###clear allzero size files##
find  /data02/cbs_cdrs/adj/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/clr/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/cm/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/com/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/data/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/mon/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/sms/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/transfer/merge_dir  -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/voice/merge_dir -type f -size 0 -print | xargs rm -f
find  /data02/cbs_cdrs/vou/merge_dir -type f -size 0 -print | xargs rm -f

