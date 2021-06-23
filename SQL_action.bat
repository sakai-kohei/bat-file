@echo on
CHCP 65001

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET /P paths="ファイルパスを入力してください。"
SET result="E:\logs\sql_bat\result.txt"
SET title=[SQL_Action]

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