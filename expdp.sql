Export
expdp sys/oracle@ORCL directory=BK_PRUEBA schemas=LEO dumpfile=LEO-$(date +%Y%m%d%H%M).dmp logfile=LEO-$(date +%Y%m%d%H%M).log grants=Y
import
impdp sys/oracle@ORCL directory=BK_PRUEBA schemas=LEO dumpfile=LEO-$(date +%Y%m%d%H%M).dmp logfile=LEO-$(date +%Y%m%d%H%M).log grants=Y
