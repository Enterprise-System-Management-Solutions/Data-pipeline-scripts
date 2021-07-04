
dt=`date -d "1 day ago" +%Y%m%d`

/data02/scripts/dwh/file_reg/file_registration.sh evcTRA $dt
/data02/scripts/dwh/file_reg/file_registration.sh evcREC $dt
