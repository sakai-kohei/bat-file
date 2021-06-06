REM ==============================================================
REM  PDFフォルダ同期バッチファイル Ver1.0
REM  Date  :2021/05/12
REM  
REM  logは、実行が成功した時の成功メッセージを格納するテキストファイル
REM  errorは、実行が失敗した時のエラーメッセージを格納するテキストファイル
REM  originalは同期元のフォルダ
REM  copiedは同期先のフォルダ
REM ==============================================================

set list=C:\Users\la0760\Desktop\log\list.txt
set error=C:\Users\la0760\Desktop\error\error.txt
set original=C:\Users\la0760\Desktop\original
set copied=Z:\AO_経営企画室\XX\copied


robocopy %original% %copied% /mir /w:1 >> %list%
if %errorlevel% == 16 echo ***FATAL ERROR*** >> %error%& goto end
if %errorlevel% == 8 echo **FAILED COPIES** >> %error%& goto end
if %errorlevel% == 4 echo *MISMATCHES* >> %error%& goto end
if %errorlevel% == 2 echo EXTRA FILES >> %error%& goto end
if %errorlevel% == 1 echo Copy successful >> %list%& goto end
if %errorlevel% == 0 echo --no change-- >> %list%& goto end
