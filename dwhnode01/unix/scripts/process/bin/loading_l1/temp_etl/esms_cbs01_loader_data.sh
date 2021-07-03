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
sqlplus -s   <<EOF
dwh_user/dwh_user_123
SET head off
SET feedback off
SET pagesize 0
SET verify off
SET linesize 400
SELECT '/data02/cbs_cdrs/data/dump_dir/'||','||'/data02/cbs_cdrs/data/dump_dir/'||file_name||','||file_name||','||file_id
  FROM cdr_head_merge
 WHERE source='data'
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
 WHERE source='data'
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
INSERT INTO L1_DATA_TEMP (PROCESSED_DATE,FILE_NAME,G1_CDR_ID, G2_CDR_SUB_ID, G3_CDR_TYPE, G4_SPLIT_CDR_REASON, G5_CDR_BATCH_ID, G6_SRC_REC_LINE_NO, G7_SRC_CDR_ID, G8_SRC_CDR_NO, G9_STATUS, G10_RE_RATING_TIMES, G11_CREATE_DATE, G12_START_DATE, G13_END_DATE, G14_CUST_LOCAL_START_DATE, G15_CUST_LOCAL_END_DATE, G16_STD_EVT_TYPE_ID, G17_EVT_SOURCE_CATEGORY, G18_OBJ_TYPE, G19_OBJ_ID, G20_OWNER_CUST_ID, G21_DEFAULT_ACCT_ID, G22_PRI_IDENTITY, G23_BILL_CYCLE_ID, G24_SERVICE_CATEGORY, G25_USAGE_SERVICE_TYPE, G26_SESSION_ID, G27_RESULT_CODE, G28_RESULT_REASON, G29_BE_ID, G30_HOT_SEQ, G31_CP_ID, G32_RECIPIENT_NUMBER, G33_USAGE_MEASURE_ID, G34_ACTUAL_USAGE, G35_RATE_USAGE, G36_SERVICE_UNIT_TYPE, G37_USAGE_MEASURE_ID2, G38_ACTUAL_USAGE2, G39_RATE_USAGE2, G40_SERVICE_UNIT_TYPE2, G41_DEBIT_AMOUNT, G42_RESERVED, G43_DEBIT_FROM_PREPAID, G44_DEBIT_FROM_ADVANCE_PREPAID, G45_DEBIT_FROM_POSTPAID, G46_DEBIT_FROM_ADVNCE_POSTPAID, G47_DEBIT_FROM_CREDIT_POSTPAID, G48_TOTAL_TAX, G49_FREE_UNIT_AMOUNT_OF_TIMES, G50_FREE_UNIT_AMT_OF_DURATION,
G51_FREE_UNIT_AMOUNT_OF_FLUX, G52_ACCT_ID, G53_ACCT_BALANCE_ID, G54_BALANCE_TYPE, G55_CUR_BALANCE, G56_CHG_BALANCE, G57_CURRENCY_ID, G58_OPER_TYPE, G59_ACCT_ID, G60_ACCT_BALANCE_ID, G61_BALANCE_TYPE, G62_CUR_BALANCE, G63_CHG_BALANCE, G64_CURRENCY_ID, G65_OPER_TYPE, G66_ACCT_ID, G67_ACCT_BALANCE_ID, G68_BALANCE_TYPE, G69_CUR_BALANCE, G70_CHG_BALANCE, G71_CURRENCY_ID, G72_OPER_TYPE, G73_ACCT_ID, G74_ACCT_BALANCE_ID, G75_BALANCE_TYPE, G76_CUR_BALANCE, G77_CHG_BALANCE, G78_CURRENCY_ID, G79_OPER_TYPE, G80_ACCT_ID, G81_ACCT_BALANCE_ID, G82_BALANCE_TYPE, G83_CUR_BALANCE, G84_CHG_BALANCE, G85_CURRENCY_ID, G86_OPER_TYPE, G87_ACCT_ID, G88_ACCT_BALANCE_ID, G89_BALANCE_TYPE, G90_CUR_BALANCE, G91_CHG_BALANCE, G92_CURRENCY_ID, G93_OPER_TYPE, G94_ACCT_ID, G95_ACCT_BALANCE_ID, G96_BALANCE_TYPE, G97_CUR_BALANCE, G98_CHG_BALANCE, G99_CURRENCY_ID, G100_OPER_TYPE,
G101_ACCT_ID, G102_ACCT_BALANCE_ID, G103_BALANCE_TYPE, G104_CUR_BALANCE, G105_CHG_BALANCE, G106_CURRENCY_ID, G107_OPER_TYPE, G108_ACCT_ID, G109_ACCT_BALANCE_ID, G110_BALANCE_TYPE, G111_CUR_BALANCE, G112_CHG_BALANCE, G113_CURRENCY_ID, G114_OPER_TYPE, G115_ACCT_ID, G116_ACCT_BALANCE_ID, G117_BALANCE_TYPE, G118_CUR_BALANCE, G119_CHG_BALANCE, G120_CURRENCY_ID, G121_OPER_TYPE, G122_FU_OWN_TYPE, G123_FU_OWN_ID, G124_FREE_UNIT_ID, G125_FREE_UNIT_TYPE, G126_CUR_AMOUNT, G127_CHG_AMOUNT, G128_FU_MEASURE_ID, G129_OPER_TYPE, G130_FU_OWN_TYPE, G131_FU_OWN_ID, G132_FREE_UNIT_ID, G133_FREE_UNIT_TYPE, G134_CUR_AMOUNT, G135_CHG_AMOUNT, G136_FU_MEASURE_ID, G137_OPER_TYPE, G138_FU_OWN_TYPE, G139_FU_OWN_ID, G140_FREE_UNIT_ID, G141_FREE_UNIT_TYPE, G142_CUR_AMOUNT, G143_CHG_AMOUNT, G144_FU_MEASURE_ID, G145_OPER_TYPE, G146_FU_OWN_TYPE, G147_FU_OWN_ID, G148_FREE_UNIT_ID, G149_FREE_UNIT_TYPE, G150_CUR_AMOUNT,
G151_CHG_AMOUNT, G152_FU_MEASURE_ID, G153_OPER_TYPE, G154_FU_OWN_TYPE, G155_FU_OWN_ID, G156_FREE_UNIT_ID, G157_FREE_UNIT_TYPE, G158_CUR_AMOUNT, G159_CHG_AMOUNT, G160_FU_MEASURE_ID, G161_OPER_TYPE, G162_FU_OWN_TYPE, G163_FU_OWN_ID, G164_FREE_UNIT_ID, G165_FREE_UNIT_TYPE, G166_CUR_AMOUNT, G167_CHG_AMOUNT, G168_FU_MEASURE_ID, G169_OPER_TYPE, G170_FU_OWN_TYPE, G171_FU_OWN_ID, G172_FREE_UNIT_ID, G173_FREE_UNIT_TYPE, G174_CUR_AMOUNT, G175_CHG_AMOUNT, G176_FU_MEASURE_ID, G177_OPER_TYPE, G178_FU_OWN_TYPE, G179_FU_OWN_ID, G180_FREE_UNIT_ID, G181_FREE_UNIT_TYPE, G182_CUR_AMOUNT, G183_CHG_AMOUNT, G184_FU_MEASURE_ID, G185_OPER_TYPE, G186_FU_OWN_TYPE, G187_FU_OWN_ID, G188_FREE_UNIT_ID, G189_FREE_UNIT_TYPE, G190_CUR_AMOUNT, G191_CHG_AMOUNT, G192_FU_MEASURE_ID, G193_OPER_TYPE, G194_FU_OWN_TYPE, G195_FU_OWN_ID, G196_FREE_UNIT_ID, G197_FREE_UNIT_TYPE, G198_CUR_AMOUNT, G199_CHG_AMOUNT, G200_FU_MEASURE_ID,
G201_OPER_TYPE, G202_ACCT_ID, G203_ACCT_BALANCE_ID, G204_BALANCE_TYPE, G205_BONUS_AMOUNT, G206_CUR_BALANCE, G207_CURRENCY_ID, G208_OPER_TYPE, G209_CUR_EXPIRE_TIME, G210_ACCT_ID, G211_ACCT_BALANCE_ID, G212_BALANCE_TYPE, G213_CUR_BALANCE, G214_CHG_BALANCE, G215_CURRENCY_ID, G216_OPER_TYPE, G217_CUR_EXPIRE_TIME, G218_ACCT_ID, G219_ACCT_BALANCE_ID, G220_BALANCE_TYPE, G221_CUR_BALANCE, G222_CHG_BALANCE, G223_CURRENCY_ID, G224_OPER_TYPE, G225_CUR_EXPIRE_TIME, G226_ACCT_ID, G227_ACCT_BALANCE_ID, G228_BALANCE_TYPE, G229_BONUS_AMOUNT, G230_CUR_BALANCE, G231_CURRENCY_ID, G232_OPER_TYPE, G233_CUR_EXPIRE_TIME, G234_ACCT_ID, G235_ACCT_BALANCE_ID, G236_BALANCE_TYPE, G237_BONUS_AMOUNT, G238_CUR_BALANCE, G239_CURRENCY_ID, G240_OPER_TYPE, G241_CUR_EXPIRE_TIME, G242_ACCT_ID, G243_ACCT_BALANCE_ID, G244_BALANCE_TYPE, G245_BONUS_AMOUNT, G246_CUR_BALANCE, G247_CURRENCY_ID, G248_OPER_TYPE, G249_CUR_EXPIRE_TIME, G250_ACCT_ID,
G251_ACCT_BALANCE_ID, G252_BALANCE_TYPE, G253_BONUS_AMOUNT, G254_CUR_BALANCE, G255_CURRENCY_ID, G256_OPER_TYPE, G257_CUR_EXPIRE_TIME, G258_ACCT_ID, G259_ACCT_BALANCE_ID, G260_BALANCE_TYPE, G261_BONUS_AMOUNT, G262_CUR_BALANCE, G263_CURRENCY_ID, G264_OPER_TYPE, G265_CUR_EXPIRE_TIME, G266_ACCT_ID, G267_ACCT_BALANCE_ID, G268_BALANCE_TYPE, G269_BONUS_AMOUNT, G270_CUR_BALANCE, G271_CURRENCY_ID, G272_OPER_TYPE, G273_CUR_EXPIRE_TIME, G274_ACCT_ID, G275_ACCT_BALANCE_ID, G276_BALANCE_TYPE, G277_BONUS_AMOUNT, G278_CUR_BALANCE, G279_CURRENCY_ID, G280_OPER_TYPE, G281_CUR_EXPIRE_TIME, G282_FU_OWN_TYPE, G283_FU_OWN_ID, G284_FREE_UNIT_TYPE, G285_FREE_UNIT_ID, G286_BONUS_AMOUNT, G287_CURRENT_AMOUNT, G288_FU_MEASURE_ID, G289_OPER_TYPE, G290_CUR_EXPIRE_TIME, G291_FU_OWN_TYPE, G292_FU_OWN_ID, G293_FREE_UNIT_TYPE, G294_FREE_UNIT_ID, G295_BONUS_AMOUNT, G296_CURRENT_AMOUNT, G297_FU_MEASURE_ID, G298_OPER_TYPE, G299_CUR_EXPIRE_TIME, G300_FU_OWN_TYPE,
G301_FU_OWN_ID, G302_FREE_UNIT_TYPE, G303_FREE_UNIT_ID, G304_BONUS_AMOUNT, G305_CURRENT_AMOUNT, G306_FU_MEASURE_ID, G307_OPER_TYPE, G308_CUR_EXPIRE_TIME, G309_FU_OWN_TYPE, G310_FU_OWN_ID, G311_FREE_UNIT_TYPE, G312_FREE_UNIT_ID, G313_BONUS_AMOUNT, G314_CURRENT_AMOUNT, G315_FU_MEASURE_ID, G316_OPER_TYPE, G317_CURRENT_AMOUNT, G318_FU_OWN_TYPE, G319_FU_OWN_ID, G320_FREE_UNIT_TYPE, G321_FREE_UNIT_ID, G322_BONUS_AMOUNT, G323_CURRENT_AMOUNT, G324_FU_MEASURE_ID, G325_OPER_TYPE, G326_CUR_EXPIRE_TIME, G327_FU_OWN_TYPE, G328_FU_OWN_ID, G329_FREE_UNIT_TYPE, G330_FREE_UNIT_ID, G331_BONUS_AMOUNT, G332_CURRENT_AMOUNT, G333_FU_MEASURE_ID, G334_OPER_TYPE, G335_CUR_EXPIRE_TIME, G336_FU_OWN_TYPE, G337_FU_OWN_ID, G338_FREE_UNIT_TYPE, G339_FREE_UNIT_ID, G340_BONUS_AMOUNT, G341_CURRENT_AMOUNT, G342_FU_MEASURE_ID, G343_OPER_TYPE, G344_CUR_EXPIRE_TIME, G345_FU_OWN_TYPE, G346_FU_OWN_ID, G347_FREE_UNIT_TYPE, G348_FREE_UNIT_ID, G349_BONUS_AMOUNT, G350_CURRENT_AMOUNT,
G351_FU_MEASURE_ID, G352_OPER_TYPE, G353_CUR_EXPIRE_TIME, G354_FU_OWN_TYPE, G355_FU_OWN_ID, G356_FREE_UNIT_TYPE, G357_FREE_UNIT_ID, G358_BONUS_AMOUNT, G359_CURRENT_AMOUNT, G360_FU_MEASURE_ID, G361_OPER_TYPE, G362_CUR_EXPIRE_TIME, G363_FU_OWN_TYPE, G364_FU_OWN_ID, G365_FREE_UNIT_TYPE, G366_FREE_UNIT_ID, G367_BONUS_AMOUNT, G368_CURRENT_AMOUNT, G369_FU_MEASURE_ID, G370_OPER_TYPE, G371_CUR_EXPIRE_TIME, G372_CALLINGPARTYNUMBER, G373_APN, G374_URL, G375_CALLINGPARTYIMSI, G376_ACCESSNETWORKADDRESS, G377_GGSNADDRESS, G378_CALLINGROAMINFO, G379_CALLINGCELLID, G380_TIMESTAMPOFSGSN, G381_TIMEZONEOFSGSN, G382_BEARERCAPABILITY, G383_CHARGINGTIME, G384_TOTALFLUX, G385_UPFLUX, G386_DOWNFLUX, G387_ELAPSEDURATION, G388_IMEI, G389_SERVICEID, G390_SPID, G391_CATEGORYID, G392_CONTENTID, G393_QOS, G394_BEARERPROTOCOLTYPE, G395_STARTTIME, G396_STOPTIME, G397_CHARGINGID, G398_TRANSITIONID, G399_SERVICELEVEL, G400_BRANDID,
G401_MAINOFFERINGID, G402_CHARGINGPARTYNUMBER, G403_PAYTYPE, G404_CHARGINGTYPE, G405_ROAMSTATE, G406_CALLINGHOMECOUNTRYCODE, G407_CALLINGHOMEAREANUMBER, G408_CALLINGHOMENETWORKCODE, G409_CALLINGROAMCOUNTRYCODE, G410_CALLINGROAMAREANUMBER, G411_CALLINGROAMNETWORKCODE, G412_SERVICETYPE, G413_CALLINGNETWORKTYPE, G414_CALLINGVPNTOPGROUPNUMBER, G415_CALLINGVPNGROUPNUMBER, G416_ONLINECHARGINGFLAG, G417_STARTTIMEOFBILLCYCLE, G418_LASTEFFECTOFFERING, G419_DTDISCOUNT, G420_RATINGGROUP, G421_HOMEZONEID, G422_SPECIALZONEID, G423_DATAZONEID, G424_MAINBALANCEINFO, G425_CHGBALANCEINFO, G426_CHGFREEUNITINFO, G427_USERSTATE, G428_GROUPPAYFLAG, G429_RATTYPE, G430_CHARGEPARTYINDICATOR, G431_ROAMINGZONEID, G432_PRIMARYOFFERCHGAMT, G433_RESERVED, G434_LOSTAMOUT1MSG1FU, G435_TAXINFO, G436_VISTLOCALSTARTTIME, G437_VISTLOCALENDTIME, G438_SUBSCRIBER_KEY, G439_ACCOUNT_KEY, G440_PREPAID_BALANCE, G441_POSTPAID_BALANCE, G442_TADIGCODE, G443_PAY_PRI_IDENTITY, G444_PAY_PAYTYPE, G445_PAY_BILL_CYCLE_ID, G446_PAY_FREE_UNIT_FLUX, G447_PAY_FREE_UNIT_DURATION, G448_PAY_DEBIT_AMOUNT, G449_PAY_DEBIT_FROM_PREPAID, G450_PAY_PREPAID_BALANCE,
G451_PAY_ACCOUNT_KEY, G452_PAY_DEBIT_FROM_POSTPAID, G453_PAY_POSTPAID_BALANCE, G454_PAY_DEFAULT_ACCT_ID, G455_SUBSCRIBERIDTYPE, G456_DISCOUNTOFLASTEFFOFFERING, G457_PAY_SUBSCRIBER_KEY, G458_UNROUND, G459_OWNER_CUST_CODE, G460_PAY_CUST_ID, G461_PAY_CUST_CODE, G462_TAPFILENAME, G463_ACCDIVIDESEQUENCE, G464_TIMEDIVIDESEQUENCE, G465_ACCUMULATIONCHANGE, G466_ACCTBALCHGLIST, G467_ACCUMLATEDPOINT, G468_PDPADDRESS)
(SELECT TO_DATE(TO_CHAR(sysdate, 'MM/DD/YYYY'), 'MM/DD/YYYY'),FILE_NAME,G1_CDR_ID, G2_CDR_SUB_ID, G3_CDR_TYPE, G4_SPLIT_CDR_REASON, G5_CDR_BATCH_ID, G6_SRC_REC_LINE_NO, G7_SRC_CDR_ID, G8_SRC_CDR_NO, G9_STATUS, G10_RE_RATING_TIMES, G11_CREATE_DATE, G12_START_DATE, G13_END_DATE, G14_CUST_LOCAL_START_DATE, G15_CUST_LOCAL_END_DATE, G16_STD_EVT_TYPE_ID, G17_EVT_SOURCE_CATEGORY, G18_OBJ_TYPE, G19_OBJ_ID, G20_OWNER_CUST_ID, G21_DEFAULT_ACCT_ID, G22_PRI_IDENTITY, G23_BILL_CYCLE_ID, G24_SERVICE_CATEGORY, G25_USAGE_SERVICE_TYPE, G26_SESSION_ID, G27_RESULT_CODE, G28_RESULT_REASON, G29_BE_ID, G30_HOT_SEQ, G31_CP_ID, G32_RECIPIENT_NUMBER, G33_USAGE_MEASURE_ID, G34_ACTUAL_USAGE, G35_RATE_USAGE, G36_SERVICE_UNIT_TYPE, G37_USAGE_MEASURE_ID2, G38_ACTUAL_USAGE2, G39_RATE_USAGE2, G40_SERVICE_UNIT_TYPE2, G41_DEBIT_AMOUNT, G42_RESERVED, G43_DEBIT_FROM_PREPAID, G44_DEBIT_FROM_ADVANCE_PREPAID, G45_DEBIT_FROM_POSTPAID, G46_DEBIT_FROM_ADVNCE_POSTPAID, G47_DEBIT_FROM_CREDIT_POSTPAID, G48_TOTAL_TAX, G49_FREE_UNIT_AMOUNT_OF_TIMES, G50_FREE_UNIT_AMT_OF_DURATION,
G51_FREE_UNIT_AMOUNT_OF_FLUX, G52_ACCT_ID, G53_ACCT_BALANCE_ID, G54_BALANCE_TYPE, G55_CUR_BALANCE, G56_CHG_BALANCE, G57_CURRENCY_ID, G58_OPER_TYPE, G59_ACCT_ID, G60_ACCT_BALANCE_ID, G61_BALANCE_TYPE, G62_CUR_BALANCE, G63_CHG_BALANCE, G64_CURRENCY_ID, G65_OPER_TYPE, G66_ACCT_ID, G67_ACCT_BALANCE_ID, G68_BALANCE_TYPE, G69_CUR_BALANCE, G70_CHG_BALANCE, G71_CURRENCY_ID, G72_OPER_TYPE, G73_ACCT_ID, G74_ACCT_BALANCE_ID, G75_BALANCE_TYPE, G76_CUR_BALANCE, G77_CHG_BALANCE, G78_CURRENCY_ID, G79_OPER_TYPE, G80_ACCT_ID, G81_ACCT_BALANCE_ID, G82_BALANCE_TYPE, G83_CUR_BALANCE, G84_CHG_BALANCE, G85_CURRENCY_ID, G86_OPER_TYPE, G87_ACCT_ID, G88_ACCT_BALANCE_ID, G89_BALANCE_TYPE, G90_CUR_BALANCE, G91_CHG_BALANCE, G92_CURRENCY_ID, G93_OPER_TYPE, G94_ACCT_ID, G95_ACCT_BALANCE_ID, G96_BALANCE_TYPE, G97_CUR_BALANCE, G98_CHG_BALANCE, G99_CURRENCY_ID, G100_OPER_TYPE,
G101_ACCT_ID, G102_ACCT_BALANCE_ID, G103_BALANCE_TYPE, G104_CUR_BALANCE, G105_CHG_BALANCE, G106_CURRENCY_ID, G107_OPER_TYPE, G108_ACCT_ID, G109_ACCT_BALANCE_ID, G110_BALANCE_TYPE, G111_CUR_BALANCE, G112_CHG_BALANCE, G113_CURRENCY_ID, G114_OPER_TYPE, G115_ACCT_ID, G116_ACCT_BALANCE_ID, G117_BALANCE_TYPE, G118_CUR_BALANCE, G119_CHG_BALANCE, G120_CURRENCY_ID, G121_OPER_TYPE, G122_FU_OWN_TYPE, G123_FU_OWN_ID, G124_FREE_UNIT_ID, G125_FREE_UNIT_TYPE, G126_CUR_AMOUNT, G127_CHG_AMOUNT, G128_FU_MEASURE_ID, G129_OPER_TYPE, G130_FU_OWN_TYPE, G131_FU_OWN_ID, G132_FREE_UNIT_ID, G133_FREE_UNIT_TYPE, G134_CUR_AMOUNT, G135_CHG_AMOUNT, G136_FU_MEASURE_ID, G137_OPER_TYPE, G138_FU_OWN_TYPE, G139_FU_OWN_ID, G140_FREE_UNIT_ID, G141_FREE_UNIT_TYPE, G142_CUR_AMOUNT, G143_CHG_AMOUNT, G144_FU_MEASURE_ID, G145_OPER_TYPE, G146_FU_OWN_TYPE, G147_FU_OWN_ID, G148_FREE_UNIT_ID, G149_FREE_UNIT_TYPE, G150_CUR_AMOUNT,
G151_CHG_AMOUNT, G152_FU_MEASURE_ID, G153_OPER_TYPE, G154_FU_OWN_TYPE, G155_FU_OWN_ID, G156_FREE_UNIT_ID, G157_FREE_UNIT_TYPE, G158_CUR_AMOUNT, G159_CHG_AMOUNT, G160_FU_MEASURE_ID, G161_OPER_TYPE, G162_FU_OWN_TYPE, G163_FU_OWN_ID, G164_FREE_UNIT_ID, G165_FREE_UNIT_TYPE, G166_CUR_AMOUNT, G167_CHG_AMOUNT, G168_FU_MEASURE_ID, G169_OPER_TYPE, G170_FU_OWN_TYPE, G171_FU_OWN_ID, G172_FREE_UNIT_ID, G173_FREE_UNIT_TYPE, G174_CUR_AMOUNT, G175_CHG_AMOUNT, G176_FU_MEASURE_ID, G177_OPER_TYPE, G178_FU_OWN_TYPE, G179_FU_OWN_ID, G180_FREE_UNIT_ID, G181_FREE_UNIT_TYPE, G182_CUR_AMOUNT, G183_CHG_AMOUNT, G184_FU_MEASURE_ID, G185_OPER_TYPE, G186_FU_OWN_TYPE, G187_FU_OWN_ID, G188_FREE_UNIT_ID, G189_FREE_UNIT_TYPE, G190_CUR_AMOUNT, G191_CHG_AMOUNT, G192_FU_MEASURE_ID, G193_OPER_TYPE, G194_FU_OWN_TYPE, G195_FU_OWN_ID, G196_FREE_UNIT_ID, G197_FREE_UNIT_TYPE, G198_CUR_AMOUNT, G199_CHG_AMOUNT, G200_FU_MEASURE_ID,
G201_OPER_TYPE, G202_ACCT_ID, G203_ACCT_BALANCE_ID, G204_BALANCE_TYPE, G205_BONUS_AMOUNT, G206_CUR_BALANCE, G207_CURRENCY_ID, G208_OPER_TYPE, G209_CUR_EXPIRE_TIME, G210_ACCT_ID, G211_ACCT_BALANCE_ID, G212_BALANCE_TYPE, G213_CUR_BALANCE, G214_CHG_BALANCE, G215_CURRENCY_ID, G216_OPER_TYPE, G217_CUR_EXPIRE_TIME, G218_ACCT_ID, G219_ACCT_BALANCE_ID, G220_BALANCE_TYPE, G221_CUR_BALANCE, G222_CHG_BALANCE, G223_CURRENCY_ID, G224_OPER_TYPE, G225_CUR_EXPIRE_TIME, G226_ACCT_ID, G227_ACCT_BALANCE_ID, G228_BALANCE_TYPE, G229_BONUS_AMOUNT, G230_CUR_BALANCE, G231_CURRENCY_ID, G232_OPER_TYPE, G233_CUR_EXPIRE_TIME, G234_ACCT_ID, G235_ACCT_BALANCE_ID, G236_BALANCE_TYPE, G237_BONUS_AMOUNT, G238_CUR_BALANCE, G239_CURRENCY_ID, G240_OPER_TYPE, G241_CUR_EXPIRE_TIME, G242_ACCT_ID, G243_ACCT_BALANCE_ID, G244_BALANCE_TYPE, G245_BONUS_AMOUNT, G246_CUR_BALANCE, G247_CURRENCY_ID, G248_OPER_TYPE, G249_CUR_EXPIRE_TIME, G250_ACCT_ID,
G251_ACCT_BALANCE_ID, G252_BALANCE_TYPE, G253_BONUS_AMOUNT, G254_CUR_BALANCE, G255_CURRENCY_ID, G256_OPER_TYPE, G257_CUR_EXPIRE_TIME, G258_ACCT_ID, G259_ACCT_BALANCE_ID, G260_BALANCE_TYPE, G261_BONUS_AMOUNT, G262_CUR_BALANCE, G263_CURRENCY_ID, G264_OPER_TYPE, G265_CUR_EXPIRE_TIME, G266_ACCT_ID, G267_ACCT_BALANCE_ID, G268_BALANCE_TYPE, G269_BONUS_AMOUNT, G270_CUR_BALANCE, G271_CURRENCY_ID, G272_OPER_TYPE, G273_CUR_EXPIRE_TIME, G274_ACCT_ID, G275_ACCT_BALANCE_ID, G276_BALANCE_TYPE, G277_BONUS_AMOUNT, G278_CUR_BALANCE, G279_CURRENCY_ID, G280_OPER_TYPE, G281_CUR_EXPIRE_TIME, G282_FU_OWN_TYPE, G283_FU_OWN_ID, G284_FREE_UNIT_TYPE, G285_FREE_UNIT_ID, G286_BONUS_AMOUNT, G287_CURRENT_AMOUNT, G288_FU_MEASURE_ID, G289_OPER_TYPE, G290_CUR_EXPIRE_TIME, G291_FU_OWN_TYPE, G292_FU_OWN_ID, G293_FREE_UNIT_TYPE, G294_FREE_UNIT_ID, G295_BONUS_AMOUNT, G296_CURRENT_AMOUNT, G297_FU_MEASURE_ID, G298_OPER_TYPE, G299_CUR_EXPIRE_TIME, G300_FU_OWN_TYPE,
G301_FU_OWN_ID, G302_FREE_UNIT_TYPE, G303_FREE_UNIT_ID, G304_BONUS_AMOUNT, G305_CURRENT_AMOUNT, G306_FU_MEASURE_ID, G307_OPER_TYPE, G308_CUR_EXPIRE_TIME, G309_FU_OWN_TYPE, G310_FU_OWN_ID, G311_FREE_UNIT_TYPE, G312_FREE_UNIT_ID, G313_BONUS_AMOUNT, G314_CURRENT_AMOUNT, G315_FU_MEASURE_ID, G316_OPER_TYPE, G317_CURRENT_AMOUNT, G318_FU_OWN_TYPE, G319_FU_OWN_ID, G320_FREE_UNIT_TYPE, G321_FREE_UNIT_ID, G322_BONUS_AMOUNT, G323_CURRENT_AMOUNT, G324_FU_MEASURE_ID, G325_OPER_TYPE, G326_CUR_EXPIRE_TIME, G327_FU_OWN_TYPE, G328_FU_OWN_ID, G329_FREE_UNIT_TYPE, G330_FREE_UNIT_ID, G331_BONUS_AMOUNT, G332_CURRENT_AMOUNT, G333_FU_MEASURE_ID, G334_OPER_TYPE, G335_CUR_EXPIRE_TIME, G336_FU_OWN_TYPE, G337_FU_OWN_ID, G338_FREE_UNIT_TYPE, G339_FREE_UNIT_ID, G340_BONUS_AMOUNT, G341_CURRENT_AMOUNT, G342_FU_MEASURE_ID, G343_OPER_TYPE, G344_CUR_EXPIRE_TIME, G345_FU_OWN_TYPE, G346_FU_OWN_ID, G347_FREE_UNIT_TYPE, G348_FREE_UNIT_ID, G349_BONUS_AMOUNT, G350_CURRENT_AMOUNT,
G351_FU_MEASURE_ID, G352_OPER_TYPE, G353_CUR_EXPIRE_TIME, G354_FU_OWN_TYPE, G355_FU_OWN_ID, G356_FREE_UNIT_TYPE, G357_FREE_UNIT_ID, G358_BONUS_AMOUNT, G359_CURRENT_AMOUNT, G360_FU_MEASURE_ID, G361_OPER_TYPE, G362_CUR_EXPIRE_TIME, G363_FU_OWN_TYPE, G364_FU_OWN_ID, G365_FREE_UNIT_TYPE, G366_FREE_UNIT_ID, G367_BONUS_AMOUNT, G368_CURRENT_AMOUNT, G369_FU_MEASURE_ID, G370_OPER_TYPE, G371_CUR_EXPIRE_TIME, G372_CALLINGPARTYNUMBER, G373_APN, G374_URL, G375_CALLINGPARTYIMSI, G376_ACCESSNETWORKADDRESS, G377_GGSNADDRESS, G378_CALLINGROAMINFO, G379_CALLINGCELLID, G380_TIMESTAMPOFSGSN, G381_TIMEZONEOFSGSN, G382_BEARERCAPABILITY, G383_CHARGINGTIME, G384_TOTALFLUX, G385_UPFLUX, G386_DOWNFLUX, G387_ELAPSEDURATION, G388_IMEI, G389_SERVICEID, G390_SPID, G391_CATEGORYID, G392_CONTENTID, G393_QOS, G394_BEARERPROTOCOLTYPE, G395_STARTTIME, G396_STOPTIME, G397_CHARGINGID, G398_TRANSITIONID, G399_SERVICELEVEL, G400_BRANDID,
G401_MAINOFFERINGID, G402_CHARGINGPARTYNUMBER, G403_PAYTYPE, G404_CHARGINGTYPE, G405_ROAMSTATE, G406_CALLINGHOMECOUNTRYCODE, G407_CALLINGHOMEAREANUMBER, G408_CALLINGHOMENETWORKCODE, G409_CALLINGROAMCOUNTRYCODE, G410_CALLINGROAMAREANUMBER, G411_CALLINGROAMNETWORKCODE, G412_SERVICETYPE, G413_CALLINGNETWORKTYPE, G414_CALLINGVPNTOPGROUPNUMBER, G415_CALLINGVPNGROUPNUMBER, G416_ONLINECHARGINGFLAG, G417_STARTTIMEOFBILLCYCLE, G418_LASTEFFECTOFFERING, G419_DTDISCOUNT, G420_RATINGGROUP, G421_HOMEZONEID, G422_SPECIALZONEID, G423_DATAZONEID, G424_MAINBALANCEINFO, G425_CHGBALANCEINFO, G426_CHGFREEUNITINFO, G427_USERSTATE, G428_GROUPPAYFLAG, G429_RATTYPE, G430_CHARGEPARTYINDICATOR, G431_ROAMINGZONEID, G432_PRIMARYOFFERCHGAMT, G433_RESERVED, G434_LOSTAMOUT1MSG1FU, G435_TAXINFO, G436_VISTLOCALSTARTTIME, G437_VISTLOCALENDTIME, G438_SUBSCRIBER_KEY, G439_ACCOUNT_KEY, G440_PREPAID_BALANCE, G441_POSTPAID_BALANCE, G442_TADIGCODE, G443_PAY_PRI_IDENTITY, G444_PAY_PAYTYPE, G445_PAY_BILL_CYCLE_ID, G446_PAY_FREE_UNIT_FLUX, G447_PAY_FREE_UNIT_DURATION, G448_PAY_DEBIT_AMOUNT, G449_PAY_DEBIT_FROM_PREPAID, G450_PAY_PREPAID_BALANCE,
G451_PAY_ACCOUNT_KEY, G452_PAY_DEBIT_FROM_POSTPAID, G453_PAY_POSTPAID_BALANCE, G454_PAY_DEFAULT_ACCT_ID, G455_SUBSCRIBERIDTYPE, G456_DISCOUNTOFLASTEFFOFFERING, G457_PAY_SUBSCRIBER_KEY, G458_UNROUND, G459_OWNER_CUST_CODE, G460_PAY_CUST_ID, G461_PAY_CUST_CODE, G462_TAPFILENAME, G463_ACCDIVIDESEQUENCE, G464_TIMEDIVIDESEQUENCE, G465_ACCUMULATIONCHANGE, G466_ACCTBALCHGLIST, G467_ACCUMLATEDPOINT, G468_PDPADDRESS  FROM CBS01_EXT )


/
COMMIT
/
UPDATE cdr_head_merge
   SET process_status=96
 WHERE source='data'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/l1_data_temp_loader_lock  export lock

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
sh esms_create_cbs01_ext_data.sh $v3 
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

