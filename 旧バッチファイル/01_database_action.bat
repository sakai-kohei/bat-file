@echo off

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET sql="E:\sql_file\database.sql"
SET error="E:\logs\sql_bat\error\error.txt"

CHCP 65001
mysql --defaults-extra-file=%cnf% <%sql% >>%error% 2>&1