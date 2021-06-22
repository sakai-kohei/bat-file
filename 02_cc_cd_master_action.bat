@echo off

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET sql="E:\sql_file\01_master\cc_cd_master.sql"
SET log="E:\logs\sql_bat\general\log.txt"
SET error="E:\logs\sql_bat\error\error.txt"

CHCP 65001
mysql --defaults-extra-file=%cnf% <%sql% >>%error% 2>&1
if %errorlevel%==1 ECHO %date% %time%>>%error%
if %errorlevel%==1 ECHO %sql%の実行が失敗しました。>>%error%
if %errorlevel%==0 ECHO %date% %time%>>%log%
if %errorlevel%==0 ECHO %sql%が実行されました。>>%log%