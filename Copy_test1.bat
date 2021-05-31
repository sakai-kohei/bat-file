CHCP 65001
echo %date% %time% >> C:\Users\la0760\Desktop\ログファイル\リスト.txt

echo コピー元PDFの中身 >> C:\Users\la0760\Desktop\ログファイル\リスト.txt
for %%f in (.\Desktop\コピー元PDF\*.pdf) do (echo %%f >> C:\Users\la0760\Desktop\ログファイル\リスト.txt)

echo コピー先PDFの中身 >> C:\Users\la0760\Desktop\ログファイル\リスト.txt
for %%c in (.\Desktop\コピー先PDF\*.pdf) do (echo %%c >> C:\Users\la0760\Desktop\ログファイル\リスト.txt)
echo. >> C:\Users\la0760\Desktop\ログファイル\リスト.txt

