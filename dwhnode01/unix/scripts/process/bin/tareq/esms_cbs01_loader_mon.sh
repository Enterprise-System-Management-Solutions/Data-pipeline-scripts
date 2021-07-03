#AUTHOR: TAREQ
## PURPOSE: DATA LOAD RECURRING01_EXT L1_RECURRING
##DATE: 05-01-2020

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
SELECT '/data02/cbs_cdrs/mon/process_dir/'||','||'/data02/cbs_cdrs/mon/process_dir/'||file_name||','||file_name||','||file_id
  FROM cdr_head
 WHERE source='mon' and trunc(PROCESS_DATE) = TRUNC(SYSDATE)
   AND process_status=30
--   and mod  (FILE_ID,3) = 1
   and rownum < 5
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
 WHERE source='mon'
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
INSERT INTO L1_RECURRING(PROCESSED_DATE, FILE_NAME, RE1_RECHARGE_LOG_ID, RE2_RECHARGE_CODE, RE3_RECHARGE_AMT, RE4_ACCT_ID, RE5_SUB_ID, RE6_PRI_IDENTITY, 
RE7_THIRD_PARTY_NUMBER, RE8_CURRENCY_ID, RE9_ORIGINAL_AMT, RE10_CURRENCY_RATE, RE11_CONVERSION_AMT, RE12_RECHARGE_TRANS_ID, 
RE13_EXT_TRANS_TYPE, RE14_EXT_TRANS_ID, RE15_ACCESS_METHOD, RE16_BATCH_NO, RE17_OFFERING_ID, RE18_PAYMENT_TYPE, RE19_RECHARGE_TAX, 
RE20_RECHARGE_PENALTY, RE21_RECHARGE_TYPE, RE22_CHANNEL_ID, RE23_RECHARGE_REASON, RE24_RESULT_CODE, RE25_ERROR_TYPE, RE26_VALID_DAY_ADDED, 
RE27_DIAMETER_SESSIONID, RE28_OPER_ID, RE29_DEPT_ID, RE30_ENTRY_DATE, RE31_RECON_DATE, RE32_RECON_STATUS, RE33_REVERSAL_TRANS_ID, 
RE34_REVERSAL_REASON_CODE, RE35_REVERSAL_OPER_ID, RE36_REVERSAL_DEPT_ID, RE37_REVERSAL_DATE, RE38_STATUS, RE39_REMARK, RE40_BE_ID, 
RE41_BE_CODE, RE42_REGION_ID, RE43_REGION_CODE, RE44_CARD_SEQUENCE, RE45_CARD_PIN_NUMBER, RE46_CARD_BATCH_NO, RE47_CARD_STATUS, 
RE48_CARD_COS_ID, RE49_CARD_SP_ID, RE50_CARD_AMOUNT, RE51_CARD_VALIDITY, RE52_VOUCHER_ENCRYPT_NUMBER, RE53_CHECK_NO, RE54_CHECK_DATE, 
RE55_CREDIT_CARD_NO, RE56_CREDIT_CARD_NAME, RE57_CREDIT_CARD_TYPE_ID, RE58_CC_EXPIRY_DATE, RE59_CC_AUTHORIZATION_CODE, RE60_BANK_CODE, 
RE61_BANK_BRANCH_CODE, RE62_ACCT_NO, RE63_BANK_ACCT_NAME, RE64_LOAN_AMOUNT, RE65_LOAN_POUNDATE, RE66_ACCT_ID, RE67_ACCT_BALANCE_ID, 
RE68_BALANCE_TYPE, RE69_CUR_BALANCE, RE70_CHG_BALANCE, RE71_PRE_APPLY_TIME, RE72_PRE_EXPIRE_TIME, RE73_CUR_EXPIRE_TIME, RE74_CURRENCYE_ID, 
RE75_OPER_TYPE, RE76_ACCT_ID, RE77_ACCT_BALANCE_ID, RE78_BALANCE_TYPE, RE79_CUR_BALANCE, RE80_CHG_BALANCE, RE81_PRE_APPLY_TIME, 
RE82_PRE_EXPIRE_TIME, RE83_CUR_EXPIRE_TIME, RE84_CURRENCYE_ID, RE85_OPER_TYPE, RE86_ACCT_ID, RE87_ACCT_BALANCE_ID, RE88_BALANCE_TYPE, 
RE89_CUR_BALANCE, RE90_CHG_BALANCE, RE91_PRE_APPLY_TIME, RE92_PRE_EXPIRE_TIME, RE93_CUR_EXPIRE_TIME, RE94_CURRENCYE_ID, RE95_OPER_TYPE, 
RE96_ACCT_ID, RE97_ACCT_BALANCE_ID, RE98_BALANCE_TYPE, RE99_CUR_BALANCE, RE100_CHG_BALANCE, RE101_PRE_APPLY_TIME, RE102_PRE_EXPIRE_TIME, 
RE103_CUR_EXPIRE_TIME, RE104_CURRENCYE_ID, RE105_OPER_TYPE, RE106_ACCT_ID, RE107_ACCT_BALANCE_ID, RE108_BALANCE_TYPE, RE109_CUR_BALANCE, 
RE110_CHG_BALANCE, RE111_PRE_APPLY_TIME, RE112_PRE_EXPIRE_TIME, RE113_CUR_EXPIRE_TIME, RE114_CURRENCYE_ID, RE115_OPER_TYPE, RE116_ACCT_ID, 
RE117_ACCT_BALANCE_ID, RE118_BALANCE_TYPE, RE119_CUR_BALANCE, RE120_CHG_BALANCE, RE121_PRE_APPLY_TIME, RE122_PRE_EXPIRE_TIME, 
RE123_CUR_EXPIRE_TIME, RE124_CURRENCYE_ID, RE125_OPER_TYPE, RE126_ACCT_ID, RE127_ACCT_BALANCE_ID, RE128_BALANCE_TYPE, RE129_CUR_BALANCE, 
RE130_CHG_BALANCE, RE131_PRE_APPLY_TIME, RE132_PRE_EXPIRE_TIME, RE133_CUR_EXPIRE_TIME, RE134_CURRENCYE_ID, RE135_OPER_TYPE, RE136_ACCT_ID, 
RE137_ACCT_BALANCE_ID, RE138_BALANCE_TYPE, RE139_CUR_BALANCE, RE140_CHG_BALANCE, RE141_PRE_APPLY_TIME, RE142_PRE_EXPIRE_TIME, 
RE143_CUR_EXPIRE_TIME, RE144_CURRENCYE_ID, RE145_OPER_TYPE, RE146_ACCT_ID, RE147_ACCT_BALANCE_ID, RE148_BALANCE_TYPE, RE149_CUR_BALANCE, 
RE150_CHG_BALANCE, RE151_PRE_APPLY_TIME, RE152_PRE_EXPIRE_TIME, RE153_CUR_EXPIRE_TIME, RE154_CURRENCYE_ID, RE155_OPER_TYPE, RE156_ACCT_ID, 
RE157_ACCT_BALANCE_ID, RE158_BALANCE_TYPE, RE159_CUR_BALANCE, RE160_CHG_BALANCE, RE161_PRE_APPLY_TIME, RE162_PRE_EXPIRE_TIME, 
RE163_CUR_EXPIRE_TIME, RE164_CURRENCYE_ID, RE165_OPER_TYPE, RE166_FU_OWN_TYPE, RE167_FU_OWN_ID, RE168_FREE_UNIT_ID, RE169_FREE_UNIT_TYPE, 
RE170_CUR_AMOUNT, RE171_CHG_AMOUNT, RE172_PRE_APPLY_TIME, RE173_PRE_EXPIRE_TIME, RE174_CUR_EXPIRE_TIME, RE175_FU_MEASURE_ID, RE176_OPER_TYPE, 
RE177_FU_OWN_TYPE, RE178_FU_OWN_ID, RE179_FREE_UNIT_ID, RE180_FREE_UNIT_TYPE, RE181_CUR_AMOUNT, RE182_CHG_AMOUNT, RE183_PRE_APPLY_TIME, 
RE184_PRE_EXPIRE_TIME, RE185_CUR_EXPIRE_TIME, RE186_FU_MEASURE_ID, RE187_OPER_TYPE, RE188_FU_OWN_TYPE, RE189_FU_OWN_ID, RE190_FREE_UNIT_ID, 
RE191_FREE_UNIT_TYPE, RE192_CUR_AMOUNT, RE193_CHG_AMOUNT, RE194_PRE_APPLY_TIME, RE195_PRE_EXPIRE_TIME, RE196_CUR_EXPIRE_TIME, 
RE197_FU_MEASURE_ID, RE198_OPER_TYPE, RE199_FU_OWN_TYPE, RE200_FU_OWN_ID, RE201_FREE_UNIT_ID, RE202_FREE_UNIT_TYPE, RE203_CUR_AMOUNT, 
RE204_CHG_AMOUNT, RE205_PRE_APPLY_TIME, RE206_PRE_EXPIRE_TIME, RE207_CUR_EXPIRE_TIME, RE208_FU_MEASURE_ID, RE209_OPER_TYPE, RE210_FU_OWN_TYPE, 
RE211_FU_OWN_ID, RE212_FREE_UNIT_ID, RE213_FREE_UNIT_TYPE, RE214_CUR_AMOUNT, RE215_CHG_AMOUNT, RE216_PRE_APPLY_TIME, RE217_PRE_EXPIRE_TIME, 
RE218_CUR_EXPIRE_TIME, RE219_FU_MEASURE_ID, RE220_OPER_TYPE, RE221_FU_OWN_TYPE, RE222_FU_OWN_ID, RE223_FREE_UNIT_ID, RE224_FREE_UNIT_TYPE, 
RE225_CUR_AMOUNT, RE226_CHG_AMOUNT, RE227_PRE_APPLY_TIME, RE228_PRE_EXPIRE_TIME, RE229_CUR_EXPIRE_TIME, RE230_FU_MEASURE_ID, RE231_OPER_TYPE, 
RE232_FU_OWN_TYPE, RE233_FU_OWN_ID, RE234_FREE_UNIT_ID, RE235_FREE_UNIT_TYPE, RE236_CUR_AMOUNT, RE237_CHG_AMOUNT, RE238_PRE_APPLY_TIME, 
RE239_PRE_EXPIRE_TIME, RE240_CUR_EXPIRE_TIME, RE241_FU_MEASURE_ID, RE242_OPER_TYPE, RE243_FU_OWN_TYPE, RE244_FU_OWN_ID, RE245_FREE_UNIT_ID, 
RE246_FREE_UNIT_TYPE, RE247_CUR_AMOUNT, RE248_CHG_AMOUNT, RE249_PRE_APPLY_TIME, RE250_PRE_EXPIRE_TIME, RE251_CUR_EXPIRE_TIME, 
RE252_FU_MEASURE_ID, RE253_OPER_TYPE, RE254_FU_OWN_TYPE, RE255_FU_OWN_ID, RE256_FREE_UNIT_ID, RE257_FREE_UNIT_TYPE, RE258_CUR_AMOUNT, 
RE259_CHG_AMOUNT, RE260_PRE_APPLY_TIME, RE261_PRE_EXPIRE_TIME, RE262_CUR_EXPIRE_TIME, RE263_FU_MEASURE_ID, RE264_OPER_TYPE, 
RE265_FU_OWN_TYPE, RE266_FU_OWN_ID, RE267_FREE_UNIT_ID, RE268_FREE_UNIT_TYPE, RE269_CUR_AMOUNT, RE270_CHG_AMOUNT, RE271_PRE_APPLY_TIME, 
RE272_PRE_EXPIRE_TIME, RE273_CUR_EXPIRE_TIME, RE274_FU_MEASURE_ID, RE275_OPER_TYPE, RE276_ACCT_ID, RE277_ACCT_BALANCE_ID, RE278_BALANCE_TYPE, 
RE279_BONUS_AMOUNT, RE280_CURRENT_BALANCE, RE281_PRE_APPLY_TIME, RE282_PRE_EXPIRE_TIME, RE283_CUR_EXPIRE_TIME, RE284_CURRENCY_ID, 
RE285_OPER_TYPE, RE286_ACCT_ID, RE287_ACCT_BALANCE_ID, RE288_BALANCE_TYPE, RE289_BONUS_AMOUNT, RE290_CURRENT_BALANCE, RE291_PRE_APPLY_TIME, 
RE292_PRE_EXPIRE_TIME, RE293_CUR_EXPIRE_TIME, RE294_CURRENCY_ID, RE295_OPER_TYPE, RE296_ACCT_ID, RE297_ACCT_BALANCE_ID, RE298_BALANCE_TYPE, 
RE299_BONUS_AMOUNT, RE300_CURRENT_BALANCE, RE301_PRE_APPLY_TIME, RE302_PRE_EXPIRE_TIME, RE303_CUR_EXPIRE_TIME, RE304_CURRENCY_ID, 
RE305_OPER_TYPE, RE306_ACCT_ID, RE307_ACCT_BALANCE_ID, RE308_BALANCE_TYPE, RE309_BONUS_AMOUNT, RE310_CURRENT_BALANCE, RE311_PRE_APPLY_TIME, 
RE312_PRE_EXPIRE_TIME, RE313_CUR_EXPIRE_TIME, RE314_CURRENCY_ID, RE315_OPER_TYPE, RE316_ACCT_ID, RE317_ACCT_BALANCE_ID, RE318_BALANCE_TYPE, 
RE319_BONUS_AMOUNT, RE320_CURRENT_BALANCE, RE321_PRE_APPLY_TIME, RE322_PRE_EXPIRE_TIME, RE323_CUR_EXPIRE_TIME, RE324_CURRENCY_ID, 
RE325_OPER_TYPE, RE326_ACCT_ID, RE327_ACCT_BALANCE_ID, RE328_BALANCE_TYPE, RE329_BONUS_AMOUNT, RE330_CURRENT_BALANCE, RE331_PRE_APPLY_TIME, 
RE332_PRE_EXPIRE_TIME, RE333_CUR_EXPIRE_TIME, RE334_CURRENCY_ID, RE335_OPER_TYPE, RE336_ACCT_ID, RE337_ACCT_BALANCE_ID, RE338_BALANCE_TYPE, 
RE339_BONUS_AMOUNT, RE340_CURRENT_BALANCE, RE341_PRE_APPLY_TIME, RE342_PRE_EXPIRE_TIME, RE343_CUR_EXPIRE_TIME, RE344_CURRENCY_ID, 
RE345_OPER_TYPE, RE346_ACCT_ID, RE347_ACCT_BALANCE_ID, RE348_BALANCE_TYPE, RE349_BONUS_AMOUNT, RE350_CURRENT_BALANCE, RE351_PRE_APPLY_TIME, 
RE352_PRE_EXPIRE_TIME, RE353_CUR_EXPIRE_TIME, RE354_CURRENCY_ID, RE355_OPER_TYPE, RE356_ACCT_ID, RE357_ACCT_BALANCE_ID, RE358_BALANCE_TYPE, 
RE359_BONUS_AMOUNT, RE360_CURRENT_BALANCE, RE361_PRE_APPLY_TIME, RE362_PRE_EXPIRE_TIME, RE363_CUR_EXPIRE_TIME, RE364_CURRENCY_ID, 
RE365_OPER_TYPE, RE366_ACCT_ID, RE367_ACCT_BALANCE_ID, RE368_BALANCE_TYPE, RE369_BONUS_AMOUNT, RE370_CURRENT_BALANCE, RE371_PRE_APPLY_TIME, 
RE372_PRE_EXPIRE_TIME, RE373_CUR_EXPIRE_TIME, RE374_CURRENCY_ID, RE375_OPER_TYPE, RE376_FU_OWN_TYPE, RE377_FU_OWN_ID, RE378_FREE_UNIT_TYPE, 
RE379_FREE_UNIT_ID, RE380_BONUS_AMOUNT, RE381_CURRENT_AMOUNT, RE382_PRE_APPLY_TIME, RE383_PRE_EXPIRE_TIME, RE384_CUR_EXPIRE_TIME, 
RE385_FU_MEASURE_ID, RE386_OPER_TYPE, RE387_FU_OWN_TYPE, RE388_FU_OWN_ID, RE389_FREE_UNIT_TYPE, RE390_FREE_UNIT_ID, RE391_BONUS_AMOUNT, 
RE392_CURRENT_AMOUNT, RE393_PRE_APPLY_TIME, RE394_PRE_EXPIRE_TIME, RE395_CUR_EXPIRE_TIME, RE396_FU_MEASURE_ID, RE397_OPER_TYPE, 
RE398_FU_OWN_TYPE, RE399_FU_OWN_ID, RE400_FREE_UNIT_TYPE, RE401_FREE_UNIT_ID, RE402_BONUS_AMOUNT, RE403_CURRENT_AMOUNT, RE404_PRE_APPLY_TIME, 
RE405_PRE_EXPIRE_TIME, RE406_CUR_EXPIRE_TIME, RE407_FU_MEASURE_ID, RE408_OPER_TYPE, RE409_FU_OWN_TYPE, RE410_FU_OWN_ID, RE411_FREE_UNIT_TYPE, 
RE412_FREE_UNIT_ID, RE413_BONUS_AMOUNT, RE414_CURRENT_AMOUNT, RE415_PRE_APPLY_TIME, RE416_PRE_EXPIRE_TIME, RE417_CUR_EXPIRE_TIME, 
RE418_FU_MEASURE_ID, RE419_OPER_TYPE, RE420_FU_OWN_TYPE, RE421_FU_OWN_ID, RE422_FREE_UNIT_TYPE, RE423_FREE_UNIT_ID, RE424_BONUS_AMOUNT, 
RE425_CURRENT_AMOUNT, RE426_PRE_APPLY_TIME, RE427_PRE_EXPIRE_TIME, RE428_CUR_EXPIRE_TIME, RE429_FU_MEASURE_ID, RE430_OPER_TYPE, 
RE431_FU_OWN_TYPE, RE432_FU_OWN_ID, RE433_FREE_UNIT_TYPE, RE434_FREE_UNIT_ID, RE435_BONUS_AMOUNT, RE436_CURRENT_AMOUNT, RE437_PRE_APPLY_TIME, 
RE438_PRE_EXPIRE_TIME, RE439_CUR_EXPIRE_TIME, RE440_FU_MEASURE_ID, RE441_OPER_TYPE, RE442_FU_OWN_TYPE, RE443_FU_OWN_ID, RE444_FREE_UNIT_TYPE, 
RE445_FREE_UNIT_ID, RE446_BONUS_AMOUNT, RE447_CURRENT_AMOUNT, RE448_PRE_APPLY_TIME, RE449_PRE_EXPIRE_TIME, RE450_CUR_EXPIRE_TIME, 
RE451_FU_MEASURE_ID, RE452_OPER_TYPE, RE453_FU_OWN_TYPE, RE454_FU_OWN_ID, RE455_FREE_UNIT_TYPE, RE456_FREE_UNIT_ID, RE457_BONUS_AMOUNT, 
RE458_CURRENT_AMOUNT, RE459_PRE_APPLY_TIME, RE460_PRE_EXPIRE_TIME, RE461_CUR_EXPIRE_TIME, RE462_FU_MEASURE_ID, RE463_OPER_TYPE, 
RE464_FU_OWN_TYPE, RE465_FU_OWN_ID, RE466_FREE_UNIT_TYPE, RE467_FREE_UNIT_ID, RE468_BONUS_AMOUNT, RE469_CURRENT_AMOUNT, RE470_PRE_APPLY_TIME, 
RE471_PRE_EXPIRE_TIME, RE472_CUR_EXPIRE_TIME, RE473_FU_MEASURE_ID, RE474_OPER_TYPE, RE475_FU_OWN_TYPE, RE476_FU_OWN_ID, RE477_FREE_UNIT_TYPE, 
RE478_FREE_UNIT_ID, RE479_BONUS_AMOUNT, RE480_CURRENT_AMOUNT, RE481_PRE_APPLY_TIME, RE482_PRE_EXPIRE_TIME, RE483_CUR_EXPIRE_TIME, 
RE484_FU_MEASURE_ID, RE485_OPER_TYPE, RE486_RECHARGEAREACODE, RE487_RECHARGECELLID, RE488_BRANDID, RE489_MAINOFFERINGID, RE490_PAYTYPE, 
RE491_STARTTIMEOFBILLCYCLE, RE492_ACCOUNT, RE493_MAINBALANCEINFO, RE494_CHGBALANCEINFO, RE495_CHGFREEUNITINFO, RE496_USERSTATE, 
RE497_OLDUSERSTATE, RE498_CARDVALUEADDED, RE499_VALIDITYADDED, RE500_TRADETYPE, RE501_AGENTNAME, RE502_ADDITIONALINFO, RE503_BANKCODE, 
RE504_SUBIDENTITYTYPE, RE505_LOGINSYSTEMCODE, RE506_LOAN_TRANS_ID, RE507_LOAN_GRADE, RE508_LOAN_ACCT_TYPE, RE509_LOAN_ACCT_BALANCE, 
RE510_ETU_GRACE_DATE, RE511_RECHARGEWAY, RE512_SUBSCRIBERID, RE513_SUBSCRIBERIDTYPE, RE514_COMMENT, RE515_CUSTOMERCODE1, 
RE516_OLD_S2_EXP_DATE, RE517_CUR_S2_EXP_DATE, RE518_OLD_S3_EXP_DATE, RE519_CUR_S3_EXP_DATE, RE520_OLD_S4_EXP_DATE, RE521_CUR_S4_EXP_DATE, 
RE522_CUSTOMER_KEY, RE523_SUBSCRIBER_KEY, RE524_ACCOUNT_KEY, RE525_DLYRECHGTIMESID, RE526_DLYRECHGTIMES, RE527_MTHLYRECHGTIMESID, 
RE528_MTHLYRECHGTIMES, RE529_PRIVATENUMBER, RE530_BILL_CYCLE_ID)
(SELECT TO_DATE(TO_CHAR(SYSDATE, 'MM/DD/YYYY'), 'MM/DD/YYYY'), '$1',
RE1_RECHARGE_LOG_ID, RE2_RECHARGE_CODE, RE3_RECHARGE_AMT, RE4_ACCT_ID, RE5_SUB_ID, RE6_PRI_IDENTITY, 
RE7_THIRD_PARTY_NUMBER, RE8_CURRENCY_ID, RE9_ORIGINAL_AMT, RE10_CURRENCY_RATE, RE11_CONVERSION_AMT, RE12_RECHARGE_TRANS_ID, 
RE13_EXT_TRANS_TYPE, RE14_EXT_TRANS_ID, RE15_ACCESS_METHOD, RE16_BATCH_NO, RE17_OFFERING_ID, RE18_PAYMENT_TYPE, RE19_RECHARGE_TAX, 
RE20_RECHARGE_PENALTY, RE21_RECHARGE_TYPE, RE22_CHANNEL_ID, RE23_RECHARGE_REASON, RE24_RESULT_CODE, RE25_ERROR_TYPE, RE26_VALID_DAY_ADDED, 
RE27_DIAMETER_SESSIONID, RE28_OPER_ID, RE29_DEPT_ID, RE30_ENTRY_DATE, RE31_RECON_DATE, RE32_RECON_STATUS, RE33_REVERSAL_TRANS_ID, 
RE34_REVERSAL_REASON_CODE, RE35_REVERSAL_OPER_ID, RE36_REVERSAL_DEPT_ID, RE37_REVERSAL_DATE, RE38_STATUS, RE39_REMARK, RE40_BE_ID, 
RE41_BE_CODE, RE42_REGION_ID, RE43_REGION_CODE, RE44_CARD_SEQUENCE, RE45_CARD_PIN_NUMBER, RE46_CARD_BATCH_NO, RE47_CARD_STATUS, 
RE48_CARD_COS_ID, RE49_CARD_SP_ID, RE50_CARD_AMOUNT, RE51_CARD_VALIDITY, RE52_VOUCHER_ENCRYPT_NUMBER, RE53_CHECK_NO, RE54_CHECK_DATE, 
RE55_CREDIT_CARD_NO, RE56_CREDIT_CARD_NAME, RE57_CREDIT_CARD_TYPE_ID, RE58_CC_EXPIRY_DATE, RE59_CC_AUTHORIZATION_CODE, RE60_BANK_CODE, 
RE61_BANK_BRANCH_CODE, RE62_ACCT_NO, RE63_BANK_ACCT_NAME, RE64_LOAN_AMOUNT, RE65_LOAN_POUNDATE, RE66_ACCT_ID, RE67_ACCT_BALANCE_ID, 
RE68_BALANCE_TYPE, RE69_CUR_BALANCE, RE70_CHG_BALANCE, RE71_PRE_APPLY_TIME, RE72_PRE_EXPIRE_TIME, RE73_CUR_EXPIRE_TIME, RE74_CURRENCYE_ID, 
RE75_OPER_TYPE, RE76_ACCT_ID, RE77_ACCT_BALANCE_ID, RE78_BALANCE_TYPE, RE79_CUR_BALANCE, RE80_CHG_BALANCE, RE81_PRE_APPLY_TIME, 
RE82_PRE_EXPIRE_TIME, RE83_CUR_EXPIRE_TIME, RE84_CURRENCYE_ID, RE85_OPER_TYPE, RE86_ACCT_ID, RE87_ACCT_BALANCE_ID, RE88_BALANCE_TYPE, 
RE89_CUR_BALANCE, RE90_CHG_BALANCE, RE91_PRE_APPLY_TIME, RE92_PRE_EXPIRE_TIME, RE93_CUR_EXPIRE_TIME, RE94_CURRENCYE_ID, RE95_OPER_TYPE, 
RE96_ACCT_ID, RE97_ACCT_BALANCE_ID, RE98_BALANCE_TYPE, RE99_CUR_BALANCE, RE100_CHG_BALANCE, RE101_PRE_APPLY_TIME, RE102_PRE_EXPIRE_TIME, 
RE103_CUR_EXPIRE_TIME, RE104_CURRENCYE_ID, RE105_OPER_TYPE, RE106_ACCT_ID, RE107_ACCT_BALANCE_ID, RE108_BALANCE_TYPE, RE109_CUR_BALANCE, 
RE110_CHG_BALANCE, RE111_PRE_APPLY_TIME, RE112_PRE_EXPIRE_TIME, RE113_CUR_EXPIRE_TIME, RE114_CURRENCYE_ID, RE115_OPER_TYPE, RE116_ACCT_ID, 
RE117_ACCT_BALANCE_ID, RE118_BALANCE_TYPE, RE119_CUR_BALANCE, RE120_CHG_BALANCE, RE121_PRE_APPLY_TIME, RE122_PRE_EXPIRE_TIME, 
RE123_CUR_EXPIRE_TIME, RE124_CURRENCYE_ID, RE125_OPER_TYPE, RE126_ACCT_ID, RE127_ACCT_BALANCE_ID, RE128_BALANCE_TYPE, RE129_CUR_BALANCE, 
RE130_CHG_BALANCE, RE131_PRE_APPLY_TIME, RE132_PRE_EXPIRE_TIME, RE133_CUR_EXPIRE_TIME, RE134_CURRENCYE_ID, RE135_OPER_TYPE, RE136_ACCT_ID, 
RE137_ACCT_BALANCE_ID, RE138_BALANCE_TYPE, RE139_CUR_BALANCE, RE140_CHG_BALANCE, RE141_PRE_APPLY_TIME, RE142_PRE_EXPIRE_TIME, 
RE143_CUR_EXPIRE_TIME, RE144_CURRENCYE_ID, RE145_OPER_TYPE, RE146_ACCT_ID, RE147_ACCT_BALANCE_ID, RE148_BALANCE_TYPE, RE149_CUR_BALANCE, 
RE150_CHG_BALANCE, RE151_PRE_APPLY_TIME, RE152_PRE_EXPIRE_TIME, RE153_CUR_EXPIRE_TIME, RE154_CURRENCYE_ID, RE155_OPER_TYPE, RE156_ACCT_ID, 
RE157_ACCT_BALANCE_ID, RE158_BALANCE_TYPE, RE159_CUR_BALANCE, RE160_CHG_BALANCE, RE161_PRE_APPLY_TIME, RE162_PRE_EXPIRE_TIME, 
RE163_CUR_EXPIRE_TIME, RE164_CURRENCYE_ID, RE165_OPER_TYPE, RE166_FU_OWN_TYPE, RE167_FU_OWN_ID, RE168_FREE_UNIT_ID, RE169_FREE_UNIT_TYPE, 
RE170_CUR_AMOUNT, RE171_CHG_AMOUNT, RE172_PRE_APPLY_TIME, RE173_PRE_EXPIRE_TIME, RE174_CUR_EXPIRE_TIME, RE175_FU_MEASURE_ID, RE176_OPER_TYPE, 
RE177_FU_OWN_TYPE, RE178_FU_OWN_ID, RE179_FREE_UNIT_ID, RE180_FREE_UNIT_TYPE, RE181_CUR_AMOUNT, RE182_CHG_AMOUNT, RE183_PRE_APPLY_TIME, 
RE184_PRE_EXPIRE_TIME, RE185_CUR_EXPIRE_TIME, RE186_FU_MEASURE_ID, RE187_OPER_TYPE, RE188_FU_OWN_TYPE, RE189_FU_OWN_ID, RE190_FREE_UNIT_ID, 
RE191_FREE_UNIT_TYPE, RE192_CUR_AMOUNT, RE193_CHG_AMOUNT, RE194_PRE_APPLY_TIME, RE195_PRE_EXPIRE_TIME, RE196_CUR_EXPIRE_TIME, 
RE197_FU_MEASURE_ID, RE198_OPER_TYPE, RE199_FU_OWN_TYPE, RE200_FU_OWN_ID, RE201_FREE_UNIT_ID, RE202_FREE_UNIT_TYPE, RE203_CUR_AMOUNT, 
RE204_CHG_AMOUNT, RE205_PRE_APPLY_TIME, RE206_PRE_EXPIRE_TIME, RE207_CUR_EXPIRE_TIME, RE208_FU_MEASURE_ID, RE209_OPER_TYPE, RE210_FU_OWN_TYPE, 
RE211_FU_OWN_ID, RE212_FREE_UNIT_ID, RE213_FREE_UNIT_TYPE, RE214_CUR_AMOUNT, RE215_CHG_AMOUNT, RE216_PRE_APPLY_TIME, RE217_PRE_EXPIRE_TIME, 
RE218_CUR_EXPIRE_TIME, RE219_FU_MEASURE_ID, RE220_OPER_TYPE, RE221_FU_OWN_TYPE, RE222_FU_OWN_ID, RE223_FREE_UNIT_ID, RE224_FREE_UNIT_TYPE, 
RE225_CUR_AMOUNT, RE226_CHG_AMOUNT, RE227_PRE_APPLY_TIME, RE228_PRE_EXPIRE_TIME, RE229_CUR_EXPIRE_TIME, RE230_FU_MEASURE_ID, RE231_OPER_TYPE, 
RE232_FU_OWN_TYPE, RE233_FU_OWN_ID, RE234_FREE_UNIT_ID, RE235_FREE_UNIT_TYPE, RE236_CUR_AMOUNT, RE237_CHG_AMOUNT, RE238_PRE_APPLY_TIME, 
RE239_PRE_EXPIRE_TIME, RE240_CUR_EXPIRE_TIME, RE241_FU_MEASURE_ID, RE242_OPER_TYPE, RE243_FU_OWN_TYPE, RE244_FU_OWN_ID, RE245_FREE_UNIT_ID, 
RE246_FREE_UNIT_TYPE, RE247_CUR_AMOUNT, RE248_CHG_AMOUNT, RE249_PRE_APPLY_TIME, RE250_PRE_EXPIRE_TIME, RE251_CUR_EXPIRE_TIME, 
RE252_FU_MEASURE_ID, RE253_OPER_TYPE, RE254_FU_OWN_TYPE, RE255_FU_OWN_ID, RE256_FREE_UNIT_ID, RE257_FREE_UNIT_TYPE, RE258_CUR_AMOUNT, 
RE259_CHG_AMOUNT, RE260_PRE_APPLY_TIME, RE261_PRE_EXPIRE_TIME, RE262_CUR_EXPIRE_TIME, RE263_FU_MEASURE_ID, RE264_OPER_TYPE, 
RE265_FU_OWN_TYPE, RE266_FU_OWN_ID, RE267_FREE_UNIT_ID, RE268_FREE_UNIT_TYPE, RE269_CUR_AMOUNT, RE270_CHG_AMOUNT, RE271_PRE_APPLY_TIME, 
RE272_PRE_EXPIRE_TIME, RE273_CUR_EXPIRE_TIME, RE274_FU_MEASURE_ID, RE275_OPER_TYPE, RE276_ACCT_ID, RE277_ACCT_BALANCE_ID, RE278_BALANCE_TYPE, 
RE279_BONUS_AMOUNT, RE280_CURRENT_BALANCE, RE281_PRE_APPLY_TIME, RE282_PRE_EXPIRE_TIME, RE283_CUR_EXPIRE_TIME, RE284_CURRENCY_ID, 
RE285_OPER_TYPE, RE286_ACCT_ID, RE287_ACCT_BALANCE_ID, RE288_BALANCE_TYPE, RE289_BONUS_AMOUNT, RE290_CURRENT_BALANCE, RE291_PRE_APPLY_TIME, 
RE292_PRE_EXPIRE_TIME, RE293_CUR_EXPIRE_TIME, RE294_CURRENCY_ID, RE295_OPER_TYPE, RE296_ACCT_ID, RE297_ACCT_BALANCE_ID, RE298_BALANCE_TYPE, 
RE299_BONUS_AMOUNT, RE300_CURRENT_BALANCE, RE301_PRE_APPLY_TIME, RE302_PRE_EXPIRE_TIME, RE303_CUR_EXPIRE_TIME, RE304_CURRENCY_ID, 
RE305_OPER_TYPE, RE306_ACCT_ID, RE307_ACCT_BALANCE_ID, RE308_BALANCE_TYPE, RE309_BONUS_AMOUNT, RE310_CURRENT_BALANCE, RE311_PRE_APPLY_TIME, 
RE312_PRE_EXPIRE_TIME, RE313_CUR_EXPIRE_TIME, RE314_CURRENCY_ID, RE315_OPER_TYPE, RE316_ACCT_ID, RE317_ACCT_BALANCE_ID, RE318_BALANCE_TYPE, 
RE319_BONUS_AMOUNT, RE320_CURRENT_BALANCE, RE321_PRE_APPLY_TIME, RE322_PRE_EXPIRE_TIME, RE323_CUR_EXPIRE_TIME, RE324_CURRENCY_ID, 
RE325_OPER_TYPE, RE326_ACCT_ID, RE327_ACCT_BALANCE_ID, RE328_BALANCE_TYPE, RE329_BONUS_AMOUNT, RE330_CURRENT_BALANCE, RE331_PRE_APPLY_TIME, 
RE332_PRE_EXPIRE_TIME, RE333_CUR_EXPIRE_TIME, RE334_CURRENCY_ID, RE335_OPER_TYPE, RE336_ACCT_ID, RE337_ACCT_BALANCE_ID, RE338_BALANCE_TYPE, 
RE339_BONUS_AMOUNT, RE340_CURRENT_BALANCE, RE341_PRE_APPLY_TIME, RE342_PRE_EXPIRE_TIME, RE343_CUR_EXPIRE_TIME, RE344_CURRENCY_ID, 
RE345_OPER_TYPE, RE346_ACCT_ID, RE347_ACCT_BALANCE_ID, RE348_BALANCE_TYPE, RE349_BONUS_AMOUNT, RE350_CURRENT_BALANCE, RE351_PRE_APPLY_TIME, 
RE352_PRE_EXPIRE_TIME, RE353_CUR_EXPIRE_TIME, RE354_CURRENCY_ID, RE355_OPER_TYPE, RE356_ACCT_ID, RE357_ACCT_BALANCE_ID, RE358_BALANCE_TYPE, 
RE359_BONUS_AMOUNT, RE360_CURRENT_BALANCE, RE361_PRE_APPLY_TIME, RE362_PRE_EXPIRE_TIME, RE363_CUR_EXPIRE_TIME, RE364_CURRENCY_ID, 
RE365_OPER_TYPE, RE366_ACCT_ID, RE367_ACCT_BALANCE_ID, RE368_BALANCE_TYPE, RE369_BONUS_AMOUNT, RE370_CURRENT_BALANCE, RE371_PRE_APPLY_TIME, 
RE372_PRE_EXPIRE_TIME, RE373_CUR_EXPIRE_TIME, RE374_CURRENCY_ID, RE375_OPER_TYPE, RE376_FU_OWN_TYPE, RE377_FU_OWN_ID, RE378_FREE_UNIT_TYPE, 
RE379_FREE_UNIT_ID, RE380_BONUS_AMOUNT, RE381_CURRENT_AMOUNT, RE382_PRE_APPLY_TIME, RE383_PRE_EXPIRE_TIME, RE384_CUR_EXPIRE_TIME, 
RE385_FU_MEASURE_ID, RE386_OPER_TYPE, RE387_FU_OWN_TYPE, RE388_FU_OWN_ID, RE389_FREE_UNIT_TYPE, RE390_FREE_UNIT_ID, RE391_BONUS_AMOUNT, 
RE392_CURRENT_AMOUNT, RE393_PRE_APPLY_TIME, RE394_PRE_EXPIRE_TIME, RE395_CUR_EXPIRE_TIME, RE396_FU_MEASURE_ID, RE397_OPER_TYPE, 
RE398_FU_OWN_TYPE, RE399_FU_OWN_ID, RE400_FREE_UNIT_TYPE, RE401_FREE_UNIT_ID, RE402_BONUS_AMOUNT, RE403_CURRENT_AMOUNT, RE404_PRE_APPLY_TIME, 
RE405_PRE_EXPIRE_TIME, RE406_CUR_EXPIRE_TIME, RE407_FU_MEASURE_ID, RE408_OPER_TYPE, RE409_FU_OWN_TYPE, RE410_FU_OWN_ID, RE411_FREE_UNIT_TYPE, 
RE412_FREE_UNIT_ID, RE413_BONUS_AMOUNT, RE414_CURRENT_AMOUNT, RE415_PRE_APPLY_TIME, RE416_PRE_EXPIRE_TIME, RE417_CUR_EXPIRE_TIME, 
RE418_FU_MEASURE_ID, RE419_OPER_TYPE, RE420_FU_OWN_TYPE, RE421_FU_OWN_ID, RE422_FREE_UNIT_TYPE, RE423_FREE_UNIT_ID, RE424_BONUS_AMOUNT, 
RE425_CURRENT_AMOUNT, RE426_PRE_APPLY_TIME, RE427_PRE_EXPIRE_TIME, RE428_CUR_EXPIRE_TIME, RE429_FU_MEASURE_ID, RE430_OPER_TYPE, 
RE431_FU_OWN_TYPE, RE432_FU_OWN_ID, RE433_FREE_UNIT_TYPE, RE434_FREE_UNIT_ID, RE435_BONUS_AMOUNT, RE436_CURRENT_AMOUNT, RE437_PRE_APPLY_TIME, 
RE438_PRE_EXPIRE_TIME, RE439_CUR_EXPIRE_TIME, RE440_FU_MEASURE_ID, RE441_OPER_TYPE, RE442_FU_OWN_TYPE, RE443_FU_OWN_ID, RE444_FREE_UNIT_TYPE, 
RE445_FREE_UNIT_ID, RE446_BONUS_AMOUNT, RE447_CURRENT_AMOUNT, RE448_PRE_APPLY_TIME, RE449_PRE_EXPIRE_TIME, RE450_CUR_EXPIRE_TIME, 
RE451_FU_MEASURE_ID, RE452_OPER_TYPE, RE453_FU_OWN_TYPE, RE454_FU_OWN_ID, RE455_FREE_UNIT_TYPE, RE456_FREE_UNIT_ID, RE457_BONUS_AMOUNT, 
RE458_CURRENT_AMOUNT, RE459_PRE_APPLY_TIME, RE460_PRE_EXPIRE_TIME, RE461_CUR_EXPIRE_TIME, RE462_FU_MEASURE_ID, RE463_OPER_TYPE, 
RE464_FU_OWN_TYPE, RE465_FU_OWN_ID, RE466_FREE_UNIT_TYPE, RE467_FREE_UNIT_ID, RE468_BONUS_AMOUNT, RE469_CURRENT_AMOUNT, RE470_PRE_APPLY_TIME, 
RE471_PRE_EXPIRE_TIME, RE472_CUR_EXPIRE_TIME, RE473_FU_MEASURE_ID, RE474_OPER_TYPE, RE475_FU_OWN_TYPE, RE476_FU_OWN_ID, RE477_FREE_UNIT_TYPE, 
RE478_FREE_UNIT_ID, RE479_BONUS_AMOUNT, RE480_CURRENT_AMOUNT, RE481_PRE_APPLY_TIME, RE482_PRE_EXPIRE_TIME, RE483_CUR_EXPIRE_TIME, 
RE484_FU_MEASURE_ID, RE485_OPER_TYPE, RE486_RECHARGEAREACODE, RE487_RECHARGECELLID, RE488_BRANDID, RE489_MAINOFFERINGID, RE490_PAYTYPE, 
RE491_STARTTIMEOFBILLCYCLE, RE492_ACCOUNT, RE493_MAINBALANCEINFO, RE494_CHGBALANCEINFO, RE495_CHGFREEUNITINFO, RE496_USERSTATE, 
RE497_OLDUSERSTATE, RE498_CARDVALUEADDED, RE499_VALIDITYADDED, RE500_TRADETYPE, RE501_AGENTNAME, RE502_ADDITIONALINFO, RE503_BANKCODE, 
RE504_SUBIDENTITYTYPE, RE505_LOGINSYSTEMCODE, RE506_LOAN_TRANS_ID, RE507_LOAN_GRADE, RE508_LOAN_ACCT_TYPE, RE509_LOAN_ACCT_BALANCE, 
RE510_ETU_GRACE_DATE, RE511_RECHARGEWAY, RE512_SUBSCRIBERID, RE513_SUBSCRIBERIDTYPE, RE514_COMMENT, RE515_CUSTOMERCODE1, 
RE516_OLD_S2_EXP_DATE, RE517_CUR_S2_EXP_DATE, RE518_OLD_S3_EXP_DATE, RE519_CUR_S3_EXP_DATE, RE520_OLD_S4_EXP_DATE, RE521_CUR_S4_EXP_DATE, 
RE522_CUSTOMER_KEY, RE523_SUBSCRIBER_KEY, RE524_ACCOUNT_KEY, RE525_DLYRECHGTIMESID, RE526_DLYRECHGTIMES, RE527_MTHLYRECHGTIMESID, 
RE528_MTHLYRECHGTIMES, RE529_PRIVATENUMBER, RE530_BILL_CYCLE_ID  FROM RECURRING01_EXT)
COMMIT
/
UPDATE cdr_head
   SET process_status=96
 WHERE source='mon'
   AND file_name='$1'
/
COMMIT
/
EXIT
EOF
}

# ======= SMSC SECTION =====

lock=/data02/scripts/process/bin/recurring01_loader_lock  export lock

if [ -f $lock ] ; then
exit 2

else
touch $lock

fileList=`get_smsc_files`

for fil in $fileList
do

v3=`echo ${fil}|sed s/,/\ /g|awk '{print $3}'`   ### file name
v4=`echo ${fil}|sed s/,/\ /g|awk '{print $4}'`   ### file id

cd /data02/scripts/process/bin/
sh esms_create_cbs01_ext_mon.sh $v3
createSMSCUpdate $v3
insertSMSCUpdate $v3


# ~~~~~~~~~~~~~~~~~~~~~~~~
updateOnError $v3 $v4
#~~~~~~~~~~~~~~~~~~~~~~~~~

done

rm -f $lock

fi

