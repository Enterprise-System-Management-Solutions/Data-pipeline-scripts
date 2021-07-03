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
SELECT '/data02/cbs_cdrs/com/dump_dir/'||','||'/data02/cbs_cdrs/com/dump_dir/'||file_name||','||file_name||','||file_id
  FROM cdr_head_merge
 WHERE source='com'-- and trunc(PROCESS_DATE) = TRUNC(SYSDATE) 
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
 WHERE source='com'
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
INSERT INTO L1_CONTENT_TEMP(PROCESSED_DATE, FILE_NAME, CO1_CDR_ID, CO2_CDR_SUB_ID, CO3_CDR_TYPE, CO4_SPLIT_CDR_REASON, CO5_CDR_BATCH_ID, CO6_SRC_REC_LINE_NO, CO7_SRC_CDR_ID, CO8_SRC_CDR_NO, CO9_STATUS, CO10_RE_RATING_TIMES, CO11_CREATE_DATE, CO12_START_DATE, CO13_END_DATE, CO14_CUST_LOCAL_START_DATE, CO15_CUST_LOCAL_END_DATE, CO16_STD_EVT_TYPE_ID, CO17_EVT_SOURCE_CATEGORY, CO18_OBJ_TYPE, CO19_OBJ_ID, CO20_OWNER_CUST_ID, CO21_DEFAULT_ACCT_ID, CO22_PRI_IDENTITY, CO23_BILL_CYCLE_ID, CO24_SERVICE_CATEGORY, CO25_USAGE_SERVICE_TYPE, CO26_SESSION_ID, CO27_RESULT_CODE, CO28_RESULT_REASON, CO29_BE_ID, CO30_HOT_SEQ, CO31_CP_ID, CO32_RECIPIENT_NUMBER, CO33_USAGE_MEASURE_ID, CO34_ACTUAL_USAGE, CO35_RATE_USAGE, CO36_SERVICE_UNIT_TYPE, CO37_USAGE_MEASURE_ID2, CO38_ACTUAL_USAGE2, CO39_RATE_USAGE2, CO40_SERVICE_UNIT_TYPE2, CO41_DEBIT_AMOUNT, CO42_RESERVED, CO43_DEBIT_FROM_PREPAID, CO44_DEBIT_FROM_ADVANCE_PRE, CO45_DEBIT_FROM_POSTPAID, CO46_DEBIT_FROM_ADVANCE_POST, CO47_DEBIT_FROM_CREDIT_POST, CO48_TOTAL_TAX, CO49_FREE_UNIT_AMOUNT_OF_TIMES, CO50_FREE_UNIT_AMT_OF_DURATION, CO51_FREE_UNIT_AMOUNT_OF_FLUX, CO52_ACCT_ID, CO53_ACCT_BALANCE_ID, CO54_BALANCE_TYPE, CO55_CUR_BALANCE, CO56_CHG_BALANCE, CO57_CURRENCY_ID, CO58_OPER_TYPE, CO59_ACCT_ID, CO60_ACCT_BALANCE_ID, CO61_BALANCE_TYPE, CO62_CUR_BALANCE, CO63_CHG_BALANCE, CO64_CURRENCY_ID, CO65_OPER_TYPE, CO66_ACCT_ID, CO67_ACCT_BALANCE_ID, CO68_BALANCE_TYPE, CO69_CUR_BALANCE, CO70_CHG_BALANCE, CO71_CURRENCY_ID, CO72_OPER_TYPE, CO73_ACCT_ID, CO74_ACCT_BALANCE_ID, CO75_BALANCE_TYPE, CO76_CUR_BALANCE, CO77_CHG_BALANCE, CO78_CURRENCY_ID, CO79_OPER_TYPE, CO80_ACCT_ID, CO81_ACCT_BALANCE_ID, CO82_BALANCE_TYPE, CO83_CUR_BALANCE, CO84_CHG_BALANCE, CO85_CURRENCY_ID, CO86_OPER_TYPE, CO87_ACCT_ID, CO88_ACCT_BALANCE_ID, CO89_BALANCE_TYPE, CO90_CUR_BALANCE, CO91_CHG_BALANCE, CO92_CURRENCY_ID, CO93_OPER_TYPE, CO94_ACCT_ID, CO95_ACCT_BALANCE_ID, CO96_BALANCE_TYPE, CO97_CUR_BALANCE, CO98_CHG_BALANCE, CO99_CURRENCY_ID, CO100_OPER_TYPE, CO101_ACCT_ID, CO102_ACCT_BALANCE_ID, CO103_BALANCE_TYPE, 
CO104_CUR_BALANCE, CO105_CHG_BALANCE, CO106_CURRENCY_ID, CO107_OPER_TYPE, CO108_ACCT_ID, CO109_ACCT_BALANCE_ID, CO110_BALANCE_TYPE, CO111_CUR_BALANCE, CO112_CHG_BALANCE, CO113_CURRENCY_ID, CO114_OPER_TYPE, CO115_ACCT_ID, CO116_ACCT_BALANCE_ID, CO117_BALANCE_TYPE, CO118_CUR_BALANCE, CO119_CHG_BALANCE, CO120_CURRENCY_ID, CO121_OPER_TYPE, CO122_FU_OWN_TYPE, CO123_FU_OWN_ID, CO124_FREE_UNIT_ID, CO125_FREE_UNIT_TYPE, CO126_CUR_AMOUNT, CO127_CHG_AMOUNT, CO128_FU_MEASURE_ID, CO129_OPER_TYPE, CO130_FU_OWN_TYPE, CO131_FU_OWN_ID, CO132_FREE_UNIT_ID, CO133_FREE_UNIT_TYPE, CO134_CUR_AMOUNT, CO135_CHG_AMOUNT, CO136_FU_MEASURE_ID, CO137_OPER_TYPE, CO138_FU_OWN_TYPE, CO139_FU_OWN_ID, CO140_FREE_UNIT_ID, CO141_FREE_UNIT_TYPE, CO142_CUR_AMOUNT, CO143_CHG_AMOUNT, CO144_FU_MEASURE_ID, CO145_OPER_TYPE, CO146_FU_OWN_TYPE, CO147_FU_OWN_ID, CO148_FREE_UNIT_ID, CO149_FREE_UNIT_TYPE, CO150_CUR_AMOUNT, CO151_CHG_AMOUNT, CO152_FU_MEASURE_ID, CO153_OPER_TYPE, CO154_FU_OWN_TYPE, CO155_FU_OWN_ID, CO156_FREE_UNIT_ID, CO157_FREE_UNIT_TYPE, CO158_CUR_AMOUNT, CO159_CHG_AMOUNT, CO160_FU_MEASURE_ID, CO161_OPER_TYPE, CO162_FU_OWN_TYPE, CO163_FU_OWN_ID, CO164_FREE_UNIT_ID, CO165_FREE_UNIT_TYPE, CO166_CUR_AMOUNT, CO167_CHG_AMOUNT, CO168_FU_MEASURE_ID, CO169_OPER_TYPE, CO170_FU_OWN_TYPE, CO171_FU_OWN_ID, CO172_FREE_UNIT_ID, CO173_FREE_UNIT_TYPE, CO174_CUR_AMOUNT, CO175_CHG_AMOUNT, CO176_FU_MEASURE_ID, CO177_OPER_TYPE, CO178_FU_OWN_TYPE, CO179_FU_OWN_ID, CO180_FREE_UNIT_ID, CO181_FREE_UNIT_TYPE, CO182_CUR_AMOUNT, CO183_CHG_AMOUNT, CO184_FU_MEASURE_ID, CO185_OPER_TYPE, CO186_FU_OWN_TYPE, CO187_FU_OWN_ID, CO188_FREE_UNIT_ID, CO189_FREE_UNIT_TYPE, CO190_CUR_AMOUNT, CO191_CHG_AMOUNT, CO192_FU_MEASURE_ID, CO193_OPER_TYPE, CO194_FU_OWN_TYPE, CO195_FU_OWN_ID, CO196_FREE_UNIT_ID, CO197_FREE_UNIT_TYPE, CO198_CUR_AMOUNT, CO199_CHG_AMOUNT, CO200_FU_MEASURE_ID, CO201_OPER_TYPE, CO202_ACCT_ID, CO203_ACCT_BALANCE_ID, CO204_BALANCE_TYPE, CO205_BONUS_AMOUNT, CO206_CUR_BALANCE, CO207_CURRENCY_ID, CO208_OPER_TYPE, CO209_CUR_EXPIRE_TIME, CO210_ACCT_ID, 
CO211_ACCT_BALANCE_ID, CO212_BALANCE_TYPE, CO213_CUR_BALANCE, CO214_CHG_BALANCE, CO215_CURRENCY_ID, CO216_OPER_TYPE, CO217_CUR_EXPIRE_TIME, CO218_ACCT_ID, CO219_ACCT_BALANCE_ID, CO220_BALANCE_TYPE, CO221_CUR_BALANCE, CO222_CHG_BALANCE, CO223_CURRENCY_ID, CO224_OPER_TYPE, CO225_CUR_EXPIRE_TIME, CO226_ACCT_ID, CO227_ACCT_BALANCE_ID, CO228_BALANCE_TYPE, CO229_BONUS_AMOUNT, CO230_CUR_BALANCE, CO231_CURRENCY_ID, CO232_OPER_TYPE, CO233_CUR_EXPIRE_TIME, CO234_ACCT_ID, CO235_ACCT_BALANCE_ID, CO236_BALANCE_TYPE, CO237_BONUS_AMOUNT, CO238_CUR_BALANCE, CO239_CURRENCY_ID, CO240_OPER_TYPE, CO241_CUR_EXPIRE_TIME, CO242_ACCT_ID, CO243_ACCT_BALANCE_ID, CO244_BALANCE_TYPE, CO245_BONUS_AMOUNT, CO246_CUR_BALANCE, CO247_CURRENCY_ID, CO248_OPER_TYPE, CO249_CUR_EXPIRE_TIME, CO250_ACCT_ID, CO251_ACCT_BALANCE_ID, CO252_BALANCE_TYPE, CO253_BONUS_AMOUNT, CO254_CUR_BALANCE, CO255_CURRENCY_ID, CO256_OPER_TYPE, CO257_CUR_EXPIRE_TIME, CO258_ACCT_ID, CO259_ACCT_BALANCE_ID, CO260_BALANCE_TYPE, CO261_BONUS_AMOUNT, CO262_CUR_BALANCE, CO263_CURRENCY_ID, CO264_OPER_TYPE, CO265_CUR_EXPIRE_TIME, CO266_ACCT_ID, CO267_ACCT_BALANCE_ID, CO268_BALANCE_TYPE, CO269_BONUS_AMOUNT, CO270_CUR_BALANCE, CO271_CURRENCY_ID, CO272_OPER_TYPE, CO273_CUR_EXPIRE_TIME, CO274_ACCT_ID, CO275_ACCT_BALANCE_ID, CO276_BALANCE_TYPE, CO277_BONUS_AMOUNT, CO278_CUR_BALANCE, CO279_CURRENCY_ID, CO280_OPER_TYPE, CO281_CUR_EXPIRE_TIME, CO282_FU_OWN_TYPE, CO283_FU_OWN_ID, CO284_FREE_UNIT_TYPE, CO285_FREE_UNIT_ID, CO286_BONUS_AMOUNT, CO287_CURRENT_AMOUNT, CO288_FU_MEASURE_ID, CO289_OPER_TYPE, CO290_CUR_EXPIRE_TIME, CO291_FU_OWN_TYPE, CO292_FU_OWN_ID, CO293_FREE_UNIT_TYPE, CO294_FREE_UNIT_ID, CO295_BONUS_AMOUNT, CO296_CURRENT_AMOUNT, CO297_FU_MEASURE_ID, CO298_OPER_TYPE, CO299_CUR_EXPIRE_TIME, CO300_FU_OWN_TYPE, CO301_FU_OWN_ID, CO302_FREE_UNIT_TYPE, CO303_FREE_UNIT_ID, CO304_BONUS_AMOUNT, CO305_CURRENT_AMOUNT, CO306_FU_MEASURE_ID, CO307_OPER_TYPE, CO308_CUR_EXPIRE_TIME, CO309_FU_OWN_TYPE, CO310_FU_OWN_ID, CO311_FREE_UNIT_TYPE, CO312_FREE_UNIT_ID, CO313_BONUS_AMOUNT, 
CO314_CURRENT_AMOUNT, CO315_FU_MEASURE_ID, CO316_OPER_TYPE, CO317_CURRENT_AMOUNT, CO318_FU_OWN_TYPE, CO319_FU_OWN_ID, CO320_FREE_UNIT_TYPE, CO321_FREE_UNIT_ID, CO322_BONUS_AMOUNT, CO323_CURRENT_AMOUNT, CO324_FU_MEASURE_ID, CO325_OPER_TYPE, CO326_CUR_EXPIRE_TIME, CO327_FU_OWN_TYPE, CO328_FU_OWN_ID, CO329_FREE_UNIT_TYPE, CO330_FREE_UNIT_ID, CO331_BONUS_AMOUNT, CO332_CURRENT_AMOUNT, CO333_FU_MEASURE_ID, CO334_OPER_TYPE, CO335_CUR_EXPIRE_TIME, CO336_FU_OWN_TYPE, CO337_FU_OWN_ID, CO338_FREE_UNIT_TYPE, CO339_FREE_UNIT_ID, CO340_BONUS_AMOUNT, CO341_CURRENT_AMOUNT, CO342_FU_MEASURE_ID, CO343_OPER_TYPE, CO344_CUR_EXPIRE_TIME, CO345_FU_OWN_TYPE, CO346_FU_OWN_ID, CO347_FREE_UNIT_TYPE, CO348_FREE_UNIT_ID, CO349_BONUS_AMOUNT, CO350_CURRENT_AMOUNT, CO351_FU_MEASURE_ID, CO352_OPER_TYPE, CO353_CUR_EXPIRE_TIME, CO354_FU_OWN_TYPE, CO355_FU_OWN_ID, CO356_FREE_UNIT_TYPE, CO357_FREE_UNIT_ID, CO358_BONUS_AMOUNT, CO359_CURRENT_AMOUNT, CO360_FU_MEASURE_ID, CO361_OPER_TYPE, CO362_CUR_EXPIRE_TIME, CO363_FU_OWN_TYPE, CO364_FU_OWN_ID, CO365_FREE_UNIT_TYPE, CO366_FREE_UNIT_ID, CO367_BONUS_AMOUNT, CO368_CURRENT_AMOUNT, CO369_FU_MEASURE_ID, CO370_OPER_TYPE, CO371_CUR_EXPIRE_TIME, CO372_CALLINGPARTYNUMBER, CO373_CALLINGPARTYIMSI, CO374_CHARGINGTYPE, CO375_CHARGINGUSAGETYPE, CO376_CHARGECODE, CO377_FREEINDICATOR, CO378_SPID, CO379_CPID, CO380_SERVICEID, CO381_CONTENTID, CO382_SERVICETYPE, CO383_CONTENTTYPE, CO384_SERVICECAPABILITY, CO385_PROVISIONTYPE, CO386_CATEGORYTYPE, CO387_PRODUCTCODE, CO388_TIMES, CO389_DURATION, CO390_INPUTOCTETS, CO391_OUTPUTOCTETS, CO392_TOTALOCTETS, CO393_SERVICEDELIVERYSTATUS, CO394_REMARK, CO395_BRANDID, CO396_MAINOFFERINGID, CO397_CHARGINGPARTYNUMBER, CO398_CALLINGNETWORKTYPE, CO399_CALLINGVPNTOPGROUPNUMBER, CO400_CALLINGVPNGROUPNUMBER, CO401_ONLINECHARGINGFLAG, CO402_STARTTIMEOFBILLCYCLE, CO403_LASTEFFECTOFFERING, CO404_REQUESTACTION, CO405_MAINBALANCEINFO, CO406_CHGBALANCEINFO, CO407_CHGFREEUNITINFO, CO408_USERSTATE, CO409_GROUPPAYFLAG, CO410_PAYTYPE, CO411_TRANSACTIONID, CO412_ADDITIONALINFO, 
CO413_CHARGEMODE, CO414_CDRPRODUCTID, CO415_CDRCHARGEMODE, CO416_CDRTIMES, CO417_CDRDURATION, CO418_CDRVOLUME, CO419_CDRCDRTYPE, CO420_CDRSERVICETYPE, CO421_CDRBEGINTIME, CO422_CDRENDTIME, CO423_CDRPKGSPID, CO424_CDRPKGSERVICEID, CO425_CDRPKGPRODUCTID, CO426_CDRSPNAME, CO427_CDRSERVICENAME, CO428_CHARGEPARTYINDICATOR, CO429_TAXINFO, CO430_SUBSCRIBER_KEY, CO431_PREPAID_BALANCE, CO432_POSTPAID_BALANCE, CO433_ACCOUNT_KEY, CO434_PAY_PAYTYPE, CO435_PAY_BILL_CYCLE_ID, CO436_PAY_DEBIT_AMOUNT, CO437_PAY_DEBIT_FROM_PREPAID, CO438_PAY_PREPAID_BALANCE, CO439_PAY_ACCOUNT_KEY, CO440_PAY_DEBIT_FROM_POSTPAID, CO441_PAY_POSTPAID_BALANCE, CO442_PAY_DEFAULT_ACCT_ID, CO443_OWNER_CUST_CODE, CO444_PAY_CUST_ID, CO445_PAY_CUST_CODE, CO446_VOLUME, CO447_ACCTBALCHGLIST, CO448_ACCUMULATIONCHANGE, CO449_DCCSERVICETYPE, CO450_DST, CO451_SRC, CO452_CHARGINGHOMECOUNTRYCODE, CO453_CHARGINGHOMEAREANUMBER, CO454_CHARGINGHOMENETWORKCODE, CO455_PAY_FREE_UNIT_TIMES, CO456_PAY_FREE_UNIT_DURATION)
(SELECT TO_DATE(TO_CHAR(sysdate, 'MM/DD/YYYY'), 'MM/DD/YYYY'), FILE_NAME,CO1_CDR_ID, CO2_CDR_SUB_ID, CO3_CDR_TYPE, CO4_SPLIT_CDR_REASON, CO5_CDR_BATCH_ID, CO6_SRC_REC_LINE_NO, CO7_SRC_CDR_ID, CO8_SRC_CDR_NO, CO9_STATUS, CO10_RE_RATING_TIMES, CO11_CREATE_DATE, CO12_START_DATE, CO13_END_DATE, CO14_CUST_LOCAL_START_DATE, CO15_CUST_LOCAL_END_DATE, CO16_STD_EVT_TYPE_ID, CO17_EVT_SOURCE_CATEGORY, CO18_OBJ_TYPE, CO19_OBJ_ID, CO20_OWNER_CUST_ID, CO21_DEFAULT_ACCT_ID, CO22_PRI_IDENTITY, CO23_BILL_CYCLE_ID, CO24_SERVICE_CATEGORY, CO25_USAGE_SERVICE_TYPE, CO26_SESSION_ID, CO27_RESULT_CODE, CO28_RESULT_REASON, CO29_BE_ID, CO30_HOT_SEQ, CO31_CP_ID, CO32_RECIPIENT_NUMBER, CO33_USAGE_MEASURE_ID, CO34_ACTUAL_USAGE, CO35_RATE_USAGE, CO36_SERVICE_UNIT_TYPE, CO37_USAGE_MEASURE_ID2, CO38_ACTUAL_USAGE2, CO39_RATE_USAGE2, CO40_SERVICE_UNIT_TYPE2, CO41_DEBIT_AMOUNT, CO42_RESERVED, CO43_DEBIT_FROM_PREPAID, CO44_DEBIT_FROM_ADVANCE_PRE, CO45_DEBIT_FROM_POSTPAID, CO46_DEBIT_FROM_ADVANCE_POST, CO47_DEBIT_FROM_CREDIT_POST, CO48_TOTAL_TAX, CO49_FREE_UNIT_AMOUNT_OF_TIMES, CO50_FREE_UNIT_AMT_OF_DURATION, CO51_FREE_UNIT_AMOUNT_OF_FLUX, CO52_ACCT_ID, CO53_ACCT_BALANCE_ID, CO54_BALANCE_TYPE, CO55_CUR_BALANCE, CO56_CHG_BALANCE, CO57_CURRENCY_ID, CO58_OPER_TYPE, CO59_ACCT_ID, CO60_ACCT_BALANCE_ID, CO61_BALANCE_TYPE, CO62_CUR_BALANCE, CO63_CHG_BALANCE, CO64_CURRENCY_ID, CO65_OPER_TYPE, CO66_ACCT_ID, CO67_ACCT_BALANCE_ID, CO68_BALANCE_TYPE, CO69_CUR_BALANCE, CO70_CHG_BALANCE, CO71_CURRENCY_ID, CO72_OPER_TYPE, CO73_ACCT_ID, CO74_ACCT_BALANCE_ID, CO75_BALANCE_TYPE, CO76_CUR_BALANCE, CO77_CHG_BALANCE, CO78_CURRENCY_ID, CO79_OPER_TYPE, CO80_ACCT_ID, CO81_ACCT_BALANCE_ID, CO82_BALANCE_TYPE, CO83_CUR_BALANCE, CO84_CHG_BALANCE, CO85_CURRENCY_ID, CO86_OPER_TYPE, CO87_ACCT_ID, CO88_ACCT_BALANCE_ID, CO89_BALANCE_TYPE, CO90_CUR_BALANCE, CO91_CHG_BALANCE, CO92_CURRENCY_ID, CO93_OPER_TYPE, CO94_ACCT_ID, CO95_ACCT_BALANCE_ID, CO96_BALANCE_TYPE, CO97_CUR_BALANCE, CO98_CHG_BALANCE, CO99_CURRENCY_ID, CO100_OPER_TYPE, CO101_ACCT_ID, CO102_ACCT_BALANCE_ID, CO103_BALANCE_TYPE, 
CO104_CUR_BALANCE, CO105_CHG_BALANCE, CO106_CURRENCY_ID, CO107_OPER_TYPE, CO108_ACCT_ID, CO109_ACCT_BALANCE_ID, CO110_BALANCE_TYPE, CO111_CUR_BALANCE, CO112_CHG_BALANCE, CO113_CURRENCY_ID, CO114_OPER_TYPE, CO115_ACCT_ID, CO116_ACCT_BALANCE_ID, CO117_BALANCE_TYPE, CO118_CUR_BALANCE, CO119_CHG_BALANCE, CO120_CURRENCY_ID, CO121_OPER_TYPE, CO122_FU_OWN_TYPE, CO123_FU_OWN_ID, CO124_FREE_UNIT_ID, CO125_FREE_UNIT_TYPE, CO126_CUR_AMOUNT, CO127_CHG_AMOUNT, CO128_FU_MEASURE_ID, CO129_OPER_TYPE, CO130_FU_OWN_TYPE, CO131_FU_OWN_ID, CO132_FREE_UNIT_ID, CO133_FREE_UNIT_TYPE, CO134_CUR_AMOUNT, CO135_CHG_AMOUNT, CO136_FU_MEASURE_ID, CO137_OPER_TYPE, CO138_FU_OWN_TYPE, CO139_FU_OWN_ID, CO140_FREE_UNIT_ID, CO141_FREE_UNIT_TYPE, CO142_CUR_AMOUNT, CO143_CHG_AMOUNT, CO144_FU_MEASURE_ID, CO145_OPER_TYPE, CO146_FU_OWN_TYPE, CO147_FU_OWN_ID, CO148_FREE_UNIT_ID, CO149_FREE_UNIT_TYPE, CO150_CUR_AMOUNT, CO151_CHG_AMOUNT, CO152_FU_MEASURE_ID, CO153_OPER_TYPE, CO154_FU_OWN_TYPE, CO155_FU_OWN_ID, CO156_FREE_UNIT_ID, CO157_FREE_UNIT_TYPE, CO158_CUR_AMOUNT, CO159_CHG_AMOUNT, CO160_FU_MEASURE_ID, CO161_OPER_TYPE, CO162_FU_OWN_TYPE, CO163_FU_OWN_ID, CO164_FREE_UNIT_ID, CO165_FREE_UNIT_TYPE, CO166_CUR_AMOUNT, CO167_CHG_AMOUNT, CO168_FU_MEASURE_ID, CO169_OPER_TYPE, CO170_FU_OWN_TYPE, CO171_FU_OWN_ID, CO172_FREE_UNIT_ID, CO173_FREE_UNIT_TYPE, CO174_CUR_AMOUNT, CO175_CHG_AMOUNT, CO176_FU_MEASURE_ID, CO177_OPER_TYPE, CO178_FU_OWN_TYPE, CO179_FU_OWN_ID, CO180_FREE_UNIT_ID, CO181_FREE_UNIT_TYPE, CO182_CUR_AMOUNT, CO183_CHG_AMOUNT, CO184_FU_MEASURE_ID, CO185_OPER_TYPE, CO186_FU_OWN_TYPE, CO187_FU_OWN_ID, CO188_FREE_UNIT_ID, CO189_FREE_UNIT_TYPE, CO190_CUR_AMOUNT, CO191_CHG_AMOUNT, CO192_FU_MEASURE_ID, CO193_OPER_TYPE, CO194_FU_OWN_TYPE, CO195_FU_OWN_ID, CO196_FREE_UNIT_ID, CO197_FREE_UNIT_TYPE, CO198_CUR_AMOUNT, CO199_CHG_AMOUNT, CO200_FU_MEASURE_ID, CO201_OPER_TYPE, CO202_ACCT_ID, CO203_ACCT_BALANCE_ID, CO204_BALANCE_TYPE, CO205_BONUS_AMOUNT, CO206_CUR_BALANCE, CO207_CURRENCY_ID, CO208_OPER_TYPE, CO209_CUR_EXPIRE_TIME, CO210_ACCT_ID, 
CO211_ACCT_BALANCE_ID, CO212_BALANCE_TYPE, CO213_CUR_BALANCE, CO214_CHG_BALANCE, CO215_CURRENCY_ID, CO216_OPER_TYPE, CO217_CUR_EXPIRE_TIME, CO218_ACCT_ID, CO219_ACCT_BALANCE_ID, CO220_BALANCE_TYPE, CO221_CUR_BALANCE, CO222_CHG_BALANCE, CO223_CURRENCY_ID, CO224_OPER_TYPE, CO225_CUR_EXPIRE_TIME, CO226_ACCT_ID, CO227_ACCT_BALANCE_ID, CO228_BALANCE_TYPE, CO229_BONUS_AMOUNT, CO230_CUR_BALANCE, CO231_CURRENCY_ID, CO232_OPER_TYPE, CO233_CUR_EXPIRE_TIME, CO234_ACCT_ID, CO235_ACCT_BALANCE_ID, CO236_BALANCE_TYPE, CO237_BONUS_AMOUNT, CO238_CUR_BALANCE, CO239_CURRENCY_ID, CO240_OPER_TYPE, CO241_CUR_EXPIRE_TIME, CO242_ACCT_ID, CO243_ACCT_BALANCE_ID, CO244_BALANCE_TYPE, CO245_BONUS_AMOUNT, CO246_CUR_BALANCE, CO247_CURRENCY_ID, CO248_OPER_TYPE, CO249_CUR_EXPIRE_TIME, CO250_ACCT_ID, CO251_ACCT_BALANCE_ID, CO252_BALANCE_TYPE, CO253_BONUS_AMOUNT, CO254_CUR_BALANCE, CO255_CURRENCY_ID, CO256_OPER_TYPE, CO257_CUR_EXPIRE_TIME, CO258_ACCT_ID, CO259_ACCT_BALANCE_ID, CO260_BALANCE_TYPE, CO261_BONUS_AMOUNT, CO262_CUR_BALANCE, CO263_CURRENCY_ID, CO264_OPER_TYPE, CO265_CUR_EXPIRE_TIME, CO266_ACCT_ID, CO267_ACCT_BALANCE_ID, CO268_BALANCE_TYPE, CO269_BONUS_AMOUNT, CO270_CUR_BALANCE, CO271_CURRENCY_ID, CO272_OPER_TYPE, CO273_CUR_EXPIRE_TIME, CO274_ACCT_ID, CO275_ACCT_BALANCE_ID, CO276_BALANCE_TYPE, CO277_BONUS_AMOUNT, CO278_CUR_BALANCE, CO279_CURRENCY_ID, CO280_OPER_TYPE, CO281_CUR_EXPIRE_TIME, CO282_FU_OWN_TYPE, CO283_FU_OWN_ID, CO284_FREE_UNIT_TYPE, CO285_FREE_UNIT_ID, CO286_BONUS_AMOUNT, CO287_CURRENT_AMOUNT, CO288_FU_MEASURE_ID, CO289_OPER_TYPE, CO290_CUR_EXPIRE_TIME, CO291_FU_OWN_TYPE, CO292_FU_OWN_ID, CO293_FREE_UNIT_TYPE, CO294_FREE_UNIT_ID, CO295_BONUS_AMOUNT, CO296_CURRENT_AMOUNT, CO297_FU_MEASURE_ID, CO298_OPER_TYPE, CO299_CUR_EXPIRE_TIME, CO300_FU_OWN_TYPE, CO301_FU_OWN_ID, CO302_FREE_UNIT_TYPE, CO303_FREE_UNIT_ID, CO304_BONUS_AMOUNT, CO305_CURRENT_AMOUNT, CO306_FU_MEASURE_ID, CO307_OPER_TYPE, CO308_CUR_EXPIRE_TIME, CO309_FU_OWN_TYPE, CO310_FU_OWN_ID, CO311_FREE_UNIT_TYPE, CO312_FREE_UNIT_ID, CO313_BONUS_AMOUNT, 
CO314_CURRENT_AMOUNT, CO315_FU_MEASURE_ID, CO316_OPER_TYPE, CO317_CURRENT_AMOUNT, CO318_FU_OWN_TYPE, CO319_FU_OWN_ID, CO320_FREE_UNIT_TYPE, CO321_FREE_UNIT_ID, CO322_BONUS_AMOUNT, CO323_CURRENT_AMOUNT, CO324_FU_MEASURE_ID, CO325_OPER_TYPE, CO326_CUR_EXPIRE_TIME, CO327_FU_OWN_TYPE, CO328_FU_OWN_ID, CO329_FREE_UNIT_TYPE, CO330_FREE_UNIT_ID, CO331_BONUS_AMOUNT, CO332_CURRENT_AMOUNT, CO333_FU_MEASURE_ID, CO334_OPER_TYPE, CO335_CUR_EXPIRE_TIME, CO336_FU_OWN_TYPE, CO337_FU_OWN_ID, CO338_FREE_UNIT_TYPE, CO339_FREE_UNIT_ID, CO340_BONUS_AMOUNT, CO341_CURRENT_AMOUNT, CO342_FU_MEASURE_ID, CO343_OPER_TYPE, CO344_CUR_EXPIRE_TIME, CO345_FU_OWN_TYPE, CO346_FU_OWN_ID, CO347_FREE_UNIT_TYPE, CO348_FREE_UNIT_ID, CO349_BONUS_AMOUNT, CO350_CURRENT_AMOUNT, CO351_FU_MEASURE_ID, CO352_OPER_TYPE, CO353_CUR_EXPIRE_TIME, CO354_FU_OWN_TYPE, CO355_FU_OWN_ID, CO356_FREE_UNIT_TYPE, CO357_FREE_UNIT_ID, CO358_BONUS_AMOUNT, CO359_CURRENT_AMOUNT, CO360_FU_MEASURE_ID, CO361_OPER_TYPE, CO362_CUR_EXPIRE_TIME, CO363_FU_OWN_TYPE, CO364_FU_OWN_ID, CO365_FREE_UNIT_TYPE, CO366_FREE_UNIT_ID, CO367_BONUS_AMOUNT, CO368_CURRENT_AMOUNT, CO369_FU_MEASURE_ID, CO370_OPER_TYPE, CO371_CUR_EXPIRE_TIME, CO372_CALLINGPARTYNUMBER, CO373_CALLINGPARTYIMSI, CO374_CHARGINGTYPE, CO375_CHARGINGUSAGETYPE, CO376_CHARGECODE, CO377_FREEINDICATOR, CO378_SPID, CO379_CPID, CO380_SERVICEID, CO381_CONTENTID, CO382_SERVICETYPE, CO383_CONTENTTYPE, CO384_SERVICECAPABILITY, CO385_PROVISIONTYPE, CO386_CATEGORYTYPE, CO387_PRODUCTCODE, CO388_TIMES, CO389_DURATION, CO390_INPUTOCTETS, CO391_OUTPUTOCTETS, CO392_TOTALOCTETS, CO393_SERVICEDELIVERYSTATUS, CO394_REMARK, CO395_BRANDID, CO396_MAINOFFERINGID, CO397_CHARGINGPARTYNUMBER, CO398_CALLINGNETWORKTYPE, CO399_CALLINGVPNTOPGROUPNUMBER, CO400_CALLINGVPNGROUPNUMBER, CO401_ONLINECHARGINGFLAG, CO402_STARTTIMEOFBILLCYCLE, CO403_LASTEFFECTOFFERING, CO404_REQUESTACTION, CO405_MAINBALANCEINFO, CO406_CHGBALANCEINFO, CO407_CHGFREEUNITINFO, CO408_USERSTATE, CO409_GROUPPAYFLAG, CO410_PAYTYPE, CO411_TRANSACTIONID, CO412_ADDITIONALINFO, 
CO413_CHARGEMODE, CO414_CDRPRODUCTID, CO415_CDRCHARGEMODE, CO416_CDRTIMES, CO417_CDRDURATION, CO418_CDRVOLUME, CO419_CDRCDRTYPE, CO420_CDRSERVICETYPE, CO421_CDRBEGINTIME, CO422_CDRENDTIME, CO423_CDRPKGSPID, CO424_CDRPKGSERVICEID, CO425_CDRPKGPRODUCTID, CO426_CDRSPNAME, CO427_CDRSERVICENAME, CO428_CHARGEPARTYINDICATOR, CO429_TAXINFO, CO430_SUBSCRIBER_KEY, CO431_PREPAID_BALANCE, CO432_POSTPAID_BALANCE, CO433_ACCOUNT_KEY, CO434_PAY_PAYTYPE, CO435_PAY_BILL_CYCLE_ID, CO436_PAY_DEBIT_AMOUNT, CO437_PAY_DEBIT_FROM_PREPAID, CO438_PAY_PREPAID_BALANCE, CO439_PAY_ACCOUNT_KEY, CO440_PAY_DEBIT_FROM_POSTPAID, CO441_PAY_POSTPAID_BALANCE, CO442_PAY_DEFAULT_ACCT_ID, CO443_OWNER_CUST_CODE, CO444_PAY_CUST_ID, CO445_PAY_CUST_CODE, CO446_VOLUME, CO447_ACCTBALCHGLIST, CO448_ACCUMULATIONCHANGE, CO449_DCCSERVICETYPE, CO450_DST, CO451_SRC, CO452_CHARGINGHOMECOUNTRYCODE, CO453_CHARGINGHOMEAREANUMBER, CO454_CHARGINGHOMENETWORKCODE, CO455_PAY_FREE_UNIT_TIMES, CO456_PAY_FREE_UNIT_DURATION FROM COM01_EXT)


/
COMMIT
/
UPDATE cdr_head_merge
   SET process_status=96
 WHERE source='com'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_com_temp_loader_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/process/bin/loading_l1/temp_etl/
sh esms_create_cbs01_ext_com.sh $v3 
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi
