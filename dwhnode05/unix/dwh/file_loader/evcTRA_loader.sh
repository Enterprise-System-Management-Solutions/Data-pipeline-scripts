PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode05
export ORACLE_UNQNAME=dwhdb05
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb05
export DATA_DIR=/data01/oradata

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib


# This function changes the status of files where errors where encountered to 34
updateOnError()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo off
SET head off
SET feedback off
REM "WHENEVER SQLERROR EXIT SQL.SQLCODE"
UPDATE cdr_head
   SET process_status=34
 WHERE file_name='$1'
   AND process_status=30
/
COMMIT
/
EXIT
EOF
}

# This function lists files after mediation and status is =30

get_smsc_files()
{

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET head off
SET feedback off
SET pagesize 0
SET verify off
SET linesize 400
SELECT '/data02/card/evcTRA/process/'||','||'/data02/card/evcTRA/process/'||file_name||','||file_name||','||file_id
  FROM cdr_head
 WHERE source='evcTRA'
   AND process_status=30
   and rownum < 1000
/
EOF
}


createSMSCUpdate()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE

UPDATE cdr_head
   SET process_status=32
 WHERE source='evcTRA'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

insertSMSCUpdate()
{
sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET echo on
SET head off
SET feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE

INSERT INTO L1_EVCTRA(PROCESSED_DATE, FILE_NAME, ET01_SERIAL_NUMBER, ET02_REGION_ID, ET03_MSISDN_DEALER, ET04_INITIATOR_ID, ET05_DEALER_NAME, ET06_MSISDN_BENEFICIARY, ET07_RECIPIENT_ID, ET08_DEALER_NAME, ET09_PRICE_TYPE, ET10_AMOUNT_ROLLBACK, ET11_SENDER_TRANSACTION, ET12_TRANSFER_DATE, ET13_STATE, ET14_ERROR_MESSAGE, ET15_ACCESS_TYPE, ET16_DEALER_DECREASE_MONEY, ET17_ACCEPTOR_INCREASE_MONEY, ET18_TRANSFER_COMMISSION_RATE, ET19_SENDER_TEMPLATE_ID, ET20_RECEIVER_TEMPLATE_ID, ET21_SENDER_BALANCE_STOCK_ADJ, ET22_TRANSFER_HANDLING_FEE, ET23_TAX, ET24_RECEIVER_AFTER_ADJUSTOR, ET25_RECEIVER_BEFORE_ADJUSTOR, ET26_CELL_ID, ET27_SOURCE_MESSAGE, ET28_DESTINATION_MESSAGE, ET29_DENOMINATION_NUMBER, ET30_QUANTITY, ET31_ACCOUNT_INDEX, ET32_ACTUAL_PAYMENT_AMOUNT, ET33_RESERVED, ET34_CELL_ID_TRANSFEREE, ET35_RESERVED, ET36_BRAND_TYPE, ET37_RESERVED)
(SELECT TO_DATE(TO_CHAR(SYSDATE, 'MM/DD/YYYY'), 'MM/DD/YYYY') AS PROCESSED_DATE, '$1', ET01_SERIAL_NUMBER, ET02_REGION_ID, ET03_MSISDN_DEALER, ET04_INITIATOR_ID, ET05_DEALER_NAME, ET06_MSISDN_BENEFICIARY, ET07_RECIPIENT_ID, ET08_DEALER_NAME, ET09_PRICE_TYPE, ET10_AMOUNT_ROLLBACK, ET11_SENDER_TRANSACTION, ET12_TRANSFER_DATE, ET13_STATE, ET14_ERROR_MESSAGE, ET15_ACCESS_TYPE, ET16_DEALER_DECREASE_MONEY, ET17_ACCEPTOR_INCREASE_MONEY, ET18_TRANSFER_COMMISSION_RATE, ET19_SENDER_TEMPLATE_ID, ET20_RECEIVER_TEMPLATE_ID, ET21_SENDER_BALANCE_STOCK_ADJ, ET22_TRANSFER_HANDLING_FEE, ET23_TAX, ET24_RECEIVER_AFTER_ADJUSTOR, ET25_RECEIVER_BEFORE_ADJUSTOR, ET26_CELL_ID, ET27_SOURCE_MESSAGE, ET28_DESTINATION_MESSAGE, ET29_DENOMINATION_NUMBER, ET30_QUANTITY, ET31_ACCOUNT_INDEX, ET32_ACTUAL_PAYMENT_AMOUNT, ET33_RESERVED, ET34_CELL_ID_TRANSFEREE, ET35_RESERVED, ET36_BRAND_TYPE, ET37_RESERVED FROM EVCTRA_EXT)
/
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='evcTRA'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/dwh/lock/evcTRA_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/dwh/file_loader/
sh create_evcTRA_ext_tab.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

