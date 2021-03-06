#!/bin/bash
PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode02
export ORACLE_UNQNAME=dwhdb02
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb02
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


dt=`date -d yesterday '+%Y%m%d'`

xdir=/tmp/last_activity_ld_${dt}.csv

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET ECHO OFF
SET WRAP OFF
SET HEAD OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET HEADSEP ON
SET TERMOUT OFF
SET UNDERLINE OFF
SET LINESIZE 20000
SET PAGESIZE 0
SPOOL $xdir
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
SELECT /*+ parallel(a,16)*/ MSISDN||'|'||SNAPSHOT_DATE_KEY||'|'||BILLING_ACCOUNT_KEY||'|'||CUSTOMER_ACCOUNT_KEY||'|'||SUBSCRIPTION_KEY||'|'||LU_DATE_KEY||'|'||LU_TIME_KEY||'|'||LU_PRODUCT_KEY||'|'||LU_USAGE_TYPE_KEY||'|'||LU_LOCATION_KEY||'|'||LU_CALL_CATEGORY_KEY||'|'||LU_GEOGRAPHY_KEY||'|'||LU_ACTUAL_DURATION||'|'||LU_AIR_CHARGE||'|'||LU_MOC_DATE_KEY||'|'||LU_MOC_TIME_KEY||'|'||LU_MOC_PRODUCT_KEY||'|'||LU_MOC_GEOGRAPHY_KEY||'|'||LU_MOC_ACTUAL_DURATION||'|'||LU_MOC_AIR_CHARGE||'|'||LU_MTC_DATE_KEY||'|'||LU_MTC_TIME_KEY||'|'||LU_MTC_PRODUCT_KEY||'|'||LU_MTC_GEOGRAPHY_KEY||'|'||LU_MTC_ACTUAL_DURATION||'|'||LU_ON_NET_MOC_DATE_KEY||'|'||LU_ON_NET_MOC_TIME_KEY||'|'||LU_ON_NET_MOC_PRODUCT_KEY||'|'||LU_ON_NET_MOC_ACTUAL_DURATION||'|'||LU_ON_NET_MOC_AIR_CHARGE||'|'||LU_OFF_NET_MOC_DATE_KEY||'|'||LU_OFF_NET_MOC_TIME_KEY||'|'||LU_OFF_NET_MOC_PRODUCT_KEY||'|'||LU_OFF_NET_MOC_LOCATION_KEY||'|'||LU_OFF_NET_MOC_ACTUAL_DURATION||'|'||LU_OFF_NET_MOC_AIR_CHARGE||'|'||LU_MOSMS_DATE_KEY||'|'||LU_MOSMS_TIME_KEY||'|'||LU_MOSMS_PRODUCT_KEY||'|'||LU_MOSMS_GEOGRAPHY_KEY||'|'||LU_MOSMS_LOCATION_KEY||'|'||LU_MOSMS_AIR_CHARGE||'|'||LU_MTSMS_DATE_KEY||'|'||LU_MTSMS_TIME_KEY||'|'||LU_MTSMS_GEOGRAPHY_KEY||'|'||LU_MTSMS_LOCATION_KEY||'|'||LU_GPRS_DATE_KEY||'|'||LU_GPRS_TIME_KEY||'|'||LU_GPRS_PRODUCT_KEY||'|'||LU_GPRS_GEOGRAPHY_KEY||'|'||LU_GPRS_DATA_SIZE||'|'||LR_DATE_KEY||'|'||LR_TIME_KEY||'|'||LR_PRODUCT_KEY||'|'||LR_RECHARGE_TYPE_KEY||'|'||LR_MAIN_ACCOUNT_AMOUNT||'|'||LR_MAIN_ACCOUNT_BALANCE||'|'||LR_VOUCHER_DATE_KEY||'|'||LR_VOUCHER_TIME_KEY||'|'||LR_VOUCHER_PRODUCT_KEY||'|'||LR_VOUCHER_MAIN_ACCOUNT_AMOUNT||'|'||LR_EV_DATE_KEY||'|'||LR_EV_TIME_KEY||'|'||LR_EV_PRODUCT_KEY||'|'||LR_EV_MAIN_ACCOUNT_AMOUNT||'|'||LB_DATE_KEY||'|'||LB_PRODUCT_KEY||'|'||LB_IN_KEY||'|'||LB_EXPIRY_DATE_KEY||'|'||LB_CLOSING_BALANCE||'|'||LB_OPENING_BALANCE||'|'||LI_CALL_DURATION||'|'||LU_MTSMS_PRODUCT_KEY
AS QUERYS
FROM LAST_ACTIVITY_FCT_LD A
WHERE SUBSTR(MSISDN,1,10) !='8801550155'
AND LU_LOCATION_KEY IS NOT NULL
/
EXIT
EOF

