@echo off

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET paths=E:\\bat_file\\sql_exe.txt
SET result="E:\logs\sql_bat\result.txt"
SET title=[%date% %time% SQL_EXE]
SET all=0
SET count=1

for /f %%b in (%paths%) do (
SET /a all+=1
)

setlocal enabledelayedexpansion
for /f %%a in (%paths%) do (
echo %title% !count!/%all% %%aの実行を始めます。>>%result%
mysql --defaults-extra-file=%cnf% <%%a >>%result% 2>&1
if !errorlevel! equ 1 (
ECHO %title%  !count!/%all% %%aの実行が失敗しました。>>%result%&goto :eof  
) 
SET /a count+=1
)
echo %title% バッチの実行が正常に終了しました。>>%result%
endlocal