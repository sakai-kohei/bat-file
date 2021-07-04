@echo off
CHCP 65001

SET result="C:\Users\horni\OneDrive\デスクトップ\office\E\logs\bat\pc_reboot\result.txt"
SET title=[%date% %time% PC_REBOOT]

echo %title% MySQL80の停止を開始します。 >>%result%
net stop MySQL80 >>%result% 2>&1
echo %title% エラーレベル=%errorlevel% >>%result%
if not %errorlevel%==0 (
echo %title% MySQL80の停止に失敗しました。 >>%result%& goto :eof
)
echo %title% MySQL80の実行が正常に停止しました。 >>%result%

echo %title% PCの再起動を開始します。 >>%result% 
shutdown.exe -f -r -t 0 >>%result%
echo %title% エラーレベル=%errorlevel% >>%result%
if not %errorlevel%==0 (
echo %title% PCの再起動に失敗しました。 >>%result%& goto :eof
)
echo %title% PCの再起動が正常に実行されました。 >>%result%