REM ==============================================================
REM  PDFコピーバッチファイル Ver1.0
REM  Date  :2021/05/10
REM  
REM  originalはコピー元のファイル数
REM  copyedはコピー先のファイル数
REM ==============================================================

CHCP 65001

echo %date% %time% >> C:\Users\la0760\Desktop\ログファイル\ログ.txt
echo "実行開始" >> C:\Users\la0760\Desktop\ログファイル\ログ.txt
copy C:\Users\la0760\Desktop\コピー元PDF\*.pdf C:\Users\la0760\Desktop\コピー先PDF

for /f "usebackq" %%s in (`dir C:\Users\la0760\Desktop\コピー先PDF\*.pdf /A-D /B /S ^| find /c /v ""`) do set copyed=%%s
echo %copyed%

for /f "usebackq" %%t in (`dir C:\Users\la0760\Desktop\コピー元PDF\*.pdf /A-D /B /S ^| find /c /v ""`) do set original=%%t
echo %original%

if %original% == %copyed% (echo "コピーが成功しました" >> C:\Users\la0760\Desktop\ログファイル\ログ.txt) else  (echo "コピー先フォルダにファイルが残っていました" >> C:\Users\la0760\Desktop\ログファイル\ログ.txt)

echo. >> C:\Users\la0760\Desktop\ログファイル\ログ.txt