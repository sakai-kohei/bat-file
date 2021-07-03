@echo off
CHCP 65001

SET result="C:\Users\horni\OneDrive\デスクトップ\office\E\logs\bat\mysql_stop\result.txt"
SET title=[%date% %time% MySQL_STOP]

echo %title% MySQL80の停止を開始します。 >>%result%
net stop MySQL80 >>%result% 2>&1
echo %title% エラーレベル=%errorlevel% >>%result%
if not %errorlevel%==0 (
echo MySQL80の停止に失敗しました。 >>%result%& goto :eof
)
echo %title% MySQL80の実行が正常に停止しました。 >>%result%

echo PCの再起動を開始します。 >>%result%
shutdown.exe -r >>%result% 2>&1
echo %title% エラーレベル=%errorlevel% >>%result%
if not %errorlevel%==0 (
echo PCの再起動に失敗しました。 >>%result%& goto :eof
)
echo %title% PCの再起動が正常に実行されました。 >>%result%