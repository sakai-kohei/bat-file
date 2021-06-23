@echo off
CHCP 65001

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET /P paths="ファイルパスを入力してください。"
SET result="E:\logs\sql_bat\result.txt"
SET title=[SQL_Action]

if not "%paths%"=="E:\bat_file\sql_action.txt" (
echo %title% %date% %time% 入力されたパスは無効です。>>%result%& goto :eof
) else ( 
echo %title%SQLファイルの実行を始めます。>>%result%
)

setlocal enabledelayedexpansion
for /f %%a in (%paths%) do (
mysql --defaults-extra-file=%cnf% <%%a >>%result% 2>&1
echo %title% エラーレベルは!errorlevel! >>%result%
if !errorlevel! equ 0 (
ECHO %title% %date% %time%に%%aの実行が成功しました。>>%result% 
) else (
ECHO %title% %date% %time%に%%aの実行が失敗しました。>>%result% 
)
)
endlocal