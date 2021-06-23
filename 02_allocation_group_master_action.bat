@echo off
CHCP 65001

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET /P INPUTSTR="実行するSQLファイルを入力してください。"
SET sql=E:\\sql_file\\01_master\\
SET log="E:\logs\sql_bat\general\log.txt"
SET error="E:\logs\sql_bat\error\error.txt"

mysql --defaults-extra-file=%cnf% <%sql%%INPUTSTR% >>%error% 2>&1
if %errorlevel%==0 (
ECHO %date% %time%に実行した%sql%は成功しました。>>%error% &goto :eof
) else %errorlevel%==1 (
ECHO %date% %time%に実行した%sql%が失敗しました。>>%log% 
)