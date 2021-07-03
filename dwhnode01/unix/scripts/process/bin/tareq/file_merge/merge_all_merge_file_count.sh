cd /data02/cbs_cdrs/$2/merge_dir

echo ==========$1 === start  >>/data02/scripts/process/log/merge_$2.out

cat cbs_cdr_$2_$100*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$101*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$102*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$103*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$104*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$105*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$106*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$107*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$108*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$109*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$110*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$111*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$112*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$113*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$114*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$115*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$116*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$117*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$118*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$119*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$120*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$121*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$122*.add | wc -l >> /data02/scripts/process/log/merge_$2.out
cat cbs_cdr_$2_$123*.add | wc -l >> /data02/scripts/process/log/merge_$2.out


echo ==========$1 === end  >>/data02/scripts/process/log/merge_$2.out

