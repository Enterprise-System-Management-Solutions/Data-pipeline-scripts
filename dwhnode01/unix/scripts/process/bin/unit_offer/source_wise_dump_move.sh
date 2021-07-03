cd /data02/unit_offer/unit_offer_pull

chmod 775 *

#mv *ocs_subscriber_del*.list /data02/unit_offer/ocs_subscriber_del
mv *ocs_subscriber_all*.list /data02/unit_offer/ocs_subscriber_all
#mv *product_name*.list /data02/unit_offer/product_name
#mv *w_uvs_servicearea*.list /data02/unit_offer/w_uvs_servicearea
#mv *account_balance_more*.list /data02/unit_offer/account_balance_more
mv *account_balance*.list /data02/unit_offer/account_balance
#mv *sys_accounttype*.list /data02/unit_offer/sys_accounttype
#mv *sys_measure*.list /data02/unit_offer/sys_measure
#mv *dic_payment_method*.list /data02/unit_offer/dic_payment_method
#mv *subscriber_lastcalltime*.list /data02/unit_offer/subscriber_lastcalltime
#mv *log_trx*.list /data02/unit_offer/log_trx
#mv *log_detail_trx*.list /data02/unit_offer/log_detail_trx
#mv *subchangelog*.list /data02/unit_offer/subchangelog
#mv  *Test_BC_OFFERING_INST*.list /data02/unit_offer/test_bc_offering
#mv  *Test_PE_FREE_UNIT*.list /data02/unit_offer/test_pe_free
#mv  *Test_SUB_IDEN*.list /data02/unit_offer/test_sub_iden

rm -f *
