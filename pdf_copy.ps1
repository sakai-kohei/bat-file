CHCP 65001
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
REM  monthは、作成したレポートが属する月を格納する変数
REM  ansは、バッチ実行者に入力させて文字列を格納する変数
REM  copiedは同期先のフォルダ
REM =====================================================================

$result="E:\logs\bat\pdf_copy\result.txt"
$original="E:\Tableau_PDF"
$title="$date $time Backup"

:yyyy
set /p year="作成したレポートの年度を[yyyy]で入力してください。"
if %year% gtr %date:~0,4% (echo %title% 今年度以降の年が入力されています。もう一度入力してください。 &goto :yyyy)
if %year% leq 2009 (echo %title% 入力した年度に実績はありません。もう一度入力してください。 &goto :yyyy)

:mm
set /p month="作成したレポートの月を[mm]で入力してください。"
if not %month%==01 if not %month%==02 if not %month%==03 if not %month%==04 if not %month%==05 if not %month%==06 if not %month%==07 if not %month%==08 if not %month%==09 if not %month%==10 if not %month%==11 if not %month%==12 (
echo %title% 入力が無効です。もう一度入力してください。 &goto :mm
)

set /p ans="作成したレポートを%year%年度%month%月にコピーします。よろしければy、バッチの実行を停止したい場合はnを入力してください。"
if %ans%==y (
echo %title% 入力したフォルダを作成し、同期を開始します。
echo %title% 入力したフォルダを作成し、同期を開始します。 >>%result%
) else (
echo %title% バッチの実行を中止します。 
echo %title% バッチの実行を中止します。 >>%result%&goto: eof
)

set copied="Z:\AO_経営企画室\82. Tableauレポート\%year%年度\%month%月"
if not exist %copied% (
mkdir %copied%
)
robocopy %original% %copied% /mir /w:1 >>%result%
echo %title%エラーレベル=%errorlevel% >>%result%
if %errorlevel% == 1 (
 echo %title% バッチの実行により、同期が成功しました。
 echo %title% バッチの実行により、同期が成功しました。 >>%result%& goto :eof
) else if %errorlevel% == 0 (
 echo %title% 同期の必要がなかったため、バッチは実行されませんでした。
 echo %title% 同期の必要がなかったため、バッチは実行されませんでした。 >>%result%&goto :eof
) else %errorlevel% gtr 1 (
 echo %title %エラーが発生したため、バッチが実行されませんでした。
 echo %title %エラーが発生したため、バッチが実行されませんでした。 >>%result%
)