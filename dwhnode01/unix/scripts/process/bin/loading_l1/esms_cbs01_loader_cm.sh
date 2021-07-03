
PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=dwhnode01
export ORACLE_UNQNAME=dwhdb01
export ORACLE_BASE=/data01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/data01/app/oraInventory
export ORACLE_SID=dwhdb01
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
UPDATE cdr_head_merge
   SET process_status=34
 WHERE file_name='$1'
   AND process_status=30
/
COMMIT
/
EXIT
EOF
}

# This function lists files (SMSC) after mediation and status is =30

get_smsc_files()
{

sqlplus  -s <<EOF
dwh_user/dwh_user_123
SET head off
SET feedback off
SET pagesize 0
SET verify off
SET linesize 400
SELECT '/data02/cbs_cdrs/cm/dump_dir/'||','||'/data02/cbs_cdrs/cm/dump_dir/'||file_name||','||file_name||','||file_id
  FROM cdr_head_merge
 WHERE source='cm'-- and trunc(PROCESS_DATE) = TRUNC(SYSDATE) 
   AND process_status=30
--   and mod  (FILE_ID,3) = 1 
   and rownum < 100
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

UPDATE cdr_head_merge
   SET process_status=32
 WHERE source='cm'
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
INSERT INTO L1_MANAGEMENT(PROCESSED_DATE, FILE_NAME, M1_CDR_ID, M2_CDR_SUB_ID, M3_CDR_TYPE, M4_SPLIT_CDR_REASON, M5_CDR_BATCH_ID, M6_SRC_REC_LINE_NO, M7_SRC_CDR_ID, M8_SRC_CDR_NO, M9_STATUS, M10_RE_RATING_TIMES, M11_CREATE_DATE, M12_START_DATE, M13_END_DATE, M14_CUST_LOCAL_START_DATE, M15_CUST_LOCAL_END_DATE, M16_STD_EVT_TYPE_ID, M17_EVT_SOURCE_CATEGORY, M18_OBJ_TYPE, M19_OBJ_ID, M20_OWNER_CUST_ID, M21_DEFAULT_ACCT_ID, M22_PRI_IDENTITY, M23_BILL_CYCLE_ID, M24_SERVICE_CATEGORY, M25_USAGE_SERVICE_TYPE, M26_SESSION_ID, M27_RESULT_CODE, M28_RESULT_REASON, M29_BE_ID, M30_HOT_SEQ, M31_CP_ID, M32_RECIPIENT_NUMBER, M33_USAGE_MEASURE_ID, M34_ACTUAL_USAGE, M35_RATE_USAGE, M36_SERVICE_UNIT_TYPE, M37_USAGE_MEASURE_ID2, M38_ACTUAL_USAGE2, M39_RATE_USAGE2, M40_SERVICE_UNIT_TYPE2, M41_DEBIT_AMOUNT, M42_RESERVED, M43_DEBIT_FROM_PREPAID, M44_DEBIT_FROM_ADVANCE_PREPAID, M45_DEBIT_FROM_POSTPAID, M46_DEBIT_FROM_ADVNCE_POSTPAID, M47_DEBIT_FROM_CREDIT_POSTPAID, M48_TOTAL_TAX, M49_FREE_UNIT_AMOUNT_OF_TIMES, M50_PAY_FREE_UNIT_DURATION, M51_FREE_UNIT_AMOUNT_OF_FLUX, M52_ACCT_ID, M53_ACCT_BALANCE_ID, M54_BALANCE_TYPE, M55_CUR_BALANCE, M56_CHG_BALANCE, M57_CURRENCY_ID, M58_OPER_TYPE, M59_ACCT_ID, M60_ACCT_BALANCE_ID, M61_BALANCE_TYPE, M62_CUR_BALANCE, M63_CHG_BALANCE, M64_CURRENCY_ID, M65_OPER_TYPE, M66_ACCT_ID, M67_ACCT_BALANCE_ID, M68_BALANCE_TYPE, M69_CUR_BALANCE, M70_CHG_BALANCE, M71_CURRENCY_ID, M72_OPER_TYPE, M73_ACCT_ID, M74_ACCT_BALANCE_ID, M75_BALANCE_TYPE, M76_CUR_BALANCE, M77_CHG_BALANCE, M78_CURRENCY_ID, M79_OPER_TYPE, M80_ACCT_ID, M81_ACCT_BALANCE_ID, M82_BALANCE_TYPE, M83_CUR_BALANCE, M84_CHG_BALANCE, M85_CURRENCY_ID, M86_OPER_TYPE, M87_ACCT_ID, M88_ACCT_BALANCE_ID, M89_BALANCE_TYPE, M90_CUR_BALANCE, M91_CHG_BALANCE, M92_CURRENCY_ID, M93_OPER_TYPE, M94_ACCT_ID, M95_ACCT_BALANCE_ID, M96_BALANCE_TYPE, M97_CUR_BALANCE, M98_CHG_BALANCE, M99_CURRENCY_ID, M100_OPER_TYPE, 
M101_ACCT_ID, M102_ACCT_BALANCE_ID, M103_BALANCE_TYPE, M104_CUR_BALANCE, M105_CHG_BALANCE, M106_CURRENCY_ID, M107_OPER_TYPE, M108_ACCT_ID, M109_ACCT_BALANCE_ID, M110_BALANCE_TYPE, M111_CUR_BALANCE, M112_CHG_BALANCE, M113_CURRENCY_ID, M114_OPER_TYPE, M115_ACCT_ID, M116_ACCT_BALANCE_ID, M117_BALANCE_TYPE, M118_CUR_BALANCE, M119_CHG_BALANCE, M120_CURRENCY_ID, M121_OPER_TYPE, M122_FU_OWN_TYPE, M123_FU_OWN_ID, M124_FREE_UNIT_ID, M125_FREE_UNIT_TYPE, M126_CUR_AMOUNT, M127_CHG_AMOUNT, M128_FU_MEASURE_ID, M129_OPER_TYPE, M130_FU_OWN_TYPE, M131_FU_OWN_ID, M132_FREE_UNIT_ID, M133_FREE_UNIT_TYPE, M134_CUR_AMOUNT, M135_CHG_AMOUNT, M136_FU_MEASURE_ID, M137_OPER_TYPE, M138_FU_OWN_TYPE, M139_FU_OWN_ID, M140_FREE_UNIT_ID, M141_FREE_UNIT_TYPE, M142_CUR_AMOUNT, M143_CHG_AMOUNT, M144_FU_MEASURE_ID, M145_OPER_TYPE, M146_FU_OWN_TYPE, M147_FU_OWN_ID, M148_FREE_UNIT_ID, M149_FREE_UNIT_TYPE, M150_CUR_AMOUNT, M151_CHG_AMOUNT, M152_FU_MEASURE_ID, M153_OPER_TYPE, M154_FU_OWN_TYPE, M155_FU_OWN_ID, M156_FREE_UNIT_ID, M157_FREE_UNIT_TYPE, M158_CUR_AMOUNT, M159_CHG_AMOUNT, M160_FU_MEASURE_ID, M161_OPER_TYPE, M162_FU_OWN_TYPE, M163_FU_OWN_ID, M164_FREE_UNIT_ID, M165_FREE_UNIT_TYPE, M166_CUR_AMOUNT, M167_CHG_AMOUNT, M168_FU_MEASURE_ID, M169_OPER_TYPE, M170_FU_OWN_TYPE, M171_FU_OWN_ID, M172_FREE_UNIT_ID, M173_FREE_UNIT_TYPE, M174_CUR_AMOUNT, M175_CHG_AMOUNT, M176_FU_MEASURE_ID, M177_OPER_TYPE, M178_FU_OWN_TYPE, M179_FU_OWN_ID, M180_FREE_UNIT_ID, M181_FREE_UNIT_TYPE, M182_CUR_AMOUNT, M183_CHG_AMOUNT, M184_FU_MEASURE_ID, M185_OPER_TYPE, M186_FU_OWN_TYPE, M187_FU_OWN_ID, M188_FREE_UNIT_ID, M189_FREE_UNIT_TYPE, M190_CUR_AMOUNT, M191_CHG_AMOUNT, M192_FU_MEASURE_ID, M193_OPER_TYPE, M194_FU_OWN_TYPE, M195_FU_OWN_ID, M196_FREE_UNIT_ID, M197_FREE_UNIT_TYPE, M198_CUR_AMOUNT, M199_CHG_AMOUNT, M200_FU_MEASURE_ID, M201_OPER_TYPE, M202_ACCT_ID, M203_ACCT_BALANCE_ID, M204_BALANCE_TYPE, M205_BONUS_AMOUNT, 
M206_CUR_BALANCE, M207_CURRENCY_ID, M208_OPER_TYPE, M209_CUR_EXPIRE_TIME, M210_ACCT_ID, M211_ACCT_BALANCE_ID, M212_BALANCE_TYPE, M213_CUR_BALANCE, M214_CHG_BALANCE, M215_CURRENCY_ID, M216_OPER_TYPE, M217_CUR_EXPIRE_TIME, M218_ACCT_ID, M219_ACCT_BALANCE_ID, M220_BALANCE_TYPE, M221_CUR_BALANCE, M222_CHG_BALANCE, M223_CURRENCY_ID, M224_OPER_TYPE, M225_CUR_EXPIRE_TIME, M226_ACCT_ID, M227_ACCT_BALANCE_ID, M228_BALANCE_TYPE, M229_BONUS_AMOUNT, M230_CUR_BALANCE, M231_CURRENCY_ID, M232_OPER_TYPE, M233_CUR_EXPIRE_TIME, M234_ACCT_ID, M235_ACCT_BALANCE_ID, M236_BALANCE_TYPE, M237_BONUS_AMOUNT, M238_CUR_BALANCE, M239_CURRENCY_ID, M240_OPER_TYPE, M241_CUR_EXPIRE_TIME, M242_ACCT_ID, M243_ACCT_BALANCE_ID, M244_BALANCE_TYPE, M245_BONUS_AMOUNT, M246_CUR_BALANCE, M247_CURRENCY_ID, M248_OPER_TYPE, M249_CUR_EXPIRE_TIME, M250_ACCT_ID, M251_ACCT_BALANCE_ID, M252_BALANCE_TYPE, M253_BONUS_AMOUNT, M254_CUR_BALANCE, M255_CURRENCY_ID, M256_OPER_TYPE, M257_CUR_EXPIRE_TIME, M258_ACCT_ID, M259_ACCT_BALANCE_ID, M260_BALANCE_TYPE, M261_BONUS_AMOUNT, M262_CUR_BALANCE, M263_CURRENCY_ID, M264_OPER_TYPE, M265_CUR_EXPIRE_TIME, M266_ACCT_ID, M267_ACCT_BALANCE_ID, M268_BALANCE_TYPE, M269_BONUS_AMOUNT, M270_CUR_BALANCE, M271_CURRENCY_ID, M272_OPER_TYPE, M273_CUR_EXPIRE_TIME, M274_ACCT_ID, M275_ACCT_BALANCE_ID, M276_BALANCE_TYPE, M277_BONUS_AMOUNT, M278_CUR_BALANCE, M279_CURRENCY_ID, M280_OPER_TYPE, M281_CUR_EXPIRE_TIME, M282_FU_OWN_TYPE, M283_FU_OWN_ID, M284_FREE_UNIT_TYPE, M285_FREE_UNIT_ID, M286_BONUS_AMOUNT, M287_CURRENT_AMOUNT, M288_FU_MEASURE_ID, M289_OPER_TYPE, M290_CUR_EXPIRE_TIME, M291_FU_OWN_TYPE, M292_FU_OWN_ID, M293_FREE_UNIT_TYPE, M294_FREE_UNIT_ID, M295_BONUS_AMOUNT, M296_CURRENT_AMOUNT, M297_FU_MEASURE_ID, M298_OPER_TYPE, M299_CUR_EXPIRE_TIME, M300_FU_OWN_TYPE, M301_FU_OWN_ID, M302_FREE_UNIT_TYPE, M303_FREE_UNIT_ID, M304_BONUS_AMOUNT, M305_CURRENT_AMOUNT, M306_FU_MEASURE_ID, M307_OPER_TYPE, 
M308_CUR_EXPIRE_TIME, M309_FU_OWN_TYPE, M310_FU_OWN_ID, M311_FREE_UNIT_TYPE, M312_FREE_UNIT_ID, M313_BONUS_AMOUNT, M314_CURRENT_AMOUNT, M315_FU_MEASURE_ID, M316_OPER_TYPE, M317_CURRENT_AMOUNT, M318_FU_OWN_TYPE, M319_FU_OWN_ID, M320_FREE_UNIT_TYPE, M321_FREE_UNIT_ID, M322_BONUS_AMOUNT, M323_CURRENT_AMOUNT, M324_FU_MEASURE_ID, M325_OPER_TYPE, M326_CUR_EXPIRE_TIME, M327_FU_OWN_TYPE, M328_FU_OWN_ID, M329_FREE_UNIT_TYPE, M330_FREE_UNIT_ID, M331_BONUS_AMOUNT, M332_CURRENT_AMOUNT, M333_FU_MEASURE_ID, M334_OPER_TYPE, M335_CUR_EXPIRE_TIME, M336_FU_OWN_TYPE, M337_FU_OWN_ID, M338_FREE_UNIT_TYPE, M339_FREE_UNIT_ID, M340_BONUS_AMOUNT, M341_CURRENT_AMOUNT, M342_FU_MEASURE_ID, M343_OPER_TYPE, M344_CUR_EXPIRE_TIME, M345_FU_OWN_TYPE, M346_FU_OWN_ID, M347_FREE_UNIT_TYPE, M348_FREE_UNIT_ID, M349_BONUS_AMOUNT, M350_CURRENT_AMOUNT, M351_FU_MEASURE_ID, M352_OPER_TYPE, M353_CUR_EXPIRE_TIME, M354_FU_OWN_TYPE, M355_FU_OWN_ID, M356_FREE_UNIT_TYPE, M357_FREE_UNIT_ID, M358_BONUS_AMOUNT, M359_CURRENT_AMOUNT, M360_FU_MEASURE_ID, M361_OPER_TYPE, M362_CUR_EXPIRE_TIME, M363_FU_OWN_TYPE, M364_FU_OWN_ID, M365_FREE_UNIT_TYPE, M366_FREE_UNIT_ID, M367_BONUS_AMOUNT, M368_CURRENT_AMOUNT, M369_FU_MEASURE_ID, M370_OPER_TYPE, M371_CUR_EXPIRE_TIME, M372_CALLINGPARTYNUMBER, M373_OPERATIONID, M374_OPERATIONTYPE, M375_BRANDID, M376_MAINOFFERINGID, M377_PAYTYPE, M378_STARTTIMEOFBILLCYCLE, M379_RESERVE, M380_MERCHANT, M381_SERVICE, M382_MAINBALANCEINFO, M383_CHGBALANCEINFO, M384_CHGFREEUNITINFO, M385_USERSTATE, M386_OLDUSERSTATE, M387_VALIDDAYADDED, M388_OPER_ID, M389_SPID, M390_SERVICEID, M391_SERVICETYPE, M392_CONTENTID, M393_URL, M394_TRANSACTIONID, M395_OLDMAINOFFERINGID, M396_ADDITIONALINFO, M397_NEWOFFERINGID, M398_EXPIRETIMEOFNEWOFFERING, M399_CHARGEPARTYINDICATOR, M400_ACCESSMETHOD, M401_TAXINFO, M402_PREPAID_BALANCE, M403_POSTPAID_BALANCE, M404_ACCOUNT_KEY, M405_PAY_PAYTYPE, M406_PAY_BILL_CYCLE_ID, 
M407_PAY_FREE_UNIT_TIMES, M408_PAY_DEBIT_AMOUNT, M409_PAY_DEBIT_FROM_PREPAID, M410_PAY_ACCOUNT_KEY, M411_PAY_DEBIT_FROM_POSTPAID, M412_PAY_DEFAULT_ACCT_ID, M413_OWNER_CUST_CODE, M414_PAY_CUST_ID, M415_PAY_CUST_CODE, M416_SUBSCRIBER_KEY, M417_OFFERINGID)
(SELECT TO_DATE(TO_CHAR(sysdate, 'MM/DD/YYYY'), 'MM/DD/YYYY'),FILE_NAME ,M1_CDR_ID, M2_CDR_SUB_ID, M3_CDR_TYPE, M4_SPLIT_CDR_REASON, M5_CDR_BATCH_ID, M6_SRC_REC_LINE_NO, M7_SRC_CDR_ID, M8_SRC_CDR_NO, M9_STATUS, M10_RE_RATING_TIMES, M11_CREATE_DATE, M12_START_DATE, M13_END_DATE, M14_CUST_LOCAL_START_DATE, M15_CUST_LOCAL_END_DATE, M16_STD_EVT_TYPE_ID, M17_EVT_SOURCE_CATEGORY, M18_OBJ_TYPE, M19_OBJ_ID, M20_OWNER_CUST_ID, M21_DEFAULT_ACCT_ID, M22_PRI_IDENTITY, M23_BILL_CYCLE_ID, M24_SERVICE_CATEGORY, M25_USAGE_SERVICE_TYPE, M26_SESSION_ID, M27_RESULT_CODE, M28_RESULT_REASON, M29_BE_ID, M30_HOT_SEQ, M31_CP_ID, M32_RECIPIENT_NUMBER, M33_USAGE_MEASURE_ID, M34_ACTUAL_USAGE, M35_RATE_USAGE, M36_SERVICE_UNIT_TYPE, M37_USAGE_MEASURE_ID2, M38_ACTUAL_USAGE2, M39_RATE_USAGE2, M40_SERVICE_UNIT_TYPE2, M41_DEBIT_AMOUNT, M42_RESERVED, M43_DEBIT_FROM_PREPAID, M44_DEBIT_FROM_ADVANCE_PREPAID, M45_DEBIT_FROM_POSTPAID, M46_DEBIT_FROM_ADVNCE_POSTPAID, M47_DEBIT_FROM_CREDIT_POSTPAID, M48_TOTAL_TAX, M49_FREE_UNIT_AMOUNT_OF_TIMES, M50_PAY_FREE_UNIT_DURATION, M51_FREE_UNIT_AMOUNT_OF_FLUX, M52_ACCT_ID, M53_ACCT_BALANCE_ID, M54_BALANCE_TYPE, M55_CUR_BALANCE, M56_CHG_BALANCE, M57_CURRENCY_ID, M58_OPER_TYPE, M59_ACCT_ID, M60_ACCT_BALANCE_ID, M61_BALANCE_TYPE, M62_CUR_BALANCE, M63_CHG_BALANCE, M64_CURRENCY_ID, M65_OPER_TYPE, M66_ACCT_ID, M67_ACCT_BALANCE_ID, M68_BALANCE_TYPE, M69_CUR_BALANCE, M70_CHG_BALANCE, M71_CURRENCY_ID, M72_OPER_TYPE, M73_ACCT_ID, M74_ACCT_BALANCE_ID, M75_BALANCE_TYPE, M76_CUR_BALANCE, M77_CHG_BALANCE, M78_CURRENCY_ID, M79_OPER_TYPE, M80_ACCT_ID, M81_ACCT_BALANCE_ID, M82_BALANCE_TYPE, M83_CUR_BALANCE, M84_CHG_BALANCE, M85_CURRENCY_ID, M86_OPER_TYPE, M87_ACCT_ID, M88_ACCT_BALANCE_ID, M89_BALANCE_TYPE, M90_CUR_BALANCE, M91_CHG_BALANCE, M92_CURRENCY_ID, M93_OPER_TYPE, M94_ACCT_ID, M95_ACCT_BALANCE_ID, M96_BALANCE_TYPE, M97_CUR_BALANCE, M98_CHG_BALANCE, M99_CURRENCY_ID, M100_OPER_TYPE, 
M101_ACCT_ID, M102_ACCT_BALANCE_ID, M103_BALANCE_TYPE, M104_CUR_BALANCE, M105_CHG_BALANCE, M106_CURRENCY_ID, M107_OPER_TYPE, M108_ACCT_ID, M109_ACCT_BALANCE_ID, M110_BALANCE_TYPE, M111_CUR_BALANCE, M112_CHG_BALANCE, M113_CURRENCY_ID, M114_OPER_TYPE, M115_ACCT_ID, M116_ACCT_BALANCE_ID, M117_BALANCE_TYPE, M118_CUR_BALANCE, M119_CHG_BALANCE, M120_CURRENCY_ID, M121_OPER_TYPE, M122_FU_OWN_TYPE, M123_FU_OWN_ID, M124_FREE_UNIT_ID, M125_FREE_UNIT_TYPE, M126_CUR_AMOUNT, M127_CHG_AMOUNT, M128_FU_MEASURE_ID, M129_OPER_TYPE, M130_FU_OWN_TYPE, M131_FU_OWN_ID, M132_FREE_UNIT_ID, M133_FREE_UNIT_TYPE, M134_CUR_AMOUNT, M135_CHG_AMOUNT, M136_FU_MEASURE_ID, M137_OPER_TYPE, M138_FU_OWN_TYPE, M139_FU_OWN_ID, M140_FREE_UNIT_ID, M141_FREE_UNIT_TYPE, M142_CUR_AMOUNT, M143_CHG_AMOUNT, M144_FU_MEASURE_ID, M145_OPER_TYPE, M146_FU_OWN_TYPE, M147_FU_OWN_ID, M148_FREE_UNIT_ID, M149_FREE_UNIT_TYPE, M150_CUR_AMOUNT, M151_CHG_AMOUNT, M152_FU_MEASURE_ID, M153_OPER_TYPE, M154_FU_OWN_TYPE, M155_FU_OWN_ID, M156_FREE_UNIT_ID, M157_FREE_UNIT_TYPE, M158_CUR_AMOUNT, M159_CHG_AMOUNT, M160_FU_MEASURE_ID, M161_OPER_TYPE, M162_FU_OWN_TYPE, M163_FU_OWN_ID, M164_FREE_UNIT_ID, M165_FREE_UNIT_TYPE, M166_CUR_AMOUNT, M167_CHG_AMOUNT, M168_FU_MEASURE_ID, M169_OPER_TYPE, M170_FU_OWN_TYPE, M171_FU_OWN_ID, M172_FREE_UNIT_ID, M173_FREE_UNIT_TYPE, M174_CUR_AMOUNT, M175_CHG_AMOUNT, M176_FU_MEASURE_ID, M177_OPER_TYPE, M178_FU_OWN_TYPE, M179_FU_OWN_ID, M180_FREE_UNIT_ID, M181_FREE_UNIT_TYPE, M182_CUR_AMOUNT, M183_CHG_AMOUNT, M184_FU_MEASURE_ID, M185_OPER_TYPE, M186_FU_OWN_TYPE, M187_FU_OWN_ID, M188_FREE_UNIT_ID, M189_FREE_UNIT_TYPE, M190_CUR_AMOUNT, M191_CHG_AMOUNT, M192_FU_MEASURE_ID, M193_OPER_TYPE, M194_FU_OWN_TYPE, M195_FU_OWN_ID, M196_FREE_UNIT_ID, M197_FREE_UNIT_TYPE, M198_CUR_AMOUNT, M199_CHG_AMOUNT, M200_FU_MEASURE_ID, M201_OPER_TYPE, M202_ACCT_ID, M203_ACCT_BALANCE_ID, M204_BALANCE_TYPE, M205_BONUS_AMOUNT, 
M206_CUR_BALANCE, M207_CURRENCY_ID, M208_OPER_TYPE, M209_CUR_EXPIRE_TIME, M210_ACCT_ID, M211_ACCT_BALANCE_ID, M212_BALANCE_TYPE, M213_CUR_BALANCE, M214_CHG_BALANCE, M215_CURRENCY_ID, M216_OPER_TYPE, M217_CUR_EXPIRE_TIME, M218_ACCT_ID, M219_ACCT_BALANCE_ID, M220_BALANCE_TYPE, M221_CUR_BALANCE, M222_CHG_BALANCE, M223_CURRENCY_ID, M224_OPER_TYPE, M225_CUR_EXPIRE_TIME, M226_ACCT_ID, M227_ACCT_BALANCE_ID, M228_BALANCE_TYPE, M229_BONUS_AMOUNT, M230_CUR_BALANCE, M231_CURRENCY_ID, M232_OPER_TYPE, M233_CUR_EXPIRE_TIME, M234_ACCT_ID, M235_ACCT_BALANCE_ID, M236_BALANCE_TYPE, M237_BONUS_AMOUNT, M238_CUR_BALANCE, M239_CURRENCY_ID, M240_OPER_TYPE, M241_CUR_EXPIRE_TIME, M242_ACCT_ID, M243_ACCT_BALANCE_ID, M244_BALANCE_TYPE, M245_BONUS_AMOUNT, M246_CUR_BALANCE, M247_CURRENCY_ID, M248_OPER_TYPE, M249_CUR_EXPIRE_TIME, M250_ACCT_ID, M251_ACCT_BALANCE_ID, M252_BALANCE_TYPE, M253_BONUS_AMOUNT, M254_CUR_BALANCE, M255_CURRENCY_ID, M256_OPER_TYPE, M257_CUR_EXPIRE_TIME, M258_ACCT_ID, M259_ACCT_BALANCE_ID, M260_BALANCE_TYPE, M261_BONUS_AMOUNT, M262_CUR_BALANCE, M263_CURRENCY_ID, M264_OPER_TYPE, M265_CUR_EXPIRE_TIME, M266_ACCT_ID, M267_ACCT_BALANCE_ID, M268_BALANCE_TYPE, M269_BONUS_AMOUNT, M270_CUR_BALANCE, M271_CURRENCY_ID, M272_OPER_TYPE, M273_CUR_EXPIRE_TIME, M274_ACCT_ID, M275_ACCT_BALANCE_ID, M276_BALANCE_TYPE, M277_BONUS_AMOUNT, M278_CUR_BALANCE, M279_CURRENCY_ID, M280_OPER_TYPE, M281_CUR_EXPIRE_TIME, M282_FU_OWN_TYPE, M283_FU_OWN_ID, M284_FREE_UNIT_TYPE, M285_FREE_UNIT_ID, M286_BONUS_AMOUNT, M287_CURRENT_AMOUNT, M288_FU_MEASURE_ID, M289_OPER_TYPE, M290_CUR_EXPIRE_TIME, M291_FU_OWN_TYPE, M292_FU_OWN_ID, M293_FREE_UNIT_TYPE, M294_FREE_UNIT_ID, M295_BONUS_AMOUNT, M296_CURRENT_AMOUNT, M297_FU_MEASURE_ID, M298_OPER_TYPE, M299_CUR_EXPIRE_TIME, M300_FU_OWN_TYPE, M301_FU_OWN_ID, M302_FREE_UNIT_TYPE, M303_FREE_UNIT_ID, M304_BONUS_AMOUNT, M305_CURRENT_AMOUNT, M306_FU_MEASURE_ID, M307_OPER_TYPE, 
M308_CUR_EXPIRE_TIME, M309_FU_OWN_TYPE, M310_FU_OWN_ID, M311_FREE_UNIT_TYPE, M312_FREE_UNIT_ID, M313_BONUS_AMOUNT, M314_CURRENT_AMOUNT, M315_FU_MEASURE_ID, M316_OPER_TYPE, M317_CURRENT_AMOUNT, M318_FU_OWN_TYPE, M319_FU_OWN_ID, M320_FREE_UNIT_TYPE, M321_FREE_UNIT_ID, M322_BONUS_AMOUNT, M323_CURRENT_AMOUNT, M324_FU_MEASURE_ID, M325_OPER_TYPE, M326_CUR_EXPIRE_TIME, M327_FU_OWN_TYPE, M328_FU_OWN_ID, M329_FREE_UNIT_TYPE, M330_FREE_UNIT_ID, M331_BONUS_AMOUNT, M332_CURRENT_AMOUNT, M333_FU_MEASURE_ID, M334_OPER_TYPE, M335_CUR_EXPIRE_TIME, M336_FU_OWN_TYPE, M337_FU_OWN_ID, M338_FREE_UNIT_TYPE, M339_FREE_UNIT_ID, M340_BONUS_AMOUNT, M341_CURRENT_AMOUNT, M342_FU_MEASURE_ID, M343_OPER_TYPE, M344_CUR_EXPIRE_TIME, M345_FU_OWN_TYPE, M346_FU_OWN_ID, M347_FREE_UNIT_TYPE, M348_FREE_UNIT_ID, M349_BONUS_AMOUNT, M350_CURRENT_AMOUNT, M351_FU_MEASURE_ID, M352_OPER_TYPE, M353_CUR_EXPIRE_TIME, M354_FU_OWN_TYPE, M355_FU_OWN_ID, M356_FREE_UNIT_TYPE, M357_FREE_UNIT_ID, M358_BONUS_AMOUNT, M359_CURRENT_AMOUNT, M360_FU_MEASURE_ID, M361_OPER_TYPE, M362_CUR_EXPIRE_TIME, M363_FU_OWN_TYPE, M364_FU_OWN_ID, M365_FREE_UNIT_TYPE, M366_FREE_UNIT_ID, M367_BONUS_AMOUNT, M368_CURRENT_AMOUNT, M369_FU_MEASURE_ID, M370_OPER_TYPE, M371_CUR_EXPIRE_TIME, M372_CALLINGPARTYNUMBER, M373_OPERATIONID, M374_OPERATIONTYPE, M375_BRANDID, M376_MAINOFFERINGID, M377_PAYTYPE, M378_STARTTIMEOFBILLCYCLE, M379_RESERVE, M380_MERCHANT, M381_SERVICE, M382_MAINBALANCEINFO, M383_CHGBALANCEINFO, M384_CHGFREEUNITINFO, M385_USERSTATE, M386_OLDUSERSTATE, M387_VALIDDAYADDED, M388_OPER_ID, M389_SPID, M390_SERVICEID, M391_SERVICETYPE, M392_CONTENTID, M393_URL, M394_TRANSACTIONID, M395_OLDMAINOFFERINGID, M396_ADDITIONALINFO, M397_NEWOFFERINGID, M398_EXPIRETIMEOFNEWOFFERING, M399_CHARGEPARTYINDICATOR, M400_ACCESSMETHOD, M401_TAXINFO, M402_PREPAID_BALANCE, M403_POSTPAID_BALANCE, M404_ACCOUNT_KEY, M405_PAY_PAYTYPE, M406_PAY_BILL_CYCLE_ID, 
M407_PAY_FREE_UNIT_TIMES, M408_PAY_DEBIT_AMOUNT, M409_PAY_DEBIT_FROM_PREPAID, M410_PAY_ACCOUNT_KEY, M411_PAY_DEBIT_FROM_POSTPAID, M412_PAY_DEFAULT_ACCT_ID, M413_OWNER_CUST_CODE, M414_PAY_CUST_ID, M415_PAY_CUST_CODE, M416_SUBSCRIBER_KEY, M417_OFFERINGID FROM CM01_EXT)

/
COMMIT
/
UPDATE cdr_head_merge
   SET process_status=96
 WHERE source='cm'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/cm01_loader_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/process/bin/loading_l1/
sh esms_create_cbs01_ext_cm.sh $v3 
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

