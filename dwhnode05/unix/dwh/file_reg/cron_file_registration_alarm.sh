#dt=`date -d +%Y%m%d`
#dt=$1
dt='2021'
cd /data02/scripts/dwh/file_reg
./file_registration_nbi_fm.sh alarm $dt

