Export
expdp sys/oracle@ORCL directory=BK_PRUEBA schemas=LEO dumpfile=LEO-$(date +%Y%m%d%H%M).dmp logfile=LEO-$(date +%Y%m%d%H%M).log grants=Y
import
impdp sys/oracle@ORCL directory=BK_PRUEBA schemas=LEO dumpfile=LEO-$(date +%Y%m%d%H%M).dmp logfile=LEO-$(date +%Y%m%d%H%M).log grants=Y



CREATE TABLESPACE USERS DATAFILE 
  '/home/u01/app/oracle/oradata/orcl/pdbdevali/users.DAT' SIZE 2000M AUTOEXTEND ON NEXT 1024M MAXSIZE UNLIMITED
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
