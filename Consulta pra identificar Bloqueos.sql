SELECT
S.inst_id as Nodo_BD,
s.TERMINAL,
decode(L.TYPE,'TM','TABLE','TX','Record(s)') TYPE_LOCK,
decode(L.REQUEST,0,'NO','YES') WAIT,
S.OSUSER OSUSER_LOCKER,
s.client_info as traceid,
s.CLIENT_INFO as sessionid,
s.COMMAND as comando,
o.object_name as Objeto,
S.PROCESS PROCESS_LOCKER,
S.USERNAME DBUSER_LOCKER,
CONCAT(' ',s.PROGRAM) PROGRAM,
O.OWNER OWNER,
s.sid,
s.serial#,
floor(last_call_et / 60) "Minutes since active",
s.Wait_Class, /**/
s.Seconds_In_Wait ,
decode(l.REQUEST,0,'NO','YES') ESPERA,
s.event,
'ALTER SYSTEM DISCONNECT SESSION '''||s.sid||','||s.serial#||''' IMMEDIATE;' AS SQL_KILL
FROM gv$lock l,dba_objects o,gv$session s
WHERE l.ID1 = o.OBJECT_ID AND s.SID =l.SID AND l.TYPE in ('TM','TX','UL')
and Seconds_In_Wait > 2