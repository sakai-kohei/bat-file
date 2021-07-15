@echo off
CHCP 65001

SET result="C:\Users\horni\OneDrive\デスクトップ\office\E\logs\bat\pc_reboot\result.txt"
SET title=[PC_REBOOT]

echo %date% %time% %title% MySQL80の停止を開始します。 >>%result%
net stop MySQL80 >>%result% 2>&1
timeout /T 5
echo %date% %time% %title% エラーレベル=%errorlevel% >>%result%
if not %errorlevel%==0 (
echo %date% %time% %title% MySQL80の停止に失敗しました。 >>%result%& goto :eof
)
echo %date% %time% %title% MySQL80の実行が正常に停止しました。 >>%result%

echo %date% %time% %title% PCの再起動を開始します。 >>%result% 
shutdown.exe -r -t 10 >>%result%
echo %date% %time% %title% エラーレベル=%errorlevel% >>%result%
if not %errorlevel%==0 (
echo %date% %time% %title% PCの再起動に失敗しました。 >>%result%& goto :eof
)
echo %date% %time% %title% PCの再起動が正常に実行されました。 >>%result%