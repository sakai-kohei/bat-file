echo off
CHCP 65001

接続先情報
set DB_NAME=mysql
set USER_ID=root
set OPTION=--default-character-set=utf8
set PAS=password
 
echo MySQLへのログインします。
%DB_NAME% -u %USER_ID% --password=%PAS% < C:\SQL\test4.sql
echo 実行が完了しました。