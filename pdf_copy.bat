@echo off
REM =====================================================================
REM  PDFフォルダ同期バッチファイル Ver1.0
REM  Date  :2021/05/12
REM  
REM  resultは、実行時のメッセージを格納するテキストファイル
REM  originalは同期元のフォルダ
REM  copiedは同期先のフォルダ
REM =====================================================================

set result=C:\Users\la0760\Desktop\logs\batch_file\result.txt
set original=C:\Users\la0760\Desktop\Tableau_PDF
set copied=C:\Users\la0760\Desktop\copied
set title=[Backup]

robocopy %original% %copied% /mir /w:1 >>%result%
echo %title%エラーレベル=%errorlevel% >>%result%
if %errorlevel% == 1 (
 echo %title%バッチの実行により、同期が成功しました。 >>%result%& goto :eof
) else if %errorlevel% == 0 (
 echo %title%同期の必要がなかったため、バッチは実行されませんでした。 >>%result%& goto :eof
) else %errorlevel% gtr 1 (
 echo %title%エラーが発生したため、バッチが実行されませんでした。 >>%result%
)