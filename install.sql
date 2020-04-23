set verify off
@@services/patch_ver.sql
spool install_&patch_num..log replace

set appinfo 'Install patch &patch_num'

whenever sqlerror exit failure

@@services/title.sql
@@services/banner.sql

set define off

prompt ================

prompt >>>> others/_before.sql
prompt 
@@others/_before.sql

prompt >>>> tables/_tables.sql
prompt 
@@tables/_tables.sql

prompt >>>> packages/_packages.sql
prompt 
@@packages/_packages.sql

prompt >>>> triggers/_triggers.sql
prompt 
@@triggers/_triggers.sql

prompt >>>> tests/_tests.sql
prompt 
@@tests/_tests.sql

prompt ================
prompt 
prompt Patch was installed

spool off

exit;
