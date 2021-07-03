#Auther: Tareq
##Purpose : merge file from source to merge db
## Date : 2020-01-03


cd /data02/cbs_cdrs/$2/

#dt=`date '+%Y%m%d%H%M%S'`
dt=$1
find . -name "cbs_cdr_$2_$100*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_00_$1.add
find . -name "cbs_cdr_$2_$101*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_01_$1.add
find . -name "cbs_cdr_$2_$102*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_02_$1.add
find . -name "cbs_cdr_$2_$103*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_03_$1.add
find . -name "cbs_cdr_$2_$104*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_04_$1.add
find . -name "cbs_cdr_$2_$105*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_05_$1.add
find . -name "cbs_cdr_$2_$106*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_06_$1.add
find . -name "cbs_cdr_$2_$107*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_07_$1.add
find . -name "cbs_cdr_$2_$108*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_08_$1.add
find . -name "cbs_cdr_$2_$109*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_09_$1.add
find . -name "cbs_cdr_$2_$110*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_10_$1.add
find . -name "cbs_cdr_$2_$111*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_11_$1.add
find . -name "cbs_cdr_$2_$112*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_12_$1.add
find . -name "cbs_cdr_$2_$113*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_13_$1.add
find . -name "cbs_cdr_$2_$114*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_14_$1.add
find . -name "cbs_cdr_$2_$115*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_15_$1.add
find . -name "cbs_cdr_$2_$116*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_16_$1.add
find . -name "cbs_cdr_$2_$117*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_17_$1.add
find . -name "cbs_cdr_$2_$118*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_18_$1.add
find . -name "cbs_cdr_$2_$119*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_19_$1.add
find . -name "cbs_cdr_$2_$120*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_20_$1.add
find . -name "cbs_cdr_$2_$121*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_21_$1.add
find . -name "cbs_cdr_$2_$122*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_22_$1.add
find . -name "cbs_cdr_$2_$123*.add" | xargs cat > /data02/cbs_cdrs/$2/merge_dir/cbs_cdr_$2_23_$1.add

chmod 777 /data02/cbs_cdrs/$2/merge_dir/*

sh  /data02/scripts/process/bin/tareq/file_merge/merge_all_cdr_files_count.sh $1 $2
sh  /data02/scripts/process/bin/tareq/file_merge/merge_all_merge_file_count.sh $1 $2
sh  /data02/scripts/process/bin/tareq/file_merge/merge_all_cdr_files_delete.sh $1 $2
