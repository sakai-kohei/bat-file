@echo off

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET sql="E:\sql_file\open.sql"
SET result="E:\logs\bat\tableau_open\result.txt"
SET prep="C:\Program Files\Tableau\Tableau Prep Builder 2021.1\Tableau Prep Builder.exe"

CHCP 65001
echo 1
mysql --defaults-extra-file=%cnf% <%sql% >>%result% 2>&1
echo 2
%prep%
echo 3
goto :eof