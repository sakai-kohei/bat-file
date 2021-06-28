@echo off

CHCP 65001

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET paths=E:\\bat_file\\sql_exe.txt
SET result="E:\logs\bat\sql_exe\result.txt"
SET title=[%date% %time% SQL_EXE]
SET all=0
SET count=1

setlocal enabledelayedexpansion
for /f %%b in (%paths%) do (

SET txt=%%b
if not "!txt:~0,12!"=="E:\sql_file\" (echo %title% 「sql_exe.txt」に記入したSQLファイルのパスが間違っています。バッチの実行を中止します。 >>%result%&goto :eof)
if not "!txt:~-3!"=="sql" (echo %title% 「sql_exe.txt」には、SQLファイルを記入してください。バッチの実行を中止します。 >>%result%&goto :eof)
SET /a all+=1
)
if !all!==0 (echo %title% テキストに実行するSQLファイルが記載されていません。バッチの実行を中止します。 >>%result%&goto :eof)
endlocal

setlocal enabledelayedexpansion
for /f %%a in (%paths%) do (
echo %title% !count!/%all% %%aの実行を始めます。 >>%result%
mysql --defaults-extra-file=%cnf% <%%a >>%result% 2>&1
if !errorlevel! equ 1 (
ECHO %title%  !count!/%all% %%aの実行が失敗しました。>>%result%&goto :eof  
) 
SET /a count+=1
)
echo %title% バッチの実行が正常に終了しました。>>%result%
endlocal