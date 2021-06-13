@ECHO OFF

SET ini=E:\my.ini
SET sql=E:\test.sql
SET log=E:\log.txt
SET error=E:\error.txt

CHCP 65001
mysql --defaults-extra-file=%ini% <%sql%
if %errorlevel%==1 ECHO %date% %time%>>%error%
if %errorlevel%==1 ECHO %sql%の実行が失敗しました。>>%error%
if %errorlevel%==0 ECHO %date% %time%>>%log%
if %errorlevel%==0 ECHO %sql%が実行されました。>>%log%