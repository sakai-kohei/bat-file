@echo off
CHCP 65001

REM =====================================================================
REM  SQLファイル実行バッチ Ver1.0
REM  Date  :2021/06/28
REM  
REM  cnfは、MySQLへのログイン情報を記載しているテキスト
REM  pathsは、実行するSQLファイルを記載するテキスト
REM  resultは、実行時のメッセージを格納するテキスト
REM  titleは、実行メッセージのタイトル
REM  allは、実行したいSQLファイルの総数を格納する変数
REM  countは、実行するSQLファイルの項番を格納する変数
REM  txtは、実行するSQLファイル名を一時的に格納する変数
REM =====================================================================

SET cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
SET paths=E:\\bat_file\\sql_exe.txt
SET result="E:\logs\bat\sql_exe\result.txt"
SET title=[%date% %time% SQL_EXE]
SET all=0
SET count=1


for /f %%b in (%paths%) do (
SET txt=%%b
if exist "%txt%" (
echo %title% 「sql_exe.txt」に記入したSQLファイルのパスが間違っています。バッチの実行を中止します。 
echo %title% 「sql_exe.txt」に記入したSQLファイルのパスが間違っています。バッチの実行を中止します。 >>%result%&goto :eof
)
if not "%txt:~-3%"=="sql" (
echo %title% 「sql_exe.txt」には、SQLファイルを記入してください。バッチの実行を中止します。
echo %title% 「sql_exe.txt」には、SQLファイルを記入してください。バッチの実行を中止します。 >>%result%&goto :eof
)
SET /a all+=1
)
if %all%==0 (
echo %title% テキストに実行するSQLファイルが記載されていません。バッチの実行を中止します。 
echo %title% テキストに実行するSQLファイルが記載されていません。バッチの実行を中止します。 >>%result%&goto :eof
)


setlocal enabledelayedexpansion
for /f %%a in (%paths%) do (
echo %title% !count!/%all% %%aの実行を始めます。 
echo %title% !count!/%all% %%aの実行を始めます。 >>%result%
mysql --defaults-extra-file=%cnf% <%%a >>%result% 2>&1
if !errorlevel! equ 1 (
echo %title%  !count!/%all% %%aの実行が失敗しました。
echo %title%  !count!/%all% %%aの実行が失敗しました。>>%result%&goto :eof  
) 
SET /a count+=1
)
echo %title% バッチの実行が正常に終了しました。
echo %title% バッチの実行が正常に終了しました。>>%result%
endlocal
