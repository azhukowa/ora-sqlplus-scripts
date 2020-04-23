set verify off
@@services/patch_ver.sql
spool uninstall_&patch_num..log replace

set appinfo 'Uninstall patch &patch_num'

whenever sqlerror continue

@@services/title.sql
@@services/banner.sql

prompt ================

prompt drop package product_test_pack;
drop package test_product_api_pack;

prompt drop trigger product_apicheck.tgr;
drop trigger product_b_iud_apicheck;

prompt drop package product_api_pack;
drop package product_api_pack;

prompt drop sequence product_pk;
drop sequence product_pk;

prompt drop table wallet;
drop table product;


prompt ================
prompt 
prompt Patch was uninstalled

spool off

exit;