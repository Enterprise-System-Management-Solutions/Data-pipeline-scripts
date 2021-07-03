
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



FILE_NAME="VOU01_EXT"  export FILE_NAME

##echo "-------------------------------- $1 --------------------------------"
echo "Create table started at `date \"+%D %T\"`"

SYN_TYPE="VOU01" export SYN_TYPE
echo $SYN_TYPE

sqlplus -s <<EOF
dwh_user/dwh_user_123
set feedback off
drop table $FILE_NAME
/
create table $FILE_NAME
(
  RE1_RECHARGE_LOG_ID          VARCHAR2(64 BYTE),
  RE2_RECHARGE_CODE            VARCHAR2(64 BYTE),
  RE3_RECHARGE_AMT             VARCHAR2(64 BYTE),
  RE4_ACCT_ID                  VARCHAR2(64 BYTE),
  RE5_SUB_ID                   VARCHAR2(64 BYTE),
  RE6_PRI_IDENTITY             VARCHAR2(64 BYTE),
  RE7_THIRD_PARTY_NUMBER       VARCHAR2(64 BYTE),
  RE8_CURRENCY_ID              VARCHAR2(64 BYTE),
  RE9_ORIGINAL_AMT             VARCHAR2(64 BYTE),
  RE10_CURRENCY_RATE           VARCHAR2(64 BYTE),
  RE11_CONVERSION_AMT          VARCHAR2(64 BYTE),
  RE12_RECHARGE_TRANS_ID       VARCHAR2(64 BYTE),
  RE13_EXT_TRANS_TYPE          VARCHAR2(64 BYTE),
  RE14_EXT_TRANS_ID            VARCHAR2(64 BYTE),
  RE15_ACCESS_METHOD           VARCHAR2(64 BYTE),
  RE16_BATCH_NO                VARCHAR2(64 BYTE),
  RE17_OFFERING_ID             VARCHAR2(64 BYTE),
  RE18_PAYMENT_TYPE            VARCHAR2(64 BYTE),
  RE19_RECHARGE_TAX            VARCHAR2(64 BYTE),
  RE20_RECHARGE_PENALTY        VARCHAR2(64 BYTE),
  RE21_RECHARGE_TYPE           VARCHAR2(64 BYTE),
  RE22_CHANNEL_ID              VARCHAR2(64 BYTE),
  RE23_RECHARGE_REASON         VARCHAR2(64 BYTE),
  RE24_RESULT_CODE             VARCHAR2(64 BYTE),
  RE25_ERROR_TYPE              VARCHAR2(64 BYTE),
  RE26_VALID_DAY_ADDED         VARCHAR2(64 BYTE),
  RE27_DIAMETER_SESSIONID      VARCHAR2(64 BYTE),
  RE28_OPER_ID                 VARCHAR2(64 BYTE),
  RE29_DEPT_ID                 VARCHAR2(64 BYTE),
  RE30_ENTRY_DATE              VARCHAR2(64 BYTE),
  RE31_RECON_DATE              VARCHAR2(64 BYTE),
  RE32_RECON_STATUS            VARCHAR2(64 BYTE),
  RE33_REVERSAL_TRANS_ID       VARCHAR2(64 BYTE),
  RE34_REVERSAL_REASON_CODE    VARCHAR2(64 BYTE),
  RE35_REVERSAL_OPER_ID        VARCHAR2(64 BYTE),
  RE36_REVERSAL_DEPT_ID        VARCHAR2(64 BYTE),
  RE37_REVERSAL_DATE           VARCHAR2(64 BYTE),
  RE38_STATUS                  VARCHAR2(64 BYTE),
  RE39_REMARK                  VARCHAR2(64 BYTE),
  RE40_BE_ID                   VARCHAR2(64 BYTE),
  RE41_BE_CODE                 VARCHAR2(64 BYTE),
  RE42_REGION_ID               VARCHAR2(64 BYTE),
  RE43_REGION_CODE             VARCHAR2(64 BYTE),
  RE44_CARD_SEQUENCE           VARCHAR2(64 BYTE),
  RE45_CARD_PIN_NUMBER         VARCHAR2(64 BYTE),
  RE46_CARD_BATCH_NO           VARCHAR2(64 BYTE),
  RE47_CARD_STATUS             VARCHAR2(64 BYTE),
  RE48_CARD_COS_ID             VARCHAR2(64 BYTE),
  RE49_CARD_SP_ID              VARCHAR2(64 BYTE),
  RE50_CARD_AMOUNT             VARCHAR2(64 BYTE),
  RE51_CARD_VALIDITY           VARCHAR2(64 BYTE),
  RE52_VOUCHER_ENCRYPT_NUMBER  VARCHAR2(64 BYTE),
  RE53_CHECK_NO                VARCHAR2(64 BYTE),
  RE54_CHECK_DATE              VARCHAR2(64 BYTE),
  RE55_CREDIT_CARD_NO          VARCHAR2(64 BYTE),
  RE56_CREDIT_CARD_NAME        VARCHAR2(64 BYTE),
  RE57_CREDIT_CARD_TYPE_ID     VARCHAR2(64 BYTE),
  RE58_CC_EXPIRY_DATE          VARCHAR2(64 BYTE),
  RE59_CC_AUTHORIZATION_CODE   VARCHAR2(64 BYTE),
  RE60_BANK_CODE               VARCHAR2(64 BYTE),
  RE61_BANK_BRANCH_CODE        VARCHAR2(64 BYTE),
  RE62_ACCT_NO                 VARCHAR2(64 BYTE),
  RE63_BANK_ACCT_NAME          VARCHAR2(64 BYTE),
  RE64_LOAN_AMOUNT             VARCHAR2(64 BYTE),
  RE65_LOAN_POUNDATE           VARCHAR2(64 BYTE),
  RE66_ACCT_ID                 VARCHAR2(64 BYTE),
  RE67_ACCT_BALANCE_ID         VARCHAR2(64 BYTE),
  RE68_BALANCE_TYPE            VARCHAR2(64 BYTE),
  RE69_CUR_BALANCE             VARCHAR2(64 BYTE),
  RE70_CHG_BALANCE             VARCHAR2(64 BYTE),
  RE71_PRE_APPLY_TIME          VARCHAR2(64 BYTE),
  RE72_PRE_EXPIRE_TIME         VARCHAR2(64 BYTE),
  RE73_CUR_EXPIRE_TIME         VARCHAR2(64 BYTE),
  RE74_CURRENCYE_ID            VARCHAR2(64 BYTE),
  RE75_OPER_TYPE               VARCHAR2(64 BYTE),
  RE76_ACCT_ID                 VARCHAR2(64 BYTE),
  RE77_ACCT_BALANCE_ID         VARCHAR2(64 BYTE),
  RE78_BALANCE_TYPE            VARCHAR2(64 BYTE),
  RE79_CUR_BALANCE             VARCHAR2(64 BYTE),
  RE80_CHG_BALANCE             VARCHAR2(64 BYTE),
  RE81_PRE_APPLY_TIME          VARCHAR2(64 BYTE),
  RE82_PRE_EXPIRE_TIME         VARCHAR2(64 BYTE),
  RE83_CUR_EXPIRE_TIME         VARCHAR2(64 BYTE),
  RE84_CURRENCYE_ID            VARCHAR2(64 BYTE),
  RE85_OPER_TYPE               VARCHAR2(64 BYTE),
  RE86_ACCT_ID                 VARCHAR2(64 BYTE),
  RE87_ACCT_BALANCE_ID         VARCHAR2(64 BYTE),
  RE88_BALANCE_TYPE            VARCHAR2(64 BYTE),
  RE89_CUR_BALANCE             VARCHAR2(64 BYTE),
  RE90_CHG_BALANCE             VARCHAR2(64 BYTE),
  RE91_PRE_APPLY_TIME          VARCHAR2(64 BYTE),
  RE92_PRE_EXPIRE_TIME         VARCHAR2(64 BYTE),
  RE93_CUR_EXPIRE_TIME         VARCHAR2(64 BYTE),
  RE94_CURRENCYE_ID            VARCHAR2(64 BYTE),
  RE95_OPER_TYPE               VARCHAR2(64 BYTE),
  RE96_ACCT_ID                 VARCHAR2(64 BYTE),
  RE97_ACCT_BALANCE_ID         VARCHAR2(64 BYTE),
  RE98_BALANCE_TYPE            VARCHAR2(64 BYTE),
  RE99_CUR_BALANCE             VARCHAR2(64 BYTE),
  RE100_CHG_BALANCE            VARCHAR2(64 BYTE),
  RE101_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE102_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE103_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE104_CURRENCYE_ID           VARCHAR2(64 BYTE),
  RE105_OPER_TYPE              VARCHAR2(64 BYTE),
  RE106_ACCT_ID                VARCHAR2(64 BYTE),
  RE107_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE108_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE109_CUR_BALANCE            VARCHAR2(64 BYTE),
  RE110_CHG_BALANCE            VARCHAR2(64 BYTE),
  RE111_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE112_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE113_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE114_CURRENCYE_ID           VARCHAR2(64 BYTE),
  RE115_OPER_TYPE              VARCHAR2(64 BYTE),
  RE116_ACCT_ID                VARCHAR2(64 BYTE),
  RE117_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE118_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE119_CUR_BALANCE            VARCHAR2(64 BYTE),
  RE120_CHG_BALANCE            VARCHAR2(64 BYTE),
  RE121_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE122_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE123_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE124_CURRENCYE_ID           VARCHAR2(64 BYTE),
  RE125_OPER_TYPE              VARCHAR2(64 BYTE),
  RE126_ACCT_ID                VARCHAR2(64 BYTE),
  RE127_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE128_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE129_CUR_BALANCE            VARCHAR2(64 BYTE),
  RE130_CHG_BALANCE            VARCHAR2(64 BYTE),
  RE131_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE132_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE133_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE134_CURRENCYE_ID           VARCHAR2(64 BYTE),
  RE135_OPER_TYPE              VARCHAR2(64 BYTE),
  RE136_ACCT_ID                VARCHAR2(64 BYTE),
  RE137_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE138_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE139_CUR_BALANCE            VARCHAR2(64 BYTE),
  RE140_CHG_BALANCE            VARCHAR2(64 BYTE),
  RE141_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE142_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE143_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE144_CURRENCYE_ID           VARCHAR2(64 BYTE),
  RE145_OPER_TYPE              VARCHAR2(64 BYTE),
  RE146_ACCT_ID                VARCHAR2(64 BYTE),
  RE147_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE148_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE149_CUR_BALANCE            VARCHAR2(64 BYTE),
  RE150_CHG_BALANCE            VARCHAR2(64 BYTE),
  RE151_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE152_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE153_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE154_CURRENCYE_ID           VARCHAR2(64 BYTE),
  RE155_OPER_TYPE              VARCHAR2(64 BYTE),
  RE156_ACCT_ID                VARCHAR2(64 BYTE),
  RE157_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE158_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE159_CUR_BALANCE            VARCHAR2(64 BYTE),
  RE160_CHG_BALANCE            VARCHAR2(64 BYTE),
  RE161_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE162_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE163_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE164_CURRENCYE_ID           VARCHAR2(64 BYTE),
  RE165_OPER_TYPE              VARCHAR2(64 BYTE),
  RE166_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE167_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE168_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE169_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE170_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE171_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE172_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE173_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE174_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE175_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE176_OPER_TYPE              VARCHAR2(64 BYTE),
  RE177_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE178_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE179_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE180_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE181_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE182_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE183_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE184_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE185_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE186_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE187_OPER_TYPE              VARCHAR2(64 BYTE),
  RE188_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE189_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE190_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE191_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE192_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE193_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE194_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE195_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE196_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE197_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE198_OPER_TYPE              VARCHAR2(64 BYTE),
  RE199_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE200_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE201_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE202_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE203_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE204_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE205_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE206_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE207_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE208_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE209_OPER_TYPE              VARCHAR2(64 BYTE),
  RE210_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE211_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE212_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE213_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE214_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE215_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE216_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE217_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE218_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE219_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE220_OPER_TYPE              VARCHAR2(64 BYTE),
  RE221_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE222_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE223_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE224_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE225_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE226_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE227_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE228_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE229_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE230_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE231_OPER_TYPE              VARCHAR2(64 BYTE),
  RE232_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE233_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE234_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE235_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE236_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE237_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE238_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE239_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE240_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE241_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE242_OPER_TYPE              VARCHAR2(64 BYTE),
  RE243_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE244_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE245_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE246_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE247_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE248_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE249_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE250_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE251_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE252_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE253_OPER_TYPE              VARCHAR2(64 BYTE),
  RE254_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE255_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE256_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE257_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE258_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE259_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE260_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE261_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE262_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE263_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE264_OPER_TYPE              VARCHAR2(64 BYTE),
  RE265_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE266_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE267_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE268_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE269_CUR_AMOUNT             VARCHAR2(64 BYTE),
  RE270_CHG_AMOUNT             VARCHAR2(64 BYTE),
  RE271_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE272_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE273_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE274_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE275_OPER_TYPE              VARCHAR2(64 BYTE),
  RE276_ACCT_ID                VARCHAR2(64 BYTE),
  RE277_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE278_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE279_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE280_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE281_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE282_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE283_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE284_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE285_OPER_TYPE              VARCHAR2(64 BYTE),
  RE286_ACCT_ID                VARCHAR2(64 BYTE),
  RE287_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE288_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE289_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE290_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE291_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE292_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE293_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE294_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE295_OPER_TYPE              VARCHAR2(64 BYTE),
  RE296_ACCT_ID                VARCHAR2(64 BYTE),
  RE297_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE298_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE299_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE300_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE301_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE302_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE303_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE304_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE305_OPER_TYPE              VARCHAR2(64 BYTE),
  RE306_ACCT_ID                VARCHAR2(64 BYTE),
  RE307_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE308_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE309_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE310_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE311_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE312_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE313_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE314_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE315_OPER_TYPE              VARCHAR2(64 BYTE),
  RE316_ACCT_ID                VARCHAR2(64 BYTE),
  RE317_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE318_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE319_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE320_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE321_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE322_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE323_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE324_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE325_OPER_TYPE              VARCHAR2(64 BYTE),
  RE326_ACCT_ID                VARCHAR2(64 BYTE),
  RE327_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE328_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE329_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE330_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE331_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE332_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE333_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE334_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE335_OPER_TYPE              VARCHAR2(64 BYTE),
  RE336_ACCT_ID                VARCHAR2(64 BYTE),
  RE337_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE338_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE339_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE340_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE341_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE342_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE343_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE344_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE345_OPER_TYPE              VARCHAR2(64 BYTE),
  RE346_ACCT_ID                VARCHAR2(64 BYTE),
  RE347_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE348_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE349_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE350_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE351_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE352_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE353_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE354_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE355_OPER_TYPE              VARCHAR2(64 BYTE),
  RE356_ACCT_ID                VARCHAR2(64 BYTE),
  RE357_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE358_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE359_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE360_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE361_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE362_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE363_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE364_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE365_OPER_TYPE              VARCHAR2(64 BYTE),
  RE366_ACCT_ID                VARCHAR2(64 BYTE),
  RE367_ACCT_BALANCE_ID        VARCHAR2(64 BYTE),
  RE368_BALANCE_TYPE           VARCHAR2(64 BYTE),
  RE369_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE370_CURRENT_BALANCE        VARCHAR2(64 BYTE),
  RE371_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE372_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE373_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE374_CURRENCY_ID            VARCHAR2(64 BYTE),
  RE375_OPER_TYPE              VARCHAR2(64 BYTE),
  RE376_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE377_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE378_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE379_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE380_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE381_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE382_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE383_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE384_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE385_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE386_OPER_TYPE              VARCHAR2(64 BYTE),
  RE387_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE388_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE389_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE390_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE391_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE392_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE393_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE394_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE395_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE396_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE397_OPER_TYPE              VARCHAR2(64 BYTE),
  RE398_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE399_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE400_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE401_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE402_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE403_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE404_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE405_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE406_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE407_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE408_OPER_TYPE              VARCHAR2(64 BYTE),
  RE409_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE410_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE411_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE412_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE413_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE414_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE415_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE416_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE417_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE418_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE419_OPER_TYPE              VARCHAR2(64 BYTE),
  RE420_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE421_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE422_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE423_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE424_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE425_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE426_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE427_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE428_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE429_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE430_OPER_TYPE              VARCHAR2(64 BYTE),
  RE431_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE432_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE433_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE434_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE435_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE436_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE437_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE438_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE439_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE440_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE441_OPER_TYPE              VARCHAR2(64 BYTE),
  RE442_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE443_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE444_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE445_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE446_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE447_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE448_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE449_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE450_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE451_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE452_OPER_TYPE              VARCHAR2(64 BYTE),
  RE453_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE454_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE455_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE456_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE457_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE458_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE459_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE460_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE461_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE462_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE463_OPER_TYPE              VARCHAR2(64 BYTE),
  RE464_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE465_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE466_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE467_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE468_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE469_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE470_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE471_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE472_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE473_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE474_OPER_TYPE              VARCHAR2(64 BYTE),
  RE475_FU_OWN_TYPE            VARCHAR2(64 BYTE),
  RE476_FU_OWN_ID              VARCHAR2(64 BYTE),
  RE477_FREE_UNIT_TYPE         VARCHAR2(64 BYTE),
  RE478_FREE_UNIT_ID           VARCHAR2(64 BYTE),
  RE479_BONUS_AMOUNT           VARCHAR2(64 BYTE),
  RE480_CURRENT_AMOUNT         VARCHAR2(64 BYTE),
  RE481_PRE_APPLY_TIME         VARCHAR2(64 BYTE),
  RE482_PRE_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE483_CUR_EXPIRE_TIME        VARCHAR2(64 BYTE),
  RE484_FU_MEASURE_ID          VARCHAR2(64 BYTE),
  RE485_OPER_TYPE              VARCHAR2(64 BYTE),
  RE486_RECHARGEAREACODE       VARCHAR2(64 BYTE),
  RE487_RECHARGECELLID         VARCHAR2(64 BYTE),
  RE488_BRANDID                VARCHAR2(64 BYTE),
  RE489_MAINOFFERINGID         VARCHAR2(64 BYTE),
  RE490_PAYTYPE                VARCHAR2(64 BYTE),
  RE491_STARTTIMEOFBILLCYCLE   VARCHAR2(64 BYTE),
  RE492_ACCOUNT                VARCHAR2(64 BYTE),
  RE493_MAINBALANCEINFO        VARCHAR2(64 BYTE),
  RE494_CHGBALANCEINFO         VARCHAR2(64 BYTE),
  RE495_CHGFREEUNITINFO        VARCHAR2(64 BYTE),
  RE496_USERSTATE              VARCHAR2(64 BYTE),
  RE497_OLDUSERSTATE           VARCHAR2(64 BYTE),
  RE498_CARDVALUEADDED         VARCHAR2(64 BYTE),
  RE499_VALIDITYADDED          VARCHAR2(64 BYTE),
  RE500_TRADETYPE              VARCHAR2(64 BYTE),
  RE501_AGENTNAME              VARCHAR2(64 BYTE),
  RE502_ADDITIONALINFO         VARCHAR2(64 BYTE),
  RE503_BANKCODE               VARCHAR2(64 BYTE),
  RE504_SUBIDENTITYTYPE        VARCHAR2(64 BYTE),
  RE505_LOGINSYSTEMCODE        VARCHAR2(64 BYTE),
  RE506_LOAN_TRANS_ID          VARCHAR2(64 BYTE),
  RE507_LOAN_GRADE             VARCHAR2(64 BYTE),
  RE508_LOAN_ACCT_TYPE         VARCHAR2(64 BYTE),
  RE509_LOAN_ACCT_BALANCE      VARCHAR2(64 BYTE),
  RE510_ETU_GRACE_DATE         VARCHAR2(64 BYTE),
  RE511_RECHARGEWAY            VARCHAR2(64 BYTE),
  RE512_SUBSCRIBERID           VARCHAR2(64 BYTE),
  RE513_SUBSCRIBERIDTYPE       VARCHAR2(64 BYTE),
  RE514_COMMENT                VARCHAR2(64 BYTE),
  RE515_CUSTOMERCODE1          VARCHAR2(64 BYTE),
  RE516_OLD_S2_EXP_DATE        VARCHAR2(64 BYTE),
  RE517_CUR_S2_EXP_DATE        VARCHAR2(64 BYTE),
  RE518_OLD_S3_EXP_DATE        VARCHAR2(64 BYTE),
  RE519_CUR_S3_EXP_DATE        VARCHAR2(64 BYTE),
  RE520_OLD_S4_EXP_DATE        VARCHAR2(64 BYTE),
  RE521_CUR_S4_EXP_DATE        VARCHAR2(64 BYTE),
  RE522_CUSTOMER_KEY           VARCHAR2(64 BYTE),
  RE523_SUBSCRIBER_KEY         VARCHAR2(64 BYTE),
  RE524_ACCOUNT_KEY            VARCHAR2(64 BYTE),
  RE525_DLYRECHGTIMESID        VARCHAR2(64 BYTE),
  RE526_DLYRECHGTIMES          VARCHAR2(64 BYTE),
  RE527_MTHLYRECHGTIMESID      VARCHAR2(64 BYTE),
  RE528_MTHLYRECHGTIMES        VARCHAR2(64 BYTE),
  RE529_PRIVATENUMBER          VARCHAR2(64 BYTE),
  RE530_BILL_CYCLE_ID          VARCHAR2(64 BYTE),
  FILE_NAME1                   VARCHAR2(256 BYTE),
  FILE_NAME2                    VARCHAR2(256 BYTE),
  FILE_NAME3                   VARCHAR2(256 BYTE)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY VOU_DIR
     ACCESS PARAMETERS 
       ( RECORDS DELIMITED by NEWLINE
        BADFILE     '$1.bad'
        DISCARDFILE '$1.dis'
        FIELDS TERMINATED BY '|'
 )
     LOCATION (VOU_DIR:'$1.add')
  )
REJECT LIMIT UNLIMITED
NOPARALLEL
NOMONITORING
/
drop synonym  $SYN_TYPE
/
create synonym  $SYN_TYPE for $FILE_NAME
/
exit
EOF

echo "External table created"
