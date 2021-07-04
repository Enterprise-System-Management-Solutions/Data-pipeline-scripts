
#dt=`date -d +%Y%m%d`
dt=$1

/data02/scripts/dwh/file_reg/file_registration_nbi_fm.sh alarm $dt
/data02/scripts/dwh/file_reg/file_registration_nbi_fm.sh event $dt
