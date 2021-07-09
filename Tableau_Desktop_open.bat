@echo off

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET sql="E:\sql_file\open.sql"
SET result="E:\logs\bat\tableau_open\result.txt"
SET desktop="C:\Program Files\Tableau\Tableau 2021.1\bin\tableau.exe"

CHCP 65001
mysql --defaults-extra-file=%cnf% <%sql% >>%error% 2>&1
%desktop%
