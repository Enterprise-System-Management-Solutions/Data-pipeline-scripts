#!/bin/bash
#Auther: Tareq
##Purpose : merge file from source to merge db
## Date : 2020-01-03


cd /data02/cbs_cdrs/$2/process_dir

dt=`date '+%Y%m%d%H%M%S'`

find . -name "cbs_cdr_$2_$100*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_00_$dt.add
find . -name "cbs_cdr_$2_$101*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_01_$dt.add
find . -name "cbs_cdr_$2_$102*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_02_$dt.add
find . -name "cbs_cdr_$2_$103*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_03_$dt.add
find . -name "cbs_cdr_$2_$104*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_04_$dt.add
find . -name "cbs_cdr_$2_$105*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_05_$dt.add
find . -name "cbs_cdr_$2_$106*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_06_$dt.add
find . -name "cbs_cdr_$2_$107*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_07_$dt.add
find . -name "cbs_cdr_$2_$108*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_08_$dt.add
find . -name "cbs_cdr_$2_$109*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_09_$dt.add
find . -name "cbs_cdr_$2_$110*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_10_$dt.add
find . -name "cbs_cdr_$2_$111*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_11_$dt.add
find . -name "cbs_cdr_$2_$112*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_12_$dt.add
find . -name "cbs_cdr_$2_$113*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_13_$dt.add
find . -name "cbs_cdr_$2_$114*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_14_$dt.add
find . -name "cbs_cdr_$2_$115*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_15_$dt.add
find . -name "cbs_cdr_$2_$116*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_16_$dt.add
find . -name "cbs_cdr_$2_$117*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_17_$dt.add
find . -name "cbs_cdr_$2_$118*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_18_$dt.add
find . -name "cbs_cdr_$2_$119*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_19_$dt.add
find . -name "cbs_cdr_$2_$120*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_20_$dt.add
find . -name "cbs_cdr_$2_$121*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_21_$dt.add
find . -name "cbs_cdr_$2_$122*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_22_$dt.add
find . -name "cbs_cdr_$2_$123*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_23_$dt.add

chmod 777 /data02/cbs_cdrs/$2/merge_dir/*

