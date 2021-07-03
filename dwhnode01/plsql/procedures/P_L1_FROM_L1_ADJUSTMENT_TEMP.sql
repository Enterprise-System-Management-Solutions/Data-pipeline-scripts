--
-- P_L1_FROM_L1_ADJUSTMENT_TEMP  (Procedure) 
--
CREATE OR REPLACE PROCEDURE DWH_USER.P_L1_FROM_L1_ADJUSTMENT_TEMP (P_PROCESS_DATE VARCHAR2) IS
    VCOUNT NUMBER;
    VDATE_KEY NUMBER;
    VSTATUS NUMBER;
    VDATE DATE := TO_DATE(TO_DATE(P_PROCESS_DATE,'YYYYMMDD'),'DD/MM/RRRR');
BEGIN
    
    SELECT DATE_KEY INTO VDATE_KEY FROM DATE_DIM
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE);
    
    SELECT COUNT(STATUS) INTO VSTATUS
    FROM ETL_LOG
    WHERE DATE_KEY = (SELECT A.DATE_KEY FROM DATE_DIM A WHERE A.DATE_VALUE = VDATE)
    AND LAYER = 'L1_ADJUSTMENT_TEMP_FULL'
    AND SOURCE = 'adj';
    
    IF VSTATUS = 0 THEN
        INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
        VALUES              ('L1_ADJUSTMENT_TEMP_FULL',VDATE_KEY,'adj','30',VCOUNT,'','',SYSDATE);
        
        COMMIT;
        INSERT INTO L1_ADJUSTMENT(PROCESSED_DATE, FILE_NAME, A1_ADJUST_LOG_ID, A2_ACCT_ID, A3_CUST_ID, A4_SUB_ID, A5_PRI_IDENTITY, A6_PAY_TYPE, A7_BATCH_NO, A8_CHANNEL_ID, A9_REASON_CODE, A10_RESULT_CODE, A11_ERROR_TYPE, A12_ACCT_BALANCE_ID, A13_ADJUST_AMT, A14_ADJUST_TRANS_ID, A15_EXT_TRANS_TYPE, A16_EXT_TRANS_ID, A17_ACCESS_METHOD, A18_REVERSAL_TRANS_ID, A19_REVERSAL_REASON_CODE, A20_REVERSAL_DATE, A21_STATUS, A22_ENTRY_DATE, A23_OPER_ID, A24_DEPT_ID, A25_REMARK, A26_BE_ID, A27_BE_CODE, A28_REGION_ID, A29_REGION_CODE, A30_DEBIT_AMOUNT, A31_RESERVED, A32_DEBIT_FROM_PREPAID, A33_DEBIT_FROM_ADVANCE_PREPAID, A34_DEBIT_FROM_POSTPAID, A35_DEBIT_FROM_ADVANCE_POST, A36_DEBIT_FROM_CREDIT_POSTPAID, A37_TOTAL_TAX, A38_FREE_UNIT_AMOUNT_OF_TIMES, A39_PAY_FREE_UNIT_DURATION, A40_FREE_UNIT_AMOUNT_OF_FLUX, A41_ACCT_ID, A42_ACCT_BALANCE_ID, A43_BALANCE_TYPE, A44_CUR_BALANCE, A45_CHG_BALANCE, A46_PRE_APPLY_TIME, A47_PRE_EXPIRE_TIME, A48_CUR_EXPIRE_TIME, A49_CURRENCYE_ID, A50_OPER_TYPE, A51_ACCT_ID, A52_ACCT_BALANCE_ID, A53_BALANCE_TYPE, A54_CUR_BALANCE, A55_CHG_BALANCE, A56_PRE_APPLY_TIME, A57_PRE_EXPIRE_TIME, A58_CUR_EXPIRE_TIME, A59_CURRENCYE_ID, A60_OPER_TYPE, A61_ACCT_ID, A62_ACCT_BALANCE_ID, A63_BALANCE_TYPE, A64_CUR_BALANCE, A65_CHG_BALANCE, A66_PRE_APPLY_TIME, A67_PRE_EXPIRE_TIME, A68_CUR_EXPIRE_TIME, A69_CURRENCYE_ID, A70_OPER_TYPE, A71_ACCT_ID, A72_ACCT_BALANCE_ID, A73_BALANCE_TYPE, A74_CUR_BALANCE, A75_CHG_BALANCE, A76_PRE_APPLY_TIME, A77_PRE_EXPIRE_TIME, A78_CUR_EXPIRE_TIME, A79_CURRENCYE_ID, A80_OPER_TYPE, A81_ACCT_ID, A82_ACCT_BALANCE_ID, A83_BALANCE_TYPE, A84_CUR_BALANCE, A85_CHG_BALANCE, A86_PRE_APPLY_TIME, A87_PRE_EXPIRE_TIME, A88_CUR_EXPIRE_TIME, A89_CURRENCYE_ID, A90_OPER_TYPE, A91_ACCT_ID, A92_ACCT_BALANCE_ID, A93_BALANCE_TYPE, A94_CUR_BALANCE, A95_CHG_BALANCE, A96_PRE_APPLY_TIME, A97_PRE_EXPIRE_TIME, A98_CUR_EXPIRE_TIME, A99_CURRENCYE_ID, A100_OPER_TYPE, A101_ACCT_ID, A102_ACCT_BALANCE_ID, A103_BALANCE_TYPE, A104_CUR_BALANCE, A105_CHG_BALANCE, A106_PRE_APPLY_TIME, A107_PRE_EXPIRE_TIME, A108_CUR_EXPIRE_TIME, A109_CURRENCYE_ID, A110_OPER_TYPE, A111_ACCT_ID, A112_ACCT_BALANCE_ID, A113_BALANCE_TYPE, A114_CUR_BALANCE, A115_CHG_BALANCE, A116_PRE_APPLY_TIME, A117_PRE_EXPIRE_TIME, A118_CUR_EXPIRE_TIME, A119_CURRENCYE_ID, A120_OPER_TYPE, A121_ACCT_ID, A122_ACCT_BALANCE_ID, A123_BALANCE_TYPE, A124_CUR_BALANCE, A125_CHG_BALANCE, A126_PRE_APPLY_TIME, 
        A127_PRE_EXPIRE_TIME, A128_CUR_EXPIRE_TIME, A129_CURRENCYE_ID, A130_OPER_TYPE, A131_ACCT_ID, A132_ACCT_BALANCE_ID, A133_BALANCE_TYPE, A134_CUR_BALANCE, A135_CHG_BALANCE, A136_PRE_APPLY_TIME, A137_PRE_EXPIRE_TIME, A138_CUR_EXPIRE_TIME, A139_CURRENCYE_ID, A140_OPER_TYPE, A141_FU_OWN_TYPE, A142_FU_OWN_ID, A143_FREE_UNIT_ID, A144_FREE_UNIT_TYPE, A145_CUR_AMOUNT, A146_CHG_AMOUNT, A147_PRE_APPLY_TIME, A148_PRE_EXPIRE_TIME, A149_CUR_EXPIRE_TIME, A150_FU_MEASURE_ID, A151_OPER_TYPE, A152_FU_OWN_TYPE, A153_FU_OWN_ID, A154_FREE_UNIT_ID, A155_FREE_UNIT_TYPE, A156_CUR_AMOUNT, A157_CHG_AMOUNT, A158_PRE_APPLY_TIME, A159_PRE_EXPIRE_TIME, A160_CUR_EXPIRE_TIME, A161_FU_MEASURE_ID, A162_OPER_TYPE, A163_FU_OWN_TYPE, A164_FU_OWN_ID, A165_FREE_UNIT_ID, A166_FREE_UNIT_TYPE, A167_CUR_AMOUNT, A168_CHG_AMOUNT, A169_PRE_APPLY_TIME, A170_PRE_EXPIRE_TIME, A171_CUR_EXPIRE_TIME, A172_FU_MEASURE_ID, A173_OPER_TYPE, A174_FU_OWN_TYPE, A175_FU_OWN_ID, A176_FREE_UNIT_ID, A177_FREE_UNIT_TYPE, A178_CUR_AMOUNT, A179_CHG_AMOUNT, A180_PRE_APPLY_TIME, A181_PRE_EXPIRE_TIME, A182_CUR_EXPIRE_TIME, A183_FU_MEASURE_ID, A184_OPER_TYPE, A185_FU_OWN_TYPE, A186_FU_OWN_ID, A187_FREE_UNIT_ID, A188_FREE_UNIT_TYPE, A189_CUR_AMOUNT, A190_CHG_AMOUNT, A191_PRE_APPLY_TIME, A192_PRE_EXPIRE_TIME, A193_CUR_EXPIRE_TIME, A194_FU_MEASURE_ID, A195_OPER_TYPE, A196_FU_OWN_TYPE, A197_FU_OWN_ID, A198_FREE_UNIT_ID, A199_FREE_UNIT_TYPE, A200_CUR_AMOUNT, A201_CHG_AMOUNT, A202_PRE_APPLY_TIME, A203_PRE_EXPIRE_TIME, A204_CUR_EXPIRE_TIME, A205_FU_MEASURE_ID, A206_OPER_TYPE, A207_FU_OWN_TYPE, A208_FU_OWN_ID, A209_FREE_UNIT_ID, A210_FREE_UNIT_TYPE, A211_CUR_AMOUNT, A212_CHG_AMOUNT, A213_PRE_APPLY_TIME, A214_PRE_EXPIRE_TIME, A215_CUR_EXPIRE_TIME, A216_FU_MEASURE_ID, A217_OPER_TYPE, A218_FU_OWN_TYPE, A219_FU_OWN_ID, A220_FREE_UNIT_ID, A221_FREE_UNIT_TYPE, A222_CUR_AMOUNT, A223_CHG_AMOUNT, A224_PRE_APPLY_TIME, A225_PRE_EXPIRE_TIME, A226_CUR_EXPIRE_TIME, A227_FU_MEASURE_ID, A228_OPER_TYPE, A229_FU_OWN_TYPE, A230_FU_OWN_ID, A231_FREE_UNIT_ID, A232_FREE_UNIT_TYPE, A233_CUR_AMOUNT, A234_CHG_AMOUNT, A235_PRE_APPLY_TIME, A236_PRE_EXPIRE_TIME, A237_CUR_EXPIRE_TIME, A238_FU_MEASURE_ID, A239_OPER_TYPE, A240_FU_OWN_TYPE, A241_FU_OWN_ID, A242_FREE_UNIT_ID, A243_FREE_UNIT_TYPE, A244_CUR_AMOUNT, A245_CHG_AMOUNT, A246_PRE_APPLY_TIME, A247_PRE_EXPIRE_TIME, A248_CUR_EXPIRE_TIME, A249_FU_MEASURE_ID, A250_OPER_TYPE, A251_ACCT_ID, 
        A252_ACCT_BALANCE_ID, A253_BALANCE_TYPE, A254_BONUS_AMOUNT, A255_CURRENT_BALANCE, A256_PRE_APPLY_TIME, A257_PRE_EXPIRE_TIME, A258_CUR_EXPIRE_TIME, A259_CURRENCY_ID, A260_OPER_TYPE, A261_ACCT_ID, A262_ACCT_BALANCE_ID, A263_BALANCE_TYPE, A264_BONUS_AMOUNT, A265_CURRENT_BALANCE, A266_PRE_APPLY_TIME, A267_PRE_EXPIRE_TIME, A268_CUR_EXPIRE_TIME, A269_CURRENCY_ID, A270_OPER_TYPE, A271_ACCT_ID, A272_ACCT_BALANCE_ID, A273_BALANCE_TYPE, A274_BONUS_AMOUNT, A275_CURRENT_BALANCE, A276_PRE_APPLY_TIME, A277_PRE_EXPIRE_TIME, A278_CUR_EXPIRE_TIME, A279_CURRENCY_ID, A280_OPER_TYPE, A281_ACCT_ID, A282_ACCT_BALANCE_ID, A283_BALANCE_TYPE, A284_BONUS_AMOUNT, A285_CURRENT_BALANCE, A286_PRE_APPLY_TIME, A287_PRE_EXPIRE_TIME, A288_CUR_EXPIRE_TIME, A289_CURRENCY_ID, A290_OPER_TYPE, A291_ACCT_ID, A292_ACCT_BALANCE_ID, A293_BALANCE_TYPE, A294_BONUS_AMOUNT, A295_CURRENT_BALANCE, A296_PRE_APPLY_TIME, A297_PRE_EXPIRE_TIME, A298_CUR_EXPIRE_TIME, A299_CURRENCY_ID, A300_OPER_TYPE, A301_ACCT_ID, A302_ACCT_BALANCE_ID, A303_BALANCE_TYPE, A304_BONUS_AMOUNT, A305_CURRENT_BALANCE, A306_PRE_APPLY_TIME, A307_PRE_EXPIRE_TIME, A308_CUR_EXPIRE_TIME, A309_CURRENCY_ID, A310_OPER_TYPE, A311_ACCT_ID, A312_ACCT_BALANCE_ID, A313_BALANCE_TYPE, A314_BONUS_AMOUNT, A315_CURRENT_BALANCE, A316_PRE_APPLY_TIME, A317_PRE_EXPIRE_TIME, A318_CUR_EXPIRE_TIME, A319_CURRENCY_ID, A320_OPER_TYPE, A321_ACCT_ID, A322_ACCT_BALANCE_ID, A323_BALANCE_TYPE, A324_BONUS_AMOUNT, A325_CURRENT_BALANCE, A326_PRE_APPLY_TIME, A327_PRE_EXPIRE_TIME, A328_CUR_EXPIRE_TIME, A329_CURRENCY_ID, A330_OPER_TYPE, A331_ACCT_ID, A332_ACCT_BALANCE_ID, A333_BALANCE_TYPE, A334_BONUS_AMOUNT, A335_CURRENT_BALANCE, A336_PRE_APPLY_TIME, A337_PRE_EXPIRE_TIME, A338_CUR_EXPIRE_TIME, A339_CURRENCY_ID, A340_OPER_TYPE, A341_ACCT_ID, A342_ACCT_BALANCE_ID, A343_BALANCE_TYPE, A344_BONUS_AMOUNT, A345_CURRENT_BALANCE, A346_PRE_APPLY_TIME, A347_PRE_EXPIRE_TIME, A348_CUR_EXPIRE_TIME, A349_CURRENCY_ID, A350_OPER_TYPE, A351_FU_OWN_TYPE, A352_FU_OWN_ID, A353_FREE_UNIT_TYPE, A354_FREE_UNIT_ID, A355_BONUS_AMOUNT, A356_CURRENT_AMOUNT, A357_PRE_APPLY_TIME, A358_PRE_EXPIRE_TIME, A359_CUR_EXPIRE_TIME, A360_FU_MEASURE_ID, A361_OPER_TYPE, A362_FU_OWN_TYPE, A363_FU_OWN_ID, A364_FREE_UNIT_TYPE, A365_FREE_UNIT_ID, A366_BONUS_AMOUNT, A367_CURRENT_AMOUNT, A368_PRE_APPLY_TIME, A369_PRE_EXPIRE_TIME, A370_CUR_EXPIRE_TIME, A371_FU_MEASURE_ID, A372_OPER_TYPE, 
        A373_FU_OWN_TYPE, A374_FU_OWN_ID, A375_FREE_UNIT_TYPE, A376_FREE_UNIT_ID, A377_BONUS_AMOUNT, A378_CURRENT_AMOUNT, A379_PRE_APPLY_TIME, A380_PRE_EXPIRE_TIME, A381_CUR_EXPIRE_TIME, A382_FU_MEASURE_ID, A383_OPER_TYPE, A384_FU_OWN_TYPE, A385_FU_OWN_ID, A386_FREE_UNIT_TYPE, A387_FREE_UNIT_ID, A388_BONUS_AMOUNT, A389_CURRENT_AMOUNT, A390_PRE_APPLY_TIME, A391_PRE_EXPIRE_TIME, A392_CUR_EXPIRE_TIME, A393_FU_MEASURE_ID, A394_OPER_TYPE, A395_FU_OWN_TYPE, A396_FU_OWN_ID, A397_FREE_UNIT_TYPE, A398_FREE_UNIT_ID, A399_BONUS_AMOUNT, A400_CURRENT_AMOUNT, A401_PRE_APPLY_TIME, A402_PRE_EXPIRE_TIME, A403_CUR_EXPIRE_TIME, A404_FU_MEASURE_ID, A405_OPER_TYPE, A406_FU_OWN_TYPE, A407_FU_OWN_ID, A408_FREE_UNIT_TYPE, A409_FREE_UNIT_ID, A410_BONUS_AMOUNT, A411_CURRENT_AMOUNT, A412_PRE_APPLY_TIME, A413_PRE_EXPIRE_TIME, A414_CUR_EXPIRE_TIME, A415_FU_MEASURE_ID, A416_OPER_TYPE, A417_FU_OWN_TYPE, A418_FU_OWN_ID, A419_FREE_UNIT_TYPE, A420_FREE_UNIT_ID, A421_BONUS_AMOUNT, A422_CURRENT_AMOUNT, A423_PRE_APPLY_TIME, A424_PRE_EXPIRE_TIME, A425_CUR_EXPIRE_TIME, A426_FU_MEASURE_ID, A427_OPER_TYPE, A428_FU_OWN_TYPE, A429_FU_OWN_ID, A430_FREE_UNIT_TYPE, A431_FREE_UNIT_ID, A432_BONUS_AMOUNT, A433_CURRENT_AMOUNT, A434_PRE_APPLY_TIME, A435_PRE_EXPIRE_TIME, A436_CUR_EXPIRE_TIME, A437_FU_MEASURE_ID, A438_OPER_TYPE, A439_FU_OWN_TYPE, A440_FU_OWN_ID, A441_FREE_UNIT_TYPE, A442_FREE_UNIT_ID, A443_BONUS_AMOUNT, A444_CURRENT_AMOUNT, A445_PRE_APPLY_TIME, A446_PRE_EXPIRE_TIME, A447_CUR_EXPIRE_TIME, A448_FU_MEASURE_ID, A449_OPER_TYPE, A450_FU_OWN_TYPE, A451_FU_OWN_ID, A452_FREE_UNIT_TYPE, A453_FREE_UNIT_ID, A454_BONUS_AMOUNT, A455_CURRENT_AMOUNT, A456_PRE_APPLY_TIME, A457_PRE_EXPIRE_TIME, A458_CUR_EXPIRE_TIME, A459_FU_MEASURE_ID, A460_OPER_TYPE, A461_BRANDID, A462_MAINOFFERINGID, A463_PAYTYPE, A464_STARTTIMEOFBILLCYCLE, A465_ACCOUNT, A466_MAINBALANCEINFO, A467_CHGBALANCEINFO, A468_CHGFREEUNITINFO, A469_USERSTATE, A470_OLDUSERSTATE, A471_SPID, A472_ADDITIONALINFO, A473_MERCHANT, A474_SERVICE, A475_OLD_S2_EXP_DATE, A476_CUR_S2_EXP_DATE, A477_OLD_S3_EXP_DATE, A478_CUR_S3_EXP_DATE, A479_OLD_S4_EXP_DATE, A480_CUR_S4_EXP_DATE, A481_BILL_CYCLE_ID, A482_PREPAID_BALANCE, A483_POSTPAID_BALANCE, A484_TAX_CODE_ID, A485_TAX_AMOUNT, A486_TAX_PRICE_FLAG, A487_TAX_CODE_ID, A488_TAX_AMOUNT, A489_TAX_PRICE_FLAG, A490_TAX_CODE_ID, A491_TAX_AMOUNT, A492_TAX_PRICE_FLAG, A493_TAX_CODE_ID, 
        A494_TAX_AMOUNT, A495_TAX_PRICE_FLAG, A496_TAX_CODE_ID, A497_TAX_AMOUNT, A498_TAX_PRICE_FLAG, A499_TAX_CODE_ID, A500_TAX_AMOUNT, A501_TAX_PRICE_FLAG, A502_TAX_CODE_ID, A503_TAX_AMOUNT, A504_TAX_PRICE_FLAG, A505_TAX_CODE_ID, A506_TAX_AMOUNT, A507_TAX_PRICE_FLAG, A508_TAX_CODE_ID, A509_TAX_AMOUNT, A510_TAX_PRICE_FLAG, A511_TAX_CODE_ID, A512_TAX_AMOUNT, A513_TAX_PRICE_FLAG, A514_LOGINSYSTEMCODE, A515_OPERTYPE, A516_LOAN_TRANS_ID, A517_ACCOUNT_KEY, A518_OWNER_CUST_CODE, A519_SUBSCRIBER_KEY, A520_LOAN_AMOUNT, A521_LOAN_POUNDAGE, A522_LOAN_PENALTY, A523_PAYMENT_ACCOUNT_KEY)
        (SELECT TO_DATE(TO_CHAR(sysdate-1, 'MM/DD/YYYY'), 'MM/DD/YYYY'),FILE_NAME , A1_ADJUST_LOG_ID, A2_ACCT_ID, A3_CUST_ID, A4_SUB_ID, A5_PRI_IDENTITY, A6_PAY_TYPE, A7_BATCH_NO, A8_CHANNEL_ID, A9_REASON_CODE, A10_RESULT_CODE, A11_ERROR_TYPE, A12_ACCT_BALANCE_ID, A13_ADJUST_AMT, A14_ADJUST_TRANS_ID, A15_EXT_TRANS_TYPE, A16_EXT_TRANS_ID, A17_ACCESS_METHOD, A18_REVERSAL_TRANS_ID, A19_REVERSAL_REASON_CODE, A20_REVERSAL_DATE, A21_STATUS, A22_ENTRY_DATE, A23_OPER_ID, A24_DEPT_ID, A25_REMARK, A26_BE_ID, A27_BE_CODE, A28_REGION_ID, A29_REGION_CODE, A30_DEBIT_AMOUNT, A31_RESERVED, A32_DEBIT_FROM_PREPAID, A33_DEBIT_FROM_ADVANCE_PREPAID, A34_DEBIT_FROM_POSTPAID, A35_DEBIT_FROM_ADVANCE_POST, A36_DEBIT_FROM_CREDIT_POSTPAID, A37_TOTAL_TAX, A38_FREE_UNIT_AMOUNT_OF_TIMES, A39_PAY_FREE_UNIT_DURATION, A40_FREE_UNIT_AMOUNT_OF_FLUX, A41_ACCT_ID, A42_ACCT_BALANCE_ID, A43_BALANCE_TYPE, A44_CUR_BALANCE, A45_CHG_BALANCE, A46_PRE_APPLY_TIME, A47_PRE_EXPIRE_TIME, A48_CUR_EXPIRE_TIME, A49_CURRENCYE_ID, A50_OPER_TYPE, A51_ACCT_ID, A52_ACCT_BALANCE_ID, A53_BALANCE_TYPE, A54_CUR_BALANCE, A55_CHG_BALANCE, A56_PRE_APPLY_TIME, A57_PRE_EXPIRE_TIME, A58_CUR_EXPIRE_TIME, A59_CURRENCYE_ID, A60_OPER_TYPE, A61_ACCT_ID, A62_ACCT_BALANCE_ID, A63_BALANCE_TYPE, A64_CUR_BALANCE, A65_CHG_BALANCE, A66_PRE_APPLY_TIME, A67_PRE_EXPIRE_TIME, A68_CUR_EXPIRE_TIME, A69_CURRENCYE_ID, A70_OPER_TYPE, A71_ACCT_ID, A72_ACCT_BALANCE_ID, A73_BALANCE_TYPE, A74_CUR_BALANCE, A75_CHG_BALANCE, A76_PRE_APPLY_TIME, A77_PRE_EXPIRE_TIME, A78_CUR_EXPIRE_TIME, A79_CURRENCYE_ID, A80_OPER_TYPE, A81_ACCT_ID, A82_ACCT_BALANCE_ID, A83_BALANCE_TYPE, A84_CUR_BALANCE, A85_CHG_BALANCE, A86_PRE_APPLY_TIME, A87_PRE_EXPIRE_TIME, A88_CUR_EXPIRE_TIME, A89_CURRENCYE_ID, A90_OPER_TYPE, A91_ACCT_ID, A92_ACCT_BALANCE_ID, A93_BALANCE_TYPE, A94_CUR_BALANCE, A95_CHG_BALANCE, A96_PRE_APPLY_TIME, A97_PRE_EXPIRE_TIME, A98_CUR_EXPIRE_TIME, A99_CURRENCYE_ID, A100_OPER_TYPE, A101_ACCT_ID, A102_ACCT_BALANCE_ID, A103_BALANCE_TYPE, A104_CUR_BALANCE, A105_CHG_BALANCE, A106_PRE_APPLY_TIME, A107_PRE_EXPIRE_TIME, A108_CUR_EXPIRE_TIME, A109_CURRENCYE_ID, A110_OPER_TYPE, A111_ACCT_ID, A112_ACCT_BALANCE_ID, A113_BALANCE_TYPE, A114_CUR_BALANCE, A115_CHG_BALANCE, A116_PRE_APPLY_TIME, A117_PRE_EXPIRE_TIME, A118_CUR_EXPIRE_TIME, A119_CURRENCYE_ID, A120_OPER_TYPE, A121_ACCT_ID, A122_ACCT_BALANCE_ID, A123_BALANCE_TYPE, A124_CUR_BALANCE, A125_CHG_BALANCE, A126_PRE_APPLY_TIME, 
        A127_PRE_EXPIRE_TIME, A128_CUR_EXPIRE_TIME, A129_CURRENCYE_ID, A130_OPER_TYPE, A131_ACCT_ID, A132_ACCT_BALANCE_ID, A133_BALANCE_TYPE, A134_CUR_BALANCE, A135_CHG_BALANCE, A136_PRE_APPLY_TIME, A137_PRE_EXPIRE_TIME, A138_CUR_EXPIRE_TIME, A139_CURRENCYE_ID, A140_OPER_TYPE, A141_FU_OWN_TYPE, A142_FU_OWN_ID, A143_FREE_UNIT_ID, A144_FREE_UNIT_TYPE, A145_CUR_AMOUNT, A146_CHG_AMOUNT, A147_PRE_APPLY_TIME, A148_PRE_EXPIRE_TIME, A149_CUR_EXPIRE_TIME, A150_FU_MEASURE_ID, A151_OPER_TYPE, A152_FU_OWN_TYPE, A153_FU_OWN_ID, A154_FREE_UNIT_ID, A155_FREE_UNIT_TYPE, A156_CUR_AMOUNT, A157_CHG_AMOUNT, A158_PRE_APPLY_TIME, A159_PRE_EXPIRE_TIME, A160_CUR_EXPIRE_TIME, A161_FU_MEASURE_ID, A162_OPER_TYPE, A163_FU_OWN_TYPE, A164_FU_OWN_ID, A165_FREE_UNIT_ID, A166_FREE_UNIT_TYPE, A167_CUR_AMOUNT, A168_CHG_AMOUNT, A169_PRE_APPLY_TIME, A170_PRE_EXPIRE_TIME, A171_CUR_EXPIRE_TIME, A172_FU_MEASURE_ID, A173_OPER_TYPE, A174_FU_OWN_TYPE, A175_FU_OWN_ID, A176_FREE_UNIT_ID, A177_FREE_UNIT_TYPE, A178_CUR_AMOUNT, A179_CHG_AMOUNT, A180_PRE_APPLY_TIME, A181_PRE_EXPIRE_TIME, A182_CUR_EXPIRE_TIME, A183_FU_MEASURE_ID, A184_OPER_TYPE, A185_FU_OWN_TYPE, A186_FU_OWN_ID, A187_FREE_UNIT_ID, A188_FREE_UNIT_TYPE, A189_CUR_AMOUNT, A190_CHG_AMOUNT, A191_PRE_APPLY_TIME, A192_PRE_EXPIRE_TIME, A193_CUR_EXPIRE_TIME, A194_FU_MEASURE_ID, A195_OPER_TYPE, A196_FU_OWN_TYPE, A197_FU_OWN_ID, A198_FREE_UNIT_ID, A199_FREE_UNIT_TYPE, A200_CUR_AMOUNT, A201_CHG_AMOUNT, A202_PRE_APPLY_TIME, A203_PRE_EXPIRE_TIME, A204_CUR_EXPIRE_TIME, A205_FU_MEASURE_ID, A206_OPER_TYPE, A207_FU_OWN_TYPE, A208_FU_OWN_ID, A209_FREE_UNIT_ID, A210_FREE_UNIT_TYPE, A211_CUR_AMOUNT, A212_CHG_AMOUNT, A213_PRE_APPLY_TIME, A214_PRE_EXPIRE_TIME, A215_CUR_EXPIRE_TIME, A216_FU_MEASURE_ID, A217_OPER_TYPE, A218_FU_OWN_TYPE, A219_FU_OWN_ID, A220_FREE_UNIT_ID, A221_FREE_UNIT_TYPE, A222_CUR_AMOUNT, A223_CHG_AMOUNT, A224_PRE_APPLY_TIME, A225_PRE_EXPIRE_TIME, A226_CUR_EXPIRE_TIME, A227_FU_MEASURE_ID, A228_OPER_TYPE, A229_FU_OWN_TYPE, A230_FU_OWN_ID, A231_FREE_UNIT_ID, A232_FREE_UNIT_TYPE, A233_CUR_AMOUNT, A234_CHG_AMOUNT, A235_PRE_APPLY_TIME, A236_PRE_EXPIRE_TIME, A237_CUR_EXPIRE_TIME, A238_FU_MEASURE_ID, A239_OPER_TYPE, A240_FU_OWN_TYPE, A241_FU_OWN_ID, A242_FREE_UNIT_ID, A243_FREE_UNIT_TYPE, A244_CUR_AMOUNT, A245_CHG_AMOUNT, A246_PRE_APPLY_TIME, A247_PRE_EXPIRE_TIME, A248_CUR_EXPIRE_TIME, A249_FU_MEASURE_ID, A250_OPER_TYPE, A251_ACCT_ID, 
        A252_ACCT_BALANCE_ID, A253_BALANCE_TYPE, A254_BONUS_AMOUNT, A255_CURRENT_BALANCE, A256_PRE_APPLY_TIME, A257_PRE_EXPIRE_TIME, A258_CUR_EXPIRE_TIME, A259_CURRENCY_ID, A260_OPER_TYPE, A261_ACCT_ID, A262_ACCT_BALANCE_ID, A263_BALANCE_TYPE, A264_BONUS_AMOUNT, A265_CURRENT_BALANCE, A266_PRE_APPLY_TIME, A267_PRE_EXPIRE_TIME, A268_CUR_EXPIRE_TIME, A269_CURRENCY_ID, A270_OPER_TYPE, A271_ACCT_ID, A272_ACCT_BALANCE_ID, A273_BALANCE_TYPE, A274_BONUS_AMOUNT, A275_CURRENT_BALANCE, A276_PRE_APPLY_TIME, A277_PRE_EXPIRE_TIME, A278_CUR_EXPIRE_TIME, A279_CURRENCY_ID, A280_OPER_TYPE, A281_ACCT_ID, A282_ACCT_BALANCE_ID, A283_BALANCE_TYPE, A284_BONUS_AMOUNT, A285_CURRENT_BALANCE, A286_PRE_APPLY_TIME, A287_PRE_EXPIRE_TIME, A288_CUR_EXPIRE_TIME, A289_CURRENCY_ID, A290_OPER_TYPE, A291_ACCT_ID, A292_ACCT_BALANCE_ID, A293_BALANCE_TYPE, A294_BONUS_AMOUNT, A295_CURRENT_BALANCE, A296_PRE_APPLY_TIME, A297_PRE_EXPIRE_TIME, A298_CUR_EXPIRE_TIME, A299_CURRENCY_ID, A300_OPER_TYPE, A301_ACCT_ID, A302_ACCT_BALANCE_ID, A303_BALANCE_TYPE, A304_BONUS_AMOUNT, A305_CURRENT_BALANCE, A306_PRE_APPLY_TIME, A307_PRE_EXPIRE_TIME, A308_CUR_EXPIRE_TIME, A309_CURRENCY_ID, A310_OPER_TYPE, A311_ACCT_ID, A312_ACCT_BALANCE_ID, A313_BALANCE_TYPE, A314_BONUS_AMOUNT, A315_CURRENT_BALANCE, A316_PRE_APPLY_TIME, A317_PRE_EXPIRE_TIME, A318_CUR_EXPIRE_TIME, A319_CURRENCY_ID, A320_OPER_TYPE, A321_ACCT_ID, A322_ACCT_BALANCE_ID, A323_BALANCE_TYPE, A324_BONUS_AMOUNT, A325_CURRENT_BALANCE, A326_PRE_APPLY_TIME, A327_PRE_EXPIRE_TIME, A328_CUR_EXPIRE_TIME, A329_CURRENCY_ID, A330_OPER_TYPE, A331_ACCT_ID, A332_ACCT_BALANCE_ID, A333_BALANCE_TYPE, A334_BONUS_AMOUNT, A335_CURRENT_BALANCE, A336_PRE_APPLY_TIME, A337_PRE_EXPIRE_TIME, A338_CUR_EXPIRE_TIME, A339_CURRENCY_ID, A340_OPER_TYPE, A341_ACCT_ID, A342_ACCT_BALANCE_ID, A343_BALANCE_TYPE, A344_BONUS_AMOUNT, A345_CURRENT_BALANCE, A346_PRE_APPLY_TIME, A347_PRE_EXPIRE_TIME, A348_CUR_EXPIRE_TIME, A349_CURRENCY_ID, A350_OPER_TYPE, A351_FU_OWN_TYPE, A352_FU_OWN_ID, A353_FREE_UNIT_TYPE, A354_FREE_UNIT_ID, A355_BONUS_AMOUNT, A356_CURRENT_AMOUNT, A357_PRE_APPLY_TIME, A358_PRE_EXPIRE_TIME, A359_CUR_EXPIRE_TIME, A360_FU_MEASURE_ID, A361_OPER_TYPE, A362_FU_OWN_TYPE, A363_FU_OWN_ID, A364_FREE_UNIT_TYPE, A365_FREE_UNIT_ID, A366_BONUS_AMOUNT, A367_CURRENT_AMOUNT, A368_PRE_APPLY_TIME, A369_PRE_EXPIRE_TIME, A370_CUR_EXPIRE_TIME, A371_FU_MEASURE_ID, A372_OPER_TYPE, 
        A373_FU_OWN_TYPE, A374_FU_OWN_ID, A375_FREE_UNIT_TYPE, A376_FREE_UNIT_ID, A377_BONUS_AMOUNT, A378_CURRENT_AMOUNT, A379_PRE_APPLY_TIME, A380_PRE_EXPIRE_TIME, A381_CUR_EXPIRE_TIME, A382_FU_MEASURE_ID, A383_OPER_TYPE, A384_FU_OWN_TYPE, A385_FU_OWN_ID, A386_FREE_UNIT_TYPE, A387_FREE_UNIT_ID, A388_BONUS_AMOUNT, A389_CURRENT_AMOUNT, A390_PRE_APPLY_TIME, A391_PRE_EXPIRE_TIME, A392_CUR_EXPIRE_TIME, A393_FU_MEASURE_ID, A394_OPER_TYPE, A395_FU_OWN_TYPE, A396_FU_OWN_ID, A397_FREE_UNIT_TYPE, A398_FREE_UNIT_ID, A399_BONUS_AMOUNT, A400_CURRENT_AMOUNT, A401_PRE_APPLY_TIME, A402_PRE_EXPIRE_TIME, A403_CUR_EXPIRE_TIME, A404_FU_MEASURE_ID, A405_OPER_TYPE, A406_FU_OWN_TYPE, A407_FU_OWN_ID, A408_FREE_UNIT_TYPE, A409_FREE_UNIT_ID, A410_BONUS_AMOUNT, A411_CURRENT_AMOUNT, A412_PRE_APPLY_TIME, A413_PRE_EXPIRE_TIME, A414_CUR_EXPIRE_TIME, A415_FU_MEASURE_ID, A416_OPER_TYPE, A417_FU_OWN_TYPE, A418_FU_OWN_ID, A419_FREE_UNIT_TYPE, A420_FREE_UNIT_ID, A421_BONUS_AMOUNT, A422_CURRENT_AMOUNT, A423_PRE_APPLY_TIME, A424_PRE_EXPIRE_TIME, A425_CUR_EXPIRE_TIME, A426_FU_MEASURE_ID, A427_OPER_TYPE, A428_FU_OWN_TYPE, A429_FU_OWN_ID, A430_FREE_UNIT_TYPE, A431_FREE_UNIT_ID, A432_BONUS_AMOUNT, A433_CURRENT_AMOUNT, A434_PRE_APPLY_TIME, A435_PRE_EXPIRE_TIME, A436_CUR_EXPIRE_TIME, A437_FU_MEASURE_ID, A438_OPER_TYPE, A439_FU_OWN_TYPE, A440_FU_OWN_ID, A441_FREE_UNIT_TYPE, A442_FREE_UNIT_ID, A443_BONUS_AMOUNT, A444_CURRENT_AMOUNT, A445_PRE_APPLY_TIME, A446_PRE_EXPIRE_TIME, A447_CUR_EXPIRE_TIME, A448_FU_MEASURE_ID, A449_OPER_TYPE, A450_FU_OWN_TYPE, A451_FU_OWN_ID, A452_FREE_UNIT_TYPE, A453_FREE_UNIT_ID, A454_BONUS_AMOUNT, A455_CURRENT_AMOUNT, A456_PRE_APPLY_TIME, A457_PRE_EXPIRE_TIME, A458_CUR_EXPIRE_TIME, A459_FU_MEASURE_ID, A460_OPER_TYPE, A461_BRANDID, A462_MAINOFFERINGID, A463_PAYTYPE, A464_STARTTIMEOFBILLCYCLE, A465_ACCOUNT, A466_MAINBALANCEINFO, A467_CHGBALANCEINFO, A468_CHGFREEUNITINFO, A469_USERSTATE, A470_OLDUSERSTATE, A471_SPID, A472_ADDITIONALINFO, A473_MERCHANT, A474_SERVICE, A475_OLD_S2_EXP_DATE, A476_CUR_S2_EXP_DATE, A477_OLD_S3_EXP_DATE, A478_CUR_S3_EXP_DATE, A479_OLD_S4_EXP_DATE, A480_CUR_S4_EXP_DATE, A481_BILL_CYCLE_ID, A482_PREPAID_BALANCE, A483_POSTPAID_BALANCE, A484_TAX_CODE_ID, A485_TAX_AMOUNT, A486_TAX_PRICE_FLAG, A487_TAX_CODE_ID, A488_TAX_AMOUNT, A489_TAX_PRICE_FLAG, A490_TAX_CODE_ID, A491_TAX_AMOUNT, A492_TAX_PRICE_FLAG, A493_TAX_CODE_ID, 
        A494_TAX_AMOUNT, A495_TAX_PRICE_FLAG, A496_TAX_CODE_ID, A497_TAX_AMOUNT, A498_TAX_PRICE_FLAG, A499_TAX_CODE_ID, A500_TAX_AMOUNT, A501_TAX_PRICE_FLAG, A502_TAX_CODE_ID, A503_TAX_AMOUNT, A504_TAX_PRICE_FLAG, A505_TAX_CODE_ID, A506_TAX_AMOUNT, A507_TAX_PRICE_FLAG, A508_TAX_CODE_ID, A509_TAX_AMOUNT, A510_TAX_PRICE_FLAG, A511_TAX_CODE_ID, A512_TAX_AMOUNT, A513_TAX_PRICE_FLAG, A514_LOGINSYSTEMCODE, A515_OPERTYPE, A516_LOAN_TRANS_ID, A517_ACCOUNT_KEY, A518_OWNER_CUST_CODE, A519_SUBSCRIBER_KEY, A520_LOAN_AMOUNT, A521_LOAN_POUNDAGE, A522_LOAN_PENALTY, A523_PAYMENT_ACCOUNT_KEY FROM L1_ADJUSTMENT_TEMP_FULL);
        COMMIT;
    UPDATE ETL_LOG SET STATUS = 96,
    UPDATE_TIME=SYSDATE
    WHERE DATE_KEY = VDATE_KEY
    AND LAYER = 'L1_ADJUSTMENT_TEMP_FULL';        
        COMMIT;
  ELSE
     INSERT INTO ETL_LOG (LAYER, DATE_KEY, SOURCE, STATUS, FILE_COUNT, PER_COUNT, POST_COUNT, INSERT_TIME)
     VALUES              ('L2_ADJUSTMENT',VDATE_KEY,'adj','34',VCOUNT,'','',SYSDATE);
    COMMIT;
  END IF;
EXCEPTION
 WHEN OTHERS THEN NULL;
END;
/

