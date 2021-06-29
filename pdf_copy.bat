@echo off
REM =====================================================================
REM  PDFフォルダ同期バッチファイル Ver1.0
REM  Date  :2021/06/15
REM  
REM  resultは、実行時のメッセージを格納するテキスト
REM  originalは同期元のフォルダ
REM  titleは、メッセージを格納している変数
REM  yearは、作成したレポートが属する年度を格納する変数
REM  strは、バッチ実行者に入力させた文字列を格納する変数
REM  lenは、バッチ実行者に入力させた文字列の長さを格納する変数
REM  nextは、バッチ実行時の翌年を格納する変数
REM  monthは、作成したレポートが属する月を格納する変数
REM  ansは、バッチ実行者に入力させて文字列を格納する変数
REM  copiedは同期先のフォルダ
REM =====================================================================
CHCP 65001

set result="E:\logs\bat\pdf_copy\result.txt"
set original="E:\Tableau_PDF"
set title=[%date% %time% Backup]

set /p year="作成したレポートの年度を[yyyy]で入力してください。"
set str=%year%
set len=0
:LOOP
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP
)
set next=%date:~0,4%+1
if not %len%==4 (echo %title% 4桁の数字を入力してください。バッチの実行を終了します。 >>%result%&goto :eof)
if %year% gtr %next% (echo %title% 今年度以降の年が入力されています。バッチの実行を終了します。 >>%result%&goto :eof)
if %year% leq 2009 (echo %title% 入力した年度に実績はありません。バッチの実行を終了します。 >>%result%&goto :eof)

set /p month="作成したレポートの月を[mm]で入力してください。"
set str=%month%
set len=0
:LOOP
if not "%str%"=="" (
    set str=%str:~1%
    set /a len=%len%+1
    goto :LOOP
)
if not %len%==2 (echo %title% 2桁の数字を入力してください。バッチの実行を終了します。 >>%result%&goto: eof)
if %month%==00 (echo %title% 入力が無効です。バッチの実行を終了します。 >>%result%&goto: eof) 
if %month% gtr 13 (echo %title% 入力が無効です。バッチの実行を終了します。 >>%result%&goto: eof)

set /p ans="作成したレポートを%year%年度%month%月にコピーします。よろしければy、入力を間違えた場合はnを入力してください。"
if %ans%==y (
echo %title% 入力したフォルダを作成し、同期を開始します。 >>%result%
) else (
echo %title% バッチの実行を取りやめます。 >>%result%&goto: eof
)

set copied="Z:\AO_経営企画室\82. Tableauレポート\%year%年度\%month%月"
if not exist %copied% (
mkdir "Z:\AO_経営企画室\82. Tableauレポート\%year%年度\%month%月"
)
robocopy %original% %copied% /mir /w:1 >>%result%
echo %title%エラーレベル=%errorlevel% >>%result%
if %errorlevel% == 1 (
 echo %title% バッチの実行により、同期が成功しました。 >>%result%& goto :eof
) else if %errorlevel% == 0 (
 echo %title% 同期の必要がなかったため、バッチは実行されませんでした。 >>%result%&goto :eof
) else %errorlevel% gtr 1 (
 echo %title %エラーが発生したため、バッチが実行されませんでした。 >>%result%
)